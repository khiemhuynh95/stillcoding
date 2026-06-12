// Persist reword-only humanized variants: new title + new intro prose + curated
// tags. The examples/constraints from the ORIGINAL content are kept verbatim by
// splicing the new intro in front of the first "Example" block, so nothing in
// the worked examples can drift.
//
// Usage:  node scripts/apply-reword.mjs scripts/batch-reword.mjs
//
// Batch entries: { id, title, tags?, intro }
//   intro = new leading HTML (statement only, ending before Example 1).
// If the original has no recognizable Example block, the body is left as-is
// (display_content stays null -> app shows the original) and only title/tags
// update; such ids are logged as NOBODY for manual handling.

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
  console.error("Usage: node scripts/apply-reword.mjs <batch-module.mjs>");
  process.exit(1);
}
const mod = await import(pathToFileURL(resolve(batchPath)).href);
const batch = mod.default;

const headers = {
  apikey: KEY,
  Authorization: `Bearer ${KEY}`,
  "Content-Type": "application/json",
};

// Markers that begin the first worked-example block, in priority order.
const MARKERS = [
  '<p><strong class="example">',
  '<strong class="example">Example 1',
  '<p><strong>Example 1',
  '<p class="example">',
];

function spliceIntro(original, intro) {
  for (const m of MARKERS) {
    const i = original.indexOf(m);
    if (i !== -1) return intro + original.slice(i);
  }
  return null; // no example block found
}

let ok = 0, nobody = 0, failed = 0;
for (const p of batch) {
  // Pull the current (correct) original content.
  const getRes = await fetch(
    `${URL_BASE}/rest/v1/problems?id=eq.${encodeURIComponent(p.id)}&select=content`,
    { headers: { apikey: KEY, Authorization: `Bearer ${KEY}` } },
  );
  const rows = await getRes.json();
  const original = rows?.[0]?.content;
  if (!original) {
    console.error(`FAIL ${p.id}  could not read original content`);
    failed++;
    continue;
  }

  const body = {
    display_title: p.title,
    humanized_at: new Date().toISOString(),
  };
  if (Array.isArray(p.tags)) body.topic_tags = p.tags;

  const spliced = spliceIntro(original, p.intro);
  if (spliced) {
    body.display_content = spliced;
  } else {
    nobody++;
    console.warn(`NOBODY ${p.id}  no Example block; title/tags only`);
  }

  const res = await fetch(
    `${URL_BASE}/rest/v1/problems?id=eq.${encodeURIComponent(p.id)}`,
    { method: "PATCH", headers: { ...headers, Prefer: "return=minimal" }, body: JSON.stringify(body) },
  );
  if (res.ok) {
    ok++;
    console.log(`ok   ${p.id}  ${p.title}`);
  } else {
    failed++;
    console.error(`FAIL ${p.id}  ${res.status} ${await res.text()}`);
  }
}
console.log(`\nDone: ${ok} written (${nobody} body-skipped), ${failed} failed.`);
