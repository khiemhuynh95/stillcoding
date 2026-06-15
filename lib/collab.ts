/**
 * Collaboration sessions — the one client-write path to Supabase.
 *
 * A session is a shared code buffer for a single (problem, language), edited
 * live via Yjs over Supabase Realtime Broadcast. This module owns the row
 * persistence (CRUD against `public.collab_sessions`); the live transport and
 * Monaco binding live in the provider + hook layers (added in increment 2/3).
 *
 * The row's `doc` column holds a base64-encoded Yjs state snapshot, written
 * back debounced so late-joiners and reloads see the current buffer. It is
 * never the live channel — keystrokes flow over Broadcast, not the DB.
 */

import * as Y from "yjs";
import {
  Awareness,
  applyAwarenessUpdate,
  encodeAwarenessUpdate,
  removeAwarenessStates,
} from "y-protocols/awareness";
import type { RealtimeChannel } from "@supabase/supabase-js";
import { supabaseClient } from "./supabase";
import { storageGet, storageSet, storageKeys } from "./storage";

const TABLE = "collab_sessions";

// --- base64 <-> bytes (broadcast payloads are JSON, so Yjs binary travels as
// base64 strings). Chunked to stay under the argument-count limit on big docs.
export function bytesToBase64(bytes: Uint8Array): string {
  let binary = "";
  const chunk = 0x8000;
  for (let i = 0; i < bytes.length; i += chunk) {
    binary += String.fromCharCode(...bytes.subarray(i, i + chunk));
  }
  return btoa(binary);
}

export function base64ToBytes(b64: string): Uint8Array {
  const binary = atob(b64);
  const bytes = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) bytes[i] = binary.charCodeAt(i);
  return bytes;
}

export interface CollabSession {
  id: string;
  slug: string;
  language: string;
  /** base64-encoded Yjs state snapshot, or null before the first save. */
  doc: string | null;
}

/** Whether the collaboration feature is usable (Supabase configured). */
export const collabEnabled = supabaseClient != null;

/**
 * Build a base64 Yjs snapshot seeded with `code`, so a new session starts from
 * the creator's current buffer. Stored as the row's `doc` at creation time.
 */
export function encodeSeedSnapshot(code: string): string {
  const doc = new Y.Doc();
  doc.getText("monaco").insert(0, code);
  const snap = bytesToBase64(Y.encodeStateAsUpdate(doc));
  doc.destroy();
  return snap;
}

/**
 * Create a new session for a (problem, language), optionally seeded with an
 * initial Yjs snapshot. Returns the new id, or null when Supabase is unset.
 */
export async function createCollabSession(
  slug: string,
  language: string,
  doc: string | null = null,
): Promise<string | null> {
  if (!supabaseClient) return null;
  const id = crypto.randomUUID();
  const { error } = await supabaseClient
    .from(TABLE)
    .insert({ id, slug, language, doc });
  if (error) throw new Error(`Collab session create failed: ${error.message}`);
  return id;
}

/** Load a session by id. Returns null when missing/expired or unconfigured. */
export async function loadCollabSession(
  id: string,
): Promise<CollabSession | null> {
  if (!supabaseClient) return null;
  const { data, error } = await supabaseClient
    .from(TABLE)
    .select("id, slug, language, doc")
    .eq("id", id)
    .maybeSingle();
  if (error) throw new Error(`Collab session read failed: ${error.message}`);
  if (!data) return null;
  return {
    id: data.id as string,
    slug: data.slug as string,
    language: data.language as string,
    doc: (data.doc as string | null) ?? null,
  };
}

/**
 * Persist a debounced Yjs snapshot for a session. No-ops when Supabase is unset.
 * Errors are swallowed: the snapshot is a convenience for late-joiners/reload —
 * the live Broadcast channel remains the working copy, so a failed save must
 * not interrupt editing.
 */
export async function saveCollabSnapshot(
  id: string,
  doc: string,
): Promise<void> {
  if (!supabaseClient) return;
  const { error } = await supabaseClient.from(TABLE).update({ doc }).eq("id", id);
  if (error) {
    // Best-effort; keep editing even if persistence hiccups.
    console.warn(`Collab snapshot save failed: ${error.message}`);
  }
}

// --- Live transport -------------------------------------------------------

export type CollabStatus = "connecting" | "connected" | "disconnected";

/** A collaborator's identity as carried in Yjs awareness. */
export interface CollabUser {
  name: string;
  color: string;
}

/**
 * Binds a Y.Doc + awareness to a Supabase Realtime Broadcast channel. Live
 * document deltas and cursor/presence updates travel as ephemeral broadcast
 * messages (never the DB). On join the provider exchanges Yjs sync messages
 * with any present peers so everyone converges.
 */
export class SupabaseYjsProvider {
  readonly doc: Y.Doc;
  readonly awareness: Awareness;
  private channel: RealtimeChannel | null = null;
  private heartbeat: ReturnType<typeof setInterval> | null = null;
  private _status: CollabStatus = "connecting";
  private statusListeners = new Set<(s: CollabStatus) => void>();
  private docUpdateHandler: (update: Uint8Array, origin: unknown) => void;
  private awarenessHandler: (
    changes: { added: number[]; updated: number[]; removed: number[] },
    origin: unknown,
  ) => void;

  constructor(
    private sessionId: string,
    doc: Y.Doc,
  ) {
    this.doc = doc;
    this.awareness = new Awareness(doc);

    // Relay local doc edits to peers (skip updates we applied *from* a peer,
    // which carry `this` as their transaction origin).
    this.docUpdateHandler = (update, origin) => {
      if (origin === this) return;
      this.send("update", { u: bytesToBase64(update) });
    };
    // Relay local awareness (cursor/presence) changes; skip remote-applied ones.
    this.awarenessHandler = ({ added, updated, removed }, origin) => {
      if (origin === this) return;
      const changed = [...added, ...updated, ...removed];
      this.send("awareness", {
        u: bytesToBase64(encodeAwarenessUpdate(this.awareness, changed)),
      });
    };

    if (!supabaseClient) {
      this.setStatus("disconnected");
      return;
    }
    this.connect();
  }

