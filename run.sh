#!/bin/bash
# This is the main entry point for Meza1. This
# performs initial install of Meza1 itself as well
# as new installation of MediaWiki or importing an
# existing MediaWiki installation.

# global functions

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

GITDIR="$DIR/.git"

# if no git directory, create it
if [ ! -d "$GITDIR" ]; then
    echo "Meza1 is not installed. Would you like to install?"

    # check for and if reqd install git

    # install Meza1

    # ask if change branch reqd
    # global function change branch

fi

# query user for what they want to do
# do you want to:
# - fresh install
# - install with import
# - partial install (start and end points)
# - upgrade a component (php, apache, etc)
# - farm vs single?

# while loop, check if mode var exists

    echo "What do you want to do?"

    # switch, kick user into sub-script or ask again


