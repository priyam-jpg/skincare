import { withPayload } from "@payloadcms/next/withPayload";
import type { NextConfig } from "next";
import path from "path";
import { fileURLToPath } from "url";

const dirname = path.dirname(fileURLToPath(import.meta.url));

const nextConfig: NextConfig = {
  // Required on Windows until Turbopack resolves Payload's Sass imports on its own.
  sassOptions: {
    loadPaths: ["./node_modules/@payloadcms/ui/dist/scss/"],
  },
  images: {
    qualities: [75, 90],
    localPatterns: [{ pathname: "/api/media/file/**" }, { pathname: "/images/**" }],
    remotePatterns: [{ protocol: "https", hostname: "res.cloudinary.com" }],
  },
  reactStrictMode: true,
  // People often type the admin address with ".html"; send them to the real page.
  async redirects() {
    return [
      { source: "/admin.html", destination: "/admin", permanent: false },
      { source: "/:page(shop|login|checkout|account|orders).html", destination: "/:page", permanent: false },
    ];
  },
  turbopack: {
    root: path.resolve(dirname),
  },
};

export default withPayload(nextConfig);
