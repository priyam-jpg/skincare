import type { Adapter } from "@payloadcms/plugin-cloud-storage/types";
import { v2 as cloudinary } from "cloudinary";
import path from "path";

type Options = { cloudName: string; apiKey: string; apiSecret: string; folder: string };

const publicIdFor = (folder: string, filename: string, prefix?: string) =>
  [folder, prefix, path.parse(filename).name].filter(Boolean).join("/");

/**
 * Stores Payload uploads in Cloudinary. Render's disk is wiped on every deploy,
 * so photos the client uploads in /admin must live outside the server.
 */
export const cloudinaryAdapter =
  ({ cloudName, apiKey, apiSecret, folder }: Options): Adapter =>
  () => {
    cloudinary.config({ cloud_name: cloudName, api_key: apiKey, api_secret: apiSecret, secure: true });

    const urlFor = (filename: string, prefix?: string) =>
      `https://res.cloudinary.com/${cloudName}/image/upload/${publicIdFor(folder, filename, prefix)}${path.extname(filename)}`;

    return {
      name: "cloudinary",

      async handleUpload({ file, data }) {
        await new Promise<void>((resolve, reject) => {
          const stream = cloudinary.uploader.upload_stream(
            {
              public_id: publicIdFor(folder, file.filename, data?.prefix),
              resource_type: "image",
              overwrite: true,
            },
            (error) => (error ? reject(error) : resolve()),
          );
          stream.end(file.buffer);
        });
        return data;
      },

      async handleDelete({ filename, doc }) {
        await cloudinary.uploader.destroy(publicIdFor(folder, filename, doc?.prefix), { resource_type: "image" });
      },

      generateURL: ({ filename, prefix }) => urlFor(filename, prefix),

      // Only used if a file is requested through /api/media/file/...; normal pages link straight to Cloudinary.
      async staticHandler(_req, { params }) {
        const res = await fetch(urlFor(params.filename, params.prefix));
        if (!res.ok || !res.body) return new Response("Not found", { status: 404 });
        return new Response(res.body, {
          headers: {
            "Content-Type": res.headers.get("content-type") ?? "application/octet-stream",
            "Cache-Control": "public, max-age=31536000, immutable",
          },
        });
      },
    };
  };
