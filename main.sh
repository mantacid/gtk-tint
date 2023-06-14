#!/usr/bin/env bash
## TODO: add help functions and case handling, also allow for greater specificity in config with table (later)

## define working directory
DIR=$(pwd)

## define module paths by type
MOD_DIR_INPT="$DIR/inputs"
MOD_DIR_ACNT="$MOD_DIR_INPT/accent/"
MOD_DIR_BASE="$MOD_DIR_INPT/base-theme/"
MOD_DIR_OTPT="$DIR/outputs/"

## get config values, assign relevant ones to global variables used by this script. for now i'll hardcode them.
ACCENT_MODULE='kde-accent.sh'
OUTPUT_MODULES={}   ## List of filepaths to module dirs
BASE_THEME_PATH="$HOME/.themes/"    ## path to the systems themes

## init a global variable to track which theme to work on
TARGET_THEME=""

## Function to set up the copied base theme
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
            theme_init.py $base_abs_path $tint_suffix
            
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

## function to call a specific INPUT module script
## takes the module name ($1), the type ($2) (base_theme or accent)
call_input_module(){
    ## define local names
    mod_name="$1"       ## name of module to be called (must include file extension)
    mod_type="$2"       ## absolute file path to find module in (must have trailing /)
    
    full_path=$mod_type$mod_name
    ## execute the module
    source $full_path
}

## function to call an output module. REMEMBER: this gets recursively called later
## takes in module name ($1), the alteration target ($2) and the associated array of colors to pass ($3) 
call_output_module(){
    ## define local names
    module="$1"
    target="$2"
    new_vals="$3"
}

