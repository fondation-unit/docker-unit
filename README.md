
### Install Composer dependencies

```
docker-compose up -d
docker-compose exec wordpress composer install --working-dir=/var/www/html/wp-content/themes/unt
```

### Use NPM

```
docker-compose exec wordpress npm run watch --prefix wp-content/themes/unt
```