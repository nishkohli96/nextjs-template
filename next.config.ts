import type { NextConfig } from 'next';

const nextConfig: NextConfig = {
  /* Configure Next.js app */
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'img.icons8.com'
      }
    ]
  },
};

export default nextConfig;
