#!/bin/bash

# Init the submodules for things like tmux theme pack
git submodule init
git submodule update

# Symbolically link all the dot files!
stow -v vim\
        bash\
        tmux\
        xorg\
        i3\
        git\
