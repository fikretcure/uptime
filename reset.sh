docker compose exec  app bash -c "composer update"
docker compose exec  app bash -c "php artisan optimize:clear"
docker compose exec  app bash -c "php artisan migrate:fresh --seed"
