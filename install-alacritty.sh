#!/bin/bash

sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 cargo

if [ ! -d "~/programs/alacritty" ]; then
    mkdir -p ~/programs
    cd ~/programs
    git clone https://github.com/alacritty/alacritty
fi

cd ~/programs/alacritty
cargo build --release

sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
