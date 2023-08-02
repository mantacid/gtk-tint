#!/usr/bin/env bash
## TODO: add help functions and case handling
## define working directory
DIR=$(pwd)

## define module paths by type
MOD_DIR_ACNT="$DIR/accent/"
MOD_DIR_THME="$DIR/themes/"
MOD_DIR_RCOL="$DIR/recolor/"

## init a global variable to track which theme to work on
TARGET_THEME=""

## function to call a specific module script
## takes the module name ($1), the type ($2) (accent/, themes/, or recolor/), and any flags to be passed to the module itself ($3). -h gives some details on the usage of these flags. 
call_module(){
    ## define local names
    mod_name="$1"       ## name of module to be called (MUST have trailing /)
    
    mod_type="$2"       ## absolute file path to find module in (MUST have trailing /)
    
    ## define local name for optional third argument (flag)
    maybeflag="$3"
    
    ## look for the shell script named "invoke.sh" within the specified module directory.
    INVOKE_SCRIPT="invoke.sh"
    
    ## every module NEEDS an invoke script, usually adding one to a custom module is a drag-and-drop affair.
    full_path="$DIR""$mod_type""$mod_name""/"
    
    ## execute the module, passing the directory to the module
    call="$full_path""$INVOKE_SCRIPT"" $maybeflag"
    echo $full_path
    echo $call
    $call
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
    echo " $0 usage:"
    echo "SYNTAX: unicate [init|invoke] -[A|R|T|i] [ARGUMENTS]"
    echo "Passing no options runs the tool as normal, using the values from the default config."
    echo ""
    echo "-h   Print this message"
    echo "-c [path/to/config]   Pass the path to a different config file."
    echo ""
    echo "init: sets up the tool, installing dependencies using the helper script."
    echo "The init command doesn't take any flags"
    echo ""
    echo "invoke: calls a module. exactly one of the capital letters must be passed, but the -i flag is optional."
    echo "-A [module name]    Tells unicate to invoke an ACCENT module. Takes the name of the module as a required argument."
    echo "-R [module name]    Tells unicate to invoke a RECOLOR module. Takes the name of the module as a required argument."
    echo "-T [module name]    Tells unicate to invoke a THEME module. Takes the name of the module as a required argument."
    echo "-i    Initializes the module specified. The behavior of this flag varies depending on what module type is being invoked. Info on this will be given when this flag is passed."
    echo "-r    Calls the reader function defined in the module. The presence of any arguments depends on the module being called."
    echo "-w    Calls the writer function defined in the module. The presence of arguments depends on the module being called."
}

## CASE HANDLING WIP##
## get the action and check if it exists
ACTION="$1"
## handle flags for init operation
if grep -q "init" <<< "$ACTION"; then
    ## run the setup script (WIP)
    echo "WIP"
## handle flags for invoke operation
elif grep -q "invoke" <<< "$ACTION"; then
    ## setup some logic variables here to get the proper scope
    declare -g invoked_action
    declare -g type_to_invoke
    declare -g name_to_invoke
    
    while getopts 'A:R:T:ir::w::' flag; do
        case "${flag}" in
            A) ## prep an ACCENT module for invocation
            type_to_invoke="$MOD_DIR_ACNT"
            name_to_invoke="${OPTARG}"
                ;;
            R) ## prep a RECOLOR module for invocation
            type_to_invoke="$MOD_DIR_RCOL"
            name_to_invoke="${OPTARG}"
                ;;
            T) ## prep a THEME module for invocation
            type_to_invoke="$MOD_DIR_THME"
            name_to_invoke="${OPTARG}"
                ;;
            i) ## pass the -i flag to the invoke script of the specified module
            invoked_action="-i"
                ;;
            r) ## pass the -r flag and any options to the envoke script of the specified module
            ##check for flag's arguments
            if [[ -n ${OPTARG} ]];
            then
                invoked_action="-r ${OPTARG}"
            else
                invoked_action="-r"
            fi
                ;;
            w) ## pass the -w flag and any options to the invoke script of the specified module
            ## check for flag's arguments
            if [[ -n ${OPTARG} ]];
            then
                invoked_action="-w ${OPTARG}"
            else
                invoked_action="-w"
            fi
                ;;
        esac
    done
    ## invoke the module
    echo $type_to_invoke
    call_module "$name_to_invoke" "$type_to_invoke" "$invoked_action"
    
## handle flags for no operations.
else
    while getopts 'c:h' flag; do
        case "${flag}" in
            c) ## use a different config file
            CONF_PATH=${OPTARG}
                ;;
            h) ## print usage
            print_usage
                ;;
            *) ## continue execution as normal, with the values in the defult config.
            break
                ;;
        esac
    done
fi
