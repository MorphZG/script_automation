#!/bin/bash
# This script automates cloning the Gogh repository, setting up a Python virtual
# environment, installing dependencies, and running the Gogh theme installer.
# It includes robust error handling and conditional checks.
#
# https://github.com/Gogh-Co/Gogh
#
# --- Configuration Variables ---
#
# Shell Parameter Expansion  ${parameter:−word}
# Uses GIT_CLONES environment variable if set, otherwise defaults to a expansion of '$HOME/git_clones'
# https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Shell-Parameter-Expansion
GIT_CLONES="${GIT_CLONES:-$HOME/git_clones}"

GOGH_REPO_URL="https://github.com/Gogh-Co/Gogh.git"
GOGH_PATH="$GIT_CLONES/gogh"
VENV_NAME="myenv"
VENV_PATH="$GOGH_PATH/$VENV_NAME"
REQUIREMENTS_FILE="$GOGH_PATH/requirements.txt"

# --- Error Handling & Script Behavior ---
# Exit immediately if a command exits with a non-zero status.
set -e
# Treat unset variables as an error when substituting.
set -u
# Enable verbose output, echoing commands before execution (useful for debugging).
# set -x

# --- Functions ---

# Check if a command exists.
check_command() {
    command -v "$1" &> /dev/null
}

# Function to run the Gogh theme script.
run_gogh_theme_script() {
    echo "Attempting to run the Gogh theme script..."
    if check_command "wget"; then
        bash -c "$(wget -qO- https://git.io/vQgMr)"
        echo "Gogh theme script executed successfully."
    else
        echo "Error: 'wget' is not installed."
        echo "Please install 'wget' (e.g., 'sudo apt install wget' on Debian/Ubuntu)"
        echo "and then run this script again."
        exit 1 # Exit if wget is needed but not found
    fi
}

# --- Main logic ---

echo "Starting Gogh setup script..."

# 1. Create the base directory for git clones if it doesn't exist.
echo "Ensuring base directory for clones exists: '$GIT_CLONES'"
mkdir -p "$GIT_CLONES"

# 2. Clone the Gogh repository.
if [ ! -d "$GOGH_PATH" ]; then
    echo "Gogh repository not found at '$GOGH_PATH'. Cloning..."
    git clone --depth=1 "$GOGH_REPO_URL" "$GOGH_PATH"
    echo "Gogh repository cloned successfully."
else
    echo "Gogh repository already exists at '$GOGH_PATH'. Skipping clone."
    # Optional: You could add 'git pull' here if you want to update the repo
    # echo "Updating existing Gogh repository..."
    # (cd "$GOGH_PATH" && git pull)
fi

# 3. Navigate into the Gogh directory.
echo "Changing directory to '$GOGH_PATH'."
# Using 'cd' and checking success is a common pattern.
# Alternative: 'pushd "$GOGH_PATH"' at start and 'popd' at end for stack-based navigation.
cd "$GOGH_PATH" || { echo "Failed to change directory to $GOGH_PATH. Exiting."; exit 1; }

# 4. Set the TERMINAL environment variable.
echo "Setting TERMINAL environment variable to 'alacritty'."
export TERMINAL="alacritty"

# 5. Set up and activate Python virtual environment, then install dependencies.
echo "Setting up Python virtual environment at '$VENV_PATH'..."
python3 -m venv "$VENV_PATH"
echo "Virtual environment created."

echo "Activating virtual environment and installing dependencies..."
# Source the activate script in a subshell for temporary activation,
# then run pip install within that subshell.
# This prevents polluting the main script's environment.
if [ -f "$VENV_PATH/bin/activate" ]; then
    . "$VENV_PATH/bin/activate" # Use '.' or 'source' to activate in current shell/subshell
    if [ -f "$REQUIREMENTS_FILE" ]; then
        pip install -r "$REQUIREMENTS_FILE"
        echo "Python dependencies installed successfully."
    else
        echo "Warning: '$REQUIREMENTS_FILE' not found. Skipping Python dependency installation."
    fi
    deactivate # Deactivate the virtual environment
else
    echo "Error: Virtual environment activation script not found at '$VENV_PATH/bin/activate'."
    echo "Please ensure Python 3 is installed and the venv was created successfully."
    exit 1
fi


# 6. Check for 'wget' and run the Gogh theme installer script.
echo "Checking for 'wget' and running theme installer..."

# Check if wget is installed
if ! check_command "wget"; then
    echo "'wget' is not installed."
    echo "Attempting to install 'wget' using 'sudo apt install wget'."
    echo "You may be prompted for your sudo password."
    # Attempt to install wget. If it fails, print error and exit.
    sudo apt install -y wget || { echo "Failed to install wget. Please install it manually."; exit 1; }
    echo "'wget' installed successfully."
fi

# Run the theme script now that wget is confirmed or installed
run_gogh_theme_script


echo ""
echo "Gogh setup complete! You might need to restart your terminal for theme changes to apply."
echo "You can manually run the Gogh theme installer again with: bash -c \"\$(wget -qO- https://git.io/vQgMr)\""
