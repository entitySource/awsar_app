// Crawl awsarindia.org and eduanchors.com with Playwright and save their content
// as JSON (plus images and PDFs) for the AWSAR + EduAnchors app.
//
// Usage (from the app folder):
//   npm i -D playwright
//   npx playwright install chromium
//   node scripts/scrape-sites.mjs                 # both sites
//   node scripts/scrape-sites.mjs --max 60        # cap pages per site
//   node scripts/scrape-sites.mjs --no-images     # JSON only
//   node scripts/scrape-sites.mjs --start http://localhost:8080/   # custom start URL(s)
//
// Output: scraped/pages.json, scraped/images/*, scraped/pdfs/*, scraped/manifest.json

import { chromium } from "playwright";
import { createHash } from "node:crypto";
import { mkdir, writeFile } from "node:fs/promises";
import path from "node:path";

const args = process.argv.slice(2);
const flag = (name) => args.includes(name);
const opt = (name, fallback) => {
  const i = args.indexOf(name);
  return i >= 0 && args[i + 1] ? args[i + 1] : fallback;
};

const START_URLS = args.includes("--start")
  ? args.filter((_, i) => args[i - 1] === "--start")
  : ["https://awsarindia.org/", "https://eduanchors.com/"];
const MAX_PAGES_PER_SITE = Number(opt("--max", 120));
const DELAY_MS = Number(opt("--delay", 1000)); // be polite to a small NGO's server
const DOWNLOAD_IMAGES = !flag("--no-images");
const DOWNLOAD_PDFS = !flag("--no-pdfs");
const MAX_FILE_BYTES = 8 * 1024 * 1024;
const OUT = path.resolve(opt("--out", "scraped"));

const SKIP_EXT = /\.(jpe?g|png|gif|webp|svg|ico|css|js|zip|mp4|mp3|docx?|xlsx?|pptx?)$/i;
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const hash = (s) => createHash("sha1").update(s).digest("hex").slice(0, 12);

function normalise(url) {
  const u = new URL(url);
  u.hash = "";
  for (const p of [...u.searchParams.keys()]) {
    if (/^(utm_|fbclid|gclid)/i.test(p)) u.searchParams.delete(p);
  }
  if (u.pathname.length > 1 && u.pathname.endsWith("/")) u.pathname = u.pathname.slice(0, -1);
  return u.toString();
}

async function robotsDisallows(origin) {
  try {
    const res = await fetch(new URL("/robots.txt", origin));
    if (!res.ok) return [];
    const rules = [];
    let applies = false;
    for (const raw of (await res.text()).split(/\r?\n/)) {
      const line = raw.split("#")[0].trim();
      const [k, ...rest] = line.split(":");
      const v = rest.join(":").trim();
      if (/^user-agent$/i.test(k)) applies = v === "*";
      else if (applies && /^disallow$/i.test(k) && v) rules.push(v);
    }
    return rules;
  } catch {
    return [];
  }
}

// Runs inside the page: pulls structured content, in document order.
function extractPage() {
  const clean = (s) => (s || "").replace(/\s+/g, " ").trim();
  const root =
    document.querySelector("main") ||
    document.querySelector("article") ||
    document.querySelector("#content, .content, .site-content") ||
    document.body;

  // Drop navigation chrome so page text isn't repeated on every page
  const chrome = new Set(root.querySelectorAll("nav, header, footer, script, style, noscript, [aria-hidden='true']"));
  const inChrome = (el) => [...chrome].some((c) => c.contains(el));

  const blocks = [];
  for (const el of root.querySelectorAll("h1,h2,h3,h4,p,li,blockquote,td,th,figcaption")) {
    if (inChrome(el)) continue;
    const text = clean(el.innerText);
    if (!text || text.length < 2) continue;
    // Skip list items / cells that only wrap a nested block we'll capture anyway
    if (el.tagName === "LI" && el.querySelector("p,li")) continue;
    blocks.push({ tag: el.tagName.toLowerCase(), text });
  }

  const images = [...document.querySelectorAll("img")]
    .map((img) => ({
      src: img.currentSrc || img.src || img.getAttribute("data-src") || "",
      alt: clean(img.alt),
      width: img.naturalWidth,
      height: img.naturalHeight,
    }))
    .filter((i) => i.src && !i.src.startsWith("data:") && (i.width === 0 || i.width >= 120));

  const links = [...document.querySelectorAll("a[href]")].map((a) => ({
    href: a.href,
    text: clean(a.innerText) || clean(a.getAttribute("aria-label")) || clean(a.title),
  }));

  const videos = [
    ...[...document.querySelectorAll("iframe[src]")].map((f) => f.src),
    ...links.map((l) => l.href),
  ].filter((u) => /youtube\.com|youtu\.be|vimeo\.com/i.test(u));

  const forms = [...document.querySelectorAll("form")].map((form) => ({
    action: form.action,
    method: form.method,
    fields: [...form.querySelectorAll("input,select,textarea")]
      .filter((f) => !["hidden", "submit", "button"].includes(f.type))
      .map((f) => {
        const label =
          (f.id && document.querySelector(`label[for="${CSS.escape(f.id)}"]`)?.innerText) ||
          f.closest("label")?.innerText ||
          f.getAttribute("aria-label") ||
          f.placeholder ||
          f.name;
        return {
          name: f.name,
          type: f.tagName === "SELECT" ? "select" : f.type || f.tagName.toLowerCase(),
          label: clean(label),
          required: f.required,
          options: f.tagName === "SELECT" ? [...f.options].map((o) => clean(o.text)) : undefined,
        };
      }),
  }));

  const nav = [...document.querySelectorAll("header nav a, nav a")].map((a) => ({
    href: a.href,
    text: clean(a.innerText),
  }));

  return {
    title: document.title,
    description: document.querySelector('meta[name="description"]')?.content || "",
    lang: document.documentElement.lang || "",
    blocks,
    images,
    links,
    videos: [...new Set(videos)],
    forms,
    nav,
  };
}

