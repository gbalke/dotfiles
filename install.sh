#!/bin/bash
DOTFILES=$HOME/dotfiles

# Init the submodules for things like tmux theme pack
cd $DOTFILES
git submodule init
git submodule update

# Installing powerline fonts for vim
FONTS=$HOME/fonts
git clone https://github.com/powerline/fonts.git $FONTS
bash $FONTS/install.sh
rm -rf $FONTS

# Install baseline apps
sudo apt install\
  tmux\
  i3\
  python3\
  compton\
  htop\
  pavucontrol\
  thunar\
  xbacklight\
  stow\
  blueman\
  feh

# Alacritty install
sudo add-apt-repository ppa:mmstick76/alacritty
sudo apt-get update
sudo apt install alacritty

# Kicad install
sudo add-apt-repository --yes ppa:js-reynaud/kicad-5.1
sudo apt update
sudo apt install --install-suggests kicad

# Arm gcc install
sudo add-apt-repository ppa:team-gcc-arm-embedded/ppa
sudo apt-get update
sudo apt-get install gcc-arm-none-eabi openocd

curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
python3 /tmp/get-pip.py

# Symbolically link all the dot files!
cd $DOTFILES
stow -v vim\
        bash\
        tmux\
        xorg\
        i3\
        git\
        alacritty

source $HOME/.bashrc
