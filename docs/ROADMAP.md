# ROADMAP (MVP → v0.1)

- MVP
  - Nx monorepo scaffold (admin, cms-core, ai-engine, sdk, modules)
  - Events bus + basic content types
  - Model adapter (one provider) + embeddings (pgvector)
  - Example modules: auto-tagger, summarizer
  - Semantic search API + minimal UI
  - Policies/quotas (per tenant), audit log

- v0.1
  - Marketplace (install/enable/config/upgrade modules)
  - Prompt Hub (versioning, A/B)
  - Observability dashboard (latency, tokens, cost, quality)
  - RAG with citations + document ingestion pipeline
