#!/bin/bash

pgrep Xephyr || Xephyr -br -ac -reset -screen 1280x768 :1 &
sleep 1
DISPLAY=:1 dwm/dwm 
