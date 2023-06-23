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
BASE_THEME_PATH="$HOME/theming-test/"    ## path to the systems themes
TINT_SUFFIX="-tint"

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

## function to call a specific INPUT module script
## takes the module name ($1), the type ($2) (inputs/base_theme/, inputs/accent/, or outputs/) 
call_module(){
    ## define local names
    mod_name="$1"       ## name of module to be called (MUST have trailing /)
    
    mod_type="$2"       ## absolute file path to find module in (MUST have trailing /)
    
    ## define local name for string of arguments.
    arguments="$3"
    
    ## look for the shell script named "invoke.sh" within the specified module directory.
    INVOKE_SCRIPT="invoke.sh"
    
    ## every module NEEDS an invoke script, usually adding one to a custom module is a drag-and-drop affair.
    full_path="$DIR/$mod_type$mod_name"
    
    ## execute the module, passing the directory to the module
    call="$full_path$INVOKE_SCRIPT"
    source $call
}

## Load the config file at the specified path, write a flattened associated array to the variable specified in the second argument
load_config(){
    ## define local names for arguments
    config_path="$1"
    
    ## get the flattened dictionary returned by toml-parse.py WIP
    #x=$(eval "$(python toml-parse.py $config_path)")
}


confstr="$DIR/gtk-tint.toml"

load_config "$confstr"

