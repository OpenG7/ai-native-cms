#!/usr/bin/env node
import { readFile } from "node:fs/promises";
import path from "node:path";
import process from "node:process";
import globby from "globby";
import Ajv from "ajv";

const repoRoot = process.cwd();
const schemaPath = path.join(repoRoot, "schemas", "ai-module-1.0.json");

async function loadJson(file) {
  const buf = await readFile(file, "utf8");
  return JSON.parse(buf);
}

async function main() {
  const schema = await loadJson(schemaPath);
  const ajv = new Ajv({ allErrors: true, strict: false });
  const validate = ajv.compile(schema);

  const patterns = [
    "libs/**/ai-module.json",
    "apps/**/ai-module.json",
    "packages/**/ai-module.json",
    "**/ai-module.json"
  ];
  const files = (await globby(patterns, { gitignore: true }))
    .filter((f, i, arr) => !f.includes("node_modules") && arr.indexOf(f) === i);

  if (files.length === 0) {
    console.log("ℹ️ No ai-module.json files found. Skipping validation.");
    process.exit(0);
  }

  let ok = true;
  for (const file of files) {
    try {
      const data = await loadJson(file);
      const valid = validate(data);
      if (!valid) {
        ok = false;
        console.error(`❌ ${file} failed validation:`);
        for (const err of validate.errors ?? []) {
          console.error(`  - ${err.instancePath || '(root)'} ${err.message}`);
        }
      } else {
        console.log(`✅ ${file} is valid.`);
      }
    } catch (e) {
      ok = false;
      console.error(`❌ ${file} could not be parsed:`, e.message);
    }
  }
  process.exit(ok ? 0 : 1);
}

main().catch(err => {
  console.error("Validator crashed:", err);
  process.exit(2);
});
