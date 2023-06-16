# INTRO
GTK-tint was designed to be extensible. For that reason we have made it easy to make your own modules for your specific workflow.

## What's a module?
The term *module* refers to a program or collection of programs that get called by the main script to move information around.

There are two types of modules: inputs and outputs.

### inputs
these are located in the `inputs/` directory, and can be divided into two subcategories: `base-theme` and `accent`, which are responsible for getting information on the base theme and accent, respectively.
