#!/bin/bash

source "$(dirname "$0")/../utils.sh"

# Claude Code
if check_command claude; then
    echo "claude - skipped (already installed)"
else
    echo "Installing Claude Code ..."
    npm install -g @anthropic-ai/claude-code
fi

# OpenAI Codex
if check_command codex; then
    echo "codex - skipped (already installed)"
else
    echo "Installing OpenAI Codex ..."
    npm install -g @openai/codex
fi

# Copy Claude AI config to ~/.claude
cp -r "$(dirname "$0")/../../ai/claude/." "$HOME/.claude"
