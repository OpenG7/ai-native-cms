# Contributing Guide

Thanks for helping build the **OpenG7 AI‑Native CMS**!

## Development setup

1. Node 20+, Git, Docker (optional for Postgres/Qdrant).  
2. Enable Corepack and Yarn (optional):
   ```bash
   corepack enable
   yarn set version stable
   ```
3. Run the bootstrap:
   ```bash
   bash scripts/bootstrap.sh
   ```
4. Start apps:
   ```bash
   yarn nx serve admin
   yarn nx serve cms-core
   yarn nx serve ai-engine
   ```

## Commit style

- Conventional Commits (e.g., `feat: add module manifest loader`, `fix(ai): guard PII redaction`).  
- Small PRs, clear scope, tests when possible.

## RFCs

For non‑trivial design changes, open a short RFC in `docs/RFCs/` and link it in your PR.

## Code quality

- TypeScript strict mode.  
- Lint/format on CI.  
- Avoid secrets in code; use env vars + vault.

## Community

Be kind. Assume good intent. See **CODE_OF_CONDUCT.md**.
