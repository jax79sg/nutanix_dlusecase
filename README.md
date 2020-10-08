# Nutanix DL use case
This repo contains the information and files necessary to setup the VM on Nutanix.<br>
Below instructions are validated on a vanilla Ubuntu 18.04 VPS on Datacrunch.io.

# VM prerequisites
## Network
- High speed internet (Else installation will be slow)

## Hardware (virtual)
- CPU: At least 16 (Else installation will be slow)
- GPU: At least 2 x 8GB
- RAM: At least 32GB
- HDD: At least 120GB

## Software
- OS: Ubuntu 18.04.04
- nvidia driver (latest)
- git
- sudo or root access

# Setup instructions
Clone this repository onto the VM.
Run the setup script. 
```bash
$git clone https://github.com/jax79sg/nutanix_dlusecase
$cd nutanix_dlusecase
$chmod +x *.sh
$./setupVM.sh
```
# Testing instructions
1. To run a benchmark based on http://ai-benchmark.com/alpha
```
#Tests the GPU
docker run --gpus all  ai-benchmark "/bin/bash -c 'python3 run-bench-gpu.py'" 

#Tests the CPU
docker run --gpus all  ai-benchmark "/bin/bash -c 'python3 run-bench-cpu.py'" 
```

2. To run a benchmark based on https://hewlettpackard.github.io/dlcookbook-dlbs
```
cd dlbs
source ./venv/bin/activate
source ./scripts/environment.sh    
python2 $experimenter run  -Pexp.framework='"nvtfcnn"' -Vexp.model='["alexnet","deep_mnist","googlenet","inception3","inception4","overfeat","resnet18","resnet34","resnet101","resnet152","resnet200","resnet269","vgg11","vgg13","resnet50", "alexnet_owt","vgg16","vgg19"]' -Vexp.gpus='["0"]' -Pexp.dtype='"float16"' -Pexp.log_file='"./runs/logs/nvtfcnn/${exp.id}.log"'

python2 $experimenter run  -Pexp.framework='"pytorch"' -Vexp.model='["alexnet","deep_mnist","googlenet","inception3","inception4","overfeat","resnet18","resnet34","resnet101","resnet152","resnet200","resnet269","vgg11","vgg13","resnet50", "alexnet_owt","vgg16","vgg19"]' -Vexp.gpus='["0"]' -Pexp.dtype='"float16"' -Pexp.log_file='"./runs/logs/pytorch/${exp.id}.log"'

python2 $experimenter run  -Pexp.framework='"caffe2"' -Vexp.model='["alexnet","deep_mnist","googlenet","inception3","inception4","overfeat","resnet18","resnet34","resnet101","resnet152","resnet200","resnet269","vgg11","vgg13","resnet50", "alexnet_owt","vgg16","vgg19","inception_resnet_v2"]' -Vexp.gpus='["0"]' -Pexp.dtype='"float16"' -Pexp.log_file='"./runs/logs/caffe2/${exp.id}.log"'

python2 $experimenter run  -Pexp.framework='"mxnet"' -Vexp.model='["alexnet","deep_mnist","googlenet","inception3","inception4","overfeat","resnet18","resnet34","resnet101","resnet152","resnet200","resnet269","vgg11","vgg13","resnet50", "alexnet_owt","vgg16","vgg19","inception_resnet_v2","deep_speech2"]' -Vexp.gpus='["0"]' -Pexp.dtype='"float16"' -Pexp.log_file='"./runs/logs/mxnet/${exp.id}.log"'

```

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

3. To run a multi GPU training. 
*NOTE:* You must have performed at least 1000 iterations of the single GPU training
Run `watch nvidia-smi` to validate both gpus being utilised.
```bash
$./testTraining2gpu.sh
[yolo] params: iou loss: ciou (4), iou_norm: 0.07, cls_norm: 1.00, scale_x_y: 1.05
Total BFLOPS 91.095 
avg_outputs = 757643 
 Allocate additional workspace_size = 75.50 MB 

 seen 64, trained: 12 K-images (0 Kilo-batches_64) 
net.optimized_memory = 0 
mini_batch = 1, batch = 32, time_steps = 1, train = 1 
nms_kind: greedynms (1), beta = 0.600000 
nms_kind: greedynms (1), beta = 0.600000 
nms_kind: greedynms (1), beta = 0.600000 
Loading weights from /darknet/myweights/backup/yolov4_last.weights...Done! Loaded 162 layers from weights-file 
 Create 12 permanent cpu-threads 

 seen 64, trained: 12 K-images (0 Kilo-batches_64) 
Learning Rate: 0.0026, Momentum: 0.949, Decay: 0.0005
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000039 seconds

 402: 27.874079, 27.874079 avg loss, 0.000068 rate, 9.233807 seconds, 25728 images, -1.000000 hours left
Loaded: 0.000045 seconds
Syncing... Done!

 404: 27.877659, 27.874437 avg loss, 0.000072 rate, 8.956024 seconds, 25856 images, 1282.733183 hours left
Loaded: 0.000095 seconds

```

# Validation instructions
Record the output of the run after about 2 hours with the following command
```bash
docker logs testTraining1gpu > ./mydata/testTraining1gpu.log
docker logs testTraining2gpu > ./mydata/testTraining2gpu.log
```
Save the testTraining1gpu.log and pass to Kah Siong for analysis.
