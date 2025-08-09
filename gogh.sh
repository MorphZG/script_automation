#! /bin/bash
# follow instructions for non-interactive mode
# clone the repository
# https://github.com/Gogh-Co/Gogh
#

git clone --depth=1 https://github.com/Gogh-Co/Gogh.git $GIT_CLONES/gogh && cd gogh

export TERMINAL=alacritty

# activate python environment and install from requirements.txt
python3 -m venv myenv
source ./myenv/bin/activate
pip install -r requirements.txt

# Check if the 'wget' command exists
if command -v wget &> /dev/null
then
    # run the script to select the terminal theme
    bash -c  "$(wget -qO- https://git.io/vQgMr)" 
else
    echo "wget is not installed."
    echo "installing wget"
    sudo apt install wget
fi

