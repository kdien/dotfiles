#!/usr/bin/env bash

if (("$(xrandr | grep -c connected)" > 1)); then
  sed -i 's/.*Xft\.dpi.*$/Xft.dpi: 192/' ~/.Xresources
  xrandr --output DP-1 --primary --pos 0x0 --output eDP-1 --pos 3840x1080 --right-of DP-1
else
  xrandr --auto
  sed -i 's/.*Xft\.dpi\(.*\)$/! Xft.dpi\1/' ~/.Xresources
fi
