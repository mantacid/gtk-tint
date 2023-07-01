# main.sh
The following functions are defined in `main.sh`.

## call_module
### Description:
Calls a specified module, passing data to it.

### Arguments:
$1: the name of the module to call
$2: the type of the module (can be `base_theme/`, `accent/`, or `output`)
$3: a string containing additional arguments/flags to pass to the invoke script

### Details:
The string in the third argument uses standardized flags, which is another reason gtk-tint uses a universal invoke.sh format: different module types need to use different data, and thus gtk-tint needs a way to call any module, regardless of what type of module it is.

## theme_init
### Description:
Set up a copy of the base theme to apply changes to. This allows the base theme to remain unchanged, and allows for the tinted theme to be selected using your environment's native configuration management methods.

The function does not pass an output.

### Arguments:
$1: the name of the base theme.
$2: the absolute path to the base theme

NOTE: the first argument may be depreciated in favor of reading the name of the theme from the filepath.

### Details:
This functions copies the target theme folder, appends the alter_suffix defined in `gtk-tint.toml` to the name of the directory. the function then runs `theme-init.py` to alter the theme's metadata to match the new directory name.

## load_config
### Description:
Populates a bash associated array with a flattened dictionary read from a `.toml` file.

### Arguments:
$1: path to the `.toml` file.
$2: name of the associated array to write to.

### Details:
The delimiter used for flattening the dictionary had to be hard-coded into `toml-parse.py` since -- as you could imagine -- using the load_config function to define variables in the load_config function creates a bit of a catch-22. You can find the delimiter inside the function `dict_flattening()`; by default it is a caret ( ^ ), since I didn't think it was a special character for any other components used in gtk-tint.
