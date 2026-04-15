#!/bin/bash
curl -fsSL https://openclaw.ai/install.sh | bash

# Copy Claude AI config to ~/.claude
cp -r "$(dirname "$0")/../../ai/claude/." "$HOME/.claude"

