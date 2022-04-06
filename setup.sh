#!/bin/sh

WORDPRESS_SRC=$PWD/wordpress/src
WORDPRESS_URL=https://fr.wordpress.org/latest-fr_FR.tar.gz
THEME_GIT=https://github.com/Hipjea/unt

# cleaning up
if [ -f "$PWD/tmp" ]; then
    rm -rf $PWD/tmp
fi

mkdir -p $PWD/wordpress/src >/dev/null 2>&1

# perform download if the Wordpress directory is empty
if [ -d "ls -A $dir" ]; then
    if [ ! -f "tmp/wordpress.tar.gz" ]; then
        echo "Downloading Moodle version $version...\n"
        curl -o $PWD/tmp/wordpress.tar.gz $WORDPRESS_URL
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
fi

if [ ! -d "ls -A $PWD/wordpress/src" ]; then
    cd $WORDPRESS_SRC
    cp ../unt-config.php ./
    cd $WORDPRESS_SRC/wp-content/themes
    git clone $THEME_GIT
fi