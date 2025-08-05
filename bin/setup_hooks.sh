#!/bin/bash
#
# setup_hooks.sh - Install git hooks for the project
#

set -e

HOOKS_DIR=".git/hooks"
PRE_COMMIT_HOOK="$HOOKS_DIR/pre-commit"

echo "🔧 Setting up git hooks..."

# Ensure hooks directory exists
if [ ! -d "$HOOKS_DIR" ]; then
    echo "❌ Error: .git/hooks directory not found. Are you in a git repository?"
    exit 1
fi

# Install pre-commit hook
echo "📝 Installing pre-commit hook..."
cat > "$PRE_COMMIT_HOOK" << 'EOF'
#!/bin/sh
#
# Pre-commit hook to check and fix trailing newlines
# This hook will automatically add missing trailing newlines to staged files
#

# Use the dedicated script for consistency
exec ./bin/fix_trailing_newlines.sh --staged-only
EOF

# Make it executable
chmod +x "$PRE_COMMIT_HOOK"

echo "✅ Pre-commit hook installed successfully!"
echo "🚀 The hook will now run automatically before each commit."
echo ""
echo "To test the hook, try staging a file and committing:"
echo "  git add ."
echo "  git commit -m 'test commit'"
