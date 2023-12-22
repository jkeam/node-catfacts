# Node Catfacts App

## Prerequisite

1. Node v16.19.0

## Running

### Locally

1. Start DB
2. Import data from `import.sql`
3. Start app with `npm start`

### Dev Spaces

1. Open up a terminal in your dev space (Hamburger in the upper right -> Terminal -> New Terminal)
2. Run `./install.sh` to setup db and migrate data
3. Run `./run.sh` to start app

## Testing

1. `npm test`

## Containers

### App

#### Building

```shell
podman build -t quay.io/<your_username>/node-catfacts -f ./Dockerfile
```

#### Pushing

```shell
podman push quay.io/<your_username>/node-catfacts
```

#### Running

```shell
./run_db.sh

# replace with whatever your IP is
podman run --name catfacts --rm -p "3000:3000" -e DB_URL=postgres://catuser:catuserpassword@192.168.1.110:5432/catfacts -t quay.io/<your_username>/node-catfacts
```

### Dev Spaces Environment

#### Building

```shell
podman build -t quay.io<your_username>/udi-rhel8-postgres -f ./Dockerfile-udi-rhel8-postgres
```

#### Pushing

```shell
podman push quay.io<your_username>/udi-rhel8-postgres
```
