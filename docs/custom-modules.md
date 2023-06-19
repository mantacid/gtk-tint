# INTRO
GTK-tint was designed to be extensible. For that reason we have made it easy to make your own modules for your specific workflow.

## What's a module?
The term *module* refers to a program or collection of programs that get called by the main script to move information around.

There are two types of modules: inputs and outputs.

### inputs
These are located in the `inputs/` directory, and can be divided into two subcategories: `base-theme` and `accent`, which are responsible for getting information on the base theme and accent, respectively.

Each module contains a file `invoke.sh`. This file is what the main script calls in order to utilize a module. Even if all the invoke file does is call another script in the module directory, it is recommended that you include it, as `invoke.sh` allows us to make changes without breaking other people's workflows.

### Outputs
These modules are responsible for writing the new colors to a theme. Their directory also contains an `invoke.sh` file and any accompanying scripts, but may optionally contain a `.toml` file that more accurately controls how the colors get applied.
