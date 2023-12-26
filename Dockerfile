# syntax=docker/dockerfile:1

# latest is 22.04 as of 2023-12-03
FROM ubuntu:latest

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get update && \
 DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y --no-install-recommends \
 apt-utils apt-transport-https bc build-essential ca-certificates cpio curl file \
 git locales mc rsync ssh sudo unzip vim wget whiptail

RUN update-ca-certificates

RUN locale-gen --no-purge en_US.UTF-8

RUN useradd -rm -d /home/openipc -s /bin/bash -g root -G sudo -u 1000 openipc --no-log-init
RUN echo 'openipc:openipc' | chpasswd

USER openipc
WORKDIR /home/openipc/firmware
