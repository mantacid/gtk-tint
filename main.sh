#!/bin/bash
## TODO: add help functions and case handling, also allow for greater specificity in config with table (later)

## define working directory
DIR=$(pwd)

## get config values, assign relevant ones to global variables used by this script. for now i'll hardcode them.
DEFAULT_ACCENT_SOURCE='kde-accent'

## Parse gtkrc. call this function if kreadconfig5 says that the value for widgetstyle is gtk2
parsegtk2theme(){
    ## local nme for theme passed as input
    base_theme=$1
    
    ## get the gtkrc file and write the contents to a string
    GTKRC_STR=$(<$THEME_DIR/$base_theme/gtk-2.0/gtkrc)
    
    ## regexp match key strings followed by hex values, with a newline at the end.
    ## colors tend to be defined first in this file, so search there.
}

## get accent color. do so by evaluating the function: $(get_accent)
get_accent(){
    $DIR/inputs/$DEFAULT_ACCENT_SOURCE.sh
}

