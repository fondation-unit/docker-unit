#!/bin/sh

# cleaning up
if [ -f "$PWD/tmp" ]; then
    rm -rf $PWD/tmp
fi

mkdir -p $PWD/wordpress/src >/dev/null 2>&1

if [ ! -f "tmp/wordpress.tar.gz" ]; then
    echo "Downloading Moodle version $version...\n"
    curl -o $PWD/tmp/wordpress.tar.gz https://fr.wordpress.org/latest-fr_FR.tar.gz
fi

if [ -f "$PWD/tmp/wordpress.tar.gz" ]; then
    mkdir $PWD/wordpress/src
    cd $PWD/tmp
    tar -zxvf wordpress.tar.gz
    rm wordpress.tar.gz
    ls $PWD/../wordpress/src
    mv $PWD/wordpress/* $PWD/../wordpress/src
    rm -rf $PWD/wordpress
fi