  private connect() {
    const client = supabaseClient!;
    const channel = client.channel(`collab:${this.sessionId}`, {
      config: { broadcast: { self: false } },
    });
    this.channel = channel;

    channel
      // A peer is asking what they're missing — answer with the diff for their
      // state vector, plus our awareness so their presence list fills in.
      .on("broadcast", { event: "sync-request" }, ({ payload }) => {
        const sv = base64ToBytes(payload.sv as string);
        this.send("sync-response", {
          u: bytesToBase64(Y.encodeStateAsUpdate(this.doc, sv)),
        });
        const states = [...this.awareness.getStates().keys()];
        if (states.length) {
          this.send("awareness", {
            u: bytesToBase64(encodeAwarenessUpdate(this.awareness, states)),
          });
        }
      })
      .on("broadcast", { event: "sync-response" }, ({ payload }) => {
        Y.applyUpdate(this.doc, base64ToBytes(payload.u as string), this);
      })
      .on("broadcast", { event: "update" }, ({ payload }) => {
        Y.applyUpdate(this.doc, base64ToBytes(payload.u as string), this);
      })
      .on("broadcast", { event: "awareness" }, ({ payload }) => {
        applyAwarenessUpdate(this.awareness, base64ToBytes(payload.u as string), this);
      })
      .subscribe((status) => {
        if (status === "SUBSCRIBED") {
          this.setStatus("connected");
          // Ask peers for anything we're missing…
          this.send("sync-request", {
            sv: bytesToBase64(Y.encodeStateVector(this.doc)),
          });
          // …and push our own state so peers who joined earlier converge too.
          this.send("update", {
            u: bytesToBase64(Y.encodeStateAsUpdate(this.doc)),
          });
          if (this.awareness.getLocalState()) {
            this.send("awareness", {
              u: bytesToBase64(
                encodeAwarenessUpdate(this.awareness, [this.doc.clientID]),
              ),
            });
          }
        } else if (status === "CHANNEL_ERROR" || status === "TIMED_OUT") {
          this.setStatus("connecting");
        } else if (status === "CLOSED") {
          this.setStatus("disconnected");
        }
      });

    this.doc.on("update", this.docUpdateHandler);
    this.awareness.on("update", this.awarenessHandler);

    // Heartbeat: re-publish our awareness state every 15s. y-protocols prunes a
    // peer whose state hasn't been refreshed within ~30s (its outdated-timeout),
    // so without this an idle collaborator's cursor would vanish even though
    // they're still connected. Bumping the local clock re-broadcasts via the
    // awareness handler and keeps everyone's lastUpdated fresh.
    this.heartbeat = setInterval(() => {
      const local = this.awareness.getLocalState();
      if (local) this.awareness.setLocalState(local);
    }, 15000);
  }

  private send(event: string, payload: Record<string, unknown>) {
    void this.channel?.send({ type: "broadcast", event, payload });
  }

  get status(): CollabStatus {
    return this._status;
  }

  /** Subscribe to status changes; fires immediately with the current value. */
  onStatus(cb: (s: CollabStatus) => void): () => void {
    this.statusListeners.add(cb);
    cb(this._status);
    return () => this.statusListeners.delete(cb);
  }

  private setStatus(s: CollabStatus) {
    this._status = s;
    this.statusListeners.forEach((l) => l(s));
  }

  destroy() {
    if (this.heartbeat) clearInterval(this.heartbeat);
    this.heartbeat = null;
    this.doc.off("update", this.docUpdateHandler);
    this.awareness.off("update", this.awarenessHandler);
    // Tell peers we're gone, then tear down.
    removeAwarenessStates(this.awareness, [this.doc.clientID], "local");
    this.awareness.destroy();
    if (this.channel) {
      void supabaseClient?.removeChannel(this.channel);
      this.channel = null;
    }
    this.setStatus("disconnected");
  }
}

// --- Anonymous identity ---------------------------------------------------

const ADJECTIVES = [
  "Swift", "Quiet", "Bright", "Clever", "Brave", "Calm", "Keen", "Bold",
];
const ANIMALS = [
  "Otter", "Falcon", "Lynx", "Heron", "Fox", "Moth", "Wren", "Ibis",
];
// Distinct, legible hues for cursor labels (light + dark friendly).
const COLORS = [
  "#1a73e8", "#188038", "#d93025", "#9334e6", "#e8710a", "#0b8043", "#d01884",
];

function randomFrom<T>(arr: T[]): T {
  return arr[Math.floor(Math.random() * arr.length)];
}

/**
 * The current user's collaborator identity (name + color), generated once and
 * persisted in localStorage so it stays stable across sessions/reloads.
 */
export function getCollabIdentity(): CollabUser {
  const existing = storageGet<CollabUser | null>(storageKeys.collabIdentity, null);
  if (existing?.name && existing?.color) return existing;
  const identity: CollabUser = {
    name: `${randomFrom(ADJECTIVES)} ${randomFrom(ANIMALS)}`,
    color: randomFrom(COLORS),
  };
  storageSet(storageKeys.collabIdentity, identity);
  return identity;
}

/** Update the persisted display name (color is kept). */
export function setCollabName(name: string): CollabUser {
  const current = getCollabIdentity();
  const updated = { ...current, name: name.trim() || current.name };
  storageSet(storageKeys.collabIdentity, updated);
  return updated;
}
