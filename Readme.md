https://hub.docker.com/r/komuw/debug

Docker container that has debugging tools.

```sh
docker buildx create --use --name multi-arch-builder
docker buildx build --push --platform linux/amd64,linux/arm64 -t komuw/debug:latest .

docker \
    run \
    -it \
    komuw/debug:latest
```

For an image with what `latest` has plus mongo tools use; `komuw/debug:mongo`
