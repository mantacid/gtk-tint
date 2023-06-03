#!/usr/bin/env python3
import tomllib

## Test the toml config format, load if valid
try
    with open("gtk-tint.toml", "rb") as f:
        data = tomllib.load(f)
except:
    print("tomllib.TOMLDecodeError: Invalid TOML Format")

## Format the config data to be of a form that the main script can use
## This means "flattening" the dictionary array into an associated array where the keys
## are a concatenation of the subtables.
## the TOML below:
#
#[[fruits]]
#name = "apple"
#
#[fruits.appearance]
#shape = "round"
#color = "red"
#
#[fruits.origin]
#grows-on = "tree"
#
#
## would become the associated array $fruits, which is structured:
#
#fruits=(apple.appearance.shape="round" apple.appearacne.color="red" apple.origin.grows-on="tree")

##WIP

