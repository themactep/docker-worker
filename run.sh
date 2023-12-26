#!/bin/bash
#
# Dockerized OpenIPC building environment
#
# 2022, Paul Philippov <paul@themactep.com>
#

install_docker() {
	echo "Installing Docker from its offical repository."
	echo "This operation requires superuser privileges."

	# install required packages
	command -v curl >/dev/null || sudo apt install curl

	# retrive official Docker repository key if missing
	local gpg_key=/usr/share/keyrings/docker-archive-keyring.gpg
	if [ ! -f "$gpg_key" ]; then
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
			sudo gpg --dearmor -o $gpg_key
	fi

	# add Docker official repository
	local distro=$(lsb_release -si | tr 'A-Z' 'a-z')
	local codename=$(lsb_release -sc)
	echo "deb [arch=amd64 signed-by=${gpg_key}] https://download.docker.com/linux/$distro $codename stable" | \
		sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	# update packages
	sudo apt-get update

	# install official version of Docker
	sudo apt-get --assume-yes install docker-ce docker-ce-cli containerd.io

	need_docker=0
	echo "Done"
}

need_docker=0
if command -v docker >/dev/null; then
	docker_ver=$(docker -v | awk -F '[ ,.]' '{print $3}')
	if [ "$docker_ver" -lt 20 ]; then
		echo "Installed Docker is outdated."
		need_docker=1
	fi
else
	echo "Docker not found."
	need_docker=2
fi

while [ "$need_docker" -gt 0 ]; do
	echo
	read -p "Do you want to install Docker from its official repository? [y/n] " yn
	case $yn in
		[yY]*)
			install_docker
			;;
		[nN]*)
			echo "Aborted."
			exit 1
			;;
		*)
			echo "Please answer only yes or no."
	esac
done


# Build a Docker image with OpenIPC development enviroment
docker build -t openipc-dev .

# Clone OpenIPC firmware source files from repository
[ ! -d firmware ] && git clone https://github.com/OpenIPC/firmware.git

# Run a container in interactive mode and mount the source files in it
docker run --rm -it --mount type=bind,source="$(pwd)/firmware",target=/home/openipc/firmware \
    openipc-dev:latest

exit 0
