#!/usr/bin/env bash
## TODO: add help functions and case handling
## define working directory
DIR=$(pwd)

## define module paths by type
MOD_DIR_INPT="$DIR/inputs"
MOD_DIR_ACNT="$MOD_DIR_INPT/accent/"
MOD_DIR_BASE="$MOD_DIR_INPT/base-theme/"
MOD_DIR_OTPT="$DIR/outputs/"
BIN_DIR_TINT="$DIR/tint-methods/"

## init a global variable to track which theme to work on
TARGET_THEME=""

## function to call a specific INPUT module script
## takes the module name ($1), the type ($2) (inputs/base_theme/, inputs/accent/, or outputs/) 
call_module(){
    ## define local names
    mod_name="$1"       ## name of module to be called (MUST have trailing /)
    
    mod_type="$2"       ## absolute file path to find module in (MUST have trailing /)
    
    ## define local name for LIST of flags/arguments.
    #arguments="$3"
    
    ## look for the shell script named "invoke.sh" within the specified module directory.
    INVOKE_SCRIPT="invoke.sh"
    
    ## every module NEEDS an invoke script, usually adding one to a custom module is a drag-and-drop affair.
    full_path="$DIR/$mod_type$mod_name"
    
    ## execute the module, passing the directory to the module
    call="$full_path$INVOKE_SCRIPT"
    source $call
}

## Load the config file at the specified path, write a flattened associated array to the empty associated array specified in the second argument
load_config(){
    ## define local names for arguments
    config_path="$1"
    declare -n output_array="$2"
    declare -a holding_array
    
    ## call the python toml parser and treat the output like a string.
    CONFSTR=$( python toml-parse.py $config_path )
    
    ## save the value of the IFS
    SAVEIFS=$IFS
    
    ## temorarily set the value of the IFS to a newlines
    IFS=$'\n'
    
    ## read the pairs into a holding array (unassociated) to iterte on later
    readarray -t holding_array <<< "$CONFSTR"
    
    ## restore default value of IFS
    IFS=$SAVEIFS
    
    ## iterate through the holding array and create key-value pairs.
    ## since the keys and values alternate, all we need to do is use every even-indexed list element as a key, and every odd-indexed element as a value.
    element_count=${#holding_array[@]}
    for ((i=0 ; i<=$(( element_count - 1)) ; i+=2 )); do
        j=$(( i + 1 ))
        key_at_i="${holding_array[$i]}"
        val_at_j=${holding_array[$j]}
        
        output_array[$key_at_i]+=$val_at_j
    done
}

## PRINT USAGE ##
print_usage(){
    echo "usage:"
    echo "-a     define an accent color (sRGB hex code) or source (module name)"
    echo "-b     define a base color source (module name)"
    echo "-c     define a tinting method (module name)"
    echo "-C     use a different config file (path)"
    echo "-o     define an output (module name)"
    #echo "-O     initialize a theme associated with a specific module"
}

## CASE HANDLING ##

while getopts 'a:b:c:C:ho:' flag; do
  case "${flag}" in
    a) ACCENT_SRC=${OPTARG}
        ;; ## specify an accent module
    b)
        $BASE_LST=${OPTARG}
        ;; ## specify a base colorscheme
    C)
        CONF_PATH=${OPTARG}
        ;; ## specify a path to a different config
    c)
        ALTER_METHOD=${OPTARG}
        ;;
        ## specify a tinting method
    h)
        print_usage
        exit 1
        ;; ## print help
    o) 
        OUT_LST=${OPTARG}
        ;; ## specify a list of output modules
    *)
        break
        ;; ## continue as normal in the absence of any flags
  esac
done

## TESTS for config parser, will remove later!
confstr="$DIR/gtk-tint.toml"
declare -A CONF_ASSOC_ARR

load_config "$confstr" CONF_ASSOC_ARR

for key in "${!CONF_ASSOC_ARR[@]}"; do
    printf '%s = %s\n' "$key" "${CONF_ASSOC_ARR[$key]}"
done
