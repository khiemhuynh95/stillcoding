/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  // Lint is run separately; don't fail production builds on lint-only issues.
  eslint: {
    ignoreDuringBuilds: true,
  },
};

export default nextConfig;
