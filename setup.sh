#!/bin/bash

set -e

REQUIRED_NODE_VERSION="24.14.0"
REQUIRED_PNPM_VERSION="11.9.0"

echo "🏁 Initiating setup..."

# -----------------------------
# Load NVM
# -----------------------------
export NVM_DIR="$HOME/.nvm"

if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
else
  echo "❌ nvm is not installed."
  exit 1
fi

# -----------------------------
# Setup Node version
# -----------------------------
if [ -f ".nvmrc" ]; then
  echo "🔧 Using Node version from .nvmrc..."
  nvm install
  nvm use
else
  echo "⚠️ .nvmrc not found. Using Node $REQUIRED_NODE_VERSION..."
  nvm install $REQUIRED_NODE_VERSION
  nvm use $REQUIRED_NODE_VERSION
fi

echo "✅ Node version: $(node -v)"

# -----------------------------
# Install pnpm
# -----------------------------
echo "📦 Installing pnpm@$REQUIRED_PNPM_VERSION..."

npm uninstall -g pnpm >/dev/null 2>&1 || true
npm install -g pnpm@$REQUIRED_PNPM_VERSION

echo "✅ pnpm version: $(pnpm -v)"

# -----------------------------
# Install npm-check-updates
# -----------------------------
if ! command -v ncu >/dev/null 2>&1; then
  echo "📦 Installing npm-check-updates..."
  npm install -g npm-check-updates
else
  echo "✅ npm-check-updates already installed."
fi

# -----------------------------
# Clean old dependencies
# -----------------------------
echo "🧹 Removing old dependencies..."

rm -rf node_modules
rm -rf .next

# -----------------------------
# Install dependencies
# -----------------------------
echo "📁 Installing dependencies..."

pnpm install --frozen-lockfile

# -----------------------------
# Build app
# -----------------------------
echo "🛠️ Building app..."

pnpm build

# -----------------------------
# Done
# -----------------------------
echo "✅ Setup complete!"
echo "🚀 Start development server: pnpm dev"
