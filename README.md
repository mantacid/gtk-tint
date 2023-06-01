# gtk-tint
gtk-tint is a program that allows your gtk theme to dynamically update to better match your system. I got sick of having to create a new gtk theme each time I changed my system theme, so I decided to do something about it.

>[!NOTE] This project is still in active development.

## Repo Structure
### gtk-tint.toml
This file is the config. It allows you to specify what theme to tint, how to tint it, and with what colors to do so.

### main.sh
This script is responsible for parsing the base gtk theme so that the tinting script can better use the values.

### inputs/
this directory holds various scripts that dictate how the accent colors get picked. If you want to integrate this tool with another one, or extend gtk-tint's functionality in any way, you typically add a file in this directory.
