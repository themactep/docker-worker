OpenIPC Docker Image
====================

Docker image for building [OpenIPC Firmware][1] in a standardized
and reproducible environment across various machines.

```
mkdir ~/openipc-dev
git clone https://github.com/themactep/openipc-docker.git ~/openipc-dev
cd ~/openipc-dev
./run.sh
```

When inside the container, follow the [instruction on building the firmware][2].


[1]: https://github.com/OpenIPC/firmware
[2]: https://github.com/OpenIPC/wiki/blob/master/en/building.md#build-the-firmware
