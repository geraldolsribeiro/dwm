#!/bin/bash

git submodule update --init --recursive

make -C dwm-flexipatch/ clean all
#sudo make -C dwm-flexipatch/ install

chmod 755 flexipatch-finalizer/flexipatch-finalizer.sh
./flexipatch-finalizer/flexipatch-finalizer.sh \
  -r -d ~/git/github/dwm/dwm-flexipatch/ \
  -o ~/git/github/dwm/dwm

make -C dwm clean all
sudo make -C dwm install

