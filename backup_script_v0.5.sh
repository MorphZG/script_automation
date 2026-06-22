#!/bin/bash

# Exit immediately if a command exits with a non-zero status,
# and treat unset variables as an error.
set -euo pipefail

# Initialize an empty array for directories
dirs=()

# Check if the script is run with an argument to trigger automated backup
if [ "${1:-}" ]; then
  # Predefined array of paths to backup
  dirs=("/home/zoran/coding/" "/home/zoran/Documents/" "/home/zoran/.dotfiles/")
  echo "Backing up these directories:"
  for dir in "${dirs[@]}"; do
    echo "  - $dir"
  done
else
  # Prompt the user to input directories for backup
  echo "Enter the directories you want to backup separated by space: "
  # -r prevents backslash escapes from interpreting characters
  read -r -a dirs
fi

# Set and create the output directory
output_dir="$HOME/backups"
mkdir -p "$output_dir"

# Create archive for each selected directory
for dir in "${dirs[@]}"; do
  # Remove trailing slash if present for consistent basename behavior
  dir="${dir%/}"

  if [ -d "$dir" ]; then
    filename=$(basename "$dir")

    echo "Archiving $dir..."

    # Compressed using gzip (.tar.gz) and excluding node_modules
    tar --exclude='node_modules' -czf "$output_dir/${filename}.tar.gz" -C "$(dirname "$dir")" "$filename"
  else
    echo "Warning: '$dir' does not exist or is not a directory. Skipping." >&2
  fi
done

echo "Backup process complete. Files saved in: $output_dir"
