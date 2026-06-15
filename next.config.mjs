/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  // Lint is run separately; don't fail production builds on lint-only issues.
  eslint: {
    ignoreDuringBuilds: true,
  },
  // Drop console.* (except errors) from the production client bundle.
  compiler: {
    removeConsole:
      process.env.NODE_ENV === "production" ? { exclude: ["error"] } : false,
  },
  // Tree-shake these libraries so only the imported symbols ship to the client.
  experimental: {
    optimizePackageImports: ["@tanstack/react-query", "isomorphic-dompurify"],
  },
  // Never let the browser/CDN cache the Pyodide runner worker: a stale copy
  // silently breaks code execution (no output), and the ?v= cache-bust alone
  // isn't enough once a build is pinned under a given query string.
  async headers() {
    return [
      {
        source: "/pyodide-worker.js",
        headers: [
          { key: "Cache-Control", value: "no-store, max-age=0, must-revalidate" },
        ],
      },
    ];
  },
};

export default nextConfig;
