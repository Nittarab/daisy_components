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
# Pre-commit hook to check and fix trailing newlines and run RuboCop
#

set -e

echo "🔍 Running pre-commit checks..."

# Fix trailing newlines first
echo "📝 Checking trailing newlines..."
./bin/fix_trailing_newlines.sh --staged-only

# Run RuboCop on staged Ruby files
echo "🔧 Running RuboCop..."
staged_ruby_files=$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(rb|rake)$' || true)

if [ -n "$staged_ruby_files" ]; then
    echo "   Checking: $staged_ruby_files"
    if ! bin/rubocop $staged_ruby_files; then
        echo "❌ RuboCop found issues. Please fix them before committing."
        echo "💡 Run 'bin/rubocop -a' to auto-fix some issues."
        exit 1
    fi
    echo "✅ RuboCop checks passed!"
else
    echo "ℹ️  No Ruby files to check with RuboCop"
fi

echo "🎉 All pre-commit checks passed!"
EOF

# Make it executable
chmod +x "$PRE_COMMIT_HOOK"

echo "✅ Pre-commit hook installed successfully!"
echo "🚀 The hook will now run automatically before each commit and will:"
echo "   • Fix trailing newlines automatically"
echo "   • Run RuboCop on staged Ruby files"
echo ""
echo "To test the hook, try staging a file and committing:"
echo "  git add ."
echo "  git commit -m 'test commit'"
