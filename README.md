# Apiv2

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit `localhost:4000` from your browser.


## Deployment

1. heroku create
2. heroku secret key
```sh
heroku config:set SECRET_BASE_KEY="whatever"
```
3. heroku add postgres
```sh
heroku addons:create heroku-postgresql:hobby-dev
```
3. heroku add build packs
```sh
heroku buildpacks:add https://github.com/HashNuke/heroku-buildpack-elixir.git
heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git
```
4. heroku push