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
};

export default nextConfig;
