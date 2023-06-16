#!/usr/bin/env bash
## INVOKE SCRIPT

## define the script to invoke
TO_INVOKE="gtk2.py"

## define the location of this module
mod_loc="$full_path/$TO_INVOKE"

######## END SETUP ########

$mod_loc
