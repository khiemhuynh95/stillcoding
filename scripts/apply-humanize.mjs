// Persist a batch of humanized problem rewrites to Supabase.
//
// Usage:  node scripts/apply-humanize.mjs scripts/batch.mjs
//
// The batch module default-exports an array of:
//   { id, title, content, tags: [{ name, slug }] }
// It writes display_title, display_content, topic_tags, humanized_at for each
// row (matched by primary key `id`). Originals (title/content) are untouched.
//
// Reads NEXT_PUBLIC_SUPABASE_URL + SUPABASE_SERVICE_ROLE_KEY from .env.local.
// The service key bypasses RLS; it is read from disk and never logged.

import { readFileSync } from "node:fs";
import { pathToFileURL } from "node:url";
import { resolve } from "node:path";

function loadEnv() {
  const env = {};
  const text = readFileSync(new URL("../.env.local", import.meta.url), "utf8");
  for (const line of text.split(/\r?\n/)) {
    const m = line.match(/^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/);
    if (m) env[m[1]] = m[2].replace(/^["']|["']$/g, "");
  }
  return env;
}

const env = loadEnv();
const URL_BASE = env.NEXT_PUBLIC_SUPABASE_URL;
const KEY = env.SUPABASE_SERVICE_ROLE_KEY;
if (!URL_BASE || !KEY) {
  console.error("Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY in .env.local");
  process.exit(1);
}

const batchPath = process.argv[2];
if (!batchPath) {
  console.error("Usage: node scripts/apply-humanize.mjs <batch-module.mjs>");
  process.exit(1);
}

const mod = await import(pathToFileURL(resolve(batchPath)).href);
const batch = mod.default;
if (!Array.isArray(batch) || !batch.length) {
  console.error("Batch module must default-export a non-empty array.");
  process.exit(1);
}

const headers = {
  apikey: KEY,
  Authorization: `Bearer ${KEY}`,
  "Content-Type": "application/json",
  Prefer: "return=minimal",
};

let ok = 0;
let failed = 0;
for (const p of batch) {
  if (!p.id || !p.title || !p.content) {
    console.error(`SKIP (missing fields): ${p.id ?? "?"}`);
    failed++;
    continue;
  }
  const body = {
    display_title: p.title,
    display_content: p.content,
    humanized_at: new Date().toISOString(),
  };
  if (Array.isArray(p.tags)) body.topic_tags = p.tags;

  const res = await fetch(
    `${URL_BASE}/rest/v1/problems?id=eq.${encodeURIComponent(p.id)}`,
    { method: "PATCH", headers, body: JSON.stringify(body) },
  );
  if (res.ok) {
    ok++;
    console.log(`ok   ${p.id}  ${p.title}`);
  } else {
    failed++;
    console.error(`FAIL ${p.id}  ${res.status} ${await res.text()}`);
  }
}

console.log(`\nDone: ${ok} written, ${failed} failed.`);
