# Nutanix DL use case
This repo contains the information and files necessary to setup the VM on Nutanix.

# VM prerequisites
CPU: 4 
GPU: 2
RAM: 32GB
HDD: 120GB

# Setup instructions
Clone this repository onto the VM.
Run the setup script. 
```bash
$git clone https://github.com/jax79sg/nutanix_dlusecase
$cd nutanix_dlusecase
$chmod +x setupVM.sh
$chmod +x get_coco_dataset.sh
$./setupVM.sh
```
# Testing instructions
To run a quick inference test to validate installation.
```bash
$./testInfer.sh
/darknet/data/dog.jpg: Predicted in 213.558000 milli-seconds.
bicycle: 92%
dog: 98%
truck: 92%
pottedplant: 33%
```
