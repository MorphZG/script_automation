#!/bin/bash

# if script is run with any argument than use predefined array of paths to backup
if [ $1 ]
then
  dirs=("/home/zoran/coding_documents/" "/home/zoran/Documents/" "/home/zoran/dotfiles/")
  echo "I will backup these directories..."
  sleep 2;
  #echo ${dirs[@]}
  echo ${dirs[0]}
  echo ${dirs[1]}
  echo ${dirs[2]}
  sleep 3;
# if there is no argument when running a script than ask to input paths for backup
else
  echo "Enter the directories you want to backup separated by space: "
  read -a dirs
fi

output_dir=$HOME/backups/
mkdir -p $output_dir

# Create archive for each selected directory
for dir in "${dirs[@]}"; do
  if [ -d "$dir" ]; then
    #tar -cvf "$output_dir/${dir//\//_}.tar" "$dir"
    tar -cvf "${dir//\//_}.tar" "$dir"
  else
    echo "Error: $dir does not exist or is not a directory"
  fi
done

echo "Backup created in $output_dir"

#tags: backup script
