#!/bin/bash
STR="hjvid_"$(date +%Y%m%d_%H%M%S)
sudo raspivid -o /tmp/$STR.h264 -t 10000 --nopreview
sudo MP4Box -fps 30 -add /tmp/$STR.h264 /tmp/$STR.mp4
~/Dropbox-Uploader/dropbox_uploader.sh upload /tmp/$STR.mp4 /Kodi/$STR.mp4
sudo rm /tmp/$STR.h264 
sudo rm /tmp/$STR.mp4