async function download(url, dir, seen, manifest, kind) {
  if (seen.has(url)) return seen.get(url);
  seen.set(url, null);
  try {
    const res = await fetch(url);
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    const len = Number(res.headers.get("content-length") || 0);
    if (len > MAX_FILE_BYTES) throw new Error(`too large (${len} bytes)`);
    const buf = Buffer.from(await res.arrayBuffer());
    if (buf.length > MAX_FILE_BYTES) throw new Error(`too large (${buf.length} bytes)`);
    const ext = path.extname(new URL(url).pathname).toLowerCase() || (kind === "pdf" ? ".pdf" : ".jpg");
    const file = `${hash(url)}${ext}`;
    await writeFile(path.join(dir, file), buf);
    const rel = `${kind === "pdf" ? "pdfs" : "images"}/${file}`;
    seen.set(url, rel);
    manifest.push({ kind, url, file: rel, bytes: buf.length });
    return rel;
  } catch (err) {
    manifest.push({ kind, url, error: String(err.message || err) });
    return null;
  }
}

async function crawlSite(browser, startUrl, results, pdfUrls) {
  const origin = new URL(startUrl).origin;
  const host = new URL(startUrl).host.replace(/^www\./, "");
  const disallow = await robotsDisallows(origin);
  const allowed = (u) => {
    const url = new URL(u);
    if (url.host.replace(/^www\./, "") !== host) return false;
    if (!/^https?:$/.test(url.protocol)) return false;
    return !disallow.some((rule) => url.pathname.startsWith(rule));
  };

  const queue = [normalise(startUrl)];
  const queued = new Set(queue);
  const page = await browser.newPage({ userAgent: "Mozilla/5.0 (FOSS Forge 2.0 hackathon content import; contact via AWSAR brief)" });
  let count = 0;

  while (queue.length && count < MAX_PAGES_PER_SITE) {
    const url = queue.shift();
    count++;
    process.stdout.write(`[${host} ${count}] ${url} ... `);
    try {
      const res = await page.goto(url, { waitUntil: "domcontentloaded", timeout: 30000 });
      await page.waitForLoadState("networkidle", { timeout: 8000 }).catch(() => {});
      // Trigger lazy-loaded images
      await page.evaluate(async () => {
        for (let y = 0; y < document.body.scrollHeight; y += 800) {
          window.scrollTo(0, y);
          await new Promise((r) => setTimeout(r, 120));
        }
      });
      const type = res?.headers()["content-type"] || "";
      if (!type.includes("html")) {
        console.log(`skipped (${type})`);
        continue;
      }
      const data = await page.evaluate(extractPage);
      results.push({ site: host, url, status: res?.status(), ...data });
      console.log(`ok (${data.blocks.length} blocks, ${data.images.length} images)`);

      for (const { href } of data.links) {
        let next;
        try {
          next = normalise(href);
        } catch {
          continue;
        }
        if (/\.pdf($|\?)/i.test(next)) {
          pdfUrls.add(next);
          continue;
        }
        if (SKIP_EXT.test(new URL(next).pathname) || !allowed(next) || queued.has(next)) continue;
        queued.add(next);
        queue.push(next);
      }
    } catch (err) {
      console.log(`failed: ${err.message}`);
      results.push({ site: host, url, error: String(err.message || err) });
    }
    await sleep(DELAY_MS);
  }
  await page.close();
  if (queue.length) console.log(`[${host}] stopped at --max ${MAX_PAGES_PER_SITE}; ${queue.length} URLs not visited`);
}

const browser = await chromium.launch();
const results = [];
const pdfUrls = new Set();
try {
  for (const start of START_URLS) await crawlSite(browser, start, results, pdfUrls);
} finally {
  await browser.close();
}

await mkdir(OUT, { recursive: true });
const manifest = [];
const seen = new Map();

if (DOWNLOAD_IMAGES) {
  const dir = path.join(OUT, "images");
  await mkdir(dir, { recursive: true });
  for (const page of results) {
    for (const img of page.images || []) {
      img.file = await download(img.src, dir, seen, manifest, "image");
    }
  }
}
if (DOWNLOAD_PDFS) {
  const dir = path.join(OUT, "pdfs");
  await mkdir(dir, { recursive: true });
  for (const url of pdfUrls) await download(url, dir, seen, manifest, "pdf");
}

await writeFile(path.join(OUT, "pages.json"), JSON.stringify(results, null, 2));
await writeFile(path.join(OUT, "manifest.json"), JSON.stringify({ scrapedAt: new Date().toISOString(), startUrls: START_URLS, pdfs: [...pdfUrls], files: manifest }, null, 2));

const ok = results.filter((r) => !r.error).length;
const failedFiles = manifest.filter((m) => m.error).length;
console.log(`\nDone: ${ok}/${results.length} pages, ${manifest.length - failedFiles} files saved (${failedFiles} failed) -> ${OUT}`);
