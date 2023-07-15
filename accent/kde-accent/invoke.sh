#!/usr/bin/env bash
## INVOKE SCRIPT

## Use variables from the main script in place of flags and options
local ARGSTR=$arguments

## case handling


## define the script to invoke
local TO_INVOKE="kde-accent.sh"

## define the location of this module
local mod_loc="$full_path$TO_INVOKE"

## get the module's config if there is one
local CHECK_IF_CONFIG="$mod_loc/modconf.toml"
if [ -f $CHECK_IF_CONFIG ]; then
    ## read the config
    local CONF_DATA=$(load_config $CHECK_IF_CONFIG)
    
else
    pass
fi

######## END SETUP ########

## get the current kde accent color
source "$mod_loc"
