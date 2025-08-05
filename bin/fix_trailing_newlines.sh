#!/bin/bash
#
# fix_trailing_newlines.sh - Script to check and fix trailing newlines
# Usage: ./bin/fix_trailing_newlines.sh [--check-only] [--staged-only]
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default options
CHECK_ONLY=false
STAGED_ONLY=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --check-only)
            CHECK_ONLY=true
            shift
            ;;
        --staged-only)
            STAGED_ONLY=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [--check-only] [--staged-only]"
            echo ""
            echo "Options:"
            echo "  --check-only   Only check for issues, don't fix them"
            echo "  --staged-only  Only check staged files (for git hooks)"
            echo "  --help         Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

echo -e "${BLUE}🔍 Checking for trailing newlines...${NC}"

# Determine which files to check
if [ "$STAGED_ONLY" = true ]; then
    # Only check staged files
    files=$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(rb|erb|css|js|md|yml|yaml|json)$' || true)
    echo -e "${BLUE}📋 Checking staged files only${NC}"
else
    # Check all relevant files in the repository
    files=$(find . -type f \( -name "*.rb" -o -name "*.erb" -o -name "*.css" -o -name "*.js" -o -name "*.md" -o -name "*.yml" -o -name "*.yaml" -o -name "*.json" \) -not -path "./.git/*" -not -path "./node_modules/*" -not -path "./tmp/*" -not -path "./log/*")
    echo -e "${BLUE}📋 Checking all source files${NC}"
fi

if [ -z "$files" ]; then
    echo -e "${GREEN}✅ No relevant files to check.${NC}"
    exit 0
fi

files_with_issues=()
files_fixed=0
total_files=0

# Check each file for missing trailing newlines
while IFS= read -r file; do
    if [ -f "$file" ] && [ -s "$file" ]; then
        total_files=$((total_files + 1))
        
        # Check if file ends with newline
        if [ "$(tail -c1 "$file" | wc -l)" -eq 0 ]; then
            files_with_issues+=("$file")
            
            if [ "$CHECK_ONLY" = true ]; then
                echo -e "${RED}❌ Missing trailing newline: $file${NC}"
            else
                echo -e "${YELLOW}⚠️  Fixing missing trailing newline: $file${NC}"
                echo "" >> "$file"
                
                # If we're checking staged files, re-stage the fixed file
                if [ "$STAGED_ONLY" = true ]; then
                    git add "$file"
                fi
                
                files_fixed=$((files_fixed + 1))
            fi
        fi
    fi
done <<< "$files"

# Summary
echo ""
echo -e "${BLUE}📊 Summary:${NC}"
echo -e "   Total files checked: $total_files"
echo -e "   Files with issues: ${#files_with_issues[@]}"

if [ "$CHECK_ONLY" = true ]; then
    if [ ${#files_with_issues[@]} -gt 0 ]; then
        echo -e "${RED}❌ Found ${#files_with_issues[@]} files missing trailing newlines${NC}"
        exit 1
    else
        echo -e "${GREEN}✅ All files have proper trailing newlines${NC}"
        exit 0
    fi
else
    if [ $files_fixed -gt 0 ]; then
        echo -e "${GREEN}✅ Fixed trailing newlines in $files_fixed files${NC}"
        if [ "$STAGED_ONLY" = true ]; then
            echo -e "${GREEN}📝 Fixed files have been automatically staged${NC}"
        fi
    else
        echo -e "${GREEN}✅ All files already have proper trailing newlines${NC}"
    fi
fi

echo -e "${GREEN}🎉 Done!${NC}"
