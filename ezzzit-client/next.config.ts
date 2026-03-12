import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "lh3.googleusercontent.com",
      },
    ],
  },
  // ADD REWRITES HERE: Route API calls from the frontend to the internal background servers
  async rewrites() {
    return [
      {
        source: '/api/server/:path*',
        destination: 'http://127.0.0.1:8001/:path*', // Main execution server
      },
      {
        source: '/api/rag/:path*',
        destination: 'http://127.0.0.1:8002/:path*', // RAG service
      },
    ]
  }
};

export default nextConfig;
