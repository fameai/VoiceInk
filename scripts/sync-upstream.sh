#!/bin/bash
# Sync source-build branch with upstream VoiceInk
#
# Workflow:
#   main         = clean upstream (Beingpax/VoiceInk)
#   source-build = local patches rebased on main
#
# Usage: ./scripts/sync-upstream.sh

set -e

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Syncing with upstream VoiceInk...${NC}"

# Fetch latest from origin
echo "Fetching origin..."
git fetch origin

# Update main
echo "Updating main branch..."
git checkout main
git pull origin main

# Rebase source-build onto updated main
echo -e "${YELLOW}Rebasing source-build onto main...${NC}"
git checkout source-build

if git rebase main; then
    echo -e "${GREEN}✓ Successfully synced source-build with upstream${NC}"
    echo ""
    echo "Local patches:"
    git log main..source-build --oneline
else
    echo -e "${RED}✗ Rebase conflict! Resolve manually:${NC}"
    echo "  1. Fix conflicts in the listed files"
    echo "  2. git add <fixed-files>"
    echo "  3. git rebase --continue"
    echo ""
    echo "Or abort with: git rebase --abort"
    exit 1
fi
