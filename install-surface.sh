#!/bin/bash

DRIVERS=$HOME/drivers
if ! (grep -qRi surface /etc/udev/); then
  git clone https://github.com/jakeday/linux-surface.git $DRIVERS
  bash $DRIVERS/setup.sh
  rm -rf $DRIVERS
fi

KERNELS=$HOME/kernels
mkdir -p kernels
echo "Get the latest kernel at: https://github.com/jakeday/linux-surface/releases"
echo "Sign the kernel following: https://github.com/jakeday/linux-surface/blob/master/SIGNING.md"

BKLT_CONF=/etc/X11/xorg.conf
if ! (grep -q intel_backlight $BKLT_CONF); then
  echo "
Section \"Device\"
Identifier  \"Card0\"
Driver      \"intel\"
Option      \"Backlight\"  \"intel_backlight\"
EndSection
  " | sudo tee -a $BKLT_CONF
fi
