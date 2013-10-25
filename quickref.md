Quick References
================

# bash #
+ split filename into directory and file parts
    + `dirname file`
    + `basename file`

+ get the path of the current base script

    `$(pwd)/$(dirname "${BASH_SOURCE[0]}")`

# pacman #
+ get details about a package

    `pacman -Qil`
    
    + Q: query
    + i: information of package
    + l: list files in package
