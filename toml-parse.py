#!/usr/bin/env python3
import tomllib
import pprint
import sys

## Test the toml config format, load if valid
try:
    with open("gtk-tint.toml", "rb") as f:
        conf_data = tomllib.load(f)
except:
    print("tomllib.TOMLDecodeError: Invalid TOML Format")
    
## function to return a copy of a dict with certain keys excluded.
def exclude_key(d, key):
    blacklist = {key}
    return {x: d[x] for x in d if x not in blacklist}

## takes in a list of dictionaries, returns a dictionary of dictionaries, where each dictionary pair has a key of < the value corresponding to key K> and a value of <the same dictionary but with the entry for K removed> 
def list_to_dict(L, K):
    out_dict = dict({})
    for i in range(len(L)):
        ith_dict = L[i]
        identifier_key = str(ith_dict[K])
        trim_dict = exclude_key(ith_dict, K)
        out_dict[identifier_key] = trim_dict
    return out_dict

## turn a dictionary <d> into a list of tuples, some of which may contain dictionaries as the second element. prepend keys with the prefix <p>
def tuples_from_layer(d, p):
    tuple_list = []     ## set up empty list to populate
    prefix = str(p + "^")
    tuple_pre_list = list(d.items())
    for i in range(len(tuple_pre_list)):
        x=tuple_pre_list[i]
        y=list(x)
        y[0] = str(prefix + x[0])
        z = tuple(y)
        tuple_list.append(z)
    return tuple_list

## babe it's 3AM time for your...
def dict_flattening(List_of_tuples, prefix):
    ## in all seriousness though this funciton is infuriating to write.
    ## right now, its still broken. i cant figure out the recursion. But I have all the necessary functions set up i think.
    ## define local values & names
    L = List_of_tuples
    use_as_id = "subdir"
    p = str(prefix + "^")
    temp_list_pre = []
    temp_list_post = []
    ## define an index to use in for loops
    i = 0
    j = 0
    
    ## iterate through tuples, adding any with complicated values (dictionaries mostly) to a temp list
    for t in L:
        if type(t[1]) is dict:
            temp_list_pre[i] = t
            L.remove(t)
            i += 1
        j += 1
    
    ## for each tuple in the temp list, set prefix to be tuple[0]+dict[k] and do the dict to tuple thing.
    for t in temp_list_pre:
        temp_prefix = str(t[0])
        nested_dict = dict(t[1])
        temp_list_post = tuples_from_layer(nested_dict, temp_prefix)
    
    ## move all the new tuples to the old list
    for i in range(len(temp_list_post)):
        E = temp_list_post[i]
        L.append(E)
    
    ## recurse until no tuples with dict values remain.
    ## ??????
        
conf_list = tuples_from_layer(conf_data, "root")
flat = dict_flattening(conf_list, "root")
print(flat)
