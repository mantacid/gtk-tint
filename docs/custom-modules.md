# INTRO
UniCATE was designed to be extensible. For that reason we have made it easy to make your own modules for your specific workflow.

## What's a module?
The term *module* refers to a program or collection of programs that get called by the main script to move information around.

There are two types of modules: inputs and outputs.

### inputs
These are located in the `inputs/` directory, and can be divided into two subcategories: `base-theme` and `accent`, which are responsible for getting information on the base theme and accent, respectively.

Each module contains a file `invoke.sh`. This file is what the main script calls in order to utilize a module. Even if all the invoke file does is call another script in the module directory, it is recommended that you include it, as `invoke.sh` allows us to make changes without breaking other people's workflows.

### Outputs
These modules are responsible for writing the new colors to a theme. Their directory also contains an `invoke.sh` file and any accompanying scripts, but may optionally contain a `.toml` file that more accurately controls how the colors get applied.

## Creating a Module
Creating a module is a simple process. First, create a directory with the name of the module within the subdirectory corresponding to its type. So if you wanted to get your accent colors from `pywal`, you'd create the module directory within `inputs/accent/`. Be sure to include an `invoke.sh` file, a README and LICENSE, and whatever scripts, configs, binaries, and/or assets the module needs in order to run.

Then, in `invoke.sh`, you write/invoke the code that handles the loading of assets, reading of configs, passing of values, etc. In other words, *the invoke file provides a unified method of handling any module users could make*.

For more information on creating modules & integrating them with the tool, see the [function documentation](functions.md).
