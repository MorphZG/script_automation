#!/bin/bash

# Check if the script is run with any argument, otherwise ask for input
if [ "$1" ]; then
  # Predefined array of paths to backup
  dirs=("/home/zoran/coding_documents/" "/home/zoran/Documents/" "/home/zoran/.dotfiles/")
  echo "Backing up these directories..."
  sleep 2;
  # Print the directories being backed up
  for dir in "${dirs[@]}"; do
    echo "$dir"
  done
  sleep 4;
else
  # Prompt the user to input directories for backup
  echo "Enter the directories you want to backup separated by space: "
  read -a dirs
fi

# Set the output directory for backups
output_dir="$HOME/backups/"
mkdir -p "$output_dir"

# Create archive for each selected directory
for dir in "${dirs[@]}"; do
  if [ -d "$dir" ]; then
    # Generate a formatted filename based on the last component of the path
    # Example: /home/user/top_directory/ >> top_directory.tar
    filename=$(basename "$dir") # Extract the last component of the path
    tar -cvf "$output_dir/${filename//\//_}.tar" "$dir"
  else
    echo "Error: $dir does not exist or is not a directory"
  fi
done

echo "Backup created in $output_dir"
