#!/usr/bin/env bash
## define the location of the relevant value
ACCENT_PATH="$HOME/.config/kdeglobals"
COLORSCHEME_PATH="$HOME/.local/share/color-schemes/$CURRENT_SCHEME.colors"
## run kreadconfig to get the NONLINEAR sRGB value that the accent is set to.

sRGB_STR=$(kreadconfig5 --file $ACCENT_PATH --group General --key AccentColor)

## get current kde color scheme
CURRENT_SCHEME=$(kreadconfig5 --file $ACCENT_PATH --group General --key ColorScheme)

## set the tint factor in the same way
TINT_FACTOR=$(kreadconfig5 --file $COLORSCHEME_PATH --group General --key TintFactor)

## create an array of the values
IFSSAVE=$IFS
IFS=','
declare -a RGBARR=($sRGB_STR)
IFS=$IFSSAVE

## convert the rgb values into a hex code for easy transfer between scripts, append the tint factor to the end.
HEX_STR=""
for i in "${!RGBARR[@]}"
do
    dec=${RGBARR[i]}
    HEX_STR=$HEX_STR$(printf '%x\n' $dec)
done

echo "$HEX_STR,$TINT_FACTOR"
