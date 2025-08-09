#! /bin/bash
# follow instructions for non-interactive mode
# clone the repository
# https://github.com/Gogh-Co/Gogh
#

set -e

# Use a temporary directory for the clone
GIT_CLONE_DIR=$(mktemp -d)
REPOSITORY="https://github.com/Gogh-Co/Gogh.git"
VENV_DIR="$GIT_CLONE_DIR/gogh/myenv"
SCRIPT_URL="https://git.io/vQgMr"

# Function checking dependencies and ask for confirmation before installing
check_and_install_dependencies() {
    local dependancies=("git" "python3" "wget")
    for dep in "${dependancies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "Dependency '$dep' not found. Attempting to install with apt..."
            # Ask for confirmation before using sudo
            read -p "Do you want to install '$dep'? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo apt-get update && sudo apt-get install -y "$dep"
            else
                echo "Installation aborted by user. Exiting."
                exit 1
            fi
        fi
    done
}

# --- Main Script ---
trap 'rm -rf "$GIT_CLONE_DIR"' EXIT # Cleanup function to delete the temp directory on exit

echo "Checking for necessary dependencies..."
check_and_install_dependencies

echo "Cloning the repository into a temporary directory..."
git clone --depth=1 "$REPOSITORY" "$GIT_CLONE_DIR/gogh"

echo "Changing directory to the cloned repository..."
cd "$GIT_CLONE_DIR/gogh"

echo "Setting TERMINAL environment variable..."
export TERMINAL=alacritty

echo "Creating and activating a Python virtual environment..."
python3 -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

echo "Installing Python dependencies..."
"$VENV_DIR/bin/pip" install -r requirements.txt

echo "Downloading and running the theme selector script..."
# Using wget to download and then bash to execute the script
# This is still a security risk, but the download is explicit.
wget -qO- "$SCRIPT_URL" | bash


