# Contribution Guidelines

Update dependencies
- Run `mix deps.get` - Install Dependencies
- Run `mix deps.update --all` - Update Dependencies: Sometimes, updating your dependencies can resolve conflicts

# Installation on Ubuntu
`sudo apt install erlang-dev elixir`
`mix archive.install hex phx_new`

`sudo apt-get install erlang-xmerl`
`sudo apt-get install inotify-tools`

# Run the server
```
mix deps.get
mix assets.setup
mix deps.compile

mix ecto.create
mix ecto.migrate

mix phx.server
```

# Run the server with Docker
```
docker compose up
```
