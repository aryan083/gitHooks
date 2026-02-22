#!/usr/bin/env bash
set -e

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

echo "Installing hooks from $ROOT/.githooks"

git config core.hooksPath "$ROOT/.githooks"

echo "Done."
