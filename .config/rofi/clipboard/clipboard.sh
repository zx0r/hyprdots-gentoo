#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme='clipboard'

## Run
rofi \
  rofi -modi clipboard:~/.config/rofi/clipboard/cliphist-rofi -show clipboard -theme ${dir}/${theme}.rasi
