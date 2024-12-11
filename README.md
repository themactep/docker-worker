Dockerized Development Environment for Thingino firmware
--------------------------------------------------------

Podman/Docker container for developing [Thingino firmware][1]
in a standardized and reproducible environment.

```
git clone https://github.com/themactep/docker-worker.git ~/docker-worker
cd ~/docker-worker
./run.sh
```

When inside the container, run `make` to start building the firmware.

[1]: https://github.com/themactep/thingino-firmware
