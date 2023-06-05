#!/usr/bin/env bash
## IMPORT module for gtk2.0 themes
## wip
## NOTE: this gets imported by the main bash script.
## Parse gtkrc. call this function if kreadconfig5 says that the value for widgetstyle is gtk2
parsegtk2theme(){
    ## local nme for theme passed as input
    base_theme=$1
    
    ## get the gtkrc file and write the contents to a string
    GTKRC_STR=$(<$THEME_DIR/$base_theme/gtk-2.0/gtkrc)
    
    ## regexp match key strings followed by hex values, with a newline at the end.
    ## colors tend to be defined first in this file, so search there.
}
