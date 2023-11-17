import os
import shutil

# this is a python script. file extension is .py

dirs = input("Enter the directories you want to backup separated by space: ").split()
output_dir = os.path.expanduser("~/backups/")

if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Create archive for each selected directory
for dir in dirs:
    dir_path = os.path.expanduser(dir)
    if os.path.isdir(dir_path):
        archive_path = os.path.join(output_dir, dir.replace("/", "_") + ".tar")
        shutil.make_archive(archive_path[:-4], "tar", dir_path)
    else:
        print(f"Error: {dir_path} does not exist or is not a directory")

print(f"Backup created in {output_dir}")
