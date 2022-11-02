# Bitter Docker Image

All instructions assume the user is working on Ubuntu.

## Uninstall Old Versions of Docker

Instructions from the docker [website](https://docs.docker.com/engine/install/ubuntu/#uninstall-old-versions).

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
```

## Install Latest Docker

Instructions from the docker [website](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script).

```bash
curl -fsSL https://get.docker.com | sudo sh
```

## Permissions

When installing for the first time the user might not have permissions to
connect to the docker daemon. If so then to add the current user to the docker
group use the following command.

```bash
sudo usermod --append --groups docker $USER
sudo reboot
```

## Build Docker Image

Download base Docker image locally.

```bash
docker pull ubuntu:22.04
```

Then build the Docker image used by the bitter FPGA application.

```bash
./build.sh
```

## Install Xilinx Tools

Most of the information in this section can be found with more detail on the
AMD/Xilinx [website](https://docs.xilinx.com/r/en-US/ug973-vivado-release-notes-install-license/Download-and-Installation).

Download the "Xilinx Unified Installer" (2022.2 as of writing) and move the
archive into the current directory. If the 2022.2 was downloaded, simply run
the following command to install Vivado into a docker volume for use with the
Bitter Docker image.

```bash
./create-xilinx-volume.sh
```

## Customize Xilinx Batch Install

If the current default install is not suitable for your project (eg. wrong
version or FPGA not included). Then the batch install can be customized by
first running the following command to generate the default batch config file
and then editing it to your needs.

```bash
test -e Xilinx && rm -rf Xilinx
mkdir Xilinx
tar zxvf Xilinx_*.tar.gz -C Xilinx --strip-components 1
cd Xilinx
./xsetup -b ConfigGen
```
