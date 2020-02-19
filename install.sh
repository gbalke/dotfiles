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
  autorandr\
  blueman\
  ctags\
  curl\
  htop\
  exfat-fuse\
  exfat-utils\
  feh\
  pavucontrol\
  python3\
  python3-setuptools\
  scrot\
  stow\
  thunar\
  tmux\
  vim\
  xbacklight\

echo
echo "Saving current monitor setup"
autorandr -s default

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
  KEYRING=https://debian.sur5.net/i3/pool/main/s/sur5r-keyring/
  DEB="$(curl $KEYRING | sed -n -e 's/\(.*href=\"\)\(.*deb\)\(\".*\)/\2/p')"
  wget $KEYRING$DEB -o /tmp/keyring.deb
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
  python $HOME/get-pip.py --user
  python3 $HOME/get-pip.py --user
  rm $HOME/get-pip.py
fi

echo
echo "Creating bin directory"
mkdir -p $HOME/bin

echo
echo "Linking dot files and bin directory"
cd $DOTFILES
stow -v vim\
        bash\
        tmux\
        xorg\
        i3\
        git\
        alacritty\
        thunar\
        bin

if ! (ls -a $HOME | grep -qi .bash_local); then
  touch $HOME/.bash_local
  cat "#!/bin/bash \n # Add extra setup here!" >> $HOME/.bash_local
fi

source $HOME/.bashrc
