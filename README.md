# Nutanix DL use case
This repo contains the information and files necessary to setup the VM on Nutanix.

# VM prerequisites
## Hardware (virtual)
CPU: 4 
GPU: 2
RAM: 32GB
HDD: 120GB

## Software
OS: Ubuntu 18.04.04
nvidia driver (latest)
git
sudo or root access

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
1. To run a quick inference test to validate installation.
```bash
$./testInfer.sh
/darknet/data/dog.jpg: Predicted in 213.558000 milli-seconds.
bicycle: 92%
dog: 98%
truck: 92%
pottedplant: 33%
```

2. To run a single GPU training. 
```bash
$./testTraining1gpu.sh
 CUDA-version: 10000 (10020), GPU count: 1  
 OpenCV version: 4.4.0
 compute_capability = 750, cudnn_half = 0 
   layer   filters  size/strd(dil)      input                output
   0 conv     32       3 x 3/ 1    512 x 512 x   3 ->  512 x 512 x  32 0.453 BF
   1 conv     64       3 x 3/ 2    512 x 512 x  32 ->  256 x 256 x  64 2.416 BF
   2 conv     64       1 x 1/ 1    256 x 256 x  64 ->  256 x 256 x  64 0.537 BF
   3 route  1 		                           ->  256 x 256 x  64 
   4 conv     64       1 x 1/ 1    256 x 256 x  64 ->  256 x 256 x  64 0.537 BF
   5 conv     32       1 x 1/ 1    256 x 256 x  64 ->  256 x 256 x  32 0.268 BF
   6 conv     64       3 x 3/ 1    256 x 256 x  32 ->  256 x 256 x  64 2.416 BF
   7 Shortcut Layer: 4,  wt = 0, wn = 0, outputs: 256 x 256 x  64 0.004 BF
   8 conv     64       1 x 1/ 1    256 x 256 x  64 ->  256 x 256 x  64 0.537 BF
   9 route  8 2 	                           ->  256 x 256 x 128 
  10 conv     64       1 x 1/ 1    256 x 256 x 128 ->  256 x 256 x  64 1.074 BF
  11 conv    128       3 x 3/ 2    256 x 256 x  64 ->  128 x 128 x 128 2.416 BF
 .
 .
 .
 
```

# Validation instructions
Record the output of the run after about 30 mins with the following command
```bash
docker logs yolov4 > yolov4.log
```
Save the yolov4.log and pass to Kah Siong for analysis.
