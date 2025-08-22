# RFC-0001 — Module Manifest

## Goal
Specify a minimal, declarative manifest for AI modules that declare permissions, events, and tools.

## Fields
- `id`, `name`, `version`
- `permissions`: array of scopes (e.g., `content:read`, `model:invoke:*`)
- `events`: array of CMS event names
- `tools`: list of tool definitions with JSON Schemas

## Example
```json
{
  "id": "ai.autotag",
  "name": "Auto-Tagger",
  "version": "1.0.0",
  "permissions": ["content:read", "content:update", "model:invoke:gpt-4o-mini"],
  "events": ["content.created"],
  "tools": ["suggestTags"]
}
```
