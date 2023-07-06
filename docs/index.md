# UniCATE (previously GTK-tint
## What Is It?
UniCATE is an extensible theming tool, designed with ease of use in mind. Extending functionality is as simple as putting a script into a folder.

Please note that this documentation is unfinished. If you're looking for an in-depth explanation of how the code is doing what it does, I've left several comments in the various scripts, many of which are detailed ehough in their current state to be considered documentation.

## How does it work?
### 1. Read the Config
Before doing anything, UniCATE parses the main config file using the parser script (written in python). The main config tells the tool what modules to use, where to look for themes, and what additional config files to load.

### 2. Setting up
UniCATE gets an accent color from the source defined in the main config, by using the `input/accent` module with the same name. It then does the same for your system's base theme, also using a module in the `input/base_theme` directory. 

If there isn't a copy of the base theme created by the tool already in the system's themes directory, UniCATE will create one to alter, so that the base theme is preserved.

### 2. Processing the Colors
Then, the tool calls a binary in the `tint-methods/` directory to tint each color in the base theme with the accent color. Our default implementation utilizes the OKlab color space, developed by Björn Ottoson. This colorspace allows us to preserve the lightness or darkness of a theme in a way that looks natural to the human eye. However, it is possible to create and use custom binaries by putting the binary in the `tint-methods/` folder and changing the `tint_method` value in the main config. In fact, we may add some more binaries in the base tool in the future!

### 3. Update the Theme
Now that UniCATE has the tinted colors, it applies them to both the copy of the base theme, and to any number of other theme files specified in the **outputs** section of the config. These optional outputs are also handled by modules, this time in the `outputs` directory (example: a module that alters the colors of some custom firefox userchrome). Note that each output module also has a config, which stores settings specific to the operation of that module.

## How Can I Customize it?
UniCATE's working directory is structured to make adding your own modules and tinting methods easy. For more info on modules and their creation, refer to the section on [modules](custom-modules.md). Documentation on tinting methods is not written yet, but will come soon.

