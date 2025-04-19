#!/bin/bash

# Exit immediately if any command fails (i.e., returns a non-zero exit code).
set -e

echo '🏁 Initiating Setup...'
echo "🔍 Checking for global dependencies..."

# Check for pnpm
if ! command -v pnpm &> /dev/null; then
  echo "📦 pnpm not found. Installing..."
  npm install -g pnpm@10.8.1
else
  echo "✅ pnpm is already installed."
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
