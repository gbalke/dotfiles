#!/bin/bash
DOTFILES=$HOME/dotfiles

# Init the submodules for things like tmux theme pack
cd $DOTFILES
git submodule init
git submodule update

# Installing powerline fonts for vim
FONTS=$HOME/fonts
if ! (fc-list | grep -qi powerline); then
  git clone https://github.com/powerline/fonts.git $FONTS
  bash $FONTS/install.sh
  rm -rf $FONTS
fi

echo
echo "Installing baseline apps"
sudo apt install\
  curl\
  vim\
  tmux\
  i3\
  python3\
  python3-setuptools\
  compton\
  htop\
  pavucontrol\
  thunar\
  xbacklight\
  stow\
  blueman\
  feh\
  exfat-fuse\
  exfat-utils\
  gnome-screensaver\
  scrot\

echo
echo "Adding package repos"
declare -a ppa_list=("mmstick76/alacritty"\
                     "js-reynaud/kicad-5.1"\
                     "team-gcc-arm-embedded/ppa")

for the_ppa in "${ppa_list[@]}"
do
  if ! grep -q "$the_ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository ppa:$the_ppa
  fi
done

# Chrome is annoying for packages
if ! grep -q "dl.google.com/linux/chrome/deb/" /etc/apt/sources.list.d/*; then
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
fi

sudo apt-get update

sudo apt install\
  alacritty\
  gcc make\
  kicad\
  gcc-arm-none-eabi openocd\
  google-chrome-stable

echo
echo "Installing pip"
curl https://bootstrap.pypa.io/get-pip.py -o $HOME/get-pip.py
python3 $HOME/get-pip.py --user
rm $HOME/get-pip.py

echo
echo "Linking dot files"
cd $DOTFILES
stow -v vim\
        bash\
        tmux\
        xorg\
        i3\
        git\
        alacritty

source $HOME/.bashrc
