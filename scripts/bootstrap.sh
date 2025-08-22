#!/usr/bin/env bash
set -euo pipefail

# Basic guard
if ! command -v node >/dev/null; then
  echo "Node.js is required." >&2
  exit 1
fi

# Use Yarn via Corepack if available
if command -v corepack >/dev/null; then
  corepack enable || true
fi

# Create Nx workspace (empty preset)
WORKSPACE_NAME="openg7-ai-cms"
if [ ! -d "$WORKSPACE_NAME" ]; then
  echo "Creating Nx workspace: $WORKSPACE_NAME"
  yarn create nx-workspace@latest "$WORKSPACE_NAME" --preset=empty --pm=yarn -y || npx create-nx-workspace@latest "$WORKSPACE_NAME" --preset=empty -y
fi

cd "$WORKSPACE_NAME"

# Add Nx plugins
yarn add -D @nx/nest @nx/angular @nx/js @nx/eslint @types/node typescript

# Generate apps
npx nx g @nx/nest:application cms-core --directory=apps --tags=scope:backend,type:app --no-interactive
npx nx g @nx/nest:application ai-engine --directory=apps --tags=scope:backend,type:worker --no-interactive
npx nx g @nx/angular:application admin --directory=apps --routing --ssr --style=css --tags=scope:frontend,type:app --no-interactive

# Generate libs
npx nx g @nx/js:library sdk --directory=libs --unitTestRunner=jest --tags=scope:sdk,type:lib --no-interactive
npx nx g @nx/js:library modules --directory=libs --unitTestRunner=jest --tags=scope:modules,type:lib --no-interactive

# Create example module files
mkdir -p libs/modules/auto-tagger/src
cat > libs/modules/auto-tagger/src/index.ts <<'TS'
export interface AiContext {
  models: { use: (name: string) => { generateJSON: (args: any) => Promise<any> } };
  cms: { update: (collection: string, id: string, patch: any) => Promise<void> };
}

export default {
  id: "ai.autotag",
  version: "1.0.0",
  tools: [{
    name: "suggestTags",
    async handler(ctx: AiContext, input: { text: string }) {
      const prompt = `Propose 3 à 6 tags SEO pour:\n---\n${input.text}`;
      const model = ctx.models.use("gpt-4o-mini");
      const out = await model.generateJSON({ prompt, schema: { tags: ["string"] } });
      return { tags: out.tags ?? [] };
    }
  }],
  async onEvent(evt: any, ctx: AiContext) {
    if (evt.type === "content.created" && evt.payload?.collection === "articles") {
      const body = evt.payload?.data?.body ?? "";
      const { tags } = await this.tools[0].handler(ctx, { text: body });
      await ctx.cms.update("articles", evt.payload.id, { tags });
    }
  }
};
TS

cat > libs/modules/auto-tagger/README.md <<'MD'
# Auto‑Tagger Module (example)

- Listens to `content.created` events for `articles`.
- Calls an AI model to suggest 3‑6 SEO tags.
- Updates the document and returns tags.

> This is a simplified example. Real modules should declare schemas, permissions, and handle errors/retries.
MD

echo "✅ Bootstrap complete. Next steps:
- Open the workspace in your editor
- Run 'yarn nx graph' and 'yarn nx serve admin'"
