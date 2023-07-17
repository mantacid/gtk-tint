#!/usr/bin/env bash
## INVOKE SCRIPT

## Use variables from the main script in place of flags and options
#local ARGSTR=$arguments

## case handling
## WIP, Will be responsible for initializing themes.
while getopts '-i' flag; do
  case "${flag}" in
    i) echo "this accent module does not need to be initialized. Stopping operation."
      ;;
    *) print_usage
      exit 1 
      ;;
  esac
done

## define the script to invoke
local TO_INVOKE="kde-oklab-lint.py"

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
