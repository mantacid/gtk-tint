#!/usr/bin/env bash
## INVOKE SCRIPT

## Use variables from the main script in place of flags and options
local ARGSTR=$arguments

## Define Theme init function for GTK2 themes. ##

## takes the name of the theme ($1) and the path to the theme directory ($2) 
theme_init(){
    ## Define local names and values
    theme_name="$1"
    base_abs_path="$2"
    ## values that dictate how the theme copy gets renamed
    tint_suffix="-tint"
    new_name=$theme_name$tint_suffix
    
    ## check if passed original theme is actually a directory
    if [[ -d $base_abs_path$theme_name ]]; then
        ## check if a tinted version of the original theme doesn't alrady exist
        if [[ ! -d $base_abs_path$new_name ]]; then
            ## make a copy of the theme directory, renaming it to differentiate it
            cp -r "$base_abs_path$theme_name/." $base_abs_path$new_name
            
            ## fix metadata in index.theme to match the new folder name
            python theme_init.py $base_abs_path $tint_suffix
            
            ## set target for alteration to be the new directory
            alter_target=$base_abs_path$new_name
        else
            ## set target for alteration to be the tint directory
            alter_target=$base_abs_path$new_name
        fi
    else
        echo "ERROR: main.sh: $theme_name is either not a directory or does not exist"
    fi
}
## case handling


## define the script to invoke
local TO_INVOKE="gtk2.sh"

## define the location of this module
local mod_loc="$full_path$TO_INVOKE"

## get the module's config if there is one
CHECK_IF_CONFIG="$mod_loc/modconf.toml"
if [ -f $CHECK_IF_CONFIG ]; then
    ## read the config
    local CONF_DATA=$(load_config $CHECK_IF_CONFIG)
fi

######## END SETUP ########

$mod_loc
