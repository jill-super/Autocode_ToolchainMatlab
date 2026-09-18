# Docs site (Astro + Starlight)

Interactive documentation for the Model-Based Design toolbox in this repository.
The site is intentionally free of hosting identifiers: no owner name, no project
name, no absolute Pages URL is stored in the source.

## Local development

```sh
cd docs
npm install
npm run dev
```

Then open the printed local URL.

## Production build

```sh
cd docs
npm install
npm run build
npm run preview
```

The static output is in `docs/dist/`.

## Publishing to a Pages-style host (you manage the workflow)

This folder contains no workflow file on purpose. A minimal publishing approach is:

1. Install and build with Node 20+.
2. Upload `docs/dist` as the Pages artifact and deploy it.

For a **project site** (served under a sub-path), set the base path only through
the environment — do not hard-code it:

```sh
DOCS_BASE="/<project>/" npm run build
```

Notes:

- Keep the trailing slash in `DOCS_BASE`.
- For a user/org root site or custom domain, omit `DOCS_BASE` (defaults to `/`).
- All internal links and assets already respect the configured base, so the same
  source works locally and when hosted.

## Structure

- `astro.config.mjs` — Starlight setup and sidebar. Base comes from `DOCS_BASE`.
- `src/content/docs/` — all pages (Starlight content collection).
- `src/components/` — small interactive islands (plain JS, no extra framework).
- `src/styles/custom.css` — theme polish.
- `public/` — static assets copied verbatim to the build output.
