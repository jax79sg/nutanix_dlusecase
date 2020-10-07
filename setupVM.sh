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
    wget \
    zip
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

# -----------------------------------------------------------

sudo docker pull quay.io/jax79sg/ai-benchmark
sudo docker pull nvcr.io/nvidia/tensorflow:18.04-py3
sudo docker pull nvcr.io/nvidia/caffe2:18.05-py2
sudo docker pull nvcr.io/nvidia/mxnet:18.05-py2
sudo docker pull nvcr.io/nvidia/pytorch:18.05-py3
sudo docker pull nvcr.io/nvidia/caffe:18.05-py2

# -----------------------------------------------------------
sudo docker build . -t yolov4

#Download pretrained model and config
axel -n 10 https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights
wget https://raw.githubusercontent.com/AlexeyAB/darknet/master/cfg/yolov4.cfg
wget https://raw.githubusercontent.com/roboflow-ai/darknet/master/cfg/csdarknet53-omega.cfg

axel -n 10 https://drive.google.com/u/0/uc?export=download&confirm=-TRL&id=18jCwaL4SJ-jOvXrZNGHJ5yz44g9zi8Hm
wget --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=18jCwaL4SJ-jOvXrZNGHJ5yz44g9zi8Hm" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p' > /tmp/confirm && wget --load-cookies /tmp/cookies.txt --no-check-certificate "https://docs.google.com/uc?export=download&confirm="$(cat /tmp/confirm)"&id=18jCwaL4SJ-jOvXrZNGHJ5yz44g9zi8Hm" -O csdarknet53-omega_final.weights && rm /tmp/cookies.txt /tmp/confirm

#Setup working folders
mkdir -p mydata
mkdir -p myconfig
mkdir -p myweights
mv yolov4.weights ./myweights/
mv csdarknet53-omega.cfg ./myconfig/
mv csdarknet53-omega_final.weights ./myweights/
docker run --gpus all  -v $(pwd)/myconfig:/darknet/myconfig -v $(pwd)/mydata:/darknet/mydata -v $(pwd)/myweights:/darknet/myweights yolov4  /darknet/darknet partial /darknet/myconfig/csdarknet53-omega.cfg /darknet/myweights/csdarknet53-omega_final.weights /darknet/myweights/csdarknet53-omega.conv.105 105


#Setup training
axel -n 10 https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.conv.137


source $(pwd)/get_coco_dataset.sh

