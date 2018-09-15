#!/bin/bash

yum -y install bitmap-fonts bitmap-fonts-cjk
yum -y install mkfontscale fontconfig
mkdir /usr/share/fonts/win/
wget https://github.com/chenqing/ng-mini/blob/master/font/msyh.ttf?raw=true -O /usr/share/fonts/win/msyh.ttf --no-check-certificate
cd /usr/share/fonts/win/
mkfontscale
mkfontdir
fc-cache