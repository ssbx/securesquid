#!/bin/bash

function clean_all {
    rm -rf $HOME/clamav
    cd sources/clamav
    make clean
    git clean -xdf
    cd ../..
}

function print_help {
    echo "generate.sh <local|system>"
    echo " Options:"
    echo "      local build and test under local user"
    echo "      system build and deploy on system"
    echo ""
    exit
}

function local_build {
    git submoudle update --init
    clean_all
    cd sources/clamav
    ./configure \
        --prefix=$HOME/clamav \
        --disable-clamav \
        --with-systemdsystemunitdir=$HOME/clamav/systemd
    make
    make install
}

function system_build {
    git submoudle update --init
    clean_all
    cd sources/clamav
    ./configure --prefix=/opt/clamav
    make
    make install
}


if  [ "$#" -ne 1 ]; then
    print_help
fi


if [ "$1" = "local" ]; then
    local_build
elif [ "$1" = "system" ]; then
    system_build
elif [ "$1" = "clean" ]; then
    clean_all
else
    print_help
fi
