#!/bin/bash

mkdir -p $HOME/backup
dpkg --get-selections > $HOME/backup/Package.list
sudo cp -R /etc/apt/sources.list* $HOME/backup/
sudo apt-key exportall > $HOME/backup/Repo.keys
