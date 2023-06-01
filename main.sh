#!/bin/bash
## TODO: add help functions and case handling
## get config values, assign relevant ones to global variables used by this script.


## Parse gtkrc
parsegtk2theme(){
    ## local nme for theme passed as input
    base_theme=$1
    
    ## get the gtkrc file and write the contents to a string
    GTKRC_STR=$(<$THEME_DIR/$base_theme/gtk-2.0/gtkrc)
    
    ## regexp match key strings followed by hex values, with a newline at the end.
    ## colors tend to be defined first in this file, so search there.
}
