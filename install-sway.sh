#!/bin/bash

# Sway dependencies
sudo apt-get install \
    meson\
    libpcre2-dev\
    libjson-c-dev\
    libpango1.0-dev\
    libcairo2-dev\
    libgdk-pixbuf2.0-dev\
    scdoc

# wlroots dependencies
sudo apt-get install \
    glslang-tools\
    libdrm-dev\
    libgbm-dev\
    libudev-dev\
    libvulkan-dev\
    libegl-dev\
    libgles-dev\
    libinput-dev\
    libxkbcommon-dev

# wayland dependencies
sudo apt-get install \
    doxygen\
    xmlto\
    graphviz

# Nvidia wayland dependencies
sudo apt-get install \
    eglexternalplatform-dev

# XWayland dependencies
sudo apt-get install \
    libxcb-composite0-dev\
    libxcb-util-dev\
    libxcb-icccm4-dev\
    libxcb-render-util0-dev\
    libxcb-xinput-dev\
    libxcb-res0-dev

# seatd dependencies
sudo apt-get install \
    libsystemd-dev

mkdir -p ~/programs

# Seatd Source Download
if [ ! -d "~/programs/seatd" ]; then
    cd ~/programs
    git clone https://github.com/kennylevinsen/seatd.git seatd
fi

# Wayland Source Download
if [ ! -d "~/programs/wayland" ]; then
    cd ~/programs
    #git clone https://gitlab.freedesktop.org/wayland/wayland.git wayland
    git clone https://github.com/NVIDIA/egl-wayland.git wayland
    
fi

# Wayland Protocols Source Download
if [ ! -d "~/programs/wayland-protocols" ]; then
    cd ~/programs
    git clone https://gitlab.freedesktop.org/wayland/wayland-protocols.git wayland-protocols
fi

# Sway Source Download
if [ ! -d "~/programs/sway" ]; then
    cd ~/programs
    git clone https://github.com/swaywm/sway.git
    # This branch is required for wlroots-eglstreams.
    cd ~/programs/sway
    git checkout f707f583e17cb5e8323ceb4bfd951ad0465b7d10
fi

# Wlroots source download
if [ ! -d "~/programs/sway/subprojects/wlroots" ]; then
    cd ~/programs/sway
    #git clone https://gitlab.freedesktop.org/wlroots/wlroots.git subprojects/wlroots
    git clone https://github.com/danvd/wlroots-eglstreams.git subprojects/wlroots
fi

# wlr-randr source download
if [ ! -d "~/programs/wlr-randr" ]; then
    cd ~/programs
    #git clone https://gitlab.freedesktop.org/wlroots/wlroots.git subprojects/wlroots
    git clone https://git.sr.ht/~emersion/wlr-randr wlr-randr
fi

echo "Building Seatd"
cd ~/programs/seatd
meson --reconfigure build/
meson build/
ninja -C build/

sudo ninja -C build/ install
echo "Building Wayland"
cd ~/programs/wayland
meson --reconfigure build/
meson build/
ninja -C build/
sudo ninja -C build/ install

echo "Building Wayland Protocols"
cd ~/programs/wayland-protocols
meson --reconfigure build/
meson build/
ninja -C build/
sudo ninja -C build/ install

echo "Building Sway"
cd ~/programs/sway
meson --reconfigure build/
meson build/ -Dseatd:builtin=enabled
ninja -C build/
sudo ninja -C build/ install

echo "Building Sway"
cd ~/programs/wlr-randr
meson --reconfigure build/
meson build/
ninja -C build/
sudo ninja -C build/ install


#/usr/share/wayland-sessions/sway.desktop
