#!/bin/bash
if ! grep -q "packages.ros.org/ros/ubuntu" /etc/apt/sources.list.d/*; then
  sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
  sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
fi

sudo apt-get update

sudo apt install ros-melodic-desktop

sudo rosdep init
rosdep update

source /opt/ros/melodic/setup.bash

sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential

sudo apt install ros-melodic-catkin
