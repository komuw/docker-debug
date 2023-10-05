https://hub.docker.com/r/komuw/debug

Docker container that has debugging tools.

```sh
docker buildx create --use --name multi-arch-builder
docker buildx build --push --platform linux/amd64,linux/arm64 -t komuw/debug:latest .

docker \
    run \
    -it \
    komuw/debug:latest

# create a pod for testing.
kubectl \
  run \
  --namespace=someNS \
  --labels="app=tester-pod,env=dev" \
  tester-pod \
  --rm -it \
  --image komuw/debug:latest

# run a debugging pod in the context of another pod.
# it is like a better `kubectl run` or `kubectl exec`
kubectl \
  debug \
  --namespace=someNS \
  some-pod-26phw \
  --container='my-debugger-pod' \
  -it \
  --image=komuw/debug:latest

# spin up a container on the host's network namespace.
kubectl \
  run \
  tester-pod \
  --rm -it \
  --overrides='{"spec": {"hostNetwork": true}}' \
  --image=komuw/debug:latest
```

Also see https://github.com/nicolaka/netshoot
