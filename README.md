# 10 Cubes

### Usage

rackup -p 4567

### Dockerized

docker compose up --build

### Run migrations
docker compose exec app bundle exec rake db:create_migration <NAME>
docker compose exec app bundle exec rake db:migrate

#### Run a console
docker compose exec app irb -r server.rb

