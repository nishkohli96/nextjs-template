#!/bin/bash

REQUIRED_PNPM_VERSION="10.33.0"

# Exit immediately if any command fails (i.e., returns a non-zero exit code).
set -e

echo '🏁 Initiating Setup...'
echo "🔍 Checking for global dependencies..."

# Ensure nvm is loaded
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
else
  echo "❌ nvm is not installed. Please install nvm first."
  exit 1
fi

# Use Node version from .nvmrc
if [ -f ".nvmrc" ]; then
  echo "🔧 Using Node version from .nvmrc..."
  nvm install
  nvm use
else
  echo "⚠️ .nvmrc not found. Skipping Node version setup."
fi

# Check if pnpm is installed and the version
if command -v pnpm &> /dev/null; then
  CURRENT_PNPM_VERSION=$(pnpm -v)
  if [ "$(printf '%s\n' "$REQUIRED_PNPM_VERSION" "$CURRENT_PNPM_VERSION" | sort -V | head -n1)" != "$REQUIRED_PNPM_VERSION" ]; then
    echo "⚠️ pnpm version $CURRENT_PNPM_VERSION is older than $REQUIRED_PNPM_VERSION. Upgrading..."
    npm install -g pnpm@$REQUIRED_PNPM_VERSION
  else
    echo "✅ pnpm v$CURRENT_PNPM_VERSION is installed."
  fi
else
  echo "📦 pnpm not found. Installing v$REQUIRED_PNPM_VERSION..."
  npm install -g pnpm@$REQUIRED_PNPM_VERSION
fi

# Check for npm-check-updates
if ! command -v npm-check-updates &> /dev/null; then
  echo "📦 npm-check-updates not found. Installing..."
  npm install -g npm-check-updates
else
  echo "✅ npm-check-updates is already installed."
fi

echo "📁 Installing project dependencies..."
pnpm install

echo "🛠️  Building the app!"
pnpm build

echo "✅ Setup complete!"
echo "🚀 You can now run the app using: \"pnpm dev\""
echo "📖 For more information, check the README.md file."
