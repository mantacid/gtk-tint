#!/usr/bin/env bash

declare -A TEMPLATE_COLOR_ARRAY
TEMPLATE_COLOR_ARRAY[background]="#232323"
TEMPLATE_COLOR_ARRAY[foreground]="#3f3f3f"
TEMPLATE_COLOR_ARRAY[accent]="#8463bf"

col_read() {
    ## build array-encoding string
    dictstr=""
    for i in "${!TEMPLATE_COLOR_ARRAY[@]}"
    do
        kvpairstr="$i"":""${TEMPLATE_COLOR_ARRAY[$i]}"
        dictstr="$dictstr""$kvpairstr"
    done
    echo "$dictstr"
}

col_write() {
    ##get options
    dest_file=$1
    
    ##append colors to specified file
    col_read >> $dest_file
}
echo "yeag"
