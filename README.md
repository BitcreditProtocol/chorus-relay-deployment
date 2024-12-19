# chorus-relay-deployment

Docker build and configuration for the Chorus relay

## Build with docker

```bash
docker build -t bitcredit-chorus-relay .
```

## For testing build and run with docker compose

```bash
# just run it
docker compose up

# build or rebuild it
docker compose build --no-cache
```

## Adding users

This relay requires a static configuration with all white listed users. The
`config.toml` file allows adding users by just adding their hex encoded npub
to the `user_hex_keys` list. The process needs to be restarted after a
configuration change.

For now a push to the master branch of this repository should trigger a
redeploy and therefor a configuration update.