"""
Insert the frontmatter into the markdown notes
"""
import os
import re

# List of required front matter properties
REQUIRED_FIELDS = [
    'author', 'pubDate', 'heroImage', 'source', 'status', 'type', 'URL'
]

# Path to start searching for markdown files
ROOT_DIR = '.'

# Regex to match front matter block
FRONTMATTER_REGEX = re.compile(r'(?m)^---\n(.*?)\n---', re.DOTALL)

def process_markdown(file_path):
    with open(file_path, 'r') as file:
        content = file.read()
    
    # Extract front matter block
    frontmatter_match = FRONTMATTER_REGEX.search(content)
    if not frontmatter_match:
        print(f"Skipping {file_path} - No front matter found.")
        return

    frontmatter = frontmatter_match.group(1).splitlines()
    updated_frontmatter = frontmatter[:]

    # Check and add missing properties
    for field in REQUIRED_FIELDS:
        if not any(line.startswith(f"{field}:") for line in frontmatter):
            updated_frontmatter.append(f"{field}:")

    # Reconstruct the file with updated front matter
    updated_content = FRONTMATTER_REGEX.sub(
        f"---\n{chr(10).join(updated_frontmatter)}\n---",
        content
    )

    with open(file_path, 'w') as file:
        file.write(updated_content)

    print(f"Updated {file_path}")

# Recursively search for markdown files and process them
for dirpath, _, filenames in os.walk(ROOT_DIR):
    for filename in filenames:
        if filename.endswith('.md'):
            process_markdown(os.path.join(dirpath, filename))

print("Front matter properties updated for all markdown files.")
