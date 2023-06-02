#!/bin/bash
## define the location of the relevant value
ACCENT_PATH="$HOME/.config/kdeglobals"

## run kreadconfig to get the NONLINEAR sRGB value that the accent is set to.

sRGB_STR=$(kreadconfig5 --file $ACCENT_PATH --group General --key AccentColor)

## create an array of the values
IFSSAVE=$IFS
IFS=','
declare -a RGBARR=($sRGB_STR)
IFS=$IFSSAVE

## convert the rgb values into a hex code for easy transfer between scripts
HEX_STR=""
for i in "${!RGBARR[@]}"
do
    dec=${RGBARR[i]}
    HEX_STR=$HEX_STR$(printf '%x\n' $dec)
done

echo $HEX_STR
