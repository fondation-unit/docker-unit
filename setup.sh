#!/bin/sh

WORDPRESS_SRC=$PWD/wordpress/src
WORDPRESS_PLUGINS=$PWD/wordpress/src/wp-content/plugins
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

# install theme and plugins
if [ ! -d "ls -A $PWD/wordpress/src" ]; then
    cd $WORDPRESS_SRC
    cp ../unt-config.php ./

    if [ -d "ls -A $WORDPRESS_SRC/wp-content/themes/unt" ]; then
        cd $WORDPRESS_SRC/wp-content/themes
        git clone $THEME_GIT
    fi
    echo $($WORDPRESS_PLUGINS/acf)
    if [ ! -f "$WORDPRESS_PLUGINS/acf" ]; then
        cd $WORDPRESS_PLUGINS
        git clone https://github.com/AdvancedCustomFields/acf
    fi
fi

# add some default configuration to the database
cd $PWD/../../../../
if [ -f ./.env ]; then
    docker-compose up -d
    CONTAINERS=$(docker ps --format '{{.Names}}:{{.Image}}' | grep 'mysql\|mariadb' | cut -d":" -f1)
    CONTAINER=${CONTAINERS[0]}
    source ./.env
    docker exec -e MYSQL_DATABASE=$MYSQL_DATABASE -e MYSQL_PWD=$MYSQL_ROOT_PASSWORD \
        ${CONTAINER[0]} mysql -u root $MYSQL_DATABASE -e \
        "UPDATE wp_options SET option_value = '/%year%/%monthnum%/%day%/%postname%/' WHERE option_name = 'permalink_structure'"
    docker exec -e MYSQL_DATABASE=$MYSQL_DATABASE -e MYSQL_PWD=$MYSQL_ROOT_PASSWORD \
        ${CONTAINER[0]} mysql -u root $MYSQL_DATABASE -e \
        "UPDATE wp_options SET option_value = 'a:1:{i:0;s:11:\"acf/acf.php\";}' WHERE option_name = 'active_plugins'"
    docker exec -e MYSQL_DATABASE=$MYSQL_DATABASE -e MYSQL_PWD=$MYSQL_ROOT_PASSWORD \
        ${CONTAINER[0]} mysql -u root $MYSQL_DATABASE -e \
        "SELECT option_name, option_value FROM wp_options WHERE option_name = 'active_plugins'"
fi
