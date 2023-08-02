#!/usr/bin/env bash
## INVOKE SCRIPT
echo "get invoked loser"
## Use variables from the main script in place of flags and options
#local ARGSTR=$arguments

## define the script to invoke
local TO_INVOKE="template.sh"

## define the location of this module
local mod_loc="$full_path$TO_INVOKE"

## get the module's config if there is one
CHECK_IF_CONFIG="$mod_loc/modconf.toml"
if [ -f $CHECK_IF_CONFIG ]; then
    ## read the config
    local CONF_DATA=$(load_config $CHECK_IF_CONFIG)
fi

## import the script to be invoked.
## not all modules will do this. Some will choose to call the script normally.
source $mod_loc
## Define template invocation functions. ##

theme_init(){
    echo "this theme does not need to be Initialized"
    echo "this module does not need ot be Initialized. Aborting"
    exit
    }
## case handling
## WIP, Will be responsible for initializing themes.
while getopts 'ir::w::' flag; do
  case "${flag}" in
    i)
        ## Take in a LIST of arguments for the theme_init funciton
        arglist=${OPTARG}
        theme_name=${arglist[0]}
        theme_path=${arglist[1]}
        theme_init theme_name theme_path ;;
    r)
        col_read ;;
    w)
        if [[-z ${OPTARG}]]
        then
            echo "the template module requires an argument for this flag (path to target file)"
            exit
        else
            col_write ${OPTARG}
        fi
    *) print_usage
       exit 1 ;;
  esac
done

######## END SETUP ########
