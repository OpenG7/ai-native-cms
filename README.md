# OpenG7 AI‑Native CMS

> A community‑driven, **AI‑native CMS** where the AI engine is part of the core — not a plugin.  
> Un projet communautaire **AI‑native** où le moteur IA est **au cœur** du CMS, pas un add‑on.

## ✨ Vision

- **Kernel CMS (NestJS)** : types de contenu, validations, workflows, ACL, events.  
- **AI Engine** : adapters de modèles (OpenAI/Azure/local), RAG (pgvector), orchestration de tools, policies.  
- **SDK Modules (TypeScript)** : créez des modules personnalisés avec manifeste déclaratif et outils.  
- **Admin UI (Angular)** : marketplace interne, réglages IA, observabilité (coûts/qualité), policies.

## 📦 Monorepo plan (Nx)

```
apps/
  admin/        # Angular 19 (SSR, Tailwind)
  cms-core/     # NestJS (API & events)
  ai-engine/    # NestJS worker (queues, RAG, jobs)
libs/
  sdk/          # SDK pour créer des modules IA
  modules/      # Exemples de modules (auto-tagger, summarizer)
docs/
  ROADMAP.md
  RFCs/
    0001-module-manifest.md
```

## 🚀 Quickstart (bootstrap automatique)

1) Installez Node 20+ et Git.  
2) (Optionnel) Activez Yarn via Corepack :

```bash
corepack enable
yarn set version stable
```

3) Lancez le **script de bootstrap** (crée une workspace Nx et les apps de base) :

```bash
bash scripts/bootstrap.sh
```

4) Démarrez en dev :

```bash
yarn install
yarn nx graph          # visualise la dépendence
yarn nx serve admin    # démarre l'UI d'administration
yarn nx serve cms-core # démarre l'API
yarn nx serve ai-engine
```

> ℹ️ Vous pouvez ajuster les commandes Nx selon la version (18/19/20). Le script fournit des valeurs par défaut raisonnables.

## 🧩 Exemple de module IA

Voir `libs/modules/auto-tagger/README.md` — un module de **tagging SEO** qui s'accroche aux events `content.created`.

## 🔐 Sécurité & données

- Secrets par tenant (vault), audit des appels modèle, quotas/policies.  
- Données au Canada possibles (Postgres + S3 compatible).

## 🤝 Contribution

- Lisez [CONTRIBUTING.md](CONTRIBUTING.md) et [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).  
- Ouvrez une *issue* ou une *RFC* dans `docs/RFCs/` pour les changements de design.

## 📜 Licence

Code sous **Apache‑2.0**. Voir [LICENSE](LICENSE).  
Contenus médias/docs peuvent utiliser **CC‑BY‑4.0** (à préciser par fichier).

---

### English Summary

This repository provides the **skeleton** for an AI‑native CMS built with **NestJS + Angular** in an **Nx monorepo**. It ships with an **AI engine**, **SDK for modules**, and an **admin UI**. A bootstrap script scaffolds apps, libs, and basic configuration so the community can focus on modules and features.
