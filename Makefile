postgres-elixir:
	docker run -d \
	  --name postgres-elixir \
	  -e POSTGRES_PASSWORD=postgres \
	  -e POSTGRES_USER=postgres \
	  -e POSTGRES_DB=rumbl_dev \
	  -p "5432:5432" \
	  postgres

build-assets:
	npm install --prefix assets
	npm run --prefix assets deploy
	MIX_ENV=prod mix phx.digest

build-release: build-assets
	MIX_ENV=prod mix release --env=prod

start: build-release
	PORT=80 _build/prod/rel/blog/bin/blog start

stop:
	_build/prod/rel/blog/bin/blog stop

renew-ssl:
	certbot renew
