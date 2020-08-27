#!/bin/bash

#On Nutanix VM

#Auto. Install Docker
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    axel \
    wget
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io   

#-------------------------------------

#Auto. Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit nvidia-container-runtime


#Copy daemon.json to /etc/docker/daemon.json to allow Docker build to receive nvidia context
sudo cp daemon.json /etc/docker/daemon.json
sudo systemctl restart docker

sudo docker build . -t yolov4

#Download pretrained model and config
axel -n 10 https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights
wget https://raw.githubusercontent.com/AlexeyAB/darknet/master/cfg/yolov4.cfg

#Setup working folders
mkdir -p mydata
mkdir -p myconfig
mkdir -p myweights
mv yolov4.weights ./myweights/
mv yolov4.cfg ./myconfig/



source $(pwd)/get_coco_dataset.sh

