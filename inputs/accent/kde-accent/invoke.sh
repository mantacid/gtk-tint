#!/usr/bin/env bash
## INVOKE SCRIPT

## define the script to invoke
TO_INVOKE="kde-accent.sh"

## define the location of this module
mod_loc="$full_path/$TO_INVOKE"

######## END SETUP ########

## get the current kde accent color
source "$mod_loc"
