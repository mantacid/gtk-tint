#!/usr/bin/env bash

## writes new values to a passed gtkrc file
## $1 is the old colors (list of hex values, # included), $2 is what to replace them with (list of hex values, in the same order as $1), and $3 is the list of files to do it all to (list of file paths).

## LISTS MUST BE THE SAME LENGTH
write_colors(){
    ## define local names
    declare col_old="$1"
    declare col_new="$2"
    declare targets="$3"
    
    ## get the length of the color lists. they should both be the same length.
    col_len=${#col_old[@]}
    
    ## loop over files
    for f in ${targets[@]};
    do
        ##iterate over all colors in the color lists, replacing matching strings in the file with a unique placeholder value.
        
        for ((i=0 ; i=$col_len ; i++));
        do
            placeholder="COLOR$i"
            ith_col_old=${col_old[i]}
            
            sed -i "s/$ith_col_old/$placeholder/g" $f
        done
        
        ## now that we are sure that no new colors will match an element in the old color list, iterate again and replace the placeholders with the new colors
        for ((i=0 ; i=$col_len ; i++));
        do
            matchstr="COLOR$i"
            ith_col_new=${col_new[i]}
            
            sed -i "s/$matchstr/$ith_col_new/g" $f
        done
    done
}
