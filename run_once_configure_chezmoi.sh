#!/bin/bash

# Define the lines to append
CONFIG_LINES="[git]
    autoCommit = true
    commitMessageTemplate = \"{{ promptString \\\"Commit message\\\" }}\""

# Target file
TARGET_FILE="$HOME/.config/chezmoi/chezmoi.toml"

# Check if the file exists, create it if not
if [ ! -f "$TARGET_FILE" ]; then
    echo "File does not exist. Creating $TARGET_FILE..."
    mkdir -p "$(dirname "$TARGET_FILE")"
    touch "$TARGET_FILE"
fi

# Append the lines to the file
echo -e "$CONFIG_LINES" >> "$TARGET_FILE"

echo "Configuration appended to $TARGET_FILE."
