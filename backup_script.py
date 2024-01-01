import os
import shutil

dirs = input("Enter the directories you want to backup separated by space: ").split()
final_archivename = input("Enter the filename for final .tar archive: ")
output_dir = os.path.expanduser("~/backups/")

if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Create archive for each selected directory
for dir in dirs:
    dir_path = os.path.expanduser(dir)
    if os.path.isdir(dir_path):
        archive_path = os.path.join(output_dir, dir.replace("/", "_") + ".tar")
        # creates the .tar archive with the following name:
        # "archive_path.tar" but then [:-4] removes ".tar" from the name
        # shutil.make_archive(base_name, format, base_dir)
        shutil.make_archive(archive_path[:-4], "tar", dir_path)
    else:
        print(f"Error: {dir_path} does not exist or is not a directory")

# TODO
# all directories from the user input are in separate archive
# combine them together using the final_archivename variable 

print(f"Backup created in {output_dir}")
