#!/bin/bash

echo "Enter the directories you want to backup separated by space: "
read -a dirs

output_dir=$HOME/backups/
mkdir -p $output_dir

# Create archive for each selected directory
for dir in "${dirs[@]}"; do
  if [ -d "$dir" ]; then
    tar -cvf "$output_dir/${dir//\//_}.tar" "$dir"
  else
    echo "Error: $dir does not exist or is not a directory"
  fi
done

echo "Backup created in $output_dir"

#tags: backup script