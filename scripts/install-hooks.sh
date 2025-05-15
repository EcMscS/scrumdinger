#!/bin/bash

echo "📎 Installing pre-commit hook..."
cp .githooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
echo "✅ Done! Git pre-commit hook installed."