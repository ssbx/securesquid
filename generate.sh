#!/bin/bash

function clean_all {
    rm -rf $HOME/opt/clamav
    rm -rf $HOME/opt/squid
    cd sources/clamav
    make clean
    git clean -xdf
    cd ../..
    cd sources/squid
    make clean
    git clean -xdf
    cd ../..
}

function print_help {
    echo "generate.sh <all|clamav|squid|clean>"
    echo " Options:"
    echo "      all     build squid and clamav"
    echo "      squid   build squid"
    echo "      clamav  build clamav"
    echo "      clean   clean all repos"
    echo ""
}

function squid_build {
    clean_all
    cd sources/squid
    ./configure --prefix=$HOME/opt/squid 
    make
    make install
}

function clamav_build {
    clean_all
    cd sources/clamav
    ./configure \
        --prefix=$HOME/opt/clamav \
        --disable-clamav \
        --with-systemdsystemunitdir=$HOME/opt/clamav/systemd
    make
    make install
    install -c -m 644 config/freshclam.conf config/clamd.conf $HOME/opt/clamav/etc
    mkdir $HOME/opt/clamav/share/clamav
}

function all {
    clamav_build
    squid_build
}

if  [ "$#" -ne 1 ]; then
    print_help
    exit
fi

git submodule update --init

if [ "$1" = "all" ]; then
    all
elif [ "$1" = "clean" ]; then
    clean_all
elif [ "$1" = "clamav" ]; then
    clamav_build
elif [ "$1" = "squid" ]; then
    squid_build
else
    print_help
fi
