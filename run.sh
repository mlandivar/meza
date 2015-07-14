#!/bin/bash
# This is the main entry point for Meza1. This
# performs initial install of Meza1 itself as well
# as new installation of MediaWiki or importing an
# existing MediaWiki installation.

# @todo: global functions ?

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

GITDIR="$DIR/.git"

# if no git directory in same directory as run.sh, create appropriate directory
if [ ! -d "$GITDIR" ]; then
    echo "Meza1 is not installed. Would you like to install?"

    # Check if git installed, and install it if required
    if ! hash git 2>/dev/null; then
	      echo "************ git not installed, installing ************"
        yum install git -y
    fi

    # install Meza1

    # if no sources directory, create it
    if [ ! -d ~/sources ]; then
        mkdir ~/sources
    fi

    # meza1 directory exists in proper location
    if [ -d ~/sources/meza1 ]; then

        echo "A meza1 directory already exists at ~/sources/meza1. Do you want to remove it and reinstall? [Y/n]"
        read overwrite_existing
        if [ "$overwrite_existing" == "Y" ]; then
            echo "Deleting existing installation"
            rm -rf ~/sources/meza1
        else
            echo "Keeping existing installation. Use run.sh from that directory. Aborting."
            exit 0;
        fi

    else # no meza1 directory

        cd ~/sources
        git clone https://github.com/enterprisemediawiki/Meza1 meza1
        cd meza1
        # git checkout "$git_branch"

    fi

else # .git directory exists

    # anything special required?

fi



while [ -z "$run_mode" ] do
    echo "What do you want to do?"
    echo "  h) help"
    echo "  x) exit"
    echo "  1) new mediawiki installation"
    echo "  2) new application install, import existing wiki"
    echo "  3) partial install (components such as PHP or Apache)"
    echo "  4) upgrade a component"
    echo "  5) upgrade Meza1"
    echo "  6) switch branch"
    read user_run_mode

    case "$user_run_mode" in
    "h")
        echo "sorry no help yet"
        ;;
    "x")
        echo "exiting..."
        exit 0
        ;;
    "1")
        bash ~/sources/meza1/client_files/install.sh
        ;;
    "2")
        echo "import existing wiki not yet available"
        ;;
    "3")
        echo "partial install not yet available"
        ;;
    "4")
        echo "upgrade a component not yet available"
        ;;
    "5")
        echo "upgrade meza1 not yet available"
        ;;
    "6")
        echo "switch branch not yet available"
        ;;
    *)
        echo "that's not an option. please pick one of the options."
        ;;
    esac

done
