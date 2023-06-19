# GTK-tint
## What Is It?
GTK-tint is an extensible theming tool, designed with ease of use in mind. Extending functionality is as simple as putting a script into a folder.

Please note that this documentation is unfinished. If you're looking for an in-depth explanation of how the code is doing what it does, I've left several comments in the various scripts, many of which are detailed ehough in their current state to be considered documentation.

## How does it work?
### 1. Read the Config
Before doing anything, GTK-tint parses the main config file using the parser script (written in python). The main config tells the tool what modules to use, where to look for themes, and what additional config files to load.

### 2. Setting up
GTK-tint gets an accent color from the source defined in the main config, by using the `input/accent` module with the same name. It then does the same for your system's base theme, also using a module in the `input/base_theme` directory. 

If there isn't a copy of the base theme created by the tool already in the system's themes directory, GTK-tint will create one to alter, so that the base theme is preserved.

### 2. Processing the Colors
Then, the tool calls a binary in the `tint-methods/` directory to tint each color in the base theme with the accent color. Our implementation utilizes the OKlab color space, developed by Björn Ottoson. This colorspace allows us to preserve the lightness or darkness of a theme in a way that looks natural to the human eye. However, it is possible to create and use custom binaries by putting the binary in the `tint-methods/` folder and changing the `tint_method` value in the main config.

### 3. Update the Theme
Now that GTK-tint has the tinted colors, it applies them to both the copy of the base theme, and to any number of other theme files specified in the **outputs** section of the config. These optional outputs are also handled by modules, this time in the `outputs` directory (example: a module that alters the colors of some custom firefox userchrome). Note that each output module also has a config, which stores settings specific to the operation of that module.

