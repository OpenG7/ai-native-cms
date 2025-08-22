# AI Module Manifest — Schema & Validator

This bundle contains the JSON Schema for `ai-module.json` manifests and a Node-based validator.

## Files
- `schemas/ai-module-1.0.json` — Official JSON Schema (draft 2020-12)
- `scripts/validate-manifests.mjs` — Validator script
- `.github/workflows/validate-manifests.yml` — CI to validate on PR/Push
- `package.json` — NPM scripts and devDependencies

## Usage (local)
```bash
npm ci
npm run validate:manifests
```

Place your module manifests anywhere in the repo named `ai-module.json` (e.g. `libs/modules/*/ai-module.json`). The validator will discover and validate them.
