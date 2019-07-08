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

# Installing font awesome fonts for i3 status bar
if ! (fc-list | grep -qi NerdFonts); then
  git clone https://github.com/ryanoasis/nerd-fonts.git $FONTS
  bash $FONTS/install.sh
  rm -rf $FONTS
fi

echo
echo "Installing baseline apps"
sudo apt install\
  curl\
  vim\
  tmux\
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

# So is i3
if ! grep -q "debian.sur5r.net/i3/" /etc/apt/sources.list.d/*; then
  /usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2019.02.01_all.deb /tmp/keyring.deb SHA256:176af52de1a976f103f9809920d80d02411ac5e763f695327de9fa6aff23f416
  sudo dpkg -i /tmp/keyring.deb
  sudo sh -c 'echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list'
fi


sudo apt-get update

sudo apt install\
  alacritty\
  gcc make\
  kicad\
  gcc-arm-none-eabi openocd\
  google-chrome-stable\
  i3

if ! hash pip 2>/dev/null; then
  echo
  echo "Installing pip"
  curl https://bootstrap.pypa.io/get-pip.py -o $HOME/get-pip.py
  python3 $HOME/get-pip.py --user
  rm $HOME/get-pip.py
fi

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
