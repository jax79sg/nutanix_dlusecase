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
Note that the content should start with something as follows
```bash
Last login: Sun Aug 30 13:55:08 on ttys000
jax@Kahs-MacBook-Pro ~ % ssh 192.168.50.88
jax@192.168.50.88's password: 
Connection closed by 192.168.50.88 port 22
jax@Kahs-MacBook-Pro ~ % ssh 192.168.50.88
jax@192.168.50.88's password: 
Welcome to Ubuntu 18.04.5 LTS (GNU/Linux 5.4.0-42-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

 * Are you ready for Kubernetes 1.19? It's nearly here! Try RC3 with
   sudo snap install microk8s --channel=1.19/candidate --classic

   https://microk8s.io/ has docs and details.

 * Canonical Livepatch is available for installation.
   - Reduce system reboots and improve kernel security. Activate at:
     https://ubuntu.com/livepatch

0 packages can be updated.
0 updates are security updates.

Your Hardware Enablement Stack (HWE) is supported until April 2023.
Last login: Fri Aug 28 19:58:11 2020 from 192.168.50.254
jax@getafix:~$ cd projects/
jax@getafix:~/projects$ s
-bash: s: command not found
jax@getafix:~/projects$ ls
apt-mirror-docker  jenkins  kubejob  modeldb  yolov4
jax@getafix:~/projects$ cd yolov4/
jax@getafix:~/projects/yolov4$ ls
Dockerfile  checkcv.py	 get_coco_dataset.sh  mydata	 setupVM.sh    testTraining1gpu.sh
README.md   daemon.json  myconfig	      myweights  testInfer.sh
jax@getafix:~/projects/yolov4$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
81cbca676a0a        registry:2          "/entrypoint.sh /etc…"   6 weeks ago         Up 6 minutes        0.0.0.0:5000->5000/tcp   registry
jax@getafix:~/projects/yolov4$ ls
Dockerfile  checkcv.py	 get_coco_dataset.sh  mydata	 setupVM.sh    testTraining1gpu.sh
README.md   daemon.json  myconfig	      myweights  testInfer.sh
jax@getafix:~/projects/yolov4$ ./testTraining1gpu.sh 
[sudo] password for jax: 
ba3d743acd7a3c86020b55a1bac5fbee68e6a042e0c34263dfdc2b5d3dc3d5fa
jax@getafix:~/projects/yolov4$ docker logs ba3
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
  12 conv     64       1 x 1/ 1    128 x 128 x 128 ->  128 x 128 x  64 0.268 BF
  13 route  11 		                           ->  128 x 128 x 128 
  14 conv     64       1 x 1/ 1    128 x 128 x 128 ->  128 x 128 x  64 0.268 BF
  15 conv     64       1 x 1/ 1    128 x 128 x  64 ->  128 x 128 x  64 0.134 BF
  16 conv     64       3 x 3/ 1    128 x 128 x  64 ->  128 x 128 x  64 1.208 BF
  17 Shortcut Layer: 14,  wt = 0, wn = 0, outputs: 128 x 128 x  64 0.001 BF
  18 conv     64       1 x 1/ 1    128 x 128 x  64 ->  128 x 128 x  64 0.134 BF
  19 conv     64       3 x 3/ 1    128 x 128 x  64 ->  128 x 128 x  64 1.208 BF
  20 Shortcut Layer: 17,  wt = 0, wn = 0, outputs: 128 x 128 x  64 0.001 BF
  21 conv     64       1 x 1/ 1    128 x 128 x  64 ->  128 x 128 x  64 0.134 BF
  22 route  21 12 	                           ->  128 x 128 x 128 
  23 conv    128       1 x 1/ 1    128 x 128 x 128 ->  128 x 128 x 128 0.537 BF
  24 conv    256       3 x 3/ 2    128 x 128 x 128 ->   64 x  64 x 256 2.416 BF
  25 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
  26 route  24 		                           ->   64 x  64 x 256 
  27 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
  28 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  29 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  30 Shortcut Layer: 27,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  31 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  32 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  33 Shortcut Layer: 30,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  34 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  35 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  36 Shortcut Layer: 33,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  37 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  38 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  39 Shortcut Layer: 36,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  40 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  41 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  42 Shortcut Layer: 39,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  43 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  44 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  45 Shortcut Layer: 42,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  46 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  47 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  48 Shortcut Layer: 45,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  49 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  50 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  51 Shortcut Layer: 48,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  52 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  53 route  52 25 	                           ->   64 x  64 x 256 
  54 conv    256       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 256 0.537 BF
  55 conv    512       3 x 3/ 2     64 x  64 x 256 ->   32 x  32 x 512 2.416 BF
  56 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
  57 route  55 		                           ->   32 x  32 x 512 
  58 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
  59 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  60 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  61 Shortcut Layer: 58,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  62 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  63 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  64 Shortcut Layer: 61,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  65 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  66 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  67 Shortcut Layer: 64,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  68 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  69 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  70 Shortcut Layer: 67,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  71 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  72 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  73 Shortcut Layer: 70,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  74 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  75 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  76 Shortcut Layer: 73,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  77 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  78 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  79 Shortcut Layer: 76,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  80 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  81 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  82 Shortcut Layer: 79,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  83 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  84 route  83 56 	                           ->   32 x  32 x 512 
  85 conv    512       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 512 0.537 BF
  86 conv   1024       3 x 3/ 2     32 x  32 x 512 ->   16 x  16 x1024 2.416 BF
  87 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
  88 route  86 		                           ->   16 x  16 x1024 
  89 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
  90 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
  91 conv    512       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x 512 1.208 BF
  92 Shortcut Layer: 89,  wt = 0, wn = 0, outputs:  16 x  16 x 512 0.000 BF
  93 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
  94 conv    512       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x 512 1.208 BF
  95 Shortcut Layer: 92,  wt = 0, wn = 0, outputs:  16 x  16 x 512 0.000 BF
  96 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
  97 conv    512       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x 512 1.208 BF
  98 Shortcut Layer: 95,  wt = 0, wn = 0, outputs:  16 x  16 x 512 0.000 BF
  99 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
 100 conv    512       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x 512 1.208 BF
 101 Shortcut Layer: 98,  wt = 0, wn = 0, outputs:  16 x  16 x 512 0.000 BF
 102 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
 103 route  102 87 	                           ->   16 x  16 x1024 
 104 conv   1024       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x1024 0.537 BF
 105 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 106 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 107 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 108 max                5x 5/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.003 BF
 109 route  107 		                           ->   16 x  16 x 512 
 110 max                9x 9/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.011 BF
 111 route  107 		                           ->   16 x  16 x 512 
 112 max               13x13/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.022 BF
 113 route  112 110 108 107 	                   ->   16 x  16 x2048 
 114 conv    512       1 x 1/ 1     16 x  16 x2048 ->   16 x  16 x 512 0.537 BF
 115 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 116 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 117 conv    256       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 256 0.067 BF
 118 upsample                 2x    16 x  16 x 256 ->   32 x  32 x 256
 119 route  85 		                           ->   32 x  32 x 512 
 120 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 121 route  120 118 	                           ->   32 x  32 x 512 
 122 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 123 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 124 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 125 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 126 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 127 conv    128       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 128 0.067 BF
 128 upsample                 2x    32 x  32 x 128 ->   64 x  64 x 128
 129 route  54 		                           ->   64 x  64 x 256 
 130 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
 131 route  130 128 	                           ->   64 x  64 x 256 
 132 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
 133 conv    256       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 256 2.416 BF
 134 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
 135 conv    256       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 256 2.416 BF
 136 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
 137 conv    256       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 256 2.416 BF
 138 conv    255       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 255 0.535 BF
 139 yolo
[yolo] params: iou loss: ciou (4), iou_norm: 0.07, cls_norm: 1.00, scale_x_y: 1.20
 140 route  136 		                           ->   64 x  64 x 128 
 141 conv    256       3 x 3/ 2     64 x  64 x 128 ->   32 x  32 x 256 0.604 BF
 142 route  141 126 	                           ->   32 x  32 x 512 
 143 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 144 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 145 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 146 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 147 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 148 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 149 conv    255       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 255 0.267 BF
 150 yolo
[yolo] params: iou loss: ciou (4), iou_norm: 0.07, cls_norm: 1.00, scale_x_y: 1.10
 151 route  147 		                           ->   32 x  32 x 256 
 152 conv    512       3 x 3/ 2     32 x  32 x 256 ->   16 x  16 x 512 0.604 BF
 153 route  152 116 	                           ->   16 x  16 x1024 
 154 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 155 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 156 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 157 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 158 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 159 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 160 conv    255       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 255 0.134 BF
 161 yolo
[yolo] params: iou loss: ciou (4), iou_norm: 0.07, cls_norm: 1.00, scale_x_y: 1.05
Total BFLOPS 91.095 
avg_outputs = 757643 
 Allocate additional workspace_size = 75.50 MB 
yolov4
net.optimized_memory = 0 
mini_batch = 1, batch = 32, time_steps = 1, train = 1 
nms_kind: greedynms (1), beta = 0.600000 
nms_kind: greedynms (1), beta = 0.600000 
nms_kind: greedynms (1), beta = 0.600000 
Loading weights from /darknet/myweights/csdarknet53-omega.conv.105...Done! Loaded 105 layers from weights-file 
 Create 6 permanent cpu-threads 
jax@getafix:~/projects/yolov4$ docker logs -f ba3
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
  12 conv     64       1 x 1/ 1    128 x 128 x 128 ->  128 x 128 x  64 0.268 BF
  13 route  11 		                           ->  128 x 128 x 128 
  14 conv     64       1 x 1/ 1    128 x 128 x 128 ->  128 x 128 x  64 0.268 BF
  15 conv     64       1 x 1/ 1    128 x 128 x  64 ->  128 x 128 x  64 0.134 BF
  16 conv     64       3 x 3/ 1    128 x 128 x  64 ->  128 x 128 x  64 1.208 BF
  17 Shortcut Layer: 14,  wt = 0, wn = 0, outputs: 128 x 128 x  64 0.001 BF
  18 conv     64       1 x 1/ 1    128 x 128 x  64 ->  128 x 128 x  64 0.134 BF
  19 conv     64       3 x 3/ 1    128 x 128 x  64 ->  128 x 128 x  64 1.208 BF
  20 Shortcut Layer: 17,  wt = 0, wn = 0, outputs: 128 x 128 x  64 0.001 BF
  21 conv     64       1 x 1/ 1    128 x 128 x  64 ->  128 x 128 x  64 0.134 BF
  22 route  21 12 	                           ->  128 x 128 x 128 
  23 conv    128       1 x 1/ 1    128 x 128 x 128 ->  128 x 128 x 128 0.537 BF
  24 conv    256       3 x 3/ 2    128 x 128 x 128 ->   64 x  64 x 256 2.416 BF
  25 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
  26 route  24 		                           ->   64 x  64 x 256 
  27 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
  28 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  29 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  30 Shortcut Layer: 27,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  31 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  32 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  33 Shortcut Layer: 30,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  34 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  35 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  36 Shortcut Layer: 33,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  37 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  38 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  39 Shortcut Layer: 36,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  40 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  41 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  42 Shortcut Layer: 39,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  43 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  44 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  45 Shortcut Layer: 42,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  46 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  47 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  48 Shortcut Layer: 45,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  49 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  50 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  51 Shortcut Layer: 48,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  52 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  53 route  52 25 	                           ->   64 x  64 x 256 
  54 conv    256       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 256 0.537 BF
  55 conv    512       3 x 3/ 2     64 x  64 x 256 ->   32 x  32 x 512 2.416 BF
  56 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
  57 route  55 		                           ->   32 x  32 x 512 
  58 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
  59 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  60 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  61 Shortcut Layer: 58,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  62 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  63 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  64 Shortcut Layer: 61,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  65 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  66 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  67 Shortcut Layer: 64,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  68 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  69 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  70 Shortcut Layer: 67,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  71 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  72 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  73 Shortcut Layer: 70,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  74 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  75 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  76 Shortcut Layer: 73,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  77 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  78 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  79 Shortcut Layer: 76,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  80 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  81 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  82 Shortcut Layer: 79,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  83 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  84 route  83 56 	                           ->   32 x  32 x 512 
  85 conv    512       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 512 0.537 BF
  86 conv   1024       3 x 3/ 2     32 x  32 x 512 ->   16 x  16 x1024 2.416 BF
  87 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
  88 route  86 		                           ->   16 x  16 x1024 
  89 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
  90 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
  91 conv    512       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x 512 1.208 BF
  92 Shortcut Layer: 89,  wt = 0, wn = 0, outputs:  16 x  16 x 512 0.000 BF
  93 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
  94 conv    512       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x 512 1.208 BF
  95 Shortcut Layer: 92,  wt = 0, wn = 0, outputs:  16 x  16 x 512 0.000 BF
  96 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
  97 conv    512       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x 512 1.208 BF
  98 Shortcut Layer: 95,  wt = 0, wn = 0, outputs:  16 x  16 x 512 0.000 BF
  99 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
 100 conv    512       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x 512 1.208 BF
 101 Shortcut Layer: 98,  wt = 0, wn = 0, outputs:  16 x  16 x 512 0.000 BF
 102 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
 103 route  102 87 	                           ->   16 x  16 x1024 
 104 conv   1024       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x1024 0.537 BF
 105 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 106 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 107 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 108 max                5x 5/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.003 BF
 109 route  107 		                           ->   16 x  16 x 512 
 110 max                9x 9/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.011 BF
 111 route  107 		                           ->   16 x  16 x 512 
 112 max               13x13/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.022 BF
 113 route  112 110 108 107 	                   ->   16 x  16 x2048 
 114 conv    512       1 x 1/ 1     16 x  16 x2048 ->   16 x  16 x 512 0.537 BF
 115 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 116 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 117 conv    256       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 256 0.067 BF
 118 upsample                 2x    16 x  16 x 256 ->   32 x  32 x 256
 119 route  85 		                           ->   32 x  32 x 512 
 120 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 121 route  120 118 	                           ->   32 x  32 x 512 
 122 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 123 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 124 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 125 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 126 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 127 conv    128       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 128 0.067 BF
 128 upsample                 2x    32 x  32 x 128 ->   64 x  64 x 128
 129 route  54 		                           ->   64 x  64 x 256 
 130 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
 131 route  130 128 	                           ->   64 x  64 x 256 
 132 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
 133 conv    256       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 256 2.416 BF
 134 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
 135 conv    256       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 256 2.416 BF
 136 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
 137 conv    256       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 256 2.416 BF
 138 conv    255       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 255 0.535 BF
 139 yolo
[yolo] params: iou loss: ciou (4), iou_norm: 0.07, cls_norm: 1.00, scale_x_y: 1.20
 140 route  136 		                           ->   64 x  64 x 128 
 141 conv    256       3 x 3/ 2     64 x  64 x 128 ->   32 x  32 x 256 0.604 BF
 142 route  141 126 	                           ->   32 x  32 x 512 
 143 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 144 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 145 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 146 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 147 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 148 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 149 conv    255       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 255 0.267 BF
 150 yolo
[yolo] params: iou loss: ciou (4), iou_norm: 0.07, cls_norm: 1.00, scale_x_y: 1.10
 151 route  147 		                           ->   32 x  32 x 256 
 152 conv    512       3 x 3/ 2     32 x  32 x 256 ->   16 x  16 x 512 0.604 BF
 153 route  152 116 	                           ->   16 x  16 x1024 
 154 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 155 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 156 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 157 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 158 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 159 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 160 conv    255       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 255 0.134 BF
 161 yolo
[yolo] params: iou loss: ciou (4), iou_norm: 0.07, cls_norm: 1.00, scale_x_y: 1.05
Total BFLOPS 91.095 
avg_outputs = 757643 
 Allocate additional workspace_size = 75.50 MB 
yolov4
net.optimized_memory = 0 
mini_batch = 1, batch = 32, time_steps = 1, train = 1 
nms_kind: greedynms (1), beta = 0.600000 
nms_kind: greedynms (1), beta = 0.600000 
nms_kind: greedynms (1), beta = 0.600000 
Loading weights from /darknet/myweights/csdarknet53-omega.conv.105...Done! Loaded 105 layers from weights-file 
 Create 6 permanent cpu-threads 

 seen 64, trained: 0 K-images (0 Kilo-batches_64) 
Learning Rate: 0.0013, Momentum: 0.949, Decay: 0.0005
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 1: 4173.809082, 4173.809082 avg loss, 0.000000 rate, 12.090222 seconds, 32 images, -1.000000 hours left
Loaded: 0.000027 seconds

 2: 4149.802734, 4171.408203 avg loss, 0.000000 rate, 11.797990 seconds, 64 images, 1680.877665 hours left
Loaded: 0.000022 seconds

 3: 4226.664062, 4176.933594 avg loss, 0.000000 rate, 12.455998 seconds, 96 images, 1680.471355 hours left
Loaded: 0.000029 seconds

 4: 4132.355469, 4172.475586 avg loss, 0.000000 rate, 12.052404 seconds, 128 images, 1680.983876 hours left
Loaded: 0.000024 seconds

 5: 4216.416504, 4176.869629 avg loss, 0.000000 rate, 12.681887 seconds, 160 images, 1680.930145 hours left
Loaded: 0.000024 seconds

 6: 4207.911621, 4179.973633 avg loss, 0.000000 rate, 12.689269 seconds, 192 images, 1681.752057 hours left
Loaded: 0.000031 seconds

 7: 4218.544434, 4183.830566 avg loss, 0.000000 rate, 12.900318 seconds, 224 images, 1682.575978 hours left
Loaded: 0.000032 seconds

 8: 4233.218750, 4188.769531 avg loss, 0.000000 rate, 12.962915 seconds, 256 images, 1683.685047 hours left
Loaded: 0.000037 seconds

 9: 4161.471191, 4186.039551 avg loss, 0.000000 rate, 12.644999 seconds, 288 images, 1684.870017 hours left
Loaded: 0.000033 seconds

 10: 4193.373535, 4186.772949 avg loss, 0.000000 rate, 12.631808 seconds, 320 images, 1685.601124 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.367014 seconds - performance bottleneck on CPU or Disk HDD/SSD

 11: 3487.893799, 4116.885254 avg loss, 0.000000 rate, 10.647831 seconds, 352 images, 1686.306541 hours left
Loaded: 0.000025 seconds

 12: 3580.657959, 4063.262451 avg loss, 0.000000 rate, 11.223797 seconds, 384 images, 1684.756846 hours left
Loaded: 0.000025 seconds

 13: 3581.504883, 4015.086670 avg loss, 0.000000 rate, 11.180193 seconds, 416 images, 1683.513146 hours left
Loaded: 0.000023 seconds

 14: 3557.247314, 3969.302734 avg loss, 0.000000 rate, 10.830639 seconds, 448 images, 1682.221232 hours left
Loaded: 0.000030 seconds

 15: 3493.402588, 3921.712646 avg loss, 0.000000 rate, 10.504375 seconds, 480 images, 1680.456240 hours left
Loaded: 0.000024 seconds

 16: 3538.359863, 3883.377441 avg loss, 0.000000 rate, 10.813901 seconds, 512 images, 1678.255292 hours left
Loaded: 0.000024 seconds

 17: 3522.840820, 3847.323730 avg loss, 0.000000 rate, 10.856585 seconds, 544 images, 1676.506631 hours left
Loaded: 0.000020 seconds

 18: 3491.266602, 3811.718018 avg loss, 0.000000 rate, 10.680745 seconds, 576 images, 1674.834767 hours left
Loaded: 0.000033 seconds

 19: 3631.731689, 3793.719482 avg loss, 0.000000 rate, 11.529724 seconds, 608 images, 1672.935128 hours left
Loaded: 0.000032 seconds

 20: 3429.565186, 3757.303955 avg loss, 0.000000 rate, 10.270648 seconds, 640 images, 1672.234745 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.302879 seconds - performance bottleneck on CPU or Disk HDD/SSD

 21: 1707.391724, 3552.312744 avg loss, 0.000000 rate, 5.263111 seconds, 672 images, 1669.790938 hours left
Loaded: 0.000039 seconds

 22: 1704.254639, 3367.506836 avg loss, 0.000000 rate, 5.234863 seconds, 704 images, 1660.830987 hours left
Loaded: 0.000025 seconds

 23: 1728.384766, 3203.594727 avg loss, 0.000000 rate, 5.180797 seconds, 736 images, 1651.500336 hours left
Loaded: 0.000024 seconds

 24: 1688.889648, 3052.124268 avg loss, 0.000000 rate, 5.089346 seconds, 768 images, 1642.187794 hours left
Loaded: 0.000031 seconds

 25: 1596.875122, 2906.599365 avg loss, 0.000000 rate, 4.812213 seconds, 800 images, 1632.841226 hours left
Loaded: 0.000031 seconds

 26: 1606.161499, 2776.555664 avg loss, 0.000000 rate, 4.927789 seconds, 832 images, 1623.202847 hours left
Loaded: 0.000031 seconds

 27: 1757.293457, 2674.629395 avg loss, 0.000000 rate, 5.351794 seconds, 864 images, 1613.821512 hours left
Loaded: 0.000035 seconds

 28: 1752.522461, 2582.418701 avg loss, 0.000000 rate, 5.315434 seconds, 896 images, 1605.123439 hours left
Loaded: 0.000032 seconds

 29: 1735.167114, 2497.693604 avg loss, 0.000000 rate, 5.275038 seconds, 928 images, 1596.461781 hours left
Loaded: 0.000031 seconds

 30: 1747.484009, 2422.672607 avg loss, 0.000000 rate, 5.294252 seconds, 960 images, 1587.830560 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.342458 seconds - performance bottleneck on CPU or Disk HDD/SSD

 31: 1507.310059, 2331.136230 avg loss, 0.000000 rate, 4.850393 seconds, 992 images, 1579.312349 hours left
Loaded: 0.000025 seconds

 32: 1486.674927, 2246.690186 avg loss, 0.000000 rate, 4.861186 seconds, 1024 images, 1570.738295 hours left
Loaded: 0.000035 seconds

 33: 1530.359497, 2175.057129 avg loss, 0.000000 rate, 4.996417 seconds, 1056 images, 1561.788926 hours left
Loaded: 0.000034 seconds

 34: 1446.722656, 2102.223633 avg loss, 0.000000 rate, 4.774529 seconds, 1088 images, 1553.117047 hours left
Loaded: 0.000036 seconds

 35: 1522.697876, 2044.270996 avg loss, 0.000000 rate, 5.037859 seconds, 1120 images, 1544.223405 hours left
Loaded: 0.000034 seconds

 36: 1518.074707, 1991.651367 avg loss, 0.000000 rate, 4.966377 seconds, 1152 images, 1535.784767 hours left
Loaded: 0.000033 seconds

 37: 1531.819458, 1945.668213 avg loss, 0.000000 rate, 5.035477 seconds, 1184 images, 1527.331126 hours left
Loaded: 0.000048 seconds

 38: 1445.424316, 1895.643799 avg loss, 0.000000 rate, 4.813233 seconds, 1216 images, 1519.058068 hours left
Loaded: 0.000037 seconds

 39: 1425.401001, 1848.619507 avg loss, 0.000000 rate, 4.750328 seconds, 1248 images, 1510.558789 hours left
Loaded: 0.000027 seconds

 40: 1487.342163, 1812.491821 avg loss, 0.000000 rate, 4.852411 seconds, 1280 images, 1502.057026 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.000023 seconds

 41: 2121.773682, 1843.420044 avg loss, 0.000000 rate, 6.606806 seconds, 1312 images, 1493.782166 hours left
Loaded: 0.000031 seconds

 42: 2100.970459, 1869.175049 avg loss, 0.000000 rate, 6.552457 seconds, 1344 images, 1488.028930 hours left
Loaded: 0.000033 seconds

 43: 2081.394531, 1890.396973 avg loss, 0.000000 rate, 6.560110 seconds, 1376 images, 1482.257666 hours left
Loaded: 0.000032 seconds

 44: 2075.794189, 1908.936646 avg loss, 0.000000 rate, 6.528168 seconds, 1408 images, 1476.554739 hours left
Loaded: 0.000034 seconds

 45: 2120.338623, 1930.076904 avg loss, 0.000000 rate, 6.726192 seconds, 1440 images, 1470.864418 hours left
Loaded: 0.000025 seconds

 46: 2014.129150, 1938.482178 avg loss, 0.000000 rate, 6.499687 seconds, 1472 images, 1465.506268 hours left
Loaded: 0.000030 seconds

 47: 2041.871826, 1948.821167 avg loss, 0.000000 rate, 6.525722 seconds, 1504 images, 1459.886798 hours left
Loaded: 0.000029 seconds

 48: 2056.140137, 1959.553101 avg loss, 0.000000 rate, 6.679307 seconds, 1536 images, 1454.359699 hours left
Loaded: 0.000028 seconds

 49: 2066.513184, 1970.249146 avg loss, 0.000000 rate, 6.692412 seconds, 1568 images, 1449.101356 hours left
Loaded: 0.000033 seconds

 50: 1970.875854, 1970.311768 avg loss, 0.000000 rate, 6.421933 seconds, 1600 images, 1443.913793 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.008391 seconds

 51: 2716.897217, 2044.970337 avg loss, 0.000000 rate, 9.532230 seconds, 1632 images, 1438.402093 hours left
Loaded: 0.000035 seconds

 52: 2616.321777, 2102.105469 avg loss, 0.000000 rate, 9.111886 seconds, 1664 images, 1437.280847 hours left
Loaded: 0.000035 seconds

 53: 2693.073975, 2161.202393 avg loss, 0.000000 rate, 9.478677 seconds, 1696 images, 1435.574836 hours left
Loaded: 0.000026 seconds

 54: 2612.814697, 2206.363525 avg loss, 0.000000 rate, 9.211340 seconds, 1728 images, 1434.395748 hours left
Loaded: 0.000028 seconds

 55: 2675.333740, 2253.260498 avg loss, 0.000000 rate, 9.592247 seconds, 1760 images, 1432.856790 hours left
Loaded: 0.000025 seconds

 56: 2577.797852, 2285.714355 avg loss, 0.000000 rate, 9.202851 seconds, 1792 images, 1431.862694 hours left
Loaded: 0.000024 seconds

 57: 2565.435547, 2313.686523 avg loss, 0.000000 rate, 9.314364 seconds, 1824 images, 1430.337201 hours left
Loaded: 0.000035 seconds

 58: 2572.105469, 2339.528320 avg loss, 0.000000 rate, 9.575367 seconds, 1856 images, 1428.981952 hours left
Loaded: 0.000028 seconds

 59: 2576.638916, 2363.239502 avg loss, 0.000000 rate, 9.726888 seconds, 1888 images, 1428.003071 hours left
Loaded: 0.000025 seconds

 60: 2376.454102, 2364.561035 avg loss, 0.000000 rate, 9.060367 seconds, 1920 images, 1427.244573 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.200603 seconds - performance bottleneck on CPU or Disk HDD/SSD

 61: 1413.966309, 2269.501465 avg loss, 0.000000 rate, 5.543922 seconds, 1952 images, 1425.567090 hours left
Loaded: 0.000027 seconds

 62: 1365.237671, 2179.075195 avg loss, 0.000000 rate, 5.454839 seconds, 1984 images, 1419.296944 hours left
Loaded: 0.000026 seconds

 63: 1303.532471, 2091.520996 avg loss, 0.000000 rate, 5.312785 seconds, 2016 images, 1412.686826 hours left
Loaded: 0.000027 seconds

 64: 1235.940308, 2005.962891 avg loss, 0.000000 rate, 5.173002 seconds, 2048 images, 1405.945325 hours left
Loaded: 0.000029 seconds

 65: 1258.312134, 1931.197876 avg loss, 0.000000 rate, 5.392919 seconds, 2080 images, 1399.076912 hours left
Loaded: 0.000026 seconds

 66: 1280.790039, 1866.157104 avg loss, 0.000000 rate, 5.322211 seconds, 2112 images, 1392.582877 hours left
Loaded: 0.000034 seconds

 67: 1223.883179, 1801.929688 avg loss, 0.000000 rate, 5.367076 seconds, 2144 images, 1386.055472 hours left
Loaded: 0.000038 seconds

 68: 1286.167847, 1750.353516 avg loss, 0.000000 rate, 5.589015 seconds, 2176 images, 1379.655705 hours left
Loaded: 0.000031 seconds

 69: 1144.565430, 1689.774658 avg loss, 0.000000 rate, 5.346576 seconds, 2208 images, 1373.628440 hours left
Loaded: 0.000024 seconds

 70: 1186.022827, 1639.399414 avg loss, 0.000000 rate, 5.546896 seconds, 2240 images, 1367.324415 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000022 seconds

 71: 2636.747803, 1739.134277 avg loss, 0.000000 rate, 13.955210 seconds, 2272 images, 1361.361867 hours left
Loaded: 0.000028 seconds

 72: 2545.147461, 1819.735596 avg loss, 0.000000 rate, 13.779991 seconds, 2304 images, 1367.147159 hours left
Loaded: 0.000028 seconds

 73: 2326.800049, 1870.442017 avg loss, 0.000000 rate, 12.637121 seconds, 2336 images, 1372.630998 hours left
Loaded: 0.000027 seconds

 74: 2290.386475, 1912.436523 avg loss, 0.000000 rate, 13.164900 seconds, 2368 images, 1376.471284 hours left
Loaded: 0.000028 seconds

 75: 2212.937500, 1942.486572 avg loss, 0.000000 rate, 13.381128 seconds, 2400 images, 1381.006785 hours left
Loaded: 0.000029 seconds

 76: 2027.360962, 1950.973999 avg loss, 0.000000 rate, 13.071362 seconds, 2432 images, 1385.797466 hours left
Loaded: 0.000044 seconds

 77: 1988.435669, 1954.720215 avg loss, 0.000000 rate, 13.782337 seconds, 2464 images, 1390.109609 hours left
Loaded: 0.000028 seconds

 78: 1822.297363, 1941.477905 avg loss, 0.000000 rate, 13.264564 seconds, 2496 images, 1395.366915 hours left
Loaded: 0.000028 seconds

 79: 1671.128418, 1914.442993 avg loss, 0.000000 rate, 12.834194 seconds, 2528 images, 1399.851852 hours left
Loaded: 0.000026 seconds

 80: 1637.605347, 1886.759277 avg loss, 0.000000 rate, 13.712697 seconds, 2560 images, 1403.693663 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.292600 seconds - performance bottleneck on CPU or Disk HDD/SSD

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 81: 717.125488, 1769.795898 avg loss, 0.000000 rate, 5.919347 seconds, 2592 images, 1408.718187 hours left
Loaded: 0.000033 seconds

 82: 697.591919, 1662.575562 avg loss, 0.000000 rate, 6.160026 seconds, 2624 images, 1403.265965 hours left
Loaded: 0.000028 seconds

 83: 749.172607, 1571.235229 avg loss, 0.000000 rate, 6.519270 seconds, 2656 images, 1397.796108 hours left
Loaded: 0.000021 seconds

 84: 645.051025, 1478.616821 avg loss, 0.000000 rate, 6.203209 seconds, 2688 images, 1392.880294 hours left
Loaded: 0.000033 seconds

 85: 608.184998, 1391.573608 avg loss, 0.000000 rate, 6.202337 seconds, 2720 images, 1387.574268 hours left
Loaded: 0.000027 seconds

 86: 514.002625, 1303.816528 avg loss, 0.000000 rate, 5.984340 seconds, 2752 images, 1382.320089 hours left
Loaded: 0.000027 seconds

 87: 457.329590, 1219.167847 avg loss, 0.000000 rate, 5.749182 seconds, 2784 images, 1376.815403 hours left
Loaded: 0.000028 seconds

 88: 495.793427, 1146.830444 avg loss, 0.000000 rate, 6.141510 seconds, 2816 images, 1371.038870 hours left
Loaded: 0.000033 seconds

 89: 421.956055, 1074.343018 avg loss, 0.000000 rate, 5.912280 seconds, 2848 images, 1365.865435 hours left
Loaded: 0.000028 seconds

 90: 456.262421, 1012.534973 avg loss, 0.000000 rate, 6.354924 seconds, 2880 images, 1360.425089 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.433668 seconds - performance bottleneck on CPU or Disk HDD/SSD

 91: 494.085114, 960.690002 avg loss, 0.000000 rate, 5.949176 seconds, 2912 images, 1355.654412 hours left
Loaded: 0.000029 seconds

 92: 382.984131, 902.919434 avg loss, 0.000000 rate, 5.591126 seconds, 2944 images, 1350.970194 hours left
Loaded: 0.000030 seconds

 93: 361.352875, 848.762756 avg loss, 0.000000 rate, 5.517861 seconds, 2976 images, 1345.232336 hours left
Loaded: 0.000038 seconds

 94: 503.326416, 814.219116 avg loss, 0.000000 rate, 5.998763 seconds, 3008 images, 1339.450001 hours left
Loaded: 0.000027 seconds

 95: 473.628143, 780.160034 avg loss, 0.000000 rate, 6.163004 seconds, 3040 images, 1334.393949 hours left
Loaded: 0.000027 seconds

 96: 403.230957, 742.467102 avg loss, 0.000000 rate, 5.817914 seconds, 3072 images, 1329.616722 hours left
Loaded: 0.000028 seconds

 97: 347.729980, 702.993408 avg loss, 0.000000 rate, 5.685118 seconds, 3104 images, 1324.407572 hours left
Loaded: 0.000036 seconds

 98: 301.123444, 662.806396 avg loss, 0.000000 rate, 5.494353 seconds, 3136 images, 1319.065910 hours left
Loaded: 0.000033 seconds

 99: 409.173920, 637.443176 avg loss, 0.000000 rate, 5.978704 seconds, 3168 images, 1313.512496 hours left
Loaded: 0.000036 seconds

 100: 279.734375, 601.672302 avg loss, 0.000000 rate, 5.330096 seconds, 3200 images, 1308.687845 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000023 seconds

 101: 425.808411, 584.085938 avg loss, 0.000000 rate, 11.886361 seconds, 3232 images, 1303.009863 hours left
Loaded: 0.000027 seconds

 102: 355.880768, 561.265442 avg loss, 0.000000 rate, 11.294668 seconds, 3264 images, 1306.501818 hours left
Loaded: 0.000027 seconds

 103: 285.962006, 533.735107 avg loss, 0.000000 rate, 10.910865 seconds, 3296 images, 1309.136378 hours left
Loaded: 0.000027 seconds

 104: 314.598602, 511.821472 avg loss, 0.000000 rate, 11.258168 seconds, 3328 images, 1311.211077 hours left
Loaded: 0.000027 seconds

 105: 360.863922, 496.725708 avg loss, 0.000000 rate, 11.660817 seconds, 3360 images, 1313.747745 hours left
Loaded: 0.000032 seconds

 106: 340.853455, 481.138489 avg loss, 0.000000 rate, 11.769280 seconds, 3392 images, 1316.818693 hours left
Loaded: 0.000026 seconds

 107: 454.811493, 478.505798 avg loss, 0.000000 rate, 12.552841 seconds, 3424 images, 1320.009667 hours left
Loaded: 0.000027 seconds

 108: 345.645447, 465.219757 avg loss, 0.000000 rate, 11.751118 seconds, 3456 images, 1324.257825 hours left
Loaded: 0.000026 seconds

 109: 207.159683, 439.413757 avg loss, 0.000000 rate, 11.051067 seconds, 3488 images, 1327.349091 hours left
Loaded: 0.000026 seconds

 110: 294.879730, 424.960358 avg loss, 0.000000 rate, 11.644643 seconds, 3520 images, 1329.436368 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.077354 seconds

 111: 277.499268, 410.214233 avg loss, 0.000000 rate, 12.834502 seconds, 3552 images, 1332.327784 hours left
Loaded: 0.000029 seconds

 112: 268.757477, 396.068542 avg loss, 0.000000 rate, 12.655604 seconds, 3584 images, 1336.951607 hours left
Loaded: 0.000030 seconds

 113: 255.175003, 381.979187 avg loss, 0.000000 rate, 12.177301 seconds, 3616 images, 1341.173013 hours left
Loaded: 0.000027 seconds

 114: 272.848114, 371.066071 avg loss, 0.000000 rate, 12.423076 seconds, 3648 images, 1344.687348 hours left
Loaded: 0.000027 seconds

 115: 318.877075, 365.847168 avg loss, 0.000000 rate, 12.953582 seconds, 3680 images, 1348.508118 hours left
Loaded: 0.000023 seconds

 116: 342.588318, 363.521271 avg loss, 0.000000 rate, 13.558823 seconds, 3712 images, 1353.028029 hours left
Loaded: 0.000026 seconds

 117: 312.894714, 358.458618 avg loss, 0.000000 rate, 13.042645 seconds, 3744 images, 1358.343956 hours left
Loaded: 0.000028 seconds

 118: 236.508789, 346.263641 avg loss, 0.000000 rate, 12.606205 seconds, 3776 images, 1362.889227 hours left
Loaded: 0.000028 seconds

 119: 315.452209, 343.182495 avg loss, 0.000000 rate, 13.055994 seconds, 3808 images, 1366.782387 hours left
Loaded: 0.000027 seconds

 120: 188.677628, 327.731995 avg loss, 0.000000 rate, 12.080338 seconds, 3840 images, 1371.261756 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.376501 seconds - performance bottleneck on CPU or Disk HDD/SSD

 121: 279.079132, 322.866699 avg loss, 0.000000 rate, 6.590676 seconds, 3872 images, 1374.340189 hours left
Loaded: 0.000029 seconds

 122: 248.802261, 315.460266 avg loss, 0.000000 rate, 6.353224 seconds, 3904 images, 1370.280771 hours left
Loaded: 0.000028 seconds

 123: 258.911102, 309.805359 avg loss, 0.000000 rate, 6.284440 seconds, 3936 images, 1365.408610 hours left
Loaded: 0.000027 seconds

 124: 297.550598, 308.579895 avg loss, 0.000000 rate, 6.524535 seconds, 3968 images, 1360.489546 hours left
Loaded: 0.000029 seconds

 125: 197.452026, 297.467102 avg loss, 0.000000 rate, 5.995200 seconds, 4000 images, 1355.953371 hours left
Loaded: 0.000029 seconds

 126: 268.017029, 294.522095 avg loss, 0.000000 rate, 6.331842 seconds, 4032 images, 1350.726801 hours left
Loaded: 0.000027 seconds

 127: 245.067322, 289.576630 avg loss, 0.000000 rate, 6.188571 seconds, 4064 images, 1346.020389 hours left
Loaded: 0.000036 seconds

 128: 204.002304, 281.019196 avg loss, 0.000000 rate, 6.059177 seconds, 4096 images, 1341.161885 hours left
Loaded: 0.000027 seconds

 129: 240.626831, 276.979950 avg loss, 0.000000 rate, 6.237739 seconds, 4128 images, 1336.172113 hours left
Loaded: 0.000036 seconds

 130: 192.039734, 268.485931 avg loss, 0.000000 rate, 5.973976 seconds, 4160 images, 1331.480398 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 131: 237.258881, 265.363220 avg loss, 0.000000 rate, 11.593608 seconds, 4192 images, 1326.468985 hours left
Loaded: 0.000037 seconds

 132: 325.659302, 271.392822 avg loss, 0.000000 rate, 12.314132 seconds, 4224 images, 1329.318462 hours left
Loaded: 0.000029 seconds

 133: 255.124847, 269.766022 avg loss, 0.000000 rate, 11.560262 seconds, 4256 images, 1333.140892 hours left
Loaded: 0.000044 seconds

 134: 117.595871, 254.549011 avg loss, 0.000000 rate, 10.724108 seconds, 4288 images, 1335.877240 hours left
Loaded: 0.000025 seconds

 135: 201.341019, 249.228210 avg loss, 0.000000 rate, 11.479370 seconds, 4320 images, 1337.424043 hours left
Loaded: 0.000032 seconds

 136: 176.025925, 241.907990 avg loss, 0.000000 rate, 11.248451 seconds, 4352 images, 1340.005059 hours left
Loaded: 0.000027 seconds

 137: 195.975159, 237.314713 avg loss, 0.000000 rate, 11.726273 seconds, 4384 images, 1342.239293 hours left
Loaded: 0.000043 seconds

 138: 298.293549, 243.412598 avg loss, 0.000000 rate, 12.438408 seconds, 4416 images, 1345.115277 hours left
Loaded: 0.000028 seconds

 139: 162.473862, 235.318726 avg loss, 0.000000 rate, 11.332060 seconds, 4448 images, 1348.952286 hours left
Loaded: 0.000030 seconds

 140: 236.942276, 235.481079 avg loss, 0.000000 rate, 12.121992 seconds, 4480 images, 1351.213153 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.039771 seconds

 141: 263.185028, 238.251480 avg loss, 0.000001 rate, 14.163974 seconds, 4512 images, 1354.549300 hours left
Loaded: 0.000027 seconds

 142: 234.001068, 237.826447 avg loss, 0.000001 rate, 14.073945 seconds, 4544 images, 1360.745408 hours left
Loaded: 0.000033 seconds

 143: 226.812149, 236.725021 avg loss, 0.000001 rate, 13.920842 seconds, 4576 images, 1366.699149 hours left
Loaded: 0.000036 seconds

 144: 244.037582, 237.456284 avg loss, 0.000001 rate, 14.003847 seconds, 4608 images, 1372.380525 hours left
Loaded: 0.000033 seconds

 145: 214.392212, 235.149872 avg loss, 0.000001 rate, 14.290621 seconds, 4640 images, 1378.120418 hours left
Loaded: 0.000030 seconds

 146: 273.906616, 239.025543 avg loss, 0.000001 rate, 14.808863 seconds, 4672 images, 1384.201450 hours left
Loaded: 0.000030 seconds

 147: 229.631790, 238.086166 avg loss, 0.000001 rate, 13.947899 seconds, 4704 images, 1390.941918 hours left
Loaded: 0.000027 seconds

 148: 222.931168, 236.570663 avg loss, 0.000001 rate, 13.633262 seconds, 4736 images, 1396.418314 hours left
Loaded: 0.000027 seconds

 149: 272.315582, 240.145157 avg loss, 0.000001 rate, 14.063818 seconds, 4768 images, 1401.402598 hours left
Loaded: 0.000033 seconds

 150: 218.835266, 238.014175 avg loss, 0.000001 rate, 14.183264 seconds, 4800 images, 1406.935417 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.013231 seconds

 151: 103.205315, 224.533295 avg loss, 0.000001 rate, 5.040129 seconds, 4832 images, 1412.578891 hours left
Loaded: 0.000027 seconds

 152: 277.454132, 229.825378 avg loss, 0.000001 rate, 5.706291 seconds, 4864 images, 1405.476570 hours left
Loaded: 0.000028 seconds

 153: 242.354340, 231.078278 avg loss, 0.000001 rate, 5.579786 seconds, 4896 images, 1399.352775 hours left
Loaded: 0.000028 seconds

 154: 220.197144, 229.990158 avg loss, 0.000001 rate, 5.476456 seconds, 4928 images, 1393.114380 hours left
Loaded: 0.000028 seconds

 155: 260.433319, 233.034470 avg loss, 0.000001 rate, 5.599881 seconds, 4960 images, 1386.794740 hours left
Loaded: 0.000028 seconds

 156: 142.568649, 223.987885 avg loss, 0.000001 rate, 5.254853 seconds, 4992 images, 1380.709822 hours left
Loaded: 0.000028 seconds

 157: 237.087830, 225.297882 avg loss, 0.000001 rate, 5.603258 seconds, 5024 images, 1374.206204 hours left
Loaded: 0.000028 seconds

 158: 181.950165, 220.963104 avg loss, 0.000001 rate, 5.339908 seconds, 5056 images, 1368.251835 hours left
Loaded: 0.000029 seconds

 159: 213.776978, 220.244492 avg loss, 0.000001 rate, 5.474097 seconds, 5088 images, 1361.990981 hours left
Loaded: 0.000023 seconds

 160: 232.193130, 221.439362 avg loss, 0.000001 rate, 5.673026 seconds, 5120 images, 1355.979225 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000029 seconds

 161: 212.305771, 220.526001 avg loss, 0.000001 rate, 13.364745 seconds, 5152 images, 1350.304038 hours left
Loaded: 0.000029 seconds

 162: 220.006531, 220.474060 avg loss, 0.000001 rate, 12.939536 seconds, 5184 images, 1355.375784 hours left
Loaded: 0.000036 seconds

 163: 199.554321, 218.382080 avg loss, 0.000001 rate, 12.655831 seconds, 5216 images, 1359.805807 hours left
Loaded: 0.000027 seconds

 164: 232.594101, 219.803284 avg loss, 0.000001 rate, 12.970404 seconds, 5248 images, 1363.797202 hours left
Loaded: 0.000029 seconds

 165: 236.897598, 221.512711 avg loss, 0.000001 rate, 12.944031 seconds, 5280 images, 1368.185837 hours left
Loaded: 0.000028 seconds

 166: 124.805183, 211.841965 avg loss, 0.000001 rate, 11.905354 seconds, 5312 images, 1372.493899 hours left
Loaded: 0.000032 seconds

 167: 186.087189, 209.266479 avg loss, 0.000001 rate, 12.494501 seconds, 5344 images, 1375.315272 hours left
Loaded: 0.000040 seconds

 168: 167.565979, 205.096436 avg loss, 0.000001 rate, 12.415798 seconds, 5376 images, 1378.927207 hours left
Loaded: 0.000027 seconds

 169: 279.006195, 212.487411 avg loss, 0.000001 rate, 13.578050 seconds, 5408 images, 1382.393620 hours left
Loaded: 0.000034 seconds

 170: 190.444321, 210.283096 avg loss, 0.000001 rate, 12.522228 seconds, 5440 images, 1387.440621 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.344794 seconds - performance bottleneck on CPU or Disk HDD/SSD

 171: 171.764816, 206.431274 avg loss, 0.000001 rate, 5.306653 seconds, 5472 images, 1390.969738 hours left
Loaded: 0.000029 seconds

 172: 148.864655, 200.674606 avg loss, 0.000001 rate, 5.334212 seconds, 5504 images, 1384.914450 hours left
Loaded: 0.000037 seconds

 173: 233.692673, 203.976410 avg loss, 0.000001 rate, 5.641779 seconds, 5536 images, 1378.478846 hours left
Loaded: 0.000038 seconds

 174: 207.229248, 204.301697 avg loss, 0.000001 rate, 5.511594 seconds, 5568 images, 1372.535050 hours left
Loaded: 0.000039 seconds

 175: 187.380508, 202.609573 avg loss, 0.000001 rate, 5.433427 seconds, 5600 images, 1366.469748 hours left
Loaded: 0.000034 seconds

 176: 181.652206, 200.513840 avg loss, 0.000001 rate, 5.446341 seconds, 5632 images, 1360.356450 hours left
Loaded: 0.000042 seconds

 177: 163.910507, 196.853500 avg loss, 0.000001 rate, 5.348402 seconds, 5664 images, 1354.322211 hours left
Loaded: 0.000030 seconds

 178: 258.875427, 203.055695 avg loss, 0.000001 rate, 5.781585 seconds, 5696 images, 1348.212196 hours left
Loaded: 0.000027 seconds

 179: 295.498993, 212.300018 avg loss, 0.000001 rate, 5.910540 seconds, 5728 images, 1342.765279 hours left
Loaded: 0.000027 seconds

 180: 271.562592, 218.226273 avg loss, 0.000001 rate, 5.729134 seconds, 5760 images, 1337.552029 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.423735 seconds - performance bottleneck on CPU or Disk HDD/SSD

 181: 241.583740, 220.562012 avg loss, 0.000001 rate, 5.108733 seconds, 5792 images, 1332.138782 hours left
Loaded: 0.000029 seconds

 182: 182.243042, 216.730118 avg loss, 0.000001 rate, 4.904603 seconds, 5824 images, 1326.506293 hours left
Loaded: 0.000032 seconds

 183: 196.541245, 214.711227 avg loss, 0.000001 rate, 4.967712 seconds, 5856 images, 1320.057563 hours left
Loaded: 0.000029 seconds

 184: 143.979492, 207.638062 avg loss, 0.000001 rate, 4.734337 seconds, 5888 images, 1313.761020 hours left
Loaded: 0.000027 seconds

 185: 262.026306, 213.076889 avg loss, 0.000002 rate, 5.099304 seconds, 5920 images, 1307.203086 hours left
Loaded: 0.000026 seconds

 186: 244.489761, 216.218170 avg loss, 0.000002 rate, 5.263336 seconds, 5952 images, 1301.217934 hours left
Loaded: 0.000029 seconds

 187: 183.963150, 212.992676 avg loss, 0.000002 rate, 4.983943 seconds, 5984 images, 1295.520584 hours left
Loaded: 0.000030 seconds

 188: 199.423065, 211.635712 avg loss, 0.000002 rate, 5.225881 seconds, 6016 images, 1289.491909 hours left
Loaded: 0.000033 seconds

 189: 214.964188, 211.968567 avg loss, 0.000002 rate, 5.320187 seconds, 6048 images, 1283.859744 hours left
Loaded: 0.000039 seconds

 190: 201.957901, 210.967499 avg loss, 0.000002 rate, 5.096817 seconds, 6080 images, 1278.414951 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.000023 seconds

 191: 224.355026, 212.306244 avg loss, 0.000002 rate, 9.054060 seconds, 6112 images, 1272.714171 hours left
Loaded: 0.000032 seconds
Saving weights to /darknet/myweights/backup//yolov4_last.weights

 192: 207.623505, 211.837967 avg loss, 0.000002 rate, 8.813693 seconds, 6144 images, 1272.569930 hours left
Loaded: 0.000029 seconds

 193: 122.225685, 202.876740 avg loss, 0.000002 rate, 8.306881 seconds, 6176 images, 1272.093081 hours left
Loaded: 0.000029 seconds

 194: 189.463943, 201.535461 avg loss, 0.000002 rate, 8.844219 seconds, 6208 images, 1270.916623 hours left
Loaded: 0.000039 seconds

 195: 138.297562, 195.211670 avg loss, 0.000002 rate, 8.480901 seconds, 6240 images, 1270.498666 hours left
Loaded: 0.000037 seconds

 196: 155.072037, 191.197708 avg loss, 0.000002 rate, 8.523954 seconds, 6272 images, 1269.579962 hours left
Loaded: 0.000030 seconds

 197: 123.224449, 184.400375 avg loss, 0.000002 rate, 8.419671 seconds, 6304 images, 1268.730250 hours left
Loaded: 0.000029 seconds

 198: 221.780441, 188.138382 avg loss, 0.000002 rate, 9.119436 seconds, 6336 images, 1267.744076 hours left
Loaded: 0.000031 seconds

 199: 179.266449, 187.251190 avg loss, 0.000002 rate, 8.843088 seconds, 6368 images, 1267.740223 hours left
Loaded: 0.000037 seconds

 200: 179.456055, 186.471680 avg loss, 0.000002 rate, 8.810084 seconds, 6400 images, 1267.352338 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.404196 seconds - performance bottleneck on CPU or Disk HDD/SSD

 201: 208.446716, 188.669189 avg loss, 0.000002 rate, 5.254430 seconds, 6432 images, 1266.922450 hours left
Loaded: 0.000031 seconds

 202: 181.754471, 187.977722 avg loss, 0.000002 rate, 5.187371 seconds, 6464 images, 1262.117143 hours left
Loaded: 0.000040 seconds

 203: 177.730820, 186.953033 avg loss, 0.000002 rate, 5.173356 seconds, 6496 images, 1256.705006 hours left
Loaded: 0.000039 seconds

 204: 167.589539, 185.016678 avg loss, 0.000002 rate, 4.984311 seconds, 6528 images, 1251.327512 hours left
Loaded: 0.000029 seconds

 205: 143.404007, 180.855408 avg loss, 0.000002 rate, 5.002899 seconds, 6560 images, 1245.741057 hours left
Loaded: 0.000029 seconds

 206: 191.696274, 181.939499 avg loss, 0.000002 rate, 5.144530 seconds, 6592 images, 1240.236271 hours left
Loaded: 0.000029 seconds

 207: 163.076813, 180.053223 avg loss, 0.000002 rate, 4.986005 seconds, 6624 images, 1234.983344 hours left
Loaded: 0.000037 seconds

 208: 184.984528, 180.546356 avg loss, 0.000002 rate, 5.128334 seconds, 6656 images, 1229.562628 hours left
Loaded: 0.000037 seconds

 209: 218.891571, 184.380875 avg loss, 0.000002 rate, 5.230139 seconds, 6688 images, 1224.393913 hours left
Loaded: 0.000039 seconds

 210: 153.263199, 181.269104 avg loss, 0.000003 rate, 4.943319 seconds, 6720 images, 1219.418348 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.432956 seconds - performance bottleneck on CPU or Disk HDD/SSD

 211: 225.461700, 185.688370 avg loss, 0.000003 rate, 5.242342 seconds, 6752 images, 1214.093934 hours left
Loaded: 0.000029 seconds

 212: 170.428268, 184.162354 avg loss, 0.000003 rate, 4.957968 seconds, 6784 images, 1209.839922 hours left
Loaded: 0.000029 seconds

 213: 123.172478, 178.063370 avg loss, 0.000003 rate, 4.789413 seconds, 6816 images, 1204.631610 hours left
Loaded: 0.000029 seconds

 214: 178.708496, 178.127884 avg loss, 0.000003 rate, 4.993761 seconds, 6848 images, 1199.241127 hours left
Loaded: 0.000032 seconds

 215: 178.261566, 178.141251 avg loss, 0.000003 rate, 5.010627 seconds, 6880 images, 1194.188516 hours left
Loaded: 0.000035 seconds

 216: 201.880875, 180.515213 avg loss, 0.000003 rate, 5.148306 seconds, 6912 images, 1189.209858 hours left
Loaded: 0.000037 seconds

 217: 137.918396, 176.255524 avg loss, 0.000003 rate, 4.881720 seconds, 6944 images, 1184.472307 hours left
Loaded: 0.000037 seconds

 218: 154.650696, 174.095047 avg loss, 0.000003 rate, 5.019718 seconds, 6976 images, 1179.411654 hours left
Loaded: 0.000038 seconds

 219: 160.616852, 172.747223 avg loss, 0.000003 rate, 4.985946 seconds, 7008 images, 1174.593365 hours left
Loaded: 0.000029 seconds

 220: 161.808960, 171.653397 avg loss, 0.000003 rate, 5.005955 seconds, 7040 images, 1169.776313 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.040800 seconds

 221: 132.017975, 167.689850 avg loss, 0.000003 rate, 6.996962 seconds, 7072 images, 1165.035223 hours left
Loaded: 0.000030 seconds

 222: 147.001724, 165.621033 avg loss, 0.000003 rate, 7.103619 seconds, 7104 images, 1163.165008 hours left
Loaded: 0.000024 seconds

 223: 120.491882, 161.108124 avg loss, 0.000003 rate, 6.551154 seconds, 7136 images, 1161.405037 hours left
Loaded: 0.000027 seconds

 224: 112.508713, 156.248184 avg loss, 0.000003 rate, 6.527615 seconds, 7168 images, 1158.894900 hours left
Loaded: 0.000034 seconds

 225: 139.759598, 154.599319 avg loss, 0.000003 rate, 6.740614 seconds, 7200 images, 1156.377139 hours left
Loaded: 0.000027 seconds

 226: 129.676651, 152.107056 avg loss, 0.000003 rate, 6.591610 seconds, 7232 images, 1154.180540 hours left
Loaded: 0.000033 seconds

 227: 133.463394, 150.242691 avg loss, 0.000003 rate, 6.725743 seconds, 7264 images, 1151.798816 hours left
Loaded: 0.000034 seconds

 228: 126.509514, 147.869370 avg loss, 0.000004 rate, 6.666905 seconds, 7296 images, 1149.627296 hours left
Loaded: 0.000027 seconds

 229: 138.127472, 146.895172 avg loss, 0.000004 rate, 6.699443 seconds, 7328 images, 1147.395710 hours left
Loaded: 0.000026 seconds

 230: 133.090744, 145.514725 avg loss, 0.000004 rate, 6.854731 seconds, 7360 images, 1145.231628 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.375955 seconds - performance bottleneck on CPU or Disk HDD/SSD

 231: 181.016693, 149.064926 avg loss, 0.000004 rate, 6.876701 seconds, 7392 images, 1143.304961 hours left
Loaded: 0.000029 seconds

 232: 96.567375, 143.815170 avg loss, 0.000004 rate, 6.278533 seconds, 7424 images, 1141.950479 hours left
Loaded: 0.000027 seconds

 233: 142.294586, 143.663116 avg loss, 0.000004 rate, 6.232214 seconds, 7456 images, 1139.255886 hours left
Loaded: 0.000026 seconds

 234: 136.773804, 142.974182 avg loss, 0.000004 rate, 6.251396 seconds, 7488 images, 1136.523852 hours left
Loaded: 0.000029 seconds

 235: 110.677681, 139.744537 avg loss, 0.000004 rate, 6.059090 seconds, 7520 images, 1133.845776 hours left
Loaded: 0.000029 seconds

 236: 107.935509, 136.563629 avg loss, 0.000004 rate, 6.201697 seconds, 7552 images, 1130.927233 hours left
Loaded: 0.000027 seconds

 237: 150.323730, 137.939636 avg loss, 0.000004 rate, 6.433364 seconds, 7584 images, 1128.236029 hours left
Loaded: 0.000027 seconds

 238: 157.173370, 139.863007 avg loss, 0.000004 rate, 6.397619 seconds, 7616 images, 1125.893646 hours left
Loaded: 0.000029 seconds

 239: 111.572647, 137.033966 avg loss, 0.000004 rate, 6.193722 seconds, 7648 images, 1123.524998 hours left
Loaded: 0.000028 seconds

 240: 119.522079, 135.282776 avg loss, 0.000004 rate, 6.325492 seconds, 7680 images, 1120.896683 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000032 seconds

 241: 163.222214, 138.076721 avg loss, 0.000004 rate, 11.911647 seconds, 7712 images, 1118.477740 hours left
Loaded: 0.000032 seconds

 242: 112.720924, 135.541138 avg loss, 0.000004 rate, 11.093544 seconds, 7744 images, 1123.845548 hours left
Loaded: 0.000030 seconds

 243: 102.766136, 132.263641 avg loss, 0.000005 rate, 10.967704 seconds, 7776 images, 1128.022801 hours left
Loaded: 0.000039 seconds

 244: 74.397499, 126.477028 avg loss, 0.000005 rate, 10.546904 seconds, 7808 images, 1131.983382 hours left
Loaded: 0.000030 seconds

 245: 103.799156, 124.209244 avg loss, 0.000005 rate, 10.925043 seconds, 7840 images, 1135.319594 hours left
Loaded: 0.000024 seconds

 246: 117.937202, 123.582039 avg loss, 0.000005 rate, 11.304243 seconds, 7872 images, 1139.147864 hours left
Loaded: 0.000030 seconds

 247: 107.615540, 121.985390 avg loss, 0.000005 rate, 10.873018 seconds, 7904 images, 1143.464745 hours left
Loaded: 0.000030 seconds

 248: 113.367668, 121.123619 avg loss, 0.000005 rate, 10.990232 seconds, 7936 images, 1147.139220 hours left
Loaded: 0.000029 seconds

 249: 77.881973, 116.799454 avg loss, 0.000005 rate, 10.379985 seconds, 7968 images, 1150.939788 hours left
Loaded: 0.000042 seconds

 250: 112.510887, 116.370598 avg loss, 0.000005 rate, 10.954667 seconds, 8000 images, 1153.854327 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.091904 seconds

 251: 96.408577, 114.374397 avg loss, 0.000005 rate, 11.882089 seconds, 8032 images, 1157.538279 hours left
Loaded: 0.000030 seconds

 252: 120.600578, 114.997017 avg loss, 0.000005 rate, 12.096136 seconds, 8064 images, 1162.601738 hours left
Loaded: 0.000029 seconds

 253: 81.153061, 111.612625 avg loss, 0.000005 rate, 11.481467 seconds, 8096 images, 1167.784296 hours left
Loaded: 0.000029 seconds

 254: 122.557632, 112.707123 avg loss, 0.000005 rate, 12.388112 seconds, 8128 images, 1172.060869 hours left
Loaded: 0.000030 seconds

 255: 76.454376, 109.081848 avg loss, 0.000005 rate, 11.712105 seconds, 8160 images, 1177.554491 hours left
Loaded: 0.000030 seconds

 256: 89.752296, 107.148895 avg loss, 0.000006 rate, 11.699639 seconds, 8192 images, 1182.053783 hours left
Loaded: 0.000029 seconds

 257: 126.525505, 109.086555 avg loss, 0.000006 rate, 12.020946 seconds, 8224 images, 1186.490729 hours left
Loaded: 0.000027 seconds

 258: 98.351021, 108.013000 avg loss, 0.000006 rate, 11.613113 seconds, 8256 images, 1191.329748 hours left
Loaded: 0.000025 seconds

 259: 119.293571, 109.141060 avg loss, 0.000006 rate, 12.072338 seconds, 8288 images, 1195.553631 hours left
Loaded: 0.000032 seconds

 260: 91.618629, 107.388817 avg loss, 0.000006 rate, 11.667581 seconds, 8320 images, 1200.373359 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.603162 seconds - performance bottleneck on CPU or Disk HDD/SSD

 261: 91.429245, 105.792862 avg loss, 0.000006 rate, 9.067511 seconds, 8352 images, 1204.582435 hours left
Loaded: 0.000030 seconds

 262: 65.725647, 101.786140 avg loss, 0.000006 rate, 8.817868 seconds, 8384 images, 1205.974536 hours left
Loaded: 0.000037 seconds

 263: 71.535706, 98.761101 avg loss, 0.000006 rate, 8.895929 seconds, 8416 images, 1206.167715 hours left
Loaded: 0.000039 seconds

 264: 93.480637, 98.233055 avg loss, 0.000006 rate, 9.175321 seconds, 8448 images, 1206.467417 hours left
Loaded: 0.000038 seconds

 265: 93.572586, 97.767006 avg loss, 0.000006 rate, 9.505445 seconds, 8480 images, 1207.152327 hours left
Loaded: 0.000029 seconds

 266: 92.029167, 97.193222 avg loss, 0.000007 rate, 9.218483 seconds, 8512 images, 1208.289082 hours left
Loaded: 0.000036 seconds

 267: 83.669884, 95.840889 avg loss, 0.000007 rate, 9.382573 seconds, 8544 images, 1209.015688 hours left
Loaded: 0.000031 seconds

 268: 94.567726, 95.713570 avg loss, 0.000007 rate, 8.856396 seconds, 8576 images, 1209.963019 hours left
Loaded: 0.000027 seconds

 269: 84.512970, 94.593506 avg loss, 0.000007 rate, 8.887007 seconds, 8608 images, 1210.169703 hours left
Loaded: 0.000026 seconds

 270: 65.017517, 91.635910 avg loss, 0.000007 rate, 8.416864 seconds, 8640 images, 1210.416824 hours left
Resizing, random_coef = 1.40 

 384 x 384 
 try to allocate additional workspace_size = 42.47 MB 
 CUDA allocate done! 
Loaded: 0.243380 seconds - performance bottleneck on CPU or Disk HDD/SSD

 271: 67.725014, 89.244820 avg loss, 0.000007 rate, 4.465087 seconds, 8672 images, 1210.008171 hours left
Loaded: 0.000039 seconds

 272: 95.664871, 89.886826 avg loss, 0.000007 rate, 4.655544 seconds, 8704 images, 1204.450637 hours left
Loaded: 0.000038 seconds

 273: 90.094040, 89.907547 avg loss, 0.000007 rate, 4.604671 seconds, 8736 images, 1198.875181 hours left
Loaded: 0.000040 seconds

 274: 64.617035, 87.378494 avg loss, 0.000007 rate, 4.404940 seconds, 8768 images, 1193.284776 hours left
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Loaded: 0.000029 seconds

 275: 112.308907, 89.871536 avg loss, 0.000007 rate, 4.803593 seconds, 8800 images, 1187.472735 hours left
Loaded: 0.000038 seconds

 276: 97.226814, 90.607063 avg loss, 0.000008 rate, 4.538242 seconds, 8832 images, 1182.272722 hours left
Loaded: 0.000030 seconds

 277: 86.523315, 90.198685 avg loss, 0.000008 rate, 4.493831 seconds, 8864 images, 1176.755999 hours left
Loaded: 0.000037 seconds

 278: 88.034500, 89.982269 avg loss, 0.000008 rate, 4.437561 seconds, 8896 images, 1171.232709 hours left
Loaded: 0.000036 seconds

 279: 62.470001, 87.231041 avg loss, 0.000008 rate, 4.288944 seconds, 8928 images, 1165.686460 hours left
Loaded: 0.000037 seconds

 280: 56.643879, 84.172325 avg loss, 0.000008 rate, 4.177222 seconds, 8960 images, 1159.989159 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 281: 57.254150, 81.480507 avg loss, 0.000008 rate, 6.690905 seconds, 8992 images, 1154.193581 hours left
Loaded: 0.000034 seconds

 282: 54.726898, 78.805145 avg loss, 0.000008 rate, 6.642699 seconds, 9024 images, 1151.948687 hours left
Loaded: 0.000032 seconds

 283: 41.702724, 75.094902 avg loss, 0.000008 rate, 6.609392 seconds, 9056 images, 1149.659252 hours left
Loaded: 0.000026 seconds

 284: 63.372581, 73.922668 avg loss, 0.000008 rate, 7.047121 seconds, 9088 images, 1147.346410 hours left
Loaded: 0.000026 seconds

 285: 68.546043, 73.385010 avg loss, 0.000009 rate, 6.969924 seconds, 9120 images, 1145.664890 hours left
Loaded: 0.000034 seconds

 286: 47.669563, 70.813461 avg loss, 0.000009 rate, 6.840206 seconds, 9152 images, 1143.892903 hours left
Loaded: 0.000027 seconds

 287: 75.743378, 71.306450 avg loss, 0.000009 rate, 7.051782 seconds, 9184 images, 1141.958386 hours left
Loaded: 0.000035 seconds

 288: 23.462509, 66.522057 avg loss, 0.000009 rate, 6.334892 seconds, 9216 images, 1140.337164 hours left
Loaded: 0.000033 seconds

 289: 66.720146, 66.541862 avg loss, 0.000009 rate, 6.921364 seconds, 9248 images, 1137.736044 hours left
Loaded: 0.000036 seconds

 290: 38.771202, 63.764797 avg loss, 0.000009 rate, 6.638670 seconds, 9280 images, 1135.975804 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.094699 seconds

 291: 48.646389, 62.252956 avg loss, 0.000009 rate, 8.324364 seconds, 9312 images, 1133.840355 hours left
Loaded: 0.000029 seconds

 292: 33.308716, 59.358532 avg loss, 0.000009 rate, 7.919865 seconds, 9344 images, 1134.199998 hours left
Loaded: 0.000029 seconds

 293: 45.104282, 57.933105 avg loss, 0.000010 rate, 8.155190 seconds, 9376 images, 1133.862440 hours left
Loaded: 0.000029 seconds

 294: 25.951593, 54.734955 avg loss, 0.000010 rate, 7.897826 seconds, 9408 images, 1133.855214 hours left
Loaded: 0.000038 seconds

 295: 50.377033, 54.299164 avg loss, 0.000010 rate, 8.249885 seconds, 9440 images, 1133.490438 hours left
Loaded: 0.000032 seconds

 296: 53.992603, 54.268509 avg loss, 0.000010 rate, 8.407584 seconds, 9472 images, 1133.618471 hours left
Loaded: 0.000030 seconds

 297: 63.428192, 55.184479 avg loss, 0.000010 rate, 8.752266 seconds, 9504 images, 1133.964308 hours left
Loaded: 0.000033 seconds

 298: 61.793503, 55.845383 avg loss, 0.000010 rate, 8.669390 seconds, 9536 images, 1134.785581 hours left
Loaded: 0.000029 seconds

 299: 30.930370, 53.353882 avg loss, 0.000010 rate, 7.936213 seconds, 9568 images, 1135.483470 hours left
Loaded: 0.000029 seconds

 300: 54.433289, 53.461823 avg loss, 0.000011 rate, 8.230170 seconds, 9600 images, 1135.155640 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.031990 seconds

 301: 49.394459, 53.055084 avg loss, 0.000011 rate, 13.492431 seconds, 9632 images, 1135.239502 hours left
Loaded: 0.000030 seconds

 302: 39.097122, 51.659286 avg loss, 0.000011 rate, 12.758831 seconds, 9664 images, 1142.678516 hours left
Loaded: 0.000032 seconds

 303: 39.544704, 50.447830 avg loss, 0.000011 rate, 12.875537 seconds, 9696 images, 1148.979404 hours left
Loaded: 0.000040 seconds

 304: 36.291386, 49.032185 avg loss, 0.000011 rate, 13.061926 seconds, 9728 images, 1155.379417 hours left
Loaded: 0.000037 seconds

 305: 41.360065, 48.264973 avg loss, 0.000011 rate, 13.385446 seconds, 9760 images, 1161.974369 hours left
Loaded: 0.000038 seconds

 306: 53.720627, 48.810539 avg loss, 0.000011 rate, 13.729752 seconds, 9792 images, 1168.952840 hours left
Loaded: 0.000037 seconds

 307: 25.762768, 46.505760 avg loss, 0.000012 rate, 12.502738 seconds, 9824 images, 1176.339877 hours left
Loaded: 0.000029 seconds

 308: 48.262390, 46.681423 avg loss, 0.000012 rate, 13.470471 seconds, 9856 images, 1181.948162 hours left
Loaded: 0.000039 seconds

 309: 37.243889, 45.737671 avg loss, 0.000012 rate, 13.436465 seconds, 9888 images, 1188.844908 hours left
Loaded: 0.000044 seconds

 310: 46.954323, 45.859337 avg loss, 0.000012 rate, 13.227187 seconds, 9920 images, 1195.625414 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.508253 seconds - performance bottleneck on CPU or Disk HDD/SSD

 311: 40.060730, 45.279476 avg loss, 0.000012 rate, 11.364718 seconds, 9952 images, 1202.047310 hours left
Loaded: 0.000029 seconds

 312: 34.766827, 44.228210 avg loss, 0.000012 rate, 11.439783 seconds, 9984 images, 1206.523320 hours left
Loaded: 0.000028 seconds

 313: 44.066196, 44.212009 avg loss, 0.000012 rate, 11.632140 seconds, 10016 images, 1210.352703 hours left
Loaded: 0.000025 seconds

 314: 42.078987, 43.998707 avg loss, 0.000013 rate, 11.747136 seconds, 10048 images, 1214.411020 hours left
Loaded: 0.000027 seconds

 315: 32.814476, 42.880283 avg loss, 0.000013 rate, 11.317186 seconds, 10080 images, 1218.588493 hours left
Loaded: 0.000027 seconds

 316: 32.425556, 41.834812 avg loss, 0.000013 rate, 11.497336 seconds, 10112 images, 1222.126790 hours left
Loaded: 0.000026 seconds

 317: 21.828638, 39.834194 avg loss, 0.000013 rate, 11.170157 seconds, 10144 images, 1225.879972 hours left
Loaded: 0.000027 seconds

 318: 39.524914, 39.803265 avg loss, 0.000013 rate, 12.345402 seconds, 10176 images, 1229.141007 hours left
Loaded: 0.000028 seconds

 319: 51.654476, 40.988384 avg loss, 0.000013 rate, 12.427738 seconds, 10208 images, 1234.002280 hours left
Loaded: 0.000028 seconds

 320: 33.071613, 40.196709 avg loss, 0.000014 rate, 11.787742 seconds, 10240 images, 1238.929306 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.341374 seconds - performance bottleneck on CPU or Disk HDD/SSD

 321: 48.416229, 41.018661 avg loss, 0.000014 rate, 6.711152 seconds, 10272 images, 1242.917822 hours left
Loaded: 0.000033 seconds

 322: 35.724873, 40.489281 avg loss, 0.000014 rate, 6.286954 seconds, 10304 images, 1240.287338 hours left
Loaded: 0.000028 seconds

 323: 47.441189, 41.184471 avg loss, 0.000014 rate, 6.528012 seconds, 10336 images, 1236.619514 hours left
Loaded: 0.000026 seconds

 324: 40.261005, 41.092125 avg loss, 0.000014 rate, 6.246551 seconds, 10368 images, 1233.323262 hours left
Loaded: 0.000027 seconds

 325: 32.749523, 40.257866 avg loss, 0.000015 rate, 6.094129 seconds, 10400 images, 1229.668897 hours left
Loaded: 0.000027 seconds

 326: 50.262012, 41.258282 avg loss, 0.000015 rate, 6.419207 seconds, 10432 images, 1225.839288 hours left
Loaded: 0.000033 seconds

 327: 26.719198, 39.804375 avg loss, 0.000015 rate, 6.070976 seconds, 10464 images, 1222.499616 hours left
Loaded: 0.000026 seconds

 328: 18.240824, 37.648018 avg loss, 0.000015 rate, 5.837383 seconds, 10496 images, 1218.709507 hours left
Loaded: 0.000028 seconds

 329: 49.123043, 38.795521 avg loss, 0.000015 rate, 6.478556 seconds, 10528 images, 1214.632724 hours left
Loaded: 0.000027 seconds

 330: 44.512516, 39.367222 avg loss, 0.000015 rate, 6.637588 seconds, 10560 images, 1211.487520 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.019708 seconds

 331: 34.363380, 38.866837 avg loss, 0.000016 rate, 10.089510 seconds, 10592 images, 1208.594703 hours left
Loaded: 0.000028 seconds

 332: 25.056065, 37.485760 avg loss, 0.000016 rate, 9.702632 seconds, 10624 images, 1210.554096 hours left
Loaded: 0.000027 seconds

 333: 36.367210, 37.373905 avg loss, 0.000016 rate, 10.035082 seconds, 10656 images, 1211.929014 hours left
Loaded: 0.000029 seconds

 334: 15.792513, 35.215767 avg loss, 0.000016 rate, 9.147076 seconds, 10688 images, 1213.752044 hours left
Loaded: 0.000043 seconds

 335: 43.314075, 36.025597 avg loss, 0.000016 rate, 10.430238 seconds, 10720 images, 1214.323069 hours left
Loaded: 0.000030 seconds

 336: 33.421341, 35.765171 avg loss, 0.000017 rate, 10.572236 seconds, 10752 images, 1216.671135 hours left
Loaded: 0.000031 seconds

 337: 32.395500, 35.428204 avg loss, 0.000017 rate, 10.418828 seconds, 10784 images, 1219.192957 hours left
Loaded: 0.000030 seconds

 338: 33.693939, 35.254776 avg loss, 0.000017 rate, 10.290605 seconds, 10816 images, 1221.476397 hours left
Loaded: 0.000029 seconds

 339: 28.807762, 34.610073 avg loss, 0.000017 rate, 10.021792 seconds, 10848 images, 1223.558825 hours left
Loaded: 0.000029 seconds

 340: 29.805780, 34.129642 avg loss, 0.000017 rate, 9.996084 seconds, 10880 images, 1225.246931 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 341: 21.134045, 32.830082 avg loss, 0.000018 rate, 12.243472 seconds, 10912 images, 1226.882408 hours left
Loaded: 0.000038 seconds

 342: 39.687569, 33.515831 avg loss, 0.000018 rate, 13.145773 seconds, 10944 images, 1231.623865 hours left
Loaded: 0.000028 seconds

 343: 19.902037, 32.154453 avg loss, 0.000018 rate, 12.035891 seconds, 10976 images, 1237.571480 hours left
Loaded: 0.000027 seconds

 344: 21.167973, 31.055805 avg loss, 0.000018 rate, 12.329706 seconds, 11008 images, 1241.917580 hours left
Loaded: 0.000027 seconds

 345: 35.659084, 31.516132 avg loss, 0.000018 rate, 13.184722 seconds, 11040 images, 1246.628389 hours left
Loaded: 0.000040 seconds

 346: 29.752050, 31.339724 avg loss, 0.000019 rate, 13.011353 seconds, 11072 images, 1252.479946 hours left
Loaded: 0.000033 seconds

 347: 32.557133, 31.461464 avg loss, 0.000019 rate, 12.824771 seconds, 11104 images, 1258.032104 hours left
Loaded: 0.000031 seconds

 348: 31.598362, 31.475153 avg loss, 0.000019 rate, 12.948406 seconds, 11136 images, 1263.269475 hours left
Loaded: 0.000027 seconds

 349: 40.940849, 32.421722 avg loss, 0.000019 rate, 13.201337 seconds, 11168 images, 1268.626200 hours left
Loaded: 0.000028 seconds

 350: 27.769323, 31.956482 avg loss, 0.000020 rate, 12.799820 seconds, 11200 images, 1274.280716 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.083908 seconds

 351: 34.341576, 32.194992 avg loss, 0.000020 rate, 15.029700 seconds, 11232 images, 1279.320821 hours left
Loaded: 0.000038 seconds

 352: 30.873779, 32.062870 avg loss, 0.000020 rate, 14.440636 seconds, 11264 images, 1287.525003 hours left
Loaded: 0.000031 seconds

 353: 26.912876, 31.547871 avg loss, 0.000020 rate, 14.455835 seconds, 11296 images, 1294.712195 hours left
Loaded: 0.000030 seconds

 354: 20.078796, 30.400963 avg loss, 0.000020 rate, 13.353886 seconds, 11328 images, 1301.848582 hours left
Loaded: 0.000027 seconds

 355: 21.156008, 29.476467 avg loss, 0.000021 rate, 13.329284 seconds, 11360 images, 1307.382631 hours left
Loaded: 0.000028 seconds

 356: 29.997902, 29.528610 avg loss, 0.000021 rate, 14.129244 seconds, 11392 images, 1312.827118 hours left
Loaded: 0.000026 seconds

 357: 26.183033, 29.194052 avg loss, 0.000021 rate, 13.782611 seconds, 11424 images, 1319.328500 hours left
Loaded: 0.000035 seconds

 358: 31.172022, 29.391850 avg loss, 0.000021 rate, 14.075061 seconds, 11456 images, 1325.283253 hours left
Loaded: 0.000033 seconds

 359: 29.899439, 29.442608 avg loss, 0.000022 rate, 14.088082 seconds, 11488 images, 1331.584730 hours left
Loaded: 0.000027 seconds

 360: 33.850639, 29.883411 avg loss, 0.000022 rate, 14.329463 seconds, 11520 images, 1337.841252 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.762703 seconds - performance bottleneck on CPU or Disk HDD/SSD

 361: 39.599426, 30.855013 avg loss, 0.000022 rate, 13.038246 seconds, 11552 images, 1344.370495 hours left
Loaded: 0.000035 seconds

 362: 16.126938, 29.382206 avg loss, 0.000022 rate, 11.558950 seconds, 11584 images, 1350.100119 hours left
Loaded: 0.000037 seconds

 363: 32.447338, 29.688719 avg loss, 0.000023 rate, 12.951671 seconds, 11616 images, 1352.657709 hours left
Loaded: 0.000036 seconds

 364: 25.201826, 29.240030 avg loss, 0.000023 rate, 12.025430 seconds, 11648 images, 1357.124560 hours left
Loaded: 0.000038 seconds

 365: 24.507404, 28.766768 avg loss, 0.000023 rate, 11.925255 seconds, 11680 images, 1360.259907 hours left
Loaded: 0.000036 seconds

 366: 33.618717, 29.251963 avg loss, 0.000023 rate, 12.268757 seconds, 11712 images, 1363.224701 hours left
Loaded: 0.000027 seconds

 367: 23.045469, 28.631313 avg loss, 0.000024 rate, 11.590417 seconds, 11744 images, 1366.637026 hours left
Loaded: 0.000034 seconds

 368: 18.928661, 27.661049 avg loss, 0.000024 rate, 11.513327 seconds, 11776 images, 1369.072791 hours left
Loaded: 0.000028 seconds

 369: 31.237642, 28.018707 avg loss, 0.000024 rate, 12.165634 seconds, 11808 images, 1371.377078 hours left
Loaded: 0.000028 seconds

 370: 25.641672, 27.781004 avg loss, 0.000024 rate, 11.772770 seconds, 11840 images, 1374.564501 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.083199 seconds

 371: 22.482735, 27.251177 avg loss, 0.000025 rate, 12.954160 seconds, 11872 images, 1377.174231 hours left
Loaded: 0.000030 seconds

 372: 23.057444, 26.831804 avg loss, 0.000025 rate, 12.529360 seconds, 11904 images, 1381.514617 hours left
Loaded: 0.000027 seconds

 373: 33.521358, 27.500759 avg loss, 0.000025 rate, 13.591470 seconds, 11936 images, 1385.105869 hours left
Loaded: 0.000031 seconds

 374: 26.361254, 27.386808 avg loss, 0.000025 rate, 13.240578 seconds, 11968 images, 1390.136699 hours left
Loaded: 0.000030 seconds

 375: 21.788750, 26.827003 avg loss, 0.000026 rate, 12.895583 seconds, 12000 images, 1394.629715 hours left
Loaded: 0.000031 seconds

 376: 30.814987, 27.225801 avg loss, 0.000026 rate, 13.345285 seconds, 12032 images, 1398.598483 hours left
Loaded: 0.000031 seconds

 377: 16.326828, 26.135904 avg loss, 0.000026 rate, 12.447933 seconds, 12064 images, 1403.152271 hours left
Loaded: 0.000026 seconds

 378: 18.774355, 25.399750 avg loss, 0.000027 rate, 12.977309 seconds, 12096 images, 1406.413857 hours left
Loaded: 0.000026 seconds

 379: 29.909531, 25.850727 avg loss, 0.000027 rate, 13.706255 seconds, 12128 images, 1410.378208 hours left
Loaded: 0.000028 seconds

 380: 19.366899, 25.202345 avg loss, 0.000027 rate, 13.042852 seconds, 12160 images, 1415.315549 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.628491 seconds - performance bottleneck on CPU or Disk HDD/SSD

 381: 32.962223, 25.978333 avg loss, 0.000027 rate, 11.503295 seconds, 12192 images, 1419.281868 hours left
Loaded: 0.000030 seconds

 382: 35.645756, 26.945074 avg loss, 0.000028 rate, 11.773257 seconds, 12224 images, 1421.942777 hours left
Loaded: 0.000028 seconds

 383: 27.144310, 26.964998 avg loss, 0.000028 rate, 10.855945 seconds, 12256 images, 1424.079010 hours left
Loaded: 0.000027 seconds

 384: 20.136370, 26.282135 avg loss, 0.000028 rate, 10.397384 seconds, 12288 images, 1424.919501 hours left
Loaded: 0.000026 seconds

 385: 41.350853, 27.789007 avg loss, 0.000029 rate, 11.820702 seconds, 12320 images, 1425.114517 hours left
Loaded: 0.000035 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 386: 20.938675, 27.103973 avg loss, 0.000029 rate, 10.724910 seconds, 12352 images, 1427.284838 hours left
Loaded: 0.000034 seconds

 387: 35.573540, 27.950930 avg loss, 0.000029 rate, 11.543437 seconds, 12384 images, 1427.911165 hours left
Loaded: 0.000029 seconds

 388: 27.289167, 27.884754 avg loss, 0.000029 rate, 11.138938 seconds, 12416 images, 1429.668290 hours left
Loaded: 0.000038 seconds

 389: 15.069977, 26.603277 avg loss, 0.000030 rate, 10.192751 seconds, 12448 images, 1430.845872 hours left
Loaded: 0.000038 seconds

 390: 26.752811, 26.618231 avg loss, 0.000030 rate, 11.346281 seconds, 12480 images, 1430.697221 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.531270 seconds - performance bottleneck on CPU or Disk HDD/SSD

 391: 24.998409, 26.456249 avg loss, 0.000030 rate, 9.987297 seconds, 12512 images, 1432.152508 hours left
Loaded: 0.000028 seconds

 392: 22.350555, 26.045679 avg loss, 0.000031 rate, 9.898313 seconds, 12544 images, 1432.443304 hours left
Loaded: 0.000030 seconds

 393: 30.009722, 26.442083 avg loss, 0.000031 rate, 10.236144 seconds, 12576 images, 1431.869550 hours left
Loaded: 0.000028 seconds

 394: 29.320028, 26.729877 avg loss, 0.000031 rate, 10.367952 seconds, 12608 images, 1431.770819 hours left
Loaded: 0.000031 seconds

 395: 16.139256, 25.670815 avg loss, 0.000032 rate, 9.601718 seconds, 12640 images, 1431.856150 hours left
Loaded: 0.000031 seconds

 396: 14.682250, 24.571959 avg loss, 0.000032 rate, 9.696568 seconds, 12672 images, 1430.876166 hours left
Loaded: 0.000044 seconds

 397: 27.609335, 24.875696 avg loss, 0.000032 rate, 10.631434 seconds, 12704 images, 1430.037718 hours left
Loaded: 0.000031 seconds

 398: 27.940746, 25.182201 avg loss, 0.000033 rate, 10.601972 seconds, 12736 images, 1430.506340 hours left
Loaded: 0.000030 seconds

 399: 24.033907, 25.067371 avg loss, 0.000033 rate, 10.105681 seconds, 12768 images, 1430.929299 hours left
Loaded: 0.000043 seconds

 400: 23.216297, 24.882263 avg loss, 0.000033 rate, 9.662591 seconds, 12800 images, 1430.658566 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.288009 seconds - performance bottleneck on CPU or Disk HDD/SSD

 401: 23.949524, 24.788990 avg loss, 0.000034 rate, 4.921059 seconds, 12832 images, 1429.775002 hours left
Loaded: 0.000029 seconds

 402: 29.580410, 25.268131 avg loss, 0.000034 rate, 5.038345 seconds, 12864 images, 1422.713513 hours left
Loaded: 0.000034 seconds

 403: 26.592518, 25.400570 avg loss, 0.000034 rate, 5.021364 seconds, 12896 images, 1415.485504 hours left
Loaded: 0.000028 seconds

 404: 31.084721, 25.968985 avg loss, 0.000035 rate, 5.183443 seconds, 12928 images, 1408.306178 hours left
Loaded: 0.000029 seconds

 405: 29.273087, 26.299395 avg loss, 0.000035 rate, 4.992062 seconds, 12960 images, 1401.423777 hours left
Loaded: 0.000027 seconds

 406: 29.747581, 26.644213 avg loss, 0.000035 rate, 5.136678 seconds, 12992 images, 1394.344329 hours left
Loaded: 0.000038 seconds

 407: 23.822161, 26.362007 avg loss, 0.000036 rate, 4.977813 seconds, 13024 images, 1387.536552 hours left
Loaded: 0.000029 seconds

 408: 22.324099, 25.958216 avg loss, 0.000036 rate, 4.985867 seconds, 13056 images, 1380.576166 hours left
Loaded: 0.000030 seconds

 409: 28.332817, 26.195675 avg loss, 0.000036 rate, 5.195557 seconds, 13088 images, 1373.696548 hours left
Loaded: 0.000040 seconds

 410: 35.115391, 27.087646 avg loss, 0.000037 rate, 5.282480 seconds, 13120 images, 1367.177002 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.013778 seconds

 411: 36.696007, 28.048483 avg loss, 0.000037 rate, 5.793724 seconds, 13152 images, 1360.843398 hours left
Loaded: 0.000030 seconds

 412: 30.837154, 28.327351 avg loss, 0.000037 rate, 5.754753 seconds, 13184 images, 1355.302388 hours left
Loaded: 0.000028 seconds

 413: 20.902828, 27.584898 avg loss, 0.000038 rate, 5.772829 seconds, 13216 images, 1349.743537 hours left
Loaded: 0.000030 seconds

 414: 20.821766, 26.908585 avg loss, 0.000038 rate, 5.598924 seconds, 13248 images, 1344.265379 hours left
Loaded: 0.000033 seconds

 415: 33.013428, 27.519070 avg loss, 0.000039 rate, 5.742920 seconds, 13280 images, 1338.600400 hours left
Loaded: 0.000030 seconds

 416: 23.209709, 27.088133 avg loss, 0.000039 rate, 5.583855 seconds, 13312 images, 1333.192088 hours left
Loaded: 0.000043 seconds

 417: 24.251598, 26.804480 avg loss, 0.000039 rate, 5.563390 seconds, 13344 images, 1327.616878 hours left
Loaded: 0.000029 seconds

 418: 19.473877, 26.071419 avg loss, 0.000040 rate, 5.581714 seconds, 13376 images, 1322.068995 hours left
Loaded: 0.000030 seconds

 419: 20.603127, 25.524590 avg loss, 0.000040 rate, 5.629326 seconds, 13408 images, 1316.602010 hours left
Loaded: 0.000040 seconds

 420: 34.498287, 26.421959 avg loss, 0.000040 rate, 6.065882 seconds, 13440 images, 1311.255821 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.545028 seconds - performance bottleneck on CPU or Disk HDD/SSD

 421: 36.043159, 27.384079 avg loss, 0.000041 rate, 6.045144 seconds, 13472 images, 1306.569516 hours left
Loaded: 0.000040 seconds

 422: 39.062786, 28.551950 avg loss, 0.000041 rate, 6.188770 seconds, 13504 images, 1302.658298 hours left
Loaded: 0.000036 seconds

 423: 19.653234, 27.662079 avg loss, 0.000042 rate, 5.507224 seconds, 13536 images, 1298.228639 hours left
Loaded: 0.000039 seconds

 424: 23.105684, 27.206440 avg loss, 0.000042 rate, 5.599019 seconds, 13568 images, 1292.896517 hours left
Loaded: 0.000038 seconds

 425: 27.122421, 27.198038 avg loss, 0.000042 rate, 5.819380 seconds, 13600 images, 1287.745218 hours left
Loaded: 0.000038 seconds

 426: 17.094711, 26.187706 avg loss, 0.000043 rate, 5.441467 seconds, 13632 images, 1282.951515 hours left
Loaded: 0.000037 seconds

 427: 21.569246, 25.725861 avg loss, 0.000043 rate, 5.465946 seconds, 13664 images, 1277.680777 hours left
Loaded: 0.000038 seconds

 428: 31.254669, 26.278742 avg loss, 0.000044 rate, 5.795342 seconds, 13696 images, 1272.496733 hours left
Loaded: 0.000036 seconds

 429: 16.644880, 25.315355 avg loss, 0.000044 rate, 5.430785 seconds, 13728 images, 1267.822076 hours left
Loaded: 0.000032 seconds

 430: 18.947302, 24.678551 avg loss, 0.000044 rate, 5.401892 seconds, 13760 images, 1262.687747 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.069981 seconds

 431: 24.350817, 24.645777 avg loss, 0.000045 rate, 7.186730 seconds, 13792 images, 1257.564606 hours left
Loaded: 0.000031 seconds

 432: 27.613369, 24.942535 avg loss, 0.000045 rate, 7.454588 seconds, 13824 images, 1255.069129 hours left
Loaded: 0.000036 seconds

 433: 26.476797, 25.095963 avg loss, 0.000046 rate, 7.345679 seconds, 13856 images, 1252.873495 hours left
Loaded: 0.000031 seconds

 434: 23.142214, 24.900587 avg loss, 0.000046 rate, 7.112644 seconds, 13888 images, 1250.548523 hours left
Loaded: 0.000038 seconds

 435: 19.872173, 24.397745 avg loss, 0.000047 rate, 7.057364 seconds, 13920 images, 1247.923071 hours left
Loaded: 0.000031 seconds

 436: 27.187332, 24.676704 avg loss, 0.000047 rate, 7.449683 seconds, 13952 images, 1245.247076 hours left
Loaded: 0.000032 seconds

 437: 34.508278, 25.659863 avg loss, 0.000047 rate, 7.584210 seconds, 13984 images, 1243.142769 hours left
Loaded: 0.000023 seconds

 438: 26.595333, 25.753410 avg loss, 0.000048 rate, 7.060773 seconds, 14016 images, 1241.246352 hours left
Loaded: 0.000028 seconds

 439: 22.188562, 25.396925 avg loss, 0.000048 rate, 7.032995 seconds, 14048 images, 1238.641780 hours left
Loaded: 0.000038 seconds

 440: 17.482397, 24.605473 avg loss, 0.000049 rate, 6.908476 seconds, 14080 images, 1236.024655 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.472647 seconds - performance bottleneck on CPU or Disk HDD/SSD

 441: 20.305264, 24.175451 avg loss, 0.000049 rate, 6.955751 seconds, 14112 images, 1233.260731 hours left
Loaded: 0.000028 seconds

 442: 38.063362, 25.564243 avg loss, 0.000050 rate, 7.954329 seconds, 14144 images, 1231.246573 hours left
Loaded: 0.000037 seconds

 443: 21.110409, 25.118860 avg loss, 0.000050 rate, 6.981586 seconds, 14176 images, 1229.983119 hours left
Loaded: 0.000027 seconds

 444: 21.927036, 24.799679 avg loss, 0.000051 rate, 7.120796 seconds, 14208 images, 1227.381105 hours left
Loaded: 0.000028 seconds

 445: 24.974419, 24.817152 avg loss, 0.000051 rate, 7.610043 seconds, 14240 images, 1224.998446 hours left
Loaded: 0.000030 seconds

 446: 18.722918, 24.207729 avg loss, 0.000051 rate, 7.159695 seconds, 14272 images, 1223.319182 hours left
Loaded: 0.000030 seconds

 447: 29.514791, 24.738436 avg loss, 0.000052 rate, 7.629594 seconds, 14304 images, 1221.031139 hours left
Loaded: 0.000038 seconds

 448: 18.183937, 24.082985 avg loss, 0.000052 rate, 7.070220 seconds, 14336 images, 1219.418664 hours left
Loaded: 0.000030 seconds

 449: 22.867298, 23.961416 avg loss, 0.000053 rate, 7.368604 seconds, 14368 images, 1217.045314 hours left
Loaded: 0.000030 seconds

 450: 26.651512, 24.230427 avg loss, 0.000053 rate, 7.550507 seconds, 14400 images, 1215.110132 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000035 seconds

 451: 23.089657, 24.116350 avg loss, 0.000054 rate, 13.609617 seconds, 14432 images, 1213.446950 hours left
Loaded: 0.000031 seconds

 452: 23.024349, 24.007151 avg loss, 0.000054 rate, 13.272755 seconds, 14464 images, 1220.216643 hours left
Loaded: 0.000028 seconds

 453: 23.493053, 23.955742 avg loss, 0.000055 rate, 13.334624 seconds, 14496 images, 1226.450686 hours left
Loaded: 0.000028 seconds

 454: 22.068737, 23.767042 avg loss, 0.000055 rate, 13.615614 seconds, 14528 images, 1232.708284 hours left
Loaded: 0.000029 seconds

 455: 16.487885, 23.039127 avg loss, 0.000056 rate, 13.216734 seconds, 14560 images, 1239.293568 hours left
Loaded: 0.000039 seconds

 456: 24.744709, 23.209686 avg loss, 0.000056 rate, 14.177301 seconds, 14592 images, 1245.258914 hours left
Loaded: 0.000028 seconds

 457: 22.861347, 23.174852 avg loss, 0.000057 rate, 13.739576 seconds, 14624 images, 1252.498820 hours left
Loaded: 0.000028 seconds

 458: 22.301472, 23.087515 avg loss, 0.000057 rate, 13.650768 seconds, 14656 images, 1259.058272 hours left
Loaded: 0.000028 seconds

 459: 24.793251, 23.258089 avg loss, 0.000058 rate, 14.697201 seconds, 14688 images, 1265.428733 hours left
Loaded: 0.000029 seconds

 460: 18.804098, 22.812691 avg loss, 0.000058 rate, 13.766716 seconds, 14720 images, 1273.188953 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.111724 seconds - performance bottleneck on CPU or Disk HDD/SSD

 461: 21.824163, 22.713839 avg loss, 0.000059 rate, 14.796443 seconds, 14752 images, 1279.579086 hours left
Loaded: 0.000028 seconds

 462: 25.823385, 23.024794 avg loss, 0.000059 rate, 15.255269 seconds, 14784 images, 1287.490711 hours left
Loaded: 0.000030 seconds

 463: 20.690161, 22.791330 avg loss, 0.000060 rate, 14.706253 seconds, 14816 images, 1295.805339 hours left
Loaded: 0.000028 seconds

 464: 32.318367, 23.744034 avg loss, 0.000060 rate, 16.819845 seconds, 14848 images, 1303.274202 hours left
Loaded: 0.000030 seconds

 465: 23.425280, 23.712158 avg loss, 0.000061 rate, 15.460113 seconds, 14880 images, 1313.604090 hours left
Loaded: 0.000029 seconds

 466: 17.519266, 23.092869 avg loss, 0.000061 rate, 14.427569 seconds, 14912 images, 1321.941986 hours left
Loaded: 0.000028 seconds

 467: 26.252136, 23.408796 avg loss, 0.000062 rate, 15.575061 seconds, 14944 images, 1328.762273 hours left
Loaded: 0.000030 seconds

 468: 25.305605, 23.598476 avg loss, 0.000062 rate, 15.460730 seconds, 14976 images, 1337.108159 hours left
Loaded: 0.000029 seconds

 469: 23.891016, 23.627731 avg loss, 0.000063 rate, 14.907087 seconds, 15008 images, 1345.211743 hours left
Loaded: 0.000027 seconds

 470: 17.226192, 22.987577 avg loss, 0.000063 rate, 14.252113 seconds, 15040 images, 1352.465262 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.414031 seconds - performance bottleneck on CPU or Disk HDD/SSD

 471: 26.934036, 23.382223 avg loss, 0.000064 rate, 7.494270 seconds, 15072 images, 1358.736449 hours left
Loaded: 0.000037 seconds

 472: 16.317547, 22.675755 avg loss, 0.000065 rate, 7.008403 seconds, 15104 images, 1356.133485 hours left
Loaded: 0.000037 seconds

 473: 28.351025, 23.243282 avg loss, 0.000065 rate, 7.727915 seconds, 15136 images, 1352.306654 hours left
Loaded: 0.000039 seconds

 474: 10.958869, 22.014841 avg loss, 0.000066 rate, 6.714386 seconds, 15168 images, 1349.517446 hours left
Loaded: 0.000031 seconds

 475: 32.659676, 23.079325 avg loss, 0.000066 rate, 8.008709 seconds, 15200 images, 1345.348361 hours left
Loaded: 0.000029 seconds

 476: 31.324400, 23.903831 avg loss, 0.000067 rate, 7.851363 seconds, 15232 images, 1343.018696 hours left
Loaded: 0.000023 seconds

 477: 26.326708, 24.146118 avg loss, 0.000067 rate, 7.605726 seconds, 15264 images, 1340.493759 hours left
Loaded: 0.000041 seconds

 478: 20.213766, 23.752884 avg loss, 0.000068 rate, 7.248720 seconds, 15296 images, 1337.652860 hours left
Loaded: 0.000028 seconds

 479: 15.680904, 22.945686 avg loss, 0.000068 rate, 6.946114 seconds, 15328 images, 1334.344510 hours left
Loaded: 0.000030 seconds

 480: 12.870579, 21.938175 avg loss, 0.000069 rate, 6.706183 seconds, 15360 images, 1330.648902 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 481: 26.879940, 22.432352 avg loss, 0.000070 rate, 14.222219 seconds, 15392 images, 1326.656983 hours left
Loaded: 0.000036 seconds

 482: 15.409622, 21.730080 avg loss, 0.000070 rate, 12.655528 seconds, 15424 images, 1333.144293 hours left
Loaded: 0.000027 seconds

 483: 21.313002, 21.688372 avg loss, 0.000071 rate, 13.661383 seconds, 15456 images, 1337.390672 hours left
Loaded: 0.000038 seconds

 484: 20.131100, 21.532644 avg loss, 0.000071 rate, 13.593015 seconds, 15488 images, 1342.991604 hours left
Loaded: 0.000030 seconds

 485: 19.901804, 21.369560 avg loss, 0.000072 rate, 13.457126 seconds, 15520 images, 1348.441547 hours left
Loaded: 0.000039 seconds

 486: 18.420786, 21.074682 avg loss, 0.000073 rate, 13.592652 seconds, 15552 images, 1353.648202 hours left
Loaded: 0.000031 seconds

 487: 22.403002, 21.207514 avg loss, 0.000073 rate, 13.747321 seconds, 15584 images, 1358.991001 hours left
Loaded: 0.000032 seconds

 488: 17.800436, 20.866806 avg loss, 0.000074 rate, 13.349032 seconds, 15616 images, 1364.495147 hours left
Loaded: 0.000038 seconds

 489: 13.688698, 20.148994 avg loss, 0.000074 rate, 12.652300 seconds, 15648 images, 1369.391021 hours left
Loaded: 0.000030 seconds

 490: 19.967693, 20.130865 avg loss, 0.000075 rate, 13.761347 seconds, 15680 images, 1373.270203 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.038696 seconds

 491: 25.822977, 20.700077 avg loss, 0.000076 rate, 15.296942 seconds, 15712 images, 1378.650922 hours left
Loaded: 0.000028 seconds

 492: 25.459803, 21.176050 avg loss, 0.000076 rate, 15.484285 seconds, 15744 images, 1386.164307 hours left
Loaded: 0.000034 seconds

 493: 10.773039, 20.135750 avg loss, 0.000077 rate, 13.603718 seconds, 15776 images, 1393.809012 hours left
Loaded: 0.000029 seconds

 494: 25.186478, 20.640823 avg loss, 0.000077 rate, 15.403506 seconds, 15808 images, 1398.765300 hours left
Loaded: 0.000029 seconds

 495: 28.021555, 21.378897 avg loss, 0.000078 rate, 15.572744 seconds, 15840 images, 1406.171718 hours left
Loaded: 0.000030 seconds

 496: 17.386044, 20.979610 avg loss, 0.000079 rate, 14.384564 seconds, 15872 images, 1413.739083 hours left
Loaded: 0.000032 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 497: 22.178576, 21.099506 avg loss, 0.000079 rate, 14.992635 seconds, 15904 images, 1419.580467 hours left
Loaded: 0.000030 seconds

 498: 21.548733, 21.144428 avg loss, 0.000080 rate, 14.731104 seconds, 15936 images, 1426.207963 hours left
Loaded: 0.000027 seconds

 499: 24.768021, 21.506788 avg loss, 0.000081 rate, 14.819296 seconds, 15968 images, 1432.405906 hours left
Loaded: 0.000028 seconds

 500: 19.299984, 21.286108 avg loss, 0.000081 rate, 14.284049 seconds, 16000 images, 1438.664294 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.400882 seconds - performance bottleneck on CPU or Disk HDD/SSD

 501: 20.336567, 21.191154 avg loss, 0.000082 rate, 11.357912 seconds, 16032 images, 1444.116661 hours left
Loaded: 0.000042 seconds

 502: 23.805588, 21.452599 avg loss, 0.000083 rate, 11.858123 seconds, 16064 images, 1446.007132 hours left
Loaded: 0.000022 seconds

 503: 21.541098, 21.461449 avg loss, 0.000083 rate, 11.309588 seconds, 16096 images, 1448.016683 hours left
Loaded: 0.000029 seconds

 504: 20.955742, 21.410877 avg loss, 0.000084 rate, 11.484789 seconds, 16128 images, 1449.244227 hours left
Loaded: 0.000028 seconds

 505: 23.506660, 21.620455 avg loss, 0.000085 rate, 11.617861 seconds, 16160 images, 1450.702807 hours left
Loaded: 0.000027 seconds

 506: 18.816954, 21.340105 avg loss, 0.000085 rate, 11.458257 seconds, 16192 images, 1452.331587 hours left
Loaded: 0.000023 seconds

 507: 28.941587, 22.100254 avg loss, 0.000086 rate, 12.632273 seconds, 16224 images, 1453.722379 hours left
Loaded: 0.000029 seconds

 508: 19.674080, 21.857637 avg loss, 0.000087 rate, 11.421084 seconds, 16256 images, 1456.729779 hours left
Loaded: 0.000030 seconds

 509: 24.737413, 22.145615 avg loss, 0.000087 rate, 11.790204 seconds, 16288 images, 1458.024899 hours left
Loaded: 0.000031 seconds

 510: 14.894899, 21.420544 avg loss, 0.000088 rate, 10.953385 seconds, 16320 images, 1459.819697 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.345043 seconds - performance bottleneck on CPU or Disk HDD/SSD

 511: 23.481676, 21.626657 avg loss, 0.000089 rate, 7.002530 seconds, 16352 images, 1460.434287 hours left
Loaded: 0.000030 seconds

 512: 12.192317, 20.683224 avg loss, 0.000089 rate, 6.124594 seconds, 16384 images, 1456.034696 hours left
Loaded: 0.000029 seconds

 513: 25.841528, 21.199055 avg loss, 0.000090 rate, 6.810807 seconds, 16416 images, 1449.980581 hours left
Loaded: 0.000032 seconds

 514: 22.695507, 21.348700 avg loss, 0.000091 rate, 6.858957 seconds, 16448 images, 1444.940037 hours left
Loaded: 0.000028 seconds

 515: 22.934835, 21.507313 avg loss, 0.000091 rate, 6.991890 seconds, 16480 images, 1440.016756 hours left
Loaded: 0.000029 seconds

 516: 24.812378, 21.837820 avg loss, 0.000092 rate, 6.850247 seconds, 16512 images, 1435.327308 hours left
Loaded: 0.000028 seconds

 517: 24.573637, 22.111403 avg loss, 0.000093 rate, 6.800663 seconds, 16544 images, 1430.488015 hours left
Loaded: 0.000028 seconds

 518: 26.768864, 22.577148 avg loss, 0.000094 rate, 6.896069 seconds, 16576 images, 1425.628231 hours left
Loaded: 0.000030 seconds

 519: 32.879486, 23.607382 avg loss, 0.000094 rate, 7.587390 seconds, 16608 images, 1420.949530 hours left
Loaded: 0.000031 seconds

 520: 26.389639, 23.885607 avg loss, 0.000095 rate, 7.238855 seconds, 16640 images, 1417.277730 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.032542 seconds

 521: 17.490685, 23.246115 avg loss, 0.000096 rate, 7.580885 seconds, 16672 images, 1413.158573 hours left
Loaded: 0.000041 seconds

 522: 31.505127, 24.072016 avg loss, 0.000097 rate, 8.220029 seconds, 16704 images, 1409.600762 hours left
Loaded: 0.000037 seconds

 523: 21.952894, 23.860104 avg loss, 0.000097 rate, 7.672607 seconds, 16736 images, 1406.921030 hours left
Loaded: 0.000037 seconds

 524: 23.734428, 23.847536 avg loss, 0.000098 rate, 7.584108 seconds, 16768 images, 1403.507794 hours left
Loaded: 0.000029 seconds

 525: 24.250172, 23.887800 avg loss, 0.000099 rate, 7.526433 seconds, 16800 images, 1400.005773 hours left
Loaded: 0.000033 seconds

 526: 18.600563, 23.359077 avg loss, 0.000100 rate, 7.222502 seconds, 16832 images, 1396.458625 hours left
Loaded: 0.000029 seconds

 527: 13.688610, 22.392031 avg loss, 0.000100 rate, 6.843360 seconds, 16864 images, 1392.524829 hours left
Loaded: 0.000038 seconds

 528: 15.197964, 21.672625 avg loss, 0.000101 rate, 6.788626 seconds, 16896 images, 1388.103789 hours left
Loaded: 0.000027 seconds

 529: 18.250481, 21.330410 avg loss, 0.000102 rate, 7.291262 seconds, 16928 images, 1383.650937 hours left
Loaded: 0.000030 seconds

 530: 26.370314, 21.834400 avg loss, 0.000103 rate, 7.628220 seconds, 16960 images, 1379.940644 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.418182 seconds - performance bottleneck on CPU or Disk HDD/SSD

 531: 21.416000, 21.792561 avg loss, 0.000103 rate, 7.163123 seconds, 16992 images, 1376.735406 hours left
Loaded: 0.000028 seconds

 532: 27.667458, 22.380051 avg loss, 0.000104 rate, 7.549423 seconds, 17024 images, 1373.497002 hours left
Loaded: 0.000028 seconds

 533: 20.426945, 22.184740 avg loss, 0.000105 rate, 7.191308 seconds, 17056 images, 1370.246723 hours left
Loaded: 0.000029 seconds

 534: 23.018414, 22.268108 avg loss, 0.000106 rate, 7.340584 seconds, 17088 images, 1366.531575 hours left
Loaded: 0.000028 seconds

 535: 19.782074, 22.019505 avg loss, 0.000107 rate, 6.887709 seconds, 17120 images, 1363.060874 hours left
Loaded: 0.000027 seconds

 536: 21.073467, 21.924900 avg loss, 0.000107 rate, 7.142960 seconds, 17152 images, 1358.995910 hours left
Loaded: 0.000027 seconds

 537: 13.129409, 21.045351 avg loss, 0.000108 rate, 6.688548 seconds, 17184 images, 1355.326080 hours left
Loaded: 0.000028 seconds

 538: 13.539480, 20.294764 avg loss, 0.000109 rate, 6.629816 seconds, 17216 images, 1351.061833 hours left
Loaded: 0.000038 seconds

 539: 15.739989, 19.839287 avg loss, 0.000110 rate, 6.927153 seconds, 17248 images, 1346.758644 hours left
Loaded: 0.000029 seconds

 540: 20.895325, 19.944891 avg loss, 0.000111 rate, 7.318840 seconds, 17280 images, 1342.911418 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.442941 seconds - performance bottleneck on CPU or Disk HDD/SSD

 541: 23.960882, 20.346491 avg loss, 0.000111 rate, 5.243035 seconds, 17312 images, 1339.646599 hours left
Loaded: 0.000039 seconds

 542: 21.802399, 20.492081 avg loss, 0.000112 rate, 5.055253 seconds, 17344 images, 1334.146687 hours left
Loaded: 0.000036 seconds

 543: 22.353979, 20.678270 avg loss, 0.000113 rate, 5.138688 seconds, 17376 images, 1327.825883 hours left
Loaded: 0.000029 seconds

 544: 24.028135, 21.013256 avg loss, 0.000114 rate, 5.183284 seconds, 17408 images, 1321.684139 hours left
Loaded: 0.000028 seconds

 545: 16.343689, 20.546299 avg loss, 0.000115 rate, 4.976441 seconds, 17440 images, 1315.665722 hours left
Loaded: 0.000029 seconds

 546: 21.396540, 20.631323 avg loss, 0.000116 rate, 5.158041 seconds, 17472 images, 1309.420218 hours left
Loaded: 0.000032 seconds

 547: 25.979324, 21.166122 avg loss, 0.000116 rate, 5.458998 seconds, 17504 images, 1303.489355 hours left
Loaded: 0.000031 seconds

 548: 25.386271, 21.588137 avg loss, 0.000117 rate, 5.458249 seconds, 17536 images, 1298.035748 hours left
Loaded: 0.000030 seconds

 549: 23.536282, 21.782951 avg loss, 0.000118 rate, 5.290121 seconds, 17568 images, 1292.635621 hours left
Loaded: 0.000037 seconds

 550: 20.376703, 21.642326 avg loss, 0.000119 rate, 5.370834 seconds, 17600 images, 1287.055989 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 551: 22.668121, 21.744905 avg loss, 0.000120 rate, 15.808184 seconds, 17632 images, 1281.644239 hours left
Loaded: 0.000036 seconds

 552: 21.305855, 21.701000 avg loss, 0.000121 rate, 15.652066 seconds, 17664 images, 1290.781430 hours left
Loaded: 0.000035 seconds

 553: 24.195808, 21.950481 avg loss, 0.000122 rate, 16.243613 seconds, 17696 images, 1299.610400 hours left
Loaded: 0.000030 seconds

 554: 24.444626, 22.199896 avg loss, 0.000122 rate, 15.713567 seconds, 17728 images, 1309.172543 hours left
Loaded: 0.000030 seconds

 555: 14.169308, 21.396837 avg loss, 0.000123 rate, 14.189335 seconds, 17760 images, 1317.902915 hours left
Loaded: 0.000030 seconds

 556: 20.421669, 21.299320 avg loss, 0.000124 rate, 15.973743 seconds, 17792 images, 1324.429183 hours left
Loaded: 0.000030 seconds

 557: 27.296589, 21.899048 avg loss, 0.000125 rate, 17.440464 seconds, 17824 images, 1333.368216 hours left
Loaded: 0.000029 seconds

 558: 21.513653, 21.860508 avg loss, 0.000126 rate, 16.216755 seconds, 17856 images, 1344.254695 hours left
Loaded: 0.000032 seconds

 559: 13.019670, 20.976423 avg loss, 0.000127 rate, 14.608161 seconds, 17888 images, 1353.332861 hours left
Loaded: 0.000037 seconds

 560: 28.362598, 21.715040 avg loss, 0.000128 rate, 16.822765 seconds, 17920 images, 1360.086310 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.333956 seconds - performance bottleneck on CPU or Disk HDD/SSD

 561: 15.544153, 21.097952 avg loss, 0.000129 rate, 11.023068 seconds, 17952 images, 1369.847660 hours left
Loaded: 0.000027 seconds

 562: 24.202721, 21.408428 avg loss, 0.000130 rate, 12.190740 seconds, 17984 images, 1371.920917 hours left
Loaded: 0.000028 seconds

 563: 28.116814, 22.079268 avg loss, 0.000131 rate, 12.501351 seconds, 18016 images, 1375.131243 hours left
Loaded: 0.000036 seconds

 564: 19.165234, 21.787865 avg loss, 0.000132 rate, 12.018185 seconds, 18048 images, 1378.740781 hours left
Loaded: 0.000028 seconds

 565: 23.832823, 21.992361 avg loss, 0.000132 rate, 12.454249 seconds, 18080 images, 1381.643227 hours left
Loaded: 0.000030 seconds

 566: 17.188425, 21.511967 avg loss, 0.000133 rate, 11.638906 seconds, 18112 images, 1385.122169 hours left
Loaded: 0.000030 seconds

 567: 19.249369, 21.285707 avg loss, 0.000134 rate, 11.974086 seconds, 18144 images, 1387.434017 hours left
Loaded: 0.000029 seconds

 568: 19.218250, 21.078962 avg loss, 0.000135 rate, 12.139867 seconds, 18176 images, 1390.188182 hours left
Loaded: 0.000037 seconds

 569: 19.399794, 20.911045 avg loss, 0.000136 rate, 11.913696 seconds, 18208 images, 1393.144987 hours left
Loaded: 0.000029 seconds

 570: 22.266199, 21.046560 avg loss, 0.000137 rate, 12.222714 seconds, 18240 images, 1395.758119 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.529640 seconds - performance bottleneck on CPU or Disk HDD/SSD

 571: 24.803301, 21.422234 avg loss, 0.000138 rate, 13.041832 seconds, 18272 images, 1398.774207 hours left
Loaded: 0.000030 seconds

 572: 21.243120, 21.404322 avg loss, 0.000139 rate, 12.300552 seconds, 18304 images, 1403.633069 hours left
Loaded: 0.000028 seconds

 573: 25.836058, 21.847496 avg loss, 0.000140 rate, 12.500380 seconds, 18336 images, 1406.678434 hours left
Loaded: 0.000027 seconds

 574: 20.429672, 21.705713 avg loss, 0.000141 rate, 11.498835 seconds, 18368 images, 1409.970807 hours left
Loaded: 0.000027 seconds

 575: 16.059038, 21.141047 avg loss, 0.000142 rate, 11.055770 seconds, 18400 images, 1411.839389 hours left
Loaded: 0.000023 seconds

 576: 17.857359, 20.812677 avg loss, 0.000143 rate, 11.691489 seconds, 18432 images, 1413.073978 hours left
Loaded: 0.000030 seconds

 577: 20.934032, 20.824814 avg loss, 0.000144 rate, 12.094429 seconds, 18464 images, 1415.178997 hours left
Loaded: 0.000029 seconds

 578: 15.761300, 20.318462 avg loss, 0.000145 rate, 11.220873 seconds, 18496 images, 1417.822495 hours left
Loaded: 0.000027 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 579: 19.707058, 20.257322 avg loss, 0.000146 rate, 11.604465 seconds, 18528 images, 1419.226437 hours left
Loaded: 0.000038 seconds

 580: 16.200653, 19.851656 avg loss, 0.000147 rate, 11.553063 seconds, 18560 images, 1421.149001 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.327664 seconds - performance bottleneck on CPU or Disk HDD/SSD

 581: 19.853741, 19.851864 avg loss, 0.000148 rate, 7.595819 seconds, 18592 images, 1422.980933 hours left
Loaded: 0.000027 seconds

 582: 14.977466, 19.364424 avg loss, 0.000149 rate, 7.335407 seconds, 18624 images, 1419.754192 hours left
Loaded: 0.000028 seconds

 583: 16.816320, 19.109613 avg loss, 0.000150 rate, 7.351808 seconds, 18656 images, 1415.743096 hours left
Loaded: 0.000030 seconds

 584: 19.951899, 19.193842 avg loss, 0.000151 rate, 7.391494 seconds, 18688 images, 1411.794867 hours left
Loaded: 0.000026 seconds

 585: 24.215508, 19.696009 avg loss, 0.000152 rate, 7.750456 seconds, 18720 images, 1407.941212 hours left
Loaded: 0.000025 seconds

 586: 14.764524, 19.202860 avg loss, 0.000153 rate, 7.182436 seconds, 18752 images, 1404.624538 hours left
Loaded: 0.000035 seconds

 587: 22.698593, 19.552433 avg loss, 0.000154 rate, 8.011177 seconds, 18784 images, 1400.552230 hours left
Loaded: 0.000032 seconds

 588: 13.216066, 18.918797 avg loss, 0.000155 rate, 7.235429 seconds, 18816 images, 1397.671468 hours left
Loaded: 0.000028 seconds

 589: 18.736881, 18.900604 avg loss, 0.000156 rate, 7.555249 seconds, 18848 images, 1393.742248 hours left
Loaded: 0.000027 seconds

 590: 21.472528, 19.157797 avg loss, 0.000158 rate, 7.783018 seconds, 18880 images, 1390.296410 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 591: 17.283730, 18.970390 avg loss, 0.000159 rate, 15.001407 seconds, 18912 images, 1387.201301 hours left
Loaded: 0.000030 seconds

 592: 21.991768, 19.272528 avg loss, 0.000160 rate, 15.977485 seconds, 18944 images, 1394.160832 hours left
Loaded: 0.000030 seconds

 593: 22.474560, 19.592731 avg loss, 0.000161 rate, 16.108287 seconds, 18976 images, 1402.406148 hours left
Loaded: 0.000031 seconds

 594: 24.094618, 20.042919 avg loss, 0.000162 rate, 16.550560 seconds, 19008 images, 1410.750602 hours left
Loaded: 0.000032 seconds

 595: 22.328283, 20.271456 avg loss, 0.000163 rate, 15.528050 seconds, 19040 images, 1419.625722 hours left
Loaded: 0.000029 seconds

 596: 16.236820, 19.867992 avg loss, 0.000164 rate, 14.534824 seconds, 19072 images, 1426.992161 hours left
Loaded: 0.000029 seconds

 597: 19.801138, 19.861307 avg loss, 0.000165 rate, 15.052665 seconds, 19104 images, 1432.905674 hours left
Loaded: 0.000037 seconds

 598: 21.271242, 20.002300 avg loss, 0.000166 rate, 15.320940 seconds, 19136 images, 1439.479093 hours left
Loaded: 0.000035 seconds

 599: 18.369123, 19.838982 avg loss, 0.000167 rate, 15.467956 seconds, 19168 images, 1446.359278 hours left
Loaded: 0.000028 seconds

 600: 22.735083, 20.128592 avg loss, 0.000168 rate, 16.049995 seconds, 19200 images, 1453.374767 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.346030 seconds - performance bottleneck on CPU or Disk HDD/SSD

 601: 16.312443, 19.746977 avg loss, 0.000170 rate, 5.457637 seconds, 19232 images, 1461.128270 hours left
Loaded: 0.000030 seconds

 602: 25.253746, 20.297653 avg loss, 0.000171 rate, 5.739229 seconds, 19264 images, 1454.576022 hours left
Loaded: 0.000037 seconds

 603: 24.843904, 20.752277 avg loss, 0.000172 rate, 5.788726 seconds, 19296 images, 1447.999842 hours left
Loaded: 0.000036 seconds

 604: 23.533636, 21.030413 avg loss, 0.000173 rate, 5.861874 seconds, 19328 images, 1441.558149 hours left
Loaded: 0.000037 seconds

 605: 27.313585, 21.658730 avg loss, 0.000174 rate, 5.833346 seconds, 19360 images, 1435.282430 hours left
Loaded: 0.000037 seconds

 606: 24.175522, 21.910408 avg loss, 0.000175 rate, 5.591321 seconds, 19392 images, 1429.029837 hours left
Loaded: 0.000038 seconds

 607: 25.217131, 22.241081 avg loss, 0.000176 rate, 5.695129 seconds, 19424 images, 1422.503682 hours left
Loaded: 0.000037 seconds

 608: 15.825791, 21.599552 avg loss, 0.000178 rate, 5.124957 seconds, 19456 images, 1416.186919 hours left
Loaded: 0.000038 seconds

 609: 17.605825, 21.200180 avg loss, 0.000179 rate, 5.333322 seconds, 19488 images, 1409.141573 hours left
Loaded: 0.000030 seconds

 610: 15.001820, 20.580343 avg loss, 0.000180 rate, 5.139104 seconds, 19520 images, 1402.456000 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 611: 29.366169, 21.458925 avg loss, 0.000181 rate, 9.178920 seconds, 19552 images, 1395.567568 hours left
Loaded: 0.000029 seconds

 612: 22.552355, 21.568268 avg loss, 0.000182 rate, 8.796900 seconds, 19584 images, 1394.357611 hours left
Loaded: 0.000032 seconds

 613: 21.505970, 21.562038 avg loss, 0.000184 rate, 8.868295 seconds, 19616 images, 1392.629269 hours left
Loaded: 0.000029 seconds

 614: 19.204222, 21.326258 avg loss, 0.000185 rate, 8.469845 seconds, 19648 images, 1391.017327 hours left
Loaded: 0.000031 seconds

 615: 21.702404, 21.363873 avg loss, 0.000186 rate, 8.780056 seconds, 19680 images, 1388.868199 hours left
Loaded: 0.000029 seconds

 616: 13.776505, 20.605135 avg loss, 0.000187 rate, 8.105638 seconds, 19712 images, 1387.171293 hours left
Loaded: 0.000038 seconds

 617: 23.332838, 20.877905 avg loss, 0.000188 rate, 9.004266 seconds, 19744 images, 1384.554853 hours left
Loaded: 0.000036 seconds

 618: 13.956402, 20.185755 avg loss, 0.000190 rate, 8.145945 seconds, 19776 images, 1383.212369 hours left
Loaded: 0.000040 seconds

 619: 20.996059, 20.266785 avg loss, 0.000191 rate, 8.922781 seconds, 19808 images, 1380.691452 hours left
Loaded: 0.000030 seconds

 620: 23.518127, 20.591919 avg loss, 0.000192 rate, 9.286548 seconds, 19840 images, 1379.274407 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.490885 seconds - performance bottleneck on CPU or Disk HDD/SSD

 621: 22.386875, 20.771414 avg loss, 0.000193 rate, 7.914069 seconds, 19872 images, 1378.376615 hours left
Loaded: 0.000030 seconds

 622: 23.388479, 21.033121 avg loss, 0.000195 rate, 8.170222 seconds, 19904 images, 1376.263585 hours left
Loaded: 0.000028 seconds

 623: 20.794271, 21.009235 avg loss, 0.000196 rate, 8.187875 seconds, 19936 images, 1373.845766 hours left
Loaded: 0.000031 seconds

 624: 26.673529, 21.575665 avg loss, 0.000197 rate, 8.256461 seconds, 19968 images, 1371.476612 hours left
Loaded: 0.000030 seconds

 625: 18.164856, 21.234583 avg loss, 0.000198 rate, 7.684498 seconds, 20000 images, 1369.226366 hours left
Loaded: 0.000037 seconds

 626: 20.304829, 21.141607 avg loss, 0.000200 rate, 7.949899 seconds, 20032 images, 1366.204412 hours left
Loaded: 0.000032 seconds

 627: 19.306261, 20.958073 avg loss, 0.000201 rate, 7.884509 seconds, 20064 images, 1363.581179 hours left
Loaded: 0.000025 seconds

 628: 19.496035, 20.811869 avg loss, 0.000202 rate, 7.969328 seconds, 20096 images, 1360.893351 hours left
Loaded: 0.000039 seconds

 629: 26.103977, 21.341080 avg loss, 0.000203 rate, 8.735021 seconds, 20128 images, 1358.350144 hours left
Loaded: 0.000038 seconds

 630: 21.209305, 21.327902 avg loss, 0.000205 rate, 8.182353 seconds, 20160 images, 1356.895554 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.438294 seconds - performance bottleneck on CPU or Disk HDD/SSD

 631: 19.820393, 21.177151 avg loss, 0.000206 rate, 6.073328 seconds, 20192 images, 1354.688090 hours left
Loaded: 0.000028 seconds

 632: 16.686918, 20.728127 avg loss, 0.000207 rate, 5.904997 seconds, 20224 images, 1350.182771 hours left
Loaded: 0.000028 seconds

 633: 27.333208, 21.388636 avg loss, 0.000209 rate, 6.396946 seconds, 20256 images, 1344.880215 hours left
Loaded: 0.000037 seconds

 634: 17.451008, 20.994873 avg loss, 0.000210 rate, 5.953098 seconds, 20288 images, 1340.313748 hours left
Loaded: 0.000030 seconds

 635: 24.799160, 21.375301 avg loss, 0.000211 rate, 6.496554 seconds, 20320 images, 1335.176663 hours left
Loaded: 0.000027 seconds

 636: 28.937868, 22.131557 avg loss, 0.000213 rate, 6.578815 seconds, 20352 images, 1330.845506 hours left
Loaded: 0.000026 seconds

 637: 17.274900, 21.645891 avg loss, 0.000214 rate, 6.279395 seconds, 20384 images, 1326.671859 hours left
Loaded: 0.000033 seconds

 638: 23.874205, 21.868723 avg loss, 0.000215 rate, 6.690319 seconds, 20416 images, 1322.124182 hours left
Loaded: 0.000028 seconds

 639: 21.770054, 21.858856 avg loss, 0.000217 rate, 6.362117 seconds, 20448 images, 1318.192544 hours left
Loaded: 0.000038 seconds

 640: 21.521555, 21.825127 avg loss, 0.000218 rate, 6.601841 seconds, 20480 images, 1313.844488 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 641: 20.729071, 21.715521 avg loss, 0.000219 rate, 12.740387 seconds, 20512 images, 1309.872765 hours left
Loaded: 0.000030 seconds

 642: 28.598900, 22.403858 avg loss, 0.000221 rate, 13.371014 seconds, 20544 images, 1314.464080 hours left
Loaded: 0.000033 seconds

 643: 18.892473, 22.052719 avg loss, 0.000222 rate, 12.055999 seconds, 20576 images, 1319.885082 hours left
Loaded: 0.000028 seconds

 644: 22.668110, 22.114258 avg loss, 0.000224 rate, 13.432007 seconds, 20608 images, 1323.425944 hours left
Loaded: 0.000029 seconds

 645: 18.342707, 21.737103 avg loss, 0.000225 rate, 12.632782 seconds, 20640 images, 1328.841930 hours left
Loaded: 0.000038 seconds

 646: 24.962439, 22.059635 avg loss, 0.000226 rate, 13.350948 seconds, 20672 images, 1333.094007 hours left
Loaded: 0.000029 seconds

 647: 13.574438, 21.211115 avg loss, 0.000228 rate, 11.375226 seconds, 20704 images, 1338.300702 hours left
Loaded: 0.000032 seconds

 648: 17.368734, 20.826878 avg loss, 0.000229 rate, 11.975196 seconds, 20736 images, 1340.712029 hours left
Loaded: 0.000024 seconds

 649: 27.544420, 21.498632 avg loss, 0.000231 rate, 13.263466 seconds, 20768 images, 1343.932262 hours left
Loaded: 0.000027 seconds

 650: 20.488241, 21.397593 avg loss, 0.000232 rate, 12.589475 seconds, 20800 images, 1348.908977 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.108338 seconds - performance bottleneck on CPU or Disk HDD/SSD

 651: 28.053858, 22.063219 avg loss, 0.000233 rate, 15.222416 seconds, 20832 images, 1352.900075 hours left
Loaded: 0.000029 seconds

 652: 25.323032, 22.389200 avg loss, 0.000235 rate, 14.713995 seconds, 20864 images, 1360.657373 hours left
Loaded: 0.000029 seconds

 653: 20.714930, 22.221773 avg loss, 0.000236 rate, 12.936152 seconds, 20896 images, 1367.480745 hours left
Loaded: 0.000032 seconds

 654: 17.147532, 21.714350 avg loss, 0.000238 rate, 12.630394 seconds, 20928 images, 1371.767372 hours left
Loaded: 0.000028 seconds

 655: 16.022375, 21.145153 avg loss, 0.000239 rate, 12.338174 seconds, 20960 images, 1375.586567 hours left
Loaded: 0.000028 seconds

 656: 18.033018, 20.833939 avg loss, 0.000241 rate, 12.848252 seconds, 20992 images, 1378.961794 hours left
Loaded: 0.000023 seconds

 657: 24.159288, 21.166473 avg loss, 0.000242 rate, 13.904014 seconds, 21024 images, 1383.011456 hours left
Loaded: 0.000028 seconds

 658: 22.493843, 21.299210 avg loss, 0.000244 rate, 13.582504 seconds, 21056 images, 1388.486452 hours left
Loaded: 0.000031 seconds

 659: 25.709370, 21.740225 avg loss, 0.000245 rate, 14.235994 seconds, 21088 images, 1393.460271 hours left
Loaded: 0.000026 seconds

 660: 22.246143, 21.790817 avg loss, 0.000247 rate, 13.615076 seconds, 21120 images, 1399.291651 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.410459 seconds - performance bottleneck on CPU or Disk HDD/SSD

 661: 20.315517, 21.643288 avg loss, 0.000248 rate, 7.474766 seconds, 21152 images, 1404.202561 hours left
Loaded: 0.000031 seconds

 662: 20.652147, 21.544174 avg loss, 0.000250 rate, 7.523293 seconds, 21184 images, 1401.108738 hours left
Loaded: 0.000029 seconds

 663: 22.511900, 21.640947 avg loss, 0.000251 rate, 7.716683 seconds, 21216 images, 1397.543342 hours left
Loaded: 0.000037 seconds

 664: 18.949453, 21.371798 avg loss, 0.000253 rate, 7.297411 seconds, 21248 images, 1394.282082 hours left
Loaded: 0.000036 seconds

 665: 10.917226, 20.326340 avg loss, 0.000254 rate, 6.520994 seconds, 21280 images, 1390.471295 hours left
Loaded: 0.000028 seconds

 666: 22.644880, 20.558193 avg loss, 0.000256 rate, 7.529829 seconds, 21312 images, 1385.620594 hours left
Loaded: 0.000040 seconds

 667: 14.998119, 20.002186 avg loss, 0.000257 rate, 7.033029 seconds, 21344 images, 1382.219064 hours left
Loaded: 0.000031 seconds

 668: 26.323223, 20.634289 avg loss, 0.000259 rate, 8.010859 seconds, 21376 images, 1378.161776 hours left
Loaded: 0.000029 seconds

 669: 28.838226, 21.454683 avg loss, 0.000260 rate, 8.140959 seconds, 21408 images, 1375.502669 hours left
Loaded: 0.000025 seconds

 670: 23.654825, 21.674698 avg loss, 0.000262 rate, 7.476018 seconds, 21440 images, 1373.050765 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.462857 seconds - performance bottleneck on CPU or Disk HDD/SSD

 671: 24.937212, 22.000950 avg loss, 0.000264 rate, 6.751768 seconds, 21472 images, 1369.700134 hours left
Loaded: 0.000029 seconds

 672: 20.761087, 21.876965 avg loss, 0.000265 rate, 6.767204 seconds, 21504 images, 1366.020030 hours left
Loaded: 0.000040 seconds

 673: 22.259470, 21.915215 avg loss, 0.000267 rate, 6.787211 seconds, 21536 images, 1361.755547 hours left
Loaded: 0.000031 seconds

 674: 20.433796, 21.767073 avg loss, 0.000268 rate, 6.539282 seconds, 21568 images, 1357.561482 hours left
Loaded: 0.000031 seconds

 675: 17.599815, 21.350348 avg loss, 0.000270 rate, 6.412765 seconds, 21600 images, 1353.065100 hours left
Loaded: 0.000028 seconds

 676: 19.400631, 21.155376 avg loss, 0.000271 rate, 6.521326 seconds, 21632 images, 1348.438007 hours left
Loaded: 0.000030 seconds

 677: 20.093241, 21.049164 avg loss, 0.000273 rate, 6.357930 seconds, 21664 images, 1344.007891 hours left
Loaded: 0.000032 seconds

 678: 16.058619, 20.550110 avg loss, 0.000275 rate, 6.129410 seconds, 21696 images, 1339.395199 hours left
Loaded: 0.000039 seconds

 679: 20.854877, 20.580587 avg loss, 0.000276 rate, 6.624586 seconds, 21728 images, 1334.511345 hours left
Loaded: 0.000030 seconds

 680: 24.085409, 20.931070 avg loss, 0.000278 rate, 6.934070 seconds, 21760 images, 1330.363821 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000037 seconds

 681: 18.369448, 20.674908 avg loss, 0.000280 rate, 12.453304 seconds, 21792 images, 1326.687423 hours left
Loaded: 0.000038 seconds

 682: 20.149521, 20.622370 avg loss, 0.000281 rate, 11.973578 seconds, 21824 images, 1330.710608 hours left
Loaded: 0.000028 seconds

 683: 26.725557, 21.232689 avg loss, 0.000283 rate, 13.008554 seconds, 21856 images, 1334.027483 hours left
Loaded: 0.000028 seconds

 684: 22.537121, 21.363132 avg loss, 0.000285 rate, 12.395167 seconds, 21888 images, 1338.748081 hours left
Loaded: 0.000026 seconds

 685: 18.708576, 21.097677 avg loss, 0.000286 rate, 11.856757 seconds, 21920 images, 1342.569826 hours left
Loaded: 0.000037 seconds

 686: 26.282717, 21.616180 avg loss, 0.000288 rate, 12.856634 seconds, 21952 images, 1345.605801 hours left
Loaded: 0.000022 seconds

 687: 23.694193, 21.823982 avg loss, 0.000290 rate, 12.306746 seconds, 21984 images, 1349.999602 hours left
Loaded: 0.000027 seconds

 688: 20.158005, 21.657385 avg loss, 0.000291 rate, 12.093807 seconds, 22016 images, 1353.585959 hours left
Loaded: 0.000027 seconds

 689: 18.802946, 21.371941 avg loss, 0.000293 rate, 11.686472 seconds, 22048 images, 1356.840786 hours left
Loaded: 0.000027 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 690: 22.560001, 21.490747 avg loss, 0.000295 rate, 12.147734 seconds, 22080 images, 1359.497504 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.497506 seconds - performance bottleneck on CPU or Disk HDD/SSD

 691: 15.319481, 20.873621 avg loss, 0.000296 rate, 11.054094 seconds, 22112 images, 1362.768031 hours left
Loaded: 0.000033 seconds

 692: 12.290628, 20.015322 avg loss, 0.000298 rate, 10.731388 seconds, 22144 images, 1365.178124 hours left
Loaded: 0.000028 seconds

 693: 13.569133, 19.370703 avg loss, 0.000300 rate, 11.110171 seconds, 22176 images, 1366.425383 hours left
Loaded: 0.000027 seconds

 694: 16.353888, 19.069021 avg loss, 0.000302 rate, 11.332288 seconds, 22208 images, 1368.186025 hours left
Loaded: 0.000026 seconds

 695: 21.264671, 19.288586 avg loss, 0.000303 rate, 12.087130 seconds, 22240 images, 1370.237399 hours left
Loaded: 0.000026 seconds

 696: 19.252058, 19.284933 avg loss, 0.000305 rate, 11.456687 seconds, 22272 images, 1373.316207 hours left
Loaded: 0.000032 seconds

 697: 14.765551, 18.832994 avg loss, 0.000307 rate, 11.421672 seconds, 22304 images, 1375.488921 hours left
Loaded: 0.000023 seconds

 698: 24.554865, 19.405182 avg loss, 0.000309 rate, 12.173548 seconds, 22336 images, 1377.591272 hours left
Loaded: 0.000026 seconds

 699: 15.819342, 19.046598 avg loss, 0.000310 rate, 11.105131 seconds, 22368 images, 1380.716415 hours left
Loaded: 0.000031 seconds

 700: 15.648455, 18.706783 avg loss, 0.000312 rate, 11.146725 seconds, 22400 images, 1382.326954 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.229560 seconds - performance bottleneck on CPU or Disk HDD/SSD

 701: 13.181457, 18.154251 avg loss, 0.000314 rate, 5.125528 seconds, 22432 images, 1383.979110 hours left
Loaded: 0.000024 seconds

 702: 18.956169, 18.234444 avg loss, 0.000316 rate, 5.405306 seconds, 22464 images, 1377.573964 hours left
Loaded: 0.000028 seconds

 703: 22.311863, 18.642185 avg loss, 0.000318 rate, 5.782714 seconds, 22496 images, 1371.302606 hours left
Loaded: 0.000028 seconds

 704: 21.280476, 18.906013 avg loss, 0.000319 rate, 5.591274 seconds, 22528 images, 1365.617918 hours left
Loaded: 0.000029 seconds

 705: 30.206959, 20.036108 avg loss, 0.000321 rate, 6.240939 seconds, 22560 images, 1359.724282 hours left
Loaded: 0.000028 seconds

 706: 20.276913, 20.060188 avg loss, 0.000323 rate, 5.559295 seconds, 22592 images, 1354.791509 hours left
Loaded: 0.000039 seconds

 707: 20.917339, 20.145903 avg loss, 0.000325 rate, 5.644996 seconds, 22624 images, 1348.961707 hours left
Loaded: 0.000036 seconds

 708: 23.836565, 20.514969 avg loss, 0.000327 rate, 5.813414 seconds, 22656 images, 1343.309184 hours left
Loaded: 0.000032 seconds

 709: 31.181372, 21.581610 avg loss, 0.000328 rate, 6.778014 seconds, 22688 images, 1337.946985 hours left
Loaded: 0.000030 seconds

 710: 25.157551, 21.939203 avg loss, 0.000330 rate, 6.454956 seconds, 22720 images, 1333.977548 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.028568 seconds

 711: 18.487349, 21.594017 avg loss, 0.000332 rate, 6.342082 seconds, 22752 images, 1329.599279 hours left
Loaded: 0.000029 seconds

 712: 19.804256, 21.415041 avg loss, 0.000334 rate, 6.437302 seconds, 22784 images, 1325.147691 hours left
Loaded: 0.000030 seconds

 713: 20.282394, 21.301777 avg loss, 0.000336 rate, 6.398039 seconds, 22816 images, 1320.833178 hours left
Loaded: 0.000031 seconds

 714: 11.905465, 20.362146 avg loss, 0.000338 rate, 5.852639 seconds, 22848 images, 1316.507281 hours left
Loaded: 0.000031 seconds

 715: 24.320576, 20.757990 avg loss, 0.000340 rate, 6.934906 seconds, 22880 images, 1311.467452 hours left
Loaded: 0.000042 seconds

 716: 21.451147, 20.827305 avg loss, 0.000342 rate, 6.665126 seconds, 22912 images, 1307.980506 hours left
Loaded: 0.000038 seconds

 717: 20.206808, 20.765255 avg loss, 0.000344 rate, 6.446762 seconds, 22944 images, 1304.153894 hours left
Loaded: 0.000032 seconds

 718: 12.411417, 19.929871 avg loss, 0.000345 rate, 5.738874 seconds, 22976 images, 1300.062383 hours left
Loaded: 0.000033 seconds

 719: 16.672596, 19.604143 avg loss, 0.000347 rate, 6.270512 seconds, 23008 images, 1295.029001 hours left
Loaded: 0.000040 seconds

 720: 21.362801, 19.780008 avg loss, 0.000349 rate, 6.802871 seconds, 23040 images, 1290.784000 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.048549 seconds

 721: 24.212992, 20.223307 avg loss, 0.000351 rate, 12.270374 seconds, 23072 images, 1287.320504 hours left
Loaded: 0.000030 seconds

 722: 25.459492, 20.746925 avg loss, 0.000353 rate, 12.428870 seconds, 23104 images, 1291.549366 hours left
Loaded: 0.000029 seconds

 723: 23.658825, 21.038115 avg loss, 0.000355 rate, 11.939496 seconds, 23136 images, 1295.888584 hours left
Loaded: 0.000046 seconds

 724: 20.142258, 20.948528 avg loss, 0.000357 rate, 11.288825 seconds, 23168 images, 1299.504990 hours left
Loaded: 0.000037 seconds

 725: 22.660505, 21.119726 avg loss, 0.000359 rate, 11.451004 seconds, 23200 images, 1302.181917 hours left
Loaded: 0.000037 seconds

 726: 23.720287, 21.379782 avg loss, 0.000361 rate, 11.678958 seconds, 23232 images, 1305.057179 hours left
Loaded: 0.000033 seconds

 727: 17.659893, 21.007793 avg loss, 0.000363 rate, 10.772658 seconds, 23264 images, 1308.220115 hours left
Loaded: 0.000029 seconds

 728: 20.776999, 20.984715 avg loss, 0.000365 rate, 11.437765 seconds, 23296 images, 1310.093206 hours left
Loaded: 0.000029 seconds

 729: 22.870457, 21.173288 avg loss, 0.000367 rate, 11.558728 seconds, 23328 images, 1312.870869 hours left
Loaded: 0.000028 seconds

 730: 21.218420, 21.177801 avg loss, 0.000369 rate, 11.316387 seconds, 23360 images, 1315.788652 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.282330 seconds - performance bottleneck on CPU or Disk HDD/SSD

 731: 13.262851, 20.386307 avg loss, 0.000371 rate, 8.293521 seconds, 23392 images, 1318.340794 hours left
Loaded: 0.000029 seconds

 732: 18.406395, 20.188316 avg loss, 0.000373 rate, 9.062547 seconds, 23424 images, 1317.062801 hours left
Loaded: 0.000030 seconds

 733: 20.824347, 20.251919 avg loss, 0.000375 rate, 9.287966 seconds, 23456 images, 1316.473258 hours left
Loaded: 0.000030 seconds

 734: 24.524670, 20.679193 avg loss, 0.000377 rate, 9.690593 seconds, 23488 images, 1316.202522 hours left
Loaded: 0.000031 seconds

 735: 28.440878, 21.455362 avg loss, 0.000379 rate, 9.946652 seconds, 23520 images, 1316.493411 hours left
Loaded: 0.000029 seconds

 736: 26.834366, 21.993263 avg loss, 0.000381 rate, 9.788921 seconds, 23552 images, 1317.136835 hours left
Loaded: 0.000024 seconds

 737: 18.715494, 21.665485 avg loss, 0.000384 rate, 8.612092 seconds, 23584 images, 1317.554826 hours left
Loaded: 0.000031 seconds

 738: 21.373831, 21.636320 avg loss, 0.000386 rate, 9.010247 seconds, 23616 images, 1316.334894 hours left
Loaded: 0.000025 seconds

 739: 22.987051, 21.771393 avg loss, 0.000388 rate, 9.149176 seconds, 23648 images, 1315.679877 hours left
Loaded: 0.000028 seconds

 740: 18.132856, 21.407539 avg loss, 0.000390 rate, 8.502949 seconds, 23680 images, 1315.224242 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.025987 seconds

 741: 19.507565, 21.217543 avg loss, 0.000392 rate, 11.563131 seconds, 23712 images, 1313.876035 hours left
Loaded: 0.000028 seconds

 742: 19.961111, 21.091900 avg loss, 0.000394 rate, 11.746044 seconds, 23744 images, 1316.825526 hours left
Loaded: 0.000028 seconds

 743: 21.286003, 21.111311 avg loss, 0.000396 rate, 12.022639 seconds, 23776 images, 1319.963377 hours left
Loaded: 0.000026 seconds

 744: 16.939432, 20.694122 avg loss, 0.000398 rate, 11.215558 seconds, 23808 images, 1323.453791 hours left
Loaded: 0.000029 seconds

 745: 15.775943, 20.202305 avg loss, 0.000400 rate, 11.161412 seconds, 23840 images, 1325.788865 hours left
Loaded: 0.000031 seconds

 746: 12.964977, 19.478573 avg loss, 0.000403 rate, 10.922392 seconds, 23872 images, 1328.025408 hours left
Loaded: 0.000028 seconds

 747: 22.299551, 19.760670 avg loss, 0.000405 rate, 12.206762 seconds, 23904 images, 1329.907736 hours left
Loaded: 0.000030 seconds

 748: 22.525179, 20.037121 avg loss, 0.000407 rate, 12.279333 seconds, 23936 images, 1333.554173 hours left
Loaded: 0.000027 seconds

 749: 23.414860, 20.374895 avg loss, 0.000409 rate, 12.264825 seconds, 23968 images, 1337.264857 hours left
Loaded: 0.000030 seconds

 750: 22.984947, 20.635900 avg loss, 0.000411 rate, 12.165179 seconds, 24000 images, 1340.918254 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.169408 seconds - performance bottleneck on CPU or Disk HDD/SSD

 751: 27.694496, 21.341761 avg loss, 0.000414 rate, 17.135681 seconds, 24032 images, 1344.396761 hours left
Loaded: 0.000031 seconds

 752: 24.523590, 21.659943 avg loss, 0.000416 rate, 16.434803 seconds, 24064 images, 1354.975588 hours left
Loaded: 0.000029 seconds

 753: 19.295444, 21.423492 avg loss, 0.000418 rate, 15.347358 seconds, 24096 images, 1364.240499 hours left
Loaded: 0.000030 seconds

 754: 19.590664, 21.240210 avg loss, 0.000420 rate, 15.175829 seconds, 24128 images, 1371.903138 hours left
Loaded: 0.000027 seconds

 755: 12.143732, 20.330563 avg loss, 0.000422 rate, 14.188680 seconds, 24160 images, 1379.250995 hours left
Loaded: 0.000023 seconds

 756: 20.750784, 20.372585 avg loss, 0.000425 rate, 15.626200 seconds, 24192 images, 1385.154986 hours left
Loaded: 0.000025 seconds

 757: 20.858545, 20.421181 avg loss, 0.000427 rate, 15.705425 seconds, 24224 images, 1392.995425 hours left
Loaded: 0.000032 seconds

 758: 13.600779, 19.739140 avg loss, 0.000429 rate, 14.171665 seconds, 24256 images, 1400.867397 hours left
Loaded: 0.000026 seconds

 759: 21.638496, 19.929075 avg loss, 0.000431 rate, 15.904743 seconds, 24288 images, 1406.531492 hours left
Loaded: 0.000028 seconds

 760: 21.943024, 20.130470 avg loss, 0.000434 rate, 16.079539 seconds, 24320 images, 1414.544705 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.349561 seconds - performance bottleneck on CPU or Disk HDD/SSD

 761: 20.969744, 20.214397 avg loss, 0.000436 rate, 7.441095 seconds, 24352 images, 1422.720391 hours left
Loaded: 0.000033 seconds

 762: 17.168871, 19.909845 avg loss, 0.000438 rate, 6.756920 seconds, 24384 images, 1419.307908 hours left
Loaded: 0.000026 seconds

 763: 20.937439, 20.012606 avg loss, 0.000441 rate, 7.123143 seconds, 24416 images, 1414.494579 hours left
Loaded: 0.000028 seconds

 764: 22.295740, 20.240919 avg loss, 0.000443 rate, 7.052061 seconds, 24448 images, 1410.237731 hours left
Loaded: 0.000027 seconds

 765: 21.589911, 20.375818 avg loss, 0.000445 rate, 6.882790 seconds, 24480 images, 1405.924762 hours left
Loaded: 0.000027 seconds

 766: 21.652651, 20.503502 avg loss, 0.000448 rate, 7.056688 seconds, 24512 images, 1401.419929 hours left
Loaded: 0.000030 seconds

 767: 24.151192, 20.868271 avg loss, 0.000450 rate, 7.506410 seconds, 24544 images, 1397.201522 hours left
Loaded: 0.000029 seconds

 768: 19.813559, 20.762800 avg loss, 0.000452 rate, 6.991226 seconds, 24576 images, 1393.649563 hours left
Loaded: 0.000030 seconds

 769: 16.943781, 20.380898 avg loss, 0.000455 rate, 6.742360 seconds, 24608 images, 1389.417952 hours left
Loaded: 0.000038 seconds

 770: 20.722460, 20.415054 avg loss, 0.000457 rate, 7.093953 seconds, 24640 images, 1384.883177 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000032 seconds

 771: 23.922747, 20.765823 avg loss, 0.000459 rate, 14.575288 seconds, 24672 images, 1380.881802 hours left
Loaded: 0.000028 seconds

 772: 20.831106, 20.772352 avg loss, 0.000462 rate, 14.060612 seconds, 24704 images, 1387.305526 hours left
Loaded: 0.000027 seconds

 773: 20.027365, 20.697853 avg loss, 0.000464 rate, 13.994779 seconds, 24736 images, 1392.950539 hours left
Loaded: 0.000042 seconds

 774: 19.750046, 20.603073 avg loss, 0.000467 rate, 14.104732 seconds, 24768 images, 1398.447666 hours left
Loaded: 0.000033 seconds

 775: 15.894613, 20.132227 avg loss, 0.000469 rate, 13.864877 seconds, 24800 images, 1404.042432 hours left
Loaded: 0.000035 seconds

 776: 14.391275, 19.558132 avg loss, 0.000471 rate, 13.516806 seconds, 24832 images, 1409.248250 hours left
Loaded: 0.000029 seconds

 777: 15.434551, 19.145775 avg loss, 0.000474 rate, 13.831919 seconds, 24864 images, 1413.918809 hours left
Loaded: 0.000031 seconds

 778: 28.132187, 20.044416 avg loss, 0.000476 rate, 16.133078 seconds, 24896 images, 1418.980030 hours left
Loaded: 0.000027 seconds

 779: 24.182821, 20.458258 avg loss, 0.000479 rate, 15.637015 seconds, 24928 images, 1427.184881 hours left
Loaded: 0.000040 seconds

 780: 25.599844, 20.972416 avg loss, 0.000481 rate, 15.629588 seconds, 24960 images, 1434.619040 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.006837 seconds

 781: 14.108739, 20.286049 avg loss, 0.000484 rate, 9.290370 seconds, 24992 images, 1441.968524 hours left
Loaded: 0.000029 seconds

 782: 20.475651, 20.305010 avg loss, 0.000486 rate, 10.193586 seconds, 25024 images, 1440.454383 hours left
Loaded: 0.000029 seconds

 783: 14.191261, 19.693636 avg loss, 0.000489 rate, 9.368501 seconds, 25056 images, 1440.199666 hours left
Loaded: 0.000030 seconds

 784: 22.146772, 19.938950 avg loss, 0.000491 rate, 10.313315 seconds, 25088 images, 1438.802166 hours left
Loaded: 0.000029 seconds

 785: 21.205124, 20.065567 avg loss, 0.000494 rate, 9.882021 seconds, 25120 images, 1438.730113 hours left
Loaded: 0.000038 seconds

 786: 16.180542, 19.677065 avg loss, 0.000496 rate, 9.310606 seconds, 25152 images, 1438.060070 hours left
Loaded: 0.000037 seconds

 787: 17.769436, 19.486301 avg loss, 0.000499 rate, 9.552250 seconds, 25184 images, 1436.603535 hours left
Loaded: 0.000034 seconds

 788: 15.728921, 19.110563 avg loss, 0.000501 rate, 9.552711 seconds, 25216 images, 1435.496965 hours left
Loaded: 0.000029 seconds

 789: 25.609383, 19.760445 avg loss, 0.000504 rate, 10.556109 seconds, 25248 images, 1434.402068 hours left
Loaded: 0.000029 seconds

 790: 23.480656, 20.132465 avg loss, 0.000506 rate, 10.616243 seconds, 25280 images, 1434.710890 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.532560 seconds - performance bottleneck on CPU or Disk HDD/SSD

 791: 22.129854, 20.332205 avg loss, 0.000509 rate, 10.126044 seconds, 25312 images, 1435.100066 hours left
Loaded: 0.000033 seconds

 792: 20.672066, 20.366192 avg loss, 0.000511 rate, 9.665156 seconds, 25344 images, 1435.544080 hours left
Loaded: 0.000027 seconds

 793: 22.791466, 20.608719 avg loss, 0.000514 rate, 9.849858 seconds, 25376 images, 1434.604686 hours left
Loaded: 0.000026 seconds

 794: 16.720655, 20.219913 avg loss, 0.000517 rate, 10.112742 seconds, 25408 images, 1433.931031 hours left
Loaded: 0.000034 seconds

 795: 28.278635, 21.025785 avg loss, 0.000519 rate, 11.354578 seconds, 25440 images, 1433.628988 hours left
Loaded: 0.000031 seconds

 796: 21.726088, 21.095816 avg loss, 0.000522 rate, 10.393510 seconds, 25472 images, 1435.053703 hours left
Loaded: 0.000038 seconds

 797: 20.687326, 21.054966 avg loss, 0.000525 rate, 10.322564 seconds, 25504 images, 1435.130108 hours left
Loaded: 0.000038 seconds

 798: 21.082434, 21.057713 avg loss, 0.000527 rate, 10.489936 seconds, 25536 images, 1435.107253 hours left
Loaded: 0.000037 seconds

 799: 19.763666, 20.928308 avg loss, 0.000530 rate, 10.422458 seconds, 25568 images, 1435.316919 hours left
Loaded: 0.000030 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 800: 20.384153, 20.873894 avg loss, 0.000532 rate, 10.591675 seconds, 25600 images, 1435.430795 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.043209 seconds

 801: 24.276876, 21.214191 avg loss, 0.000535 rate, 13.463938 seconds, 25632 images, 1435.778388 hours left
Loaded: 0.000034 seconds

 802: 14.633767, 20.556149 avg loss, 0.000538 rate, 12.352802 seconds, 25664 images, 1440.169251 hours left
Loaded: 0.000030 seconds

 803: 13.454405, 19.845974 avg loss, 0.000541 rate, 12.901159 seconds, 25696 images, 1442.913928 hours left
Loaded: 0.000029 seconds

 804: 21.172091, 19.978586 avg loss, 0.000543 rate, 13.512711 seconds, 25728 images, 1446.392263 hours left
Loaded: 0.000028 seconds

 805: 21.615993, 20.142326 avg loss, 0.000546 rate, 13.286778 seconds, 25760 images, 1450.684638 hours left
Loaded: 0.000023 seconds

 806: 19.980371, 20.126131 avg loss, 0.000549 rate, 13.314048 seconds, 25792 images, 1454.620445 hours left
Loaded: 0.000027 seconds

 807: 17.252872, 19.838806 avg loss, 0.000551 rate, 12.687178 seconds, 25824 images, 1458.554701 hours left
Loaded: 0.000031 seconds

 808: 20.004662, 19.855392 avg loss, 0.000554 rate, 13.628085 seconds, 25856 images, 1461.579467 hours left
Loaded: 0.000029 seconds

 809: 17.455435, 19.615396 avg loss, 0.000557 rate, 12.869808 seconds, 25888 images, 1465.879967 hours left
Loaded: 0.000027 seconds

 810: 21.204573, 19.774315 avg loss, 0.000560 rate, 13.593035 seconds, 25920 images, 1469.084909 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.525018 seconds - performance bottleneck on CPU or Disk HDD/SSD

 811: 25.477255, 20.344608 avg loss, 0.000562 rate, 8.308440 seconds, 25952 images, 1473.261622 hours left
Loaded: 0.000028 seconds

 812: 15.105633, 19.820711 avg loss, 0.000565 rate, 7.139161 seconds, 25984 images, 1470.790079 hours left
Loaded: 0.000026 seconds

 813: 20.170307, 19.855671 avg loss, 0.000568 rate, 8.108748 seconds, 26016 images, 1465.991545 hours left
Loaded: 0.000034 seconds

 814: 30.187456, 20.888849 avg loss, 0.000571 rate, 8.371456 seconds, 26048 images, 1462.586776 hours left
Loaded: 0.000026 seconds

 815: 19.221085, 20.722073 avg loss, 0.000574 rate, 7.397261 seconds, 26080 images, 1459.580689 hours left
Loaded: 0.000025 seconds

 816: 17.572760, 20.407141 avg loss, 0.000576 rate, 7.369054 seconds, 26112 images, 1455.252430 hours left
Loaded: 0.000034 seconds

 817: 18.425161, 20.208942 avg loss, 0.000579 rate, 7.406538 seconds, 26144 images, 1450.928282 hours left
Loaded: 0.000048 seconds

 818: 22.320356, 20.420084 avg loss, 0.000582 rate, 7.920190 seconds, 26176 images, 1446.699393 hours left
Loaded: 0.000034 seconds

 819: 19.969345, 20.375010 avg loss, 0.000585 rate, 7.770391 seconds, 26208 images, 1443.225746 hours left
Loaded: 0.000033 seconds

 820: 14.768103, 19.814320 avg loss, 0.000588 rate, 7.295868 seconds, 26240 images, 1439.578871 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 821: 22.626320, 20.095520 avg loss, 0.000591 rate, 9.181539 seconds, 26272 images, 1435.309804 hours left
Loaded: 0.000026 seconds

 822: 17.128471, 19.798815 avg loss, 0.000594 rate, 9.193204 seconds, 26304 images, 1433.700706 hours left
Loaded: 0.000034 seconds

 823: 22.246017, 20.043535 avg loss, 0.000596 rate, 9.618704 seconds, 26336 images, 1432.123865 hours left
Loaded: 0.000030 seconds

 824: 19.336699, 19.972851 avg loss, 0.000599 rate, 9.097548 seconds, 26368 images, 1431.153369 hours left
Loaded: 0.000033 seconds

 825: 13.944404, 19.370007 avg loss, 0.000602 rate, 8.442437 seconds, 26400 images, 1429.469186 hours left
Loaded: 0.000036 seconds

 826: 19.095444, 19.342550 avg loss, 0.000605 rate, 9.076836 seconds, 26432 images, 1426.892539 hours left
Loaded: 0.000030 seconds

 827: 17.137836, 19.122078 avg loss, 0.000608 rate, 8.524799 seconds, 26464 images, 1425.222175 hours left
Loaded: 0.000028 seconds

 828: 17.068628, 18.916733 avg loss, 0.000611 rate, 8.531495 seconds, 26496 images, 1422.802262 hours left
Loaded: 0.000029 seconds

 829: 22.409529, 19.266012 avg loss, 0.000614 rate, 9.045451 seconds, 26528 images, 1420.415832 hours left
Loaded: 0.000030 seconds

 830: 26.837778, 20.023190 avg loss, 0.000617 rate, 9.775785 seconds, 26560 images, 1418.766587 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.000030 seconds

 831: 14.871224, 19.507994 avg loss, 0.000620 rate, 9.126561 seconds, 26592 images, 1418.147495 hours left
Loaded: 0.000030 seconds

 832: 19.080765, 19.465271 avg loss, 0.000623 rate, 9.749100 seconds, 26624 images, 1416.633464 hours left
Loaded: 0.000029 seconds

 833: 24.108742, 19.929619 avg loss, 0.000626 rate, 10.321527 seconds, 26656 images, 1415.998609 hours left
Loaded: 0.000037 seconds

 834: 22.139301, 20.150587 avg loss, 0.000629 rate, 10.308764 seconds, 26688 images, 1416.164584 hours left
Loaded: 0.000034 seconds

 835: 14.007354, 19.536264 avg loss, 0.000632 rate, 9.758112 seconds, 26720 images, 1416.311168 hours left
Loaded: 0.000029 seconds

 836: 22.882574, 19.870895 avg loss, 0.000635 rate, 10.716659 seconds, 26752 images, 1415.691970 hours left
Loaded: 0.000040 seconds

 837: 21.358232, 20.019629 avg loss, 0.000638 rate, 10.459041 seconds, 26784 images, 1416.409351 hours left
Loaded: 0.000039 seconds

 838: 19.316862, 19.949352 avg loss, 0.000641 rate, 10.365457 seconds, 26816 images, 1416.761984 hours left
Loaded: 0.000040 seconds

 839: 24.069124, 20.361330 avg loss, 0.000644 rate, 10.988690 seconds, 26848 images, 1416.981169 hours left
Loaded: 0.000040 seconds

 840: 19.947041, 20.319901 avg loss, 0.000647 rate, 10.389562 seconds, 26880 images, 1418.063150 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 841: 15.347062, 19.822617 avg loss, 0.000650 rate, 13.773614 seconds, 26912 images, 1418.302724 hours left
Loaded: 0.000029 seconds

 842: 25.157955, 20.356150 avg loss, 0.000653 rate, 14.813275 seconds, 26944 images, 1423.236717 hours left
Loaded: 0.000025 seconds

 843: 24.887831, 20.809319 avg loss, 0.000657 rate, 15.044892 seconds, 26976 images, 1429.564325 hours left
Loaded: 0.000032 seconds

 844: 19.021679, 20.630554 avg loss, 0.000660 rate, 14.144078 seconds, 27008 images, 1436.150077 hours left
Loaded: 0.000029 seconds

 845: 29.235233, 21.491022 avg loss, 0.000663 rate, 16.879069 seconds, 27040 images, 1441.419672 hours left
Loaded: 0.000032 seconds

 846: 24.291006, 21.771021 avg loss, 0.000666 rate, 15.787541 seconds, 27072 images, 1450.432506 hours left
Loaded: 0.000036 seconds

 847: 23.454275, 21.939346 avg loss, 0.000669 rate, 15.437990 seconds, 27104 images, 1457.840208 hours left
Loaded: 0.000041 seconds

 848: 22.320463, 21.977459 avg loss, 0.000672 rate, 15.460120 seconds, 27136 images, 1464.688642 hours left
Loaded: 0.000034 seconds

 849: 23.529827, 22.132696 avg loss, 0.000675 rate, 15.325756 seconds, 27168 images, 1471.499270 hours left
Loaded: 0.000036 seconds

 850: 21.346373, 22.054064 avg loss, 0.000679 rate, 15.155152 seconds, 27200 images, 1478.055254 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.531711 seconds - performance bottleneck on CPU or Disk HDD/SSD

 851: 17.149239, 21.563581 avg loss, 0.000682 rate, 12.543709 seconds, 27232 images, 1484.308855 hours left
Loaded: 0.000030 seconds

 852: 21.078764, 21.515100 avg loss, 0.000685 rate, 12.802523 seconds, 27264 images, 1487.613337 hours left
Loaded: 0.000026 seconds

 853: 20.138277, 21.377419 avg loss, 0.000688 rate, 12.685892 seconds, 27296 images, 1490.506022 hours left
Loaded: 0.000029 seconds

 854: 19.705730, 21.210249 avg loss, 0.000691 rate, 12.838501 seconds, 27328 images, 1493.207865 hours left
Loaded: 0.000034 seconds

 855: 27.049492, 21.794174 avg loss, 0.000695 rate, 14.570797 seconds, 27360 images, 1496.094465 hours left
Loaded: 0.000029 seconds

 856: 17.409800, 21.355736 avg loss, 0.000698 rate, 12.941651 seconds, 27392 images, 1501.356429 hours left
Loaded: 0.000028 seconds

 857: 19.589226, 21.179085 avg loss, 0.000701 rate, 13.353188 seconds, 27424 images, 1504.304637 hours left
Loaded: 0.000031 seconds

 858: 16.074120, 20.668589 avg loss, 0.000705 rate, 12.630344 seconds, 27456 images, 1507.794495 hours left
Loaded: 0.000026 seconds

 859: 18.564577, 20.458187 avg loss, 0.000708 rate, 13.319666 seconds, 27488 images, 1510.246191 hours left
Loaded: 0.000032 seconds

 860: 16.397312, 20.052099 avg loss, 0.000711 rate, 12.826798 seconds, 27520 images, 1513.630033 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.363598 seconds - performance bottleneck on CPU or Disk HDD/SSD

 861: 23.146191, 20.361507 avg loss, 0.000714 rate, 6.337023 seconds, 27552 images, 1516.295961 hours left
Loaded: 0.000026 seconds

 862: 22.038692, 20.529226 avg loss, 0.000718 rate, 6.281081 seconds, 27584 images, 1510.432713 hours left
Loaded: 0.000028 seconds

 863: 23.227549, 20.799059 avg loss, 0.000721 rate, 6.355386 seconds, 27616 images, 1504.045842 hours left
Loaded: 0.000028 seconds

 864: 23.416603, 21.060814 avg loss, 0.000724 rate, 6.121914 seconds, 27648 images, 1497.825951 hours left
Loaded: 0.000035 seconds

 865: 12.467876, 20.201521 avg loss, 0.000728 rate, 5.492820 seconds, 27680 images, 1491.344212 hours left
Loaded: 0.000036 seconds

 866: 22.864429, 20.467812 avg loss, 0.000731 rate, 6.299447 seconds, 27712 images, 1484.054178 hours left
Loaded: 0.000030 seconds

 867: 17.504118, 20.171442 avg loss, 0.000735 rate, 5.946397 seconds, 27744 images, 1477.956526 hours left
Loaded: 0.000032 seconds

 868: 18.153227, 19.969620 avg loss, 0.000738 rate, 6.107189 seconds, 27776 images, 1471.429839 hours left
Loaded: 0.000037 seconds

 869: 26.060894, 20.578747 avg loss, 0.000741 rate, 6.678582 seconds, 27808 images, 1465.191563 hours left
Loaded: 0.000029 seconds

 870: 14.263100, 19.947182 avg loss, 0.000745 rate, 5.794225 seconds, 27840 images, 1459.808674 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000029 seconds

 871: 24.619976, 20.414461 avg loss, 0.000748 rate, 14.029501 seconds, 27872 images, 1453.252221 hours left
Loaded: 0.000034 seconds

 872: 19.995304, 20.372545 avg loss, 0.000752 rate, 13.124350 seconds, 27904 images, 1458.190712 hours left
Loaded: 0.000030 seconds

 873: 20.582811, 20.393572 avg loss, 0.000755 rate, 13.529637 seconds, 27936 images, 1461.823568 hours left
Loaded: 0.000038 seconds

 874: 23.341311, 20.688345 avg loss, 0.000759 rate, 13.501118 seconds, 27968 images, 1465.982533 hours left
Loaded: 0.000028 seconds

 875: 21.695425, 20.789053 avg loss, 0.000762 rate, 12.845451 seconds, 28000 images, 1470.060300 hours left
Loaded: 0.000029 seconds

 876: 26.092718, 21.319420 avg loss, 0.000766 rate, 13.759522 seconds, 28032 images, 1473.187274 hours left
Loaded: 0.000037 seconds

 877: 20.181011, 21.205580 avg loss, 0.000769 rate, 12.544415 seconds, 28064 images, 1477.551533 hours left
Loaded: 0.000036 seconds

 878: 14.148540, 20.499876 avg loss, 0.000773 rate, 11.497417 seconds, 28096 images, 1480.185744 hours left
Loaded: 0.000038 seconds

 879: 22.318392, 20.681728 avg loss, 0.000776 rate, 11.762682 seconds, 28128 images, 1481.340513 hours left
Loaded: 0.000034 seconds

 880: 24.378078, 21.051363 avg loss, 0.000780 rate, 12.300976 seconds, 28160 images, 1482.851848 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.611326 seconds - performance bottleneck on CPU or Disk HDD/SSD

 881: 23.278027, 21.274029 avg loss, 0.000783 rate, 12.614056 seconds, 28192 images, 1485.095094 hours left
Loaded: 0.000029 seconds

 882: 17.754652, 20.922091 avg loss, 0.000787 rate, 11.712154 seconds, 28224 images, 1488.598747 hours left
Loaded: 0.000035 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 883: 22.853781, 21.115259 avg loss, 0.000790 rate, 12.613242 seconds, 28256 images, 1489.967266 hours left
Loaded: 0.000030 seconds

 884: 18.013569, 20.805090 avg loss, 0.000794 rate, 11.702110 seconds, 28288 images, 1492.572647 hours left
Loaded: 0.000026 seconds

 885: 15.364875, 20.261068 avg loss, 0.000797 rate, 11.107124 seconds, 28320 images, 1493.887422 hours left
Loaded: 0.000028 seconds

 886: 28.299772, 21.064939 avg loss, 0.000801 rate, 12.889686 seconds, 28352 images, 1494.363279 hours left
Loaded: 0.000026 seconds

 887: 13.408792, 20.299324 avg loss, 0.000805 rate, 10.796492 seconds, 28384 images, 1497.308221 hours left
Loaded: 0.000022 seconds

 888: 12.983047, 19.567696 avg loss, 0.000808 rate, 10.960411 seconds, 28416 images, 1497.318710 hours left
Loaded: 0.000034 seconds

 889: 26.624878, 20.273415 avg loss, 0.000812 rate, 12.981589 seconds, 28448 images, 1497.556546 hours left
Loaded: 0.000040 seconds

 890: 15.515303, 19.797604 avg loss, 0.000816 rate, 11.467987 seconds, 28480 images, 1500.596996 hours left
Resizing, random_coef = 1.40 

 384 x 384 
 try to allocate additional workspace_size = 42.47 MB 
 CUDA allocate done! 
Loaded: 0.243499 seconds - performance bottleneck on CPU or Disk HDD/SSD

 891: 16.787525, 19.496595 avg loss, 0.000819 rate, 4.706495 seconds, 28512 images, 1501.506430 hours left
Loaded: 0.000029 seconds

 892: 17.298046, 19.276741 avg loss, 0.000823 rate, 4.880829 seconds, 28544 images, 1493.360994 hours left
Loaded: 0.000032 seconds

 893: 21.583242, 19.507391 avg loss, 0.000827 rate, 5.113026 seconds, 28576 images, 1485.201053 hours left
Loaded: 0.000037 seconds

 894: 19.686739, 19.525326 avg loss, 0.000830 rate, 4.870373 seconds, 28608 images, 1477.444943 hours left
Loaded: 0.000037 seconds

 895: 22.531616, 19.825954 avg loss, 0.000834 rate, 4.853712 seconds, 28640 images, 1469.429634 hours left
Loaded: 0.000037 seconds

 896: 23.093975, 20.152756 avg loss, 0.000838 rate, 4.884029 seconds, 28672 images, 1461.471343 hours left
Loaded: 0.000031 seconds

 897: 23.302448, 20.467726 avg loss, 0.000842 rate, 4.806285 seconds, 28704 images, 1453.634694 hours left
Loaded: 0.000029 seconds

 898: 18.769735, 20.297926 avg loss, 0.000845 rate, 4.598743 seconds, 28736 images, 1445.768500 hours left
Loaded: 0.000036 seconds

 899: 22.528423, 20.520975 avg loss, 0.000849 rate, 4.769043 seconds, 28768 images, 1437.692926 hours left
Loaded: 0.000034 seconds

 900: 26.016195, 21.070498 avg loss, 0.000853 rate, 4.811124 seconds, 28800 images, 1429.934445 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 901: 20.241470, 20.987595 avg loss, 0.000857 rate, 12.963114 seconds, 28832 images, 1422.311931 hours left
Loaded: 0.000031 seconds

 902: 21.374355, 21.026270 avg loss, 0.000861 rate, 13.259597 seconds, 28864 images, 1426.078748 hours left
Loaded: 0.000032 seconds

 903: 18.813917, 20.805035 avg loss, 0.000864 rate, 12.647234 seconds, 28896 images, 1430.219319 hours left
Loaded: 0.000030 seconds

 904: 16.821779, 20.406710 avg loss, 0.000868 rate, 12.478773 seconds, 28928 images, 1433.468630 hours left
Loaded: 0.000029 seconds

 905: 26.064190, 20.972458 avg loss, 0.000872 rate, 13.550438 seconds, 28960 images, 1436.451626 hours left
Loaded: 0.000041 seconds

 906: 17.877480, 20.662960 avg loss, 0.000876 rate, 12.594331 seconds, 28992 images, 1440.891973 hours left
Loaded: 0.000039 seconds

 907: 22.982170, 20.894880 avg loss, 0.000880 rate, 13.301313 seconds, 29024 images, 1443.961048 hours left
Loaded: 0.000029 seconds

 908: 26.892506, 21.494642 avg loss, 0.000884 rate, 13.604111 seconds, 29056 images, 1447.980513 hours left
Loaded: 0.000029 seconds

 909: 14.480137, 20.793192 avg loss, 0.000888 rate, 12.009502 seconds, 29088 images, 1452.379943 hours left
Loaded: 0.000029 seconds

 910: 23.526937, 21.066566 avg loss, 0.000891 rate, 13.304121 seconds, 29120 images, 1454.522417 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.288571 seconds - performance bottleneck on CPU or Disk HDD/SSD

 911: 18.635155, 20.823425 avg loss, 0.000895 rate, 8.378002 seconds, 29152 images, 1458.440043 hours left
Loaded: 0.000031 seconds

 912: 19.711702, 20.712254 avg loss, 0.000899 rate, 8.373090 seconds, 29184 images, 1455.882669 hours left
Loaded: 0.000031 seconds

 913: 20.135372, 20.654566 avg loss, 0.000903 rate, 8.579298 seconds, 29216 images, 1452.943608 hours left
Loaded: 0.000025 seconds

 914: 27.803429, 21.369452 avg loss, 0.000907 rate, 9.058883 seconds, 29248 images, 1450.320077 hours left
Loaded: 0.000029 seconds

 915: 19.026121, 21.135118 avg loss, 0.000911 rate, 8.534713 seconds, 29280 images, 1448.388287 hours left
Loaded: 0.000030 seconds

 916: 30.869457, 22.108553 avg loss, 0.000915 rate, 9.737187 seconds, 29312 images, 1445.748388 hours left
Loaded: 0.000029 seconds

 917: 16.593523, 21.557051 avg loss, 0.000919 rate, 8.315611 seconds, 29344 images, 1444.803578 hours left
Loaded: 0.000026 seconds

 918: 15.412015, 20.942547 avg loss, 0.000923 rate, 8.043224 seconds, 29376 images, 1441.895424 hours left
Loaded: 0.000030 seconds

 919: 16.236729, 20.471966 avg loss, 0.000927 rate, 8.331968 seconds, 29408 images, 1438.638324 hours left
Loaded: 0.000031 seconds

 920: 25.364620, 20.961231 avg loss, 0.000931 rate, 9.738216 seconds, 29440 images, 1435.814475 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 921: 18.304729, 20.695581 avg loss, 0.000935 rate, 13.073875 seconds, 29472 images, 1434.970327 hours left
Loaded: 0.000032 seconds

 922: 26.531670, 21.279190 avg loss, 0.000939 rate, 14.136375 seconds, 29504 images, 1438.763546 hours left
Loaded: 0.000031 seconds

 923: 13.741760, 20.525448 avg loss, 0.000944 rate, 12.497619 seconds, 29536 images, 1443.993253 hours left
Loaded: 0.000033 seconds

 924: 24.301754, 20.903078 avg loss, 0.000948 rate, 14.663120 seconds, 29568 images, 1446.896498 hours left
Loaded: 0.000037 seconds

 925: 15.330237, 20.345795 avg loss, 0.000952 rate, 12.741079 seconds, 29600 images, 1452.775766 hours left
Loaded: 0.000040 seconds

 926: 14.772700, 19.788485 avg loss, 0.000956 rate, 12.725419 seconds, 29632 images, 1455.928975 hours left
Loaded: 0.000035 seconds

 927: 18.482588, 19.657894 avg loss, 0.000960 rate, 13.712908 seconds, 29664 images, 1459.028890 hours left
Loaded: 0.000035 seconds

 928: 15.363453, 19.228451 avg loss, 0.000964 rate, 12.762046 seconds, 29696 images, 1463.468103 hours left
Loaded: 0.000031 seconds

 929: 20.828131, 19.388418 avg loss, 0.000968 rate, 13.262401 seconds, 29728 images, 1466.543376 hours left
Loaded: 0.000027 seconds

 930: 21.940176, 19.643595 avg loss, 0.000972 rate, 13.228286 seconds, 29760 images, 1470.282195 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.693382 seconds - performance bottleneck on CPU or Disk HDD/SSD

 931: 17.587898, 19.438025 avg loss, 0.000977 rate, 12.673164 seconds, 29792 images, 1473.936242 hours left
Loaded: 0.000034 seconds

 932: 21.278494, 19.622072 avg loss, 0.000981 rate, 13.158291 seconds, 29824 images, 1477.745537 hours left
Loaded: 0.000046 seconds

 933: 19.305746, 19.590439 avg loss, 0.000985 rate, 12.748222 seconds, 29856 images, 1481.227755 hours left
Loaded: 0.000030 seconds

 934: 10.630334, 18.694427 avg loss, 0.000989 rate, 11.994001 seconds, 29888 images, 1484.106086 hours left
Loaded: 0.000030 seconds

 935: 21.126318, 18.937616 avg loss, 0.000994 rate, 13.530860 seconds, 29920 images, 1485.908956 hours left
Loaded: 0.000032 seconds

 936: 24.217514, 19.465607 avg loss, 0.000998 rate, 13.924546 seconds, 29952 images, 1489.826434 hours left
Loaded: 0.000031 seconds

 937: 27.121307, 20.231176 avg loss, 0.001002 rate, 14.512841 seconds, 29984 images, 1494.251012 hours left
Loaded: 0.000030 seconds

 938: 23.950064, 20.603065 avg loss, 0.001006 rate, 13.763855 seconds, 30016 images, 1499.447666 hours left
Loaded: 0.000030 seconds

 939: 17.557243, 20.298483 avg loss, 0.001011 rate, 12.944654 seconds, 30048 images, 1503.552965 hours left
Loaded: 0.000029 seconds

 940: 23.413300, 20.609964 avg loss, 0.001015 rate, 13.814077 seconds, 30080 images, 1506.480391 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.475780 seconds - performance bottleneck on CPU or Disk HDD/SSD

 941: 17.828802, 20.331848 avg loss, 0.001019 rate, 11.403904 seconds, 30112 images, 1510.584977 hours left
Loaded: 0.000027 seconds

 942: 22.704212, 20.569084 avg loss, 0.001024 rate, 12.099091 seconds, 30144 images, 1511.964149 hours left
Loaded: 0.000032 seconds

 943: 18.252272, 20.337402 avg loss, 0.001028 rate, 11.764930 seconds, 30176 images, 1513.633995 hours left
Loaded: 0.000040 seconds

 944: 22.980314, 20.601694 avg loss, 0.001032 rate, 12.298943 seconds, 30208 images, 1514.823415 hours left
Loaded: 0.000034 seconds

 945: 30.834810, 21.625006 avg loss, 0.001037 rate, 13.865096 seconds, 30240 images, 1516.741945 hours left
Loaded: 0.000040 seconds

 946: 17.800060, 21.242512 avg loss, 0.001041 rate, 11.662014 seconds, 30272 images, 1520.814526 hours left
Loaded: 0.000037 seconds

 947: 14.635858, 20.581846 avg loss, 0.001046 rate, 11.211588 seconds, 30304 images, 1521.789244 hours left
Loaded: 0.000036 seconds

 948: 13.837490, 19.907410 avg loss, 0.001050 rate, 11.194392 seconds, 30336 images, 1522.129145 hours left
Loaded: 0.000027 seconds

 949: 28.033707, 20.720039 avg loss, 0.001054 rate, 12.811204 seconds, 30368 images, 1522.441752 hours left
Loaded: 0.000028 seconds

 950: 22.925022, 20.940538 avg loss, 0.001059 rate, 12.105908 seconds, 30400 images, 1524.994746 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.439420 seconds - performance bottleneck on CPU or Disk HDD/SSD

 951: 30.395485, 21.886034 avg loss, 0.001063 rate, 7.199850 seconds, 30432 images, 1526.543478 hours left
Loaded: 0.000038 seconds

 952: 16.524876, 21.349918 avg loss, 0.001068 rate, 6.124628 seconds, 30464 images, 1521.878584 hours left
Loaded: 0.000032 seconds

 953: 21.243464, 21.339273 avg loss, 0.001072 rate, 6.011161 seconds, 30496 images, 1515.158602 hours left
Loaded: 0.000026 seconds

 954: 22.752901, 21.480637 avg loss, 0.001077 rate, 6.132613 seconds, 30528 images, 1508.348344 hours left
Loaded: 0.000028 seconds

 955: 19.928686, 21.325441 avg loss, 0.001081 rate, 5.952913 seconds, 30560 images, 1501.774693 hours left
Loaded: 0.000036 seconds

 956: 14.655037, 20.658401 avg loss, 0.001086 rate, 5.812864 seconds, 30592 images, 1495.017409 hours left
Loaded: 0.000030 seconds

 957: 22.842129, 20.876774 avg loss, 0.001090 rate, 6.440132 seconds, 30624 images, 1488.133359 hours left
Loaded: 0.000032 seconds

 958: 25.398670, 21.328964 avg loss, 0.001095 rate, 6.676129 seconds, 30656 images, 1482.188533 hours left
Loaded: 0.000036 seconds

 959: 20.304800, 21.226547 avg loss, 0.001100 rate, 6.168508 seconds, 30688 images, 1476.630614 hours left
Loaded: 0.000040 seconds

 960: 21.564594, 21.260351 avg loss, 0.001104 rate, 6.527600 seconds, 30720 images, 1470.423877 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.435524 seconds - performance bottleneck on CPU or Disk HDD/SSD

 961: 28.449677, 21.979284 avg loss, 0.001109 rate, 7.156851 seconds, 30752 images, 1464.777477 hours left
Loaded: 0.000030 seconds

 962: 24.262980, 22.207653 avg loss, 0.001113 rate, 6.456485 seconds, 30784 images, 1460.664959 hours left
Loaded: 0.000030 seconds

 963: 19.453991, 21.932287 avg loss, 0.001118 rate, 5.995265 seconds, 30816 images, 1455.017420 hours left
Loaded: 0.000031 seconds

 964: 15.544712, 21.293530 avg loss, 0.001123 rate, 5.857124 seconds, 30848 images, 1448.786347 hours left
Loaded: 0.000030 seconds

 965: 27.366404, 21.900818 avg loss, 0.001127 rate, 6.728173 seconds, 30880 images, 1442.425885 hours left
Loaded: 0.000038 seconds

 966: 24.087074, 22.119444 avg loss, 0.001132 rate, 6.649860 seconds, 30912 images, 1437.337687 hours left
Loaded: 0.000038 seconds

 967: 20.342585, 21.941757 avg loss, 0.001137 rate, 6.418184 seconds, 30944 images, 1432.191685 hours left
Loaded: 0.000038 seconds

 968: 17.882545, 21.535835 avg loss, 0.001141 rate, 6.347062 seconds, 30976 images, 1426.775653 hours left
Loaded: 0.000037 seconds

 969: 20.902571, 21.472509 avg loss, 0.001146 rate, 6.593609 seconds, 31008 images, 1421.315076 hours left
Loaded: 0.000035 seconds

 970: 23.063002, 21.631559 avg loss, 0.001151 rate, 6.579713 seconds, 31040 images, 1416.251191 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000030 seconds

 971: 14.633095, 20.931713 avg loss, 0.001156 rate, 12.777160 seconds, 31072 images, 1411.218640 hours left
Loaded: 0.000023 seconds

 972: 17.935135, 20.632055 avg loss, 0.001160 rate, 13.103296 seconds, 31104 images, 1414.835849 hours left
Loaded: 0.000040 seconds

 973: 22.934488, 20.862299 avg loss, 0.001165 rate, 13.762510 seconds, 31136 images, 1418.869379 hours left
Loaded: 0.000037 seconds

 974: 18.825626, 20.658632 avg loss, 0.001170 rate, 13.107134 seconds, 31168 images, 1423.777268 hours left
Loaded: 0.000023 seconds

 975: 23.007149, 20.893484 avg loss, 0.001175 rate, 13.865106 seconds, 31200 images, 1427.726656 hours left
Loaded: 0.000024 seconds

 976: 21.799021, 20.984037 avg loss, 0.001180 rate, 13.679685 seconds, 31232 images, 1432.688235 hours left
Loaded: 0.000037 seconds

 977: 31.742601, 22.059895 avg loss, 0.001184 rate, 15.016731 seconds, 31264 images, 1437.342875 hours left
Loaded: 0.000032 seconds

 978: 14.914025, 21.345308 avg loss, 0.001189 rate, 12.552138 seconds, 31296 images, 1443.806185 hours left
Loaded: 0.000030 seconds

 979: 25.825745, 21.793352 avg loss, 0.001194 rate, 14.666008 seconds, 31328 images, 1446.785040 hours left
Loaded: 0.000029 seconds

 980: 29.064491, 22.520466 avg loss, 0.001199 rate, 15.227066 seconds, 31360 images, 1452.667187 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.436312 seconds - performance bottleneck on CPU or Disk HDD/SSD

 981: 25.371073, 22.805527 avg loss, 0.001204 rate, 10.750014 seconds, 31392 images, 1459.268970 hours left
Loaded: 0.000030 seconds

 982: 26.813385, 23.206312 avg loss, 0.001209 rate, 10.818090 seconds, 31424 images, 1460.197912 hours left
Loaded: 0.000031 seconds

 983: 22.669762, 23.152657 avg loss, 0.001214 rate, 10.290208 seconds, 31456 images, 1460.606630 hours left
Loaded: 0.000031 seconds

 984: 26.764568, 23.513847 avg loss, 0.001219 rate, 10.430685 seconds, 31488 images, 1460.278771 hours left
Loaded: 0.000039 seconds

 985: 20.018961, 23.164358 avg loss, 0.001224 rate, 9.773406 seconds, 31520 images, 1460.149081 hours left
Loaded: 0.000040 seconds

 986: 19.897373, 22.837660 avg loss, 0.001229 rate, 9.385087 seconds, 31552 images, 1459.108667 hours left
Loaded: 0.000037 seconds

 987: 15.325817, 22.086475 avg loss, 0.001234 rate, 9.087950 seconds, 31584 images, 1457.539823 hours left
Loaded: 0.000031 seconds

 988: 21.328880, 22.010715 avg loss, 0.001239 rate, 9.315948 seconds, 31616 images, 1455.574351 hours left
Loaded: 0.000033 seconds

 989: 18.478413, 21.657486 avg loss, 0.001244 rate, 9.131710 seconds, 31648 images, 1453.944851 hours left
Loaded: 0.000035 seconds

 990: 19.243191, 21.416056 avg loss, 0.001249 rate, 9.177942 seconds, 31680 images, 1452.075987 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.004309 seconds

 991: 17.920311, 21.066481 avg loss, 0.001254 rate, 8.432354 seconds, 31712 images, 1450.289937 hours left
Loaded: 0.000030 seconds

 992: 16.671503, 20.626984 avg loss, 0.001259 rate, 8.534806 seconds, 31744 images, 1447.493132 hours left
Loaded: 0.000031 seconds

Saving weights to /darknet/myweights/backup//yolov4_1000.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
 993: 18.468353, 20.411121 avg loss, 0.001264 rate, 8.796625 seconds, 31776 images, 1444.860488 hours left
Loaded: 0.000031 seconds

 994: 21.304680, 20.500477 avg loss, 0.001269 rate, 8.958502 seconds, 31808 images, 1442.617442 hours left
Loaded: 0.000043 seconds

 995: 17.702246, 20.220654 avg loss, 0.001274 rate, 8.360824 seconds, 31840 images, 1440.621394 hours left
Loaded: 0.000028 seconds

 996: 19.609121, 20.159500 avg loss, 0.001279 rate, 8.665720 seconds, 31872 images, 1437.816011 hours left
Loaded: 0.000029 seconds

 997: 18.451019, 19.988651 avg loss, 0.001284 rate, 8.786110 seconds, 31904 images, 1435.461685 hours left
Loaded: 0.000034 seconds

 998: 22.397436, 20.229530 avg loss, 0.001290 rate, 9.363710 seconds, 31936 images, 1433.297920 hours left
Loaded: 0.000031 seconds

 999: 18.535135, 20.060091 avg loss, 0.001295 rate, 9.174160 seconds, 31968 images, 1431.957203 hours left
Loaded: 0.000028 seconds

 1000: 22.228460, 20.276928 avg loss, 0.001300 rate, 9.511372 seconds, 32000 images, 1430.366860 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.088049 seconds

 1001: 24.910854, 20.740320 avg loss, 0.001300 rate, 17.061863 seconds, 32032 images, 1429.260271 hours left
Loaded: 0.000030 seconds

 1002: 25.839275, 21.250216 avg loss, 0.001300 rate, 16.715763 seconds, 32064 images, 1438.763138 hours left
Loaded: 0.000037 seconds

 1003: 16.039639, 20.729158 avg loss, 0.001300 rate, 14.960590 seconds, 32096 images, 1447.568591 hours left
Loaded: 0.000031 seconds

 1004: 18.789402, 20.535183 avg loss, 0.001300 rate, 15.346776 seconds, 32128 images, 1453.850665 hours left
Loaded: 0.000035 seconds

 1005: 15.821966, 20.063862 avg loss, 0.001300 rate, 14.841369 seconds, 32160 images, 1460.605696 hours left
Loaded: 0.000032 seconds

 1006: 17.831602, 19.840635 avg loss, 0.001300 rate, 14.326487 seconds, 32192 images, 1466.591895 hours left
Loaded: 0.000023 seconds

 1007: 28.932325, 20.749804 avg loss, 0.001300 rate, 16.628623 seconds, 32224 images, 1471.803795 hours left
Loaded: 0.000027 seconds

 1008: 27.431864, 21.418009 avg loss, 0.001300 rate, 16.407566 seconds, 32256 images, 1480.157693 hours left
Loaded: 0.000030 seconds

 1009: 27.676027, 22.043810 avg loss, 0.001300 rate, 16.047771 seconds, 32288 images, 1488.121299 hours left
Loaded: 0.000026 seconds

 1010: 13.911646, 21.230593 avg loss, 0.001300 rate, 13.364597 seconds, 32320 images, 1495.506020 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.571376 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1011: 21.300655, 21.237598 avg loss, 0.001300 rate, 14.866395 seconds, 32352 images, 1499.094016 hours left
Loaded: 0.000029 seconds

 1012: 21.270140, 21.240852 avg loss, 0.001300 rate, 13.845313 seconds, 32384 images, 1505.522526 hours left
Loaded: 0.000025 seconds

 1013: 21.891514, 21.305918 avg loss, 0.001300 rate, 13.655868 seconds, 32416 images, 1509.677266 hours left
Loaded: 0.000026 seconds

 1014: 25.197306, 21.695057 avg loss, 0.001300 rate, 13.791187 seconds, 32448 images, 1513.527564 hours left
Loaded: 0.000033 seconds

 1015: 17.235933, 21.249146 avg loss, 0.001300 rate, 12.776040 seconds, 32480 images, 1517.527072 hours left
Loaded: 0.000040 seconds

 1016: 12.629765, 20.387207 avg loss, 0.001300 rate, 12.478771 seconds, 32512 images, 1520.078082 hours left
Loaded: 0.000026 seconds

 1017: 20.748774, 20.423365 avg loss, 0.001300 rate, 13.351145 seconds, 32544 images, 1522.191109 hours left
Loaded: 0.000029 seconds

 1018: 19.522480, 20.333277 avg loss, 0.001300 rate, 13.187955 seconds, 32576 images, 1525.493330 hours left
Loaded: 0.000027 seconds

 1019: 19.197716, 20.219721 avg loss, 0.001300 rate, 13.509663 seconds, 32608 images, 1528.536076 hours left
Loaded: 0.000031 seconds

 1020: 21.596458, 20.357395 avg loss, 0.001300 rate, 14.521407 seconds, 32640 images, 1531.994712 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.282788 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1021: 19.055021, 20.227158 avg loss, 0.001300 rate, 6.184077 seconds, 32672 images, 1536.822468 hours left
Loaded: 0.000030 seconds

 1022: 24.755611, 20.680002 avg loss, 0.001300 rate, 6.528775 seconds, 32704 images, 1530.426655 hours left
Loaded: 0.000029 seconds

 1023: 21.928181, 20.804821 avg loss, 0.001300 rate, 6.466923 seconds, 32736 images, 1524.180721 hours left
Loaded: 0.000030 seconds

 1024: 24.701288, 21.194468 avg loss, 0.001300 rate, 6.578856 seconds, 32768 images, 1517.911410 hours left
Loaded: 0.000026 seconds

 1025: 13.036371, 20.378658 avg loss, 0.001300 rate, 5.822108 seconds, 32800 images, 1511.860075 hours left
Loaded: 0.000037 seconds

 1026: 15.119521, 19.852745 avg loss, 0.001300 rate, 6.089846 seconds, 32832 images, 1504.819294 hours left
Loaded: 0.000031 seconds

 1027: 25.890869, 20.456558 avg loss, 0.001300 rate, 6.873221 seconds, 32864 images, 1498.220389 hours left
Loaded: 0.000031 seconds

 1028: 20.223839, 20.433287 avg loss, 0.001300 rate, 6.540142 seconds, 32896 images, 1492.774321 hours left
Loaded: 0.000039 seconds

 1029: 21.203991, 20.510357 avg loss, 0.001300 rate, 6.422268 seconds, 32928 images, 1486.920573 hours left
Loaded: 0.000035 seconds

 1030: 19.407578, 20.400080 avg loss, 0.001300 rate, 6.130899 seconds, 32960 images, 1480.961812 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 1031: 20.500200, 20.410091 avg loss, 0.001300 rate, 15.696848 seconds, 32992 images, 1474.658367 hours left
Loaded: 0.000028 seconds

 1032: 14.928331, 19.861916 avg loss, 0.001300 rate, 15.411001 seconds, 33024 images, 1481.689854 hours left
Loaded: 0.000030 seconds

 1033: 20.104418, 19.886166 avg loss, 0.001300 rate, 16.660735 seconds, 33056 images, 1488.254404 hours left
Loaded: 0.000031 seconds

 1034: 20.227470, 19.920296 avg loss, 0.001300 rate, 16.641562 seconds, 33088 images, 1496.487158 hours left
Loaded: 0.000030 seconds

 1035: 21.248405, 20.053106 avg loss, 0.001300 rate, 16.898964 seconds, 33120 images, 1504.610939 hours left
Loaded: 0.000037 seconds

 1036: 20.051250, 20.052921 avg loss, 0.001300 rate, 16.610355 seconds, 33152 images, 1513.010553 hours left
Loaded: 0.000035 seconds

 1037: 22.209667, 20.268597 avg loss, 0.001300 rate, 16.587180 seconds, 33184 images, 1520.925719 hours left
Loaded: 0.000027 seconds

 1038: 16.670918, 19.908829 avg loss, 0.001300 rate, 15.407538 seconds, 33216 images, 1528.729533 hours left
Loaded: 0.000025 seconds

 1039: 16.695345, 19.587481 avg loss, 0.001300 rate, 15.398397 seconds, 33248 images, 1534.818623 hours left
Loaded: 0.000026 seconds

 1040: 16.247974, 19.253531 avg loss, 0.001300 rate, 15.189353 seconds, 33280 images, 1540.834094 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.442174 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1041: 17.337173, 19.061895 avg loss, 0.001300 rate, 12.357610 seconds, 33312 images, 1546.499343 hours left
Loaded: 0.000026 seconds

 1042: 18.090746, 18.964781 avg loss, 0.001300 rate, 12.202906 seconds, 33344 images, 1548.792604 hours left
Loaded: 0.000031 seconds

 1043: 15.893503, 18.657654 avg loss, 0.001300 rate, 12.757151 seconds, 33376 images, 1550.234835 hours left
Loaded: 0.000030 seconds

 1044: 19.212187, 18.713108 avg loss, 0.001300 rate, 13.316518 seconds, 33408 images, 1552.431568 hours left
Loaded: 0.000027 seconds

 1045: 12.920323, 18.133829 avg loss, 0.001300 rate, 12.150063 seconds, 33440 images, 1555.382350 hours left
Loaded: 0.000030 seconds

 1046: 20.161261, 18.336573 avg loss, 0.001300 rate, 13.455444 seconds, 33472 images, 1556.685271 hours left
Loaded: 0.000026 seconds

 1047: 18.531929, 18.356108 avg loss, 0.001300 rate, 13.053211 seconds, 33504 images, 1559.786183 hours left
Loaded: 0.000029 seconds

 1048: 21.576529, 18.678150 avg loss, 0.001300 rate, 13.251247 seconds, 33536 images, 1562.297997 hours left
Loaded: 0.000024 seconds

 1049: 23.098291, 19.120165 avg loss, 0.001300 rate, 13.421581 seconds, 33568 images, 1565.059421 hours left
Loaded: 0.000029 seconds

 1050: 20.018768, 19.210026 avg loss, 0.001300 rate, 13.135435 seconds, 33600 images, 1568.029491 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.116770 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1051: 18.740747, 19.163097 avg loss, 0.001300 rate, 13.599391 seconds, 33632 images, 1570.572842 hours left
Loaded: 0.000021 seconds

 1052: 20.275860, 19.274374 avg loss, 0.001300 rate, 14.108321 seconds, 33664 images, 1573.896358 hours left
Loaded: 0.000027 seconds

 1053: 17.414587, 19.088396 avg loss, 0.001300 rate, 13.666275 seconds, 33696 images, 1577.730694 hours left
Loaded: 0.000027 seconds

 1054: 19.296732, 19.109230 avg loss, 0.001300 rate, 14.018129 seconds, 33728 images, 1580.913380 hours left
Loaded: 0.000027 seconds

 1055: 15.268087, 18.725117 avg loss, 0.001300 rate, 13.364715 seconds, 33760 images, 1584.552347 hours left
Loaded: 0.000029 seconds

 1056: 18.197399, 18.672344 avg loss, 0.001300 rate, 14.256581 seconds, 33792 images, 1587.248374 hours left
Loaded: 0.000027 seconds

 1057: 25.032980, 19.308407 avg loss, 0.001300 rate, 15.061657 seconds, 33824 images, 1591.154731 hours left
Loaded: 0.000034 seconds

 1058: 18.152864, 19.192852 avg loss, 0.001300 rate, 14.128740 seconds, 33856 images, 1596.138899 hours left
Loaded: 0.000027 seconds

 1059: 20.312540, 19.304821 avg loss, 0.001300 rate, 14.489708 seconds, 33888 images, 1599.778920 hours left
Loaded: 0.000034 seconds

 1060: 26.426790, 20.017017 avg loss, 0.001300 rate, 14.945009 seconds, 33920 images, 1603.883276 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.333660 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1061: 16.666834, 19.681999 avg loss, 0.001300 rate, 6.181657 seconds, 33952 images, 1608.578212 hours left
Loaded: 0.000028 seconds

 1062: 16.502062, 19.364006 avg loss, 0.001300 rate, 6.099145 seconds, 33984 images, 1601.531341 hours left
Loaded: 0.000038 seconds

 1063: 26.152956, 20.042900 avg loss, 0.001300 rate, 6.931135 seconds, 34016 images, 1593.977595 hours left
Loaded: 0.000040 seconds

 1064: 17.942753, 19.832886 avg loss, 0.001300 rate, 6.105168 seconds, 34048 images, 1587.653622 hours left
Loaded: 0.000030 seconds

 1065: 20.794643, 19.929062 avg loss, 0.001300 rate, 6.358424 seconds, 34080 images, 1580.246989 hours left
Loaded: 0.000030 seconds

 1066: 21.640598, 20.100216 avg loss, 0.001300 rate, 6.256701 seconds, 34112 images, 1573.265740 hours left
Loaded: 0.000039 seconds

 1067: 24.573439, 20.547539 avg loss, 0.001300 rate, 6.590903 seconds, 34144 images, 1566.213163 hours left
Loaded: 0.000037 seconds

 1068: 21.885593, 20.681345 avg loss, 0.001300 rate, 5.883482 seconds, 34176 images, 1559.694749 hours left
Loaded: 0.000028 seconds

 1069: 17.849440, 20.398155 avg loss, 0.001300 rate, 5.651413 seconds, 34208 images, 1552.260084 hours left
Loaded: 0.000027 seconds

 1070: 15.297468, 19.888086 avg loss, 0.001300 rate, 5.489569 seconds, 34240 images, 1544.577785 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.005178 seconds

 1071: 22.737381, 20.173016 avg loss, 0.001300 rate, 7.597447 seconds, 34272 images, 1536.747766 hours left
Loaded: 0.000031 seconds

 1072: 18.460470, 20.001760 avg loss, 0.001300 rate, 7.197331 seconds, 34304 images, 1531.927443 hours left
Loaded: 0.000027 seconds

 1073: 15.896351, 19.591219 avg loss, 0.001300 rate, 7.149598 seconds, 34336 images, 1526.593083 hours left
Loaded: 0.000030 seconds

 1074: 23.568506, 19.988947 avg loss, 0.001300 rate, 8.140950 seconds, 34368 images, 1521.245820 hours left
Loaded: 0.000030 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 1075: 17.957752, 19.785828 avg loss, 0.001300 rate, 7.419111 seconds, 34400 images, 1517.327310 hours left
Loaded: 0.000041 seconds

 1076: 18.330059, 19.640251 avg loss, 0.001300 rate, 7.700275 seconds, 34432 images, 1512.446576 hours left
Loaded: 0.000025 seconds

 1077: 15.534549, 19.229681 avg loss, 0.001300 rate, 7.293324 seconds, 34464 images, 1508.004687 hours left
Loaded: 0.000028 seconds

 1078: 20.782957, 19.385008 avg loss, 0.001300 rate, 7.868416 seconds, 34496 images, 1503.042616 hours left
Loaded: 0.000030 seconds

 1079: 16.904202, 19.136927 avg loss, 0.001300 rate, 7.744320 seconds, 34528 images, 1498.927967 hours left
Loaded: 0.000033 seconds

 1080: 20.495523, 19.272787 avg loss, 0.001300 rate, 8.003893 seconds, 34560 images, 1494.682286 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.382444 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1081: 23.689362, 19.714445 avg loss, 0.001300 rate, 5.701642 seconds, 34592 images, 1490.839147 hours left
Loaded: 0.000038 seconds

 1082: 23.140310, 20.057032 avg loss, 0.001300 rate, 5.847551 seconds, 34624 images, 1484.371069 hours left
Loaded: 0.000037 seconds

 1083: 20.180515, 20.069380 avg loss, 0.001300 rate, 5.406176 seconds, 34656 images, 1477.639569 hours left
Loaded: 0.000027 seconds

 1084: 28.078987, 20.870340 avg loss, 0.001300 rate, 5.691273 seconds, 34688 images, 1470.363059 hours left
Loaded: 0.000028 seconds

 1085: 22.912567, 21.074562 avg loss, 0.001300 rate, 5.546537 seconds, 34720 images, 1463.554791 hours left
Loaded: 0.000028 seconds

 1086: 17.449455, 20.712051 avg loss, 0.001300 rate, 5.273046 seconds, 34752 images, 1456.613804 hours left
Loaded: 0.000027 seconds

 1087: 18.072212, 20.448067 avg loss, 0.001300 rate, 5.687153 seconds, 34784 images, 1449.362807 hours left
Loaded: 0.000030 seconds

 1088: 23.062237, 20.709484 avg loss, 0.001300 rate, 6.041045 seconds, 34816 images, 1442.758779 hours left
Loaded: 0.000030 seconds

 1089: 18.464769, 20.485012 avg loss, 0.001300 rate, 5.840374 seconds, 34848 images, 1436.711719 hours left
Loaded: 0.000029 seconds

 1090: 15.563397, 19.992851 avg loss, 0.001300 rate, 5.532337 seconds, 34880 images, 1430.446732 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.146167 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1091: 20.579081, 20.051474 avg loss, 0.001300 rate, 6.870236 seconds, 34912 images, 1423.817054 hours left
Loaded: 0.000031 seconds

 1092: 20.769867, 20.123314 avg loss, 0.001300 rate, 6.484447 seconds, 34944 images, 1419.312383 hours left
Loaded: 0.000031 seconds

 1093: 19.977707, 20.108753 avg loss, 0.001300 rate, 6.488324 seconds, 34976 images, 1414.114828 hours left
Loaded: 0.000034 seconds

 1094: 21.873140, 20.285192 avg loss, 0.001300 rate, 6.617364 seconds, 35008 images, 1408.974608 hours left
Loaded: 0.000029 seconds

 1095: 17.970951, 20.053768 avg loss, 0.001300 rate, 6.158711 seconds, 35040 images, 1404.064786 hours left
Loaded: 0.000027 seconds

 1096: 16.975052, 19.745897 avg loss, 0.001300 rate, 6.212465 seconds, 35072 images, 1398.567777 hours left
Loaded: 0.000036 seconds

 1097: 21.940369, 19.965343 avg loss, 0.001300 rate, 6.575273 seconds, 35104 images, 1393.200288 hours left
Loaded: 0.000029 seconds

 1098: 20.700718, 20.038881 avg loss, 0.001300 rate, 6.677731 seconds, 35136 images, 1388.389767 hours left
Loaded: 0.000036 seconds

 1099: 22.919388, 20.326931 avg loss, 0.001300 rate, 6.565491 seconds, 35168 images, 1383.769455 hours left
Loaded: 0.000040 seconds

 1100: 12.032456, 19.497484 avg loss, 0.001300 rate, 5.676814 seconds, 35200 images, 1379.039635 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000033 seconds

 1101: 16.753447, 19.223080 avg loss, 0.001300 rate, 14.347790 seconds, 35232 images, 1373.124309 hours left
Loaded: 0.000033 seconds

 1102: 25.330765, 19.833849 avg loss, 0.001300 rate, 15.822777 seconds, 35264 images, 1379.296667 hours left
Loaded: 0.000030 seconds

 1103: 15.440166, 19.394480 avg loss, 0.001300 rate, 14.212272 seconds, 35296 images, 1387.453381 hours left
Loaded: 0.000032 seconds

 1104: 16.075888, 19.062620 avg loss, 0.001300 rate, 14.085753 seconds, 35328 images, 1393.294362 hours left
Loaded: 0.000030 seconds

 1105: 20.080006, 19.164358 avg loss, 0.001300 rate, 14.538960 seconds, 35360 images, 1398.901391 hours left
Loaded: 0.000030 seconds

 1106: 17.778210, 19.025743 avg loss, 0.001300 rate, 13.646798 seconds, 35392 images, 1405.080999 hours left
Loaded: 0.000030 seconds

 1107: 14.727994, 18.595968 avg loss, 0.001300 rate, 13.570014 seconds, 35424 images, 1409.961158 hours left
Loaded: 0.000033 seconds

 1108: 18.450106, 18.581383 avg loss, 0.001300 rate, 13.945660 seconds, 35456 images, 1414.685964 hours left
Loaded: 0.000032 seconds

 1109: 14.088174, 18.132061 avg loss, 0.001300 rate, 13.673470 seconds, 35488 images, 1419.884583 hours left
Loaded: 0.000031 seconds

 1110: 15.976256, 17.916481 avg loss, 0.001300 rate, 13.393457 seconds, 35520 images, 1424.653595 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.443108 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1111: 18.806969, 18.005529 avg loss, 0.001300 rate, 8.764111 seconds, 35552 images, 1428.986445 hours left
Loaded: 0.000038 seconds

 1112: 19.224306, 18.127407 avg loss, 0.001300 rate, 8.893373 seconds, 35584 images, 1427.468772 hours left
Loaded: 0.000039 seconds

 1113: 18.041735, 18.118839 avg loss, 0.001300 rate, 8.737120 seconds, 35616 images, 1425.530939 hours left
Loaded: 0.000026 seconds

 1114: 23.945173, 18.701473 avg loss, 0.001300 rate, 9.286133 seconds, 35648 images, 1423.395709 hours left
Loaded: 0.000037 seconds

 1115: 22.774229, 19.108749 avg loss, 0.001300 rate, 9.326966 seconds, 35680 images, 1422.043370 hours left
Loaded: 0.000039 seconds

 1116: 11.493443, 18.347219 avg loss, 0.001300 rate, 8.172736 seconds, 35712 images, 1420.761187 hours left
Loaded: 0.000030 seconds

 1117: 21.680090, 18.680506 avg loss, 0.001300 rate, 9.294835 seconds, 35744 images, 1417.890680 hours left
Loaded: 0.000029 seconds

 1118: 21.744541, 18.986910 avg loss, 0.001300 rate, 9.240064 seconds, 35776 images, 1416.605391 hours left
Loaded: 0.000048 seconds

 1119: 14.753367, 18.563555 avg loss, 0.001300 rate, 8.394119 seconds, 35808 images, 1415.256951 hours left
Loaded: 0.000038 seconds

 1120: 19.730848, 18.680285 avg loss, 0.001300 rate, 9.204160 seconds, 35840 images, 1412.748526 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.024749 seconds

 1121: 22.781742, 19.090431 avg loss, 0.001300 rate, 10.416552 seconds, 35872 images, 1411.388810 hours left
Loaded: 0.000039 seconds

 1122: 14.428638, 18.624252 avg loss, 0.001300 rate, 9.387482 seconds, 35904 images, 1411.758732 hours left
Loaded: 0.000032 seconds

 1123: 17.167315, 18.478558 avg loss, 0.001300 rate, 9.618458 seconds, 35936 images, 1410.663162 hours left
Loaded: 0.000029 seconds

 1124: 25.436729, 19.174376 avg loss, 0.001300 rate, 10.400013 seconds, 35968 images, 1409.898912 hours left
Loaded: 0.000032 seconds

 1125: 21.565840, 19.413523 avg loss, 0.001300 rate, 10.111510 seconds, 36000 images, 1410.226412 hours left
Loaded: 0.000027 seconds

 1126: 20.492210, 19.521391 avg loss, 0.001300 rate, 9.943107 seconds, 36032 images, 1410.150416 hours left
Loaded: 0.000029 seconds

 1127: 20.376526, 19.606905 avg loss, 0.001300 rate, 10.206205 seconds, 36064 images, 1409.841544 hours left
Loaded: 0.000038 seconds

 1128: 24.752672, 20.121481 avg loss, 0.001300 rate, 10.670770 seconds, 36096 images, 1409.900690 hours left
Loaded: 0.000038 seconds

 1129: 26.129665, 20.722300 avg loss, 0.001300 rate, 10.357831 seconds, 36128 images, 1410.603649 hours left
Loaded: 0.000038 seconds

 1130: 25.412794, 21.191349 avg loss, 0.001300 rate, 10.114357 seconds, 36160 images, 1410.865458 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.451171 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1131: 19.138315, 20.986046 avg loss, 0.001300 rate, 7.907678 seconds, 36192 images, 1410.786887 hours left
Loaded: 0.000028 seconds

 1132: 23.453650, 21.232807 avg loss, 0.001300 rate, 8.180880 seconds, 36224 images, 1408.273893 hours left
Loaded: 0.000038 seconds

 1133: 15.501088, 20.659636 avg loss, 0.001300 rate, 7.426208 seconds, 36256 images, 1405.539177 hours left
Loaded: 0.000040 seconds

 1134: 25.724756, 21.166147 avg loss, 0.001300 rate, 8.247569 seconds, 36288 images, 1401.784971 hours left
Loaded: 0.000038 seconds

 1135: 23.449991, 21.394531 avg loss, 0.001300 rate, 8.081146 seconds, 36320 images, 1399.207623 hours left
Loaded: 0.000041 seconds

 1136: 18.231934, 21.078272 avg loss, 0.001300 rate, 7.953811 seconds, 36352 images, 1396.425172 hours left
Loaded: 0.000038 seconds

 1137: 17.754267, 20.745871 avg loss, 0.001300 rate, 7.759380 seconds, 36384 images, 1393.493898 hours left
Loaded: 0.000039 seconds

 1138: 18.562704, 20.527554 avg loss, 0.001300 rate, 7.738294 seconds, 36416 images, 1390.322212 hours left
Loaded: 0.000038 seconds

 1139: 17.450541, 20.219852 avg loss, 0.001300 rate, 7.910913 seconds, 36448 images, 1387.152975 hours left
Loaded: 0.000037 seconds

 1140: 18.545313, 20.052399 avg loss, 0.001300 rate, 8.183049 seconds, 36480 images, 1384.254847 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 1141: 20.085890, 20.055748 avg loss, 0.001300 rate, 14.511304 seconds, 36512 images, 1381.763161 hours left
Loaded: 0.000041 seconds

 1142: 13.582160, 19.408390 avg loss, 0.001300 rate, 13.342521 seconds, 36544 images, 1388.074331 hours left
Loaded: 0.000026 seconds

 1143: 20.599096, 19.527460 avg loss, 0.001300 rate, 14.596583 seconds, 36576 images, 1392.701143 hours left
Loaded: 0.000042 seconds

 1144: 20.962097, 19.670923 avg loss, 0.001300 rate, 14.383240 seconds, 36608 images, 1399.021143 hours left
Loaded: 0.000028 seconds

 1145: 21.577599, 19.861591 avg loss, 0.001300 rate, 14.290068 seconds, 36640 images, 1404.981996 hours left
Loaded: 0.000038 seconds

 1146: 23.553766, 20.230808 avg loss, 0.001300 rate, 14.698171 seconds, 36672 images, 1410.753942 hours left
Loaded: 0.000029 seconds

 1147: 18.767836, 20.084511 avg loss, 0.001300 rate, 13.982922 seconds, 36704 images, 1417.034220 hours left
Loaded: 0.000028 seconds

 1148: 24.396049, 20.515665 avg loss, 0.001300 rate, 13.900503 seconds, 36736 images, 1422.259526 hours left
Loaded: 0.000026 seconds

 1149: 16.799742, 20.144073 avg loss, 0.001300 rate, 13.094228 seconds, 36768 images, 1427.318216 hours left
Loaded: 0.000025 seconds

 1150: 21.448280, 20.274494 avg loss, 0.001300 rate, 14.084806 seconds, 36800 images, 1431.207904 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.432021 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1151: 18.504717, 20.097517 avg loss, 0.001300 rate, 10.704073 seconds, 36832 images, 1436.432672 hours left
Loaded: 0.000030 seconds

 1152: 19.235226, 20.011288 avg loss, 0.001300 rate, 11.061520 seconds, 36864 images, 1437.515018 hours left
Loaded: 0.000028 seconds

 1153: 20.837460, 20.093904 avg loss, 0.001300 rate, 11.276332 seconds, 36896 images, 1438.483111 hours left
Loaded: 0.000036 seconds

 1154: 14.402472, 19.524761 avg loss, 0.001300 rate, 9.775106 seconds, 36928 images, 1439.739453 hours left
Loaded: 0.000027 seconds

 1155: 14.418458, 19.014132 avg loss, 0.001300 rate, 10.344664 seconds, 36960 images, 1438.900899 hours left
Loaded: 0.000030 seconds

 1156: 18.618414, 18.974560 avg loss, 0.001300 rate, 11.294065 seconds, 36992 images, 1438.860709 hours left
Loaded: 0.000026 seconds

 1157: 22.414433, 19.318546 avg loss, 0.001300 rate, 11.707665 seconds, 37024 images, 1440.137778 hours left
Loaded: 0.000033 seconds

 1158: 18.525282, 19.239220 avg loss, 0.001300 rate, 11.094614 seconds, 37056 images, 1441.975730 hours left
Loaded: 0.000029 seconds

 1159: 19.023865, 19.217684 avg loss, 0.001300 rate, 11.207340 seconds, 37088 images, 1442.944952 hours left
Loaded: 0.000029 seconds

 1160: 25.608143, 19.856730 avg loss, 0.001300 rate, 11.682617 seconds, 37120 images, 1444.060791 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.395700 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1161: 21.075867, 19.978643 avg loss, 0.001300 rate, 5.569863 seconds, 37152 images, 1445.824676 hours left
Loaded: 0.000037 seconds

 1162: 22.890715, 20.269850 avg loss, 0.001300 rate, 5.522225 seconds, 37184 images, 1439.640993 hours left
Loaded: 0.000028 seconds

 1163: 20.362473, 20.279112 avg loss, 0.001300 rate, 5.415912 seconds, 37216 images, 1432.904249 hours left
Loaded: 0.000028 seconds

 1164: 18.672857, 20.118486 avg loss, 0.001300 rate, 5.254329 seconds, 37248 images, 1426.087383 hours left
Loaded: 0.000036 seconds

 1165: 12.182758, 19.324913 avg loss, 0.001300 rate, 4.951571 seconds, 37280 images, 1419.114547 hours left
Loaded: 0.000038 seconds

 1166: 21.378366, 19.530258 avg loss, 0.001300 rate, 5.538828 seconds, 37312 images, 1411.791501 hours left
Loaded: 0.000028 seconds

 1167: 20.152634, 19.592495 avg loss, 0.001300 rate, 5.490073 seconds, 37344 images, 1405.356221 hours left
Loaded: 0.000038 seconds

 1168: 20.065060, 19.639751 avg loss, 0.001300 rate, 5.462463 seconds, 37376 images, 1398.917641 hours left
Loaded: 0.000029 seconds

 1169: 21.671072, 19.842884 avg loss, 0.001300 rate, 5.598407 seconds, 37408 images, 1392.505147 hours left
Loaded: 0.000042 seconds

 1170: 20.601412, 19.918737 avg loss, 0.001300 rate, 5.541795 seconds, 37440 images, 1386.345309 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 1171: 13.595758, 19.286440 avg loss, 0.001300 rate, 6.364200 seconds, 37472 images, 1380.168551 hours left
Loaded: 0.000026 seconds

 1172: 21.061907, 19.463987 avg loss, 0.001300 rate, 6.938436 seconds, 37504 images, 1375.194215 hours left
Loaded: 0.000034 seconds

 1173: 20.548506, 19.572439 avg loss, 0.001300 rate, 6.780031 seconds, 37536 images, 1371.066087 hours left
Loaded: 0.000034 seconds

 1174: 12.589241, 18.874119 avg loss, 0.001300 rate, 6.593677 seconds, 37568 images, 1366.759519 hours left
Loaded: 0.000031 seconds

 1175: 28.782425, 19.864950 avg loss, 0.001300 rate, 8.126585 seconds, 37600 images, 1362.237523 hours left
Loaded: 0.000031 seconds

 1176: 20.045790, 19.883034 avg loss, 0.001300 rate, 7.475071 seconds, 37632 images, 1359.886891 hours left
Loaded: 0.000026 seconds

 1177: 25.568241, 20.451555 avg loss, 0.001300 rate, 8.005947 seconds, 37664 images, 1356.656086 hours left
Loaded: 0.000033 seconds

 1178: 22.220791, 20.628479 avg loss, 0.001300 rate, 7.715272 seconds, 37696 images, 1354.193889 hours left
Loaded: 0.000029 seconds

 1179: 22.687870, 20.834417 avg loss, 0.001300 rate, 7.716877 seconds, 37728 images, 1351.353134 hours left
Loaded: 0.000039 seconds

 1180: 16.857260, 20.436701 avg loss, 0.001300 rate, 6.975344 seconds, 37760 images, 1348.542985 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.349736 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1181: 15.612375, 19.954268 avg loss, 0.001300 rate, 6.219197 seconds, 37792 images, 1344.732425 hours left
Loaded: 0.000030 seconds

 1182: 18.855747, 19.844416 avg loss, 0.001300 rate, 6.493303 seconds, 37824 images, 1340.396205 hours left
Loaded: 0.000033 seconds

 1183: 20.476992, 19.907673 avg loss, 0.001300 rate, 6.400090 seconds, 37856 images, 1335.998474 hours left
Loaded: 0.000028 seconds

 1184: 23.782003, 20.295105 avg loss, 0.001300 rate, 6.520922 seconds, 37888 images, 1331.515420 hours left
Loaded: 0.000022 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 1185: 14.865087, 19.752104 avg loss, 0.001300 rate, 5.689791 seconds, 37920 images, 1327.244764 hours left
Loaded: 0.000027 seconds

 1186: 30.334099, 20.810303 avg loss, 0.001300 rate, 6.467330 seconds, 37952 images, 1321.864031 hours left
Loaded: 0.000036 seconds

 1187: 22.785227, 21.007795 avg loss, 0.001300 rate, 6.018932 seconds, 37984 images, 1317.615518 hours left
Loaded: 0.000029 seconds

 1188: 21.120411, 21.019056 avg loss, 0.001300 rate, 6.147425 seconds, 38016 images, 1312.787566 hours left
Loaded: 0.000026 seconds

 1189: 23.277147, 21.244865 avg loss, 0.001300 rate, 6.333065 seconds, 38048 images, 1308.186085 hours left
Loaded: 0.000026 seconds

 1190: 21.721117, 21.292490 avg loss, 0.001300 rate, 6.094668 seconds, 38080 images, 1303.888075 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.023447 seconds

 1191: 26.769985, 21.840240 avg loss, 0.001300 rate, 11.554990 seconds, 38112 images, 1299.302378 hours left
Loaded: 0.000028 seconds

 1192: 12.018769, 20.858093 avg loss, 0.001300 rate, 9.949032 seconds, 38144 images, 1302.368307 hours left
Loaded: 0.000028 seconds

 1193: 24.380230, 21.210306 avg loss, 0.001300 rate, 11.289503 seconds, 38176 images, 1303.143651 hours left
Loaded: 0.000027 seconds

 1194: 23.884478, 21.477724 avg loss, 0.001300 rate, 11.411421 seconds, 38208 images, 1305.770399 hours left
Loaded: 0.000028 seconds

 1195: 23.936646, 21.723616 avg loss, 0.001300 rate, 11.150561 seconds, 38240 images, 1308.539942 hours left
Loaded: 0.000036 seconds

 1196: 18.145760, 21.365829 avg loss, 0.001300 rate, 10.559036 seconds, 38272 images, 1310.919959 hours left
Loaded: 0.000041 seconds

 1197: 15.314581, 20.760704 avg loss, 0.001300 rate, 10.231804 seconds, 38304 images, 1312.455735 hours left
Loaded: 0.000036 seconds

 1198: 18.252916, 20.509926 avg loss, 0.001300 rate, 10.904899 seconds, 38336 images, 1313.522278 hours left
Loaded: 0.000030 seconds

 1199: 23.918653, 20.850800 avg loss, 0.001300 rate, 11.092079 seconds, 38368 images, 1315.511668 hours left
Loaded: 0.000026 seconds

 1200: 19.248343, 20.690554 avg loss, 0.001300 rate, 10.521930 seconds, 38400 images, 1317.740734 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.497260 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1201: 26.183687, 21.239866 avg loss, 0.001300 rate, 8.781188 seconds, 38432 images, 1319.156707 hours left
Loaded: 0.000031 seconds

 1202: 23.847742, 21.500654 avg loss, 0.001300 rate, 8.312812 seconds, 38464 images, 1318.833821 hours left
Loaded: 0.000031 seconds

 1203: 15.222786, 20.872868 avg loss, 0.001300 rate, 7.707407 seconds, 38496 images, 1317.174902 hours left
Loaded: 0.000030 seconds

 1204: 19.004879, 20.686069 avg loss, 0.001300 rate, 8.018279 seconds, 38528 images, 1314.692890 hours left
Loaded: 0.000030 seconds

 1205: 17.919260, 20.409389 avg loss, 0.001300 rate, 8.010106 seconds, 38560 images, 1312.666835 hours left
Loaded: 0.000030 seconds

 1206: 14.794142, 19.847864 avg loss, 0.001300 rate, 7.570843 seconds, 38592 images, 1310.649682 hours left
Loaded: 0.000039 seconds

 1207: 22.965445, 20.159622 avg loss, 0.001300 rate, 8.571086 seconds, 38624 images, 1308.043453 hours left
Loaded: 0.000038 seconds

 1208: 21.316383, 20.275299 avg loss, 0.001300 rate, 8.393828 seconds, 38656 images, 1306.850540 hours left
Loaded: 0.000041 seconds

 1209: 20.956944, 20.343464 avg loss, 0.001300 rate, 8.595721 seconds, 38688 images, 1305.423687 hours left
Loaded: 0.000039 seconds

 1210: 16.691490, 19.978266 avg loss, 0.001300 rate, 8.196679 seconds, 38720 images, 1304.291092 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.080544 seconds

 1211: 20.831570, 20.063597 avg loss, 0.001300 rate, 10.625488 seconds, 38752 images, 1302.616361 hours left
Loaded: 0.000025 seconds

 1212: 23.927223, 20.449959 avg loss, 0.001300 rate, 11.179383 seconds, 38784 images, 1304.438557 hours left
Loaded: 0.000033 seconds

 1213: 21.272707, 20.532234 avg loss, 0.001300 rate, 10.825855 seconds, 38816 images, 1306.899044 hours left
Loaded: 0.000026 seconds

 1214: 21.693041, 20.648315 avg loss, 0.001300 rate, 10.790735 seconds, 38848 images, 1308.844583 hours left
Loaded: 0.000030 seconds

 1215: 23.530935, 20.936577 avg loss, 0.001300 rate, 11.046424 seconds, 38880 images, 1310.721916 hours left
Loaded: 0.000030 seconds

 1216: 11.183318, 19.961250 avg loss, 0.001300 rate, 9.197290 seconds, 38912 images, 1312.935069 hours left
Loaded: 0.000037 seconds

 1217: 19.420832, 19.907207 avg loss, 0.001300 rate, 10.355215 seconds, 38944 images, 1312.561494 hours left
Loaded: 0.000036 seconds

 1218: 15.787459, 19.495234 avg loss, 0.001300 rate, 9.848438 seconds, 38976 images, 1313.797563 hours left
Loaded: 0.000030 seconds

 1219: 26.739395, 20.219650 avg loss, 0.001300 rate, 11.565082 seconds, 39008 images, 1314.318393 hours left
Loaded: 0.000031 seconds

 1220: 22.781773, 20.475863 avg loss, 0.001300 rate, 10.748173 seconds, 39040 images, 1317.214781 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.049153 seconds

 1221: 21.461859, 20.574463 avg loss, 0.001300 rate, 11.745641 seconds, 39072 images, 1318.949212 hours left
Loaded: 0.000029 seconds

 1222: 17.158567, 20.232874 avg loss, 0.001300 rate, 11.022839 seconds, 39104 images, 1322.117770 hours left
Loaded: 0.000032 seconds

 1223: 24.750113, 20.684597 avg loss, 0.001300 rate, 12.068429 seconds, 39136 images, 1324.184039 hours left
Loaded: 0.000033 seconds

 1224: 18.771139, 20.493252 avg loss, 0.001300 rate, 10.978457 seconds, 39168 images, 1327.679728 hours left
Loaded: 0.000032 seconds

 1225: 27.092499, 21.153177 avg loss, 0.001300 rate, 12.163584 seconds, 39200 images, 1329.628768 hours left
Loaded: 0.000029 seconds

 1226: 21.745289, 21.212389 avg loss, 0.001300 rate, 11.305967 seconds, 39232 images, 1333.201909 hours left
Loaded: 0.000029 seconds

 1227: 13.730359, 20.464186 avg loss, 0.001300 rate, 10.103300 seconds, 39264 images, 1335.549876 hours left
Loaded: 0.000029 seconds

 1228: 21.402666, 20.558033 avg loss, 0.001300 rate, 11.156931 seconds, 39296 images, 1336.206389 hours left
Loaded: 0.000028 seconds

 1229: 12.602864, 19.762516 avg loss, 0.001300 rate, 10.016378 seconds, 39328 images, 1338.317555 hours left
Loaded: 0.000044 seconds

 1230: 27.823248, 20.568588 avg loss, 0.001300 rate, 11.433153 seconds, 39360 images, 1338.825783 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.440437 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1231: 17.460684, 20.257797 avg loss, 0.001300 rate, 9.401502 seconds, 39392 images, 1341.293794 hours left
Loaded: 0.000028 seconds

 1232: 22.375931, 20.469610 avg loss, 0.001300 rate, 9.778657 seconds, 39424 images, 1341.530243 hours left
Loaded: 0.000027 seconds

 1233: 17.146215, 20.137270 avg loss, 0.001300 rate, 9.070869 seconds, 39456 images, 1341.676577 hours left
Loaded: 0.000035 seconds

 1234: 16.271559, 19.750698 avg loss, 0.001300 rate, 9.159664 seconds, 39488 images, 1340.839822 hours left
Loaded: 0.000034 seconds

 1235: 23.400259, 20.115654 avg loss, 0.001300 rate, 10.272604 seconds, 39520 images, 1340.134565 hours left
Loaded: 0.000031 seconds

 1236: 20.067917, 20.110880 avg loss, 0.001300 rate, 10.587273 seconds, 39552 images, 1340.979813 hours left
Loaded: 0.000030 seconds

 1237: 26.267324, 20.726524 avg loss, 0.001300 rate, 10.550522 seconds, 39584 images, 1342.252973 hours left
Loaded: 0.000028 seconds

 1238: 13.697006, 20.023573 avg loss, 0.001300 rate, 9.421896 seconds, 39616 images, 1343.462401 hours left
Loaded: 0.000029 seconds

 1239: 18.260052, 19.847221 avg loss, 0.001300 rate, 10.244225 seconds, 39648 images, 1343.094481 hours left
Loaded: 0.000029 seconds

 1240: 16.217714, 19.484270 avg loss, 0.001300 rate, 10.124895 seconds, 39680 images, 1343.870651 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.052373 seconds

 1241: 20.546165, 19.590460 avg loss, 0.001300 rate, 14.570528 seconds, 39712 images, 1344.473541 hours left
Loaded: 0.000026 seconds

 1242: 11.996827, 18.831097 avg loss, 0.001300 rate, 13.702696 seconds, 39744 images, 1351.308303 hours left
Loaded: 0.000027 seconds

 1243: 19.981726, 18.946159 avg loss, 0.001300 rate, 14.503590 seconds, 39776 images, 1356.798548 hours left
Loaded: 0.000027 seconds

 1244: 15.170500, 18.568594 avg loss, 0.001300 rate, 13.830193 seconds, 39808 images, 1363.344554 hours left
Loaded: 0.000037 seconds

 1245: 19.994383, 18.711172 avg loss, 0.001300 rate, 14.744387 seconds, 39840 images, 1368.891177 hours left
Loaded: 0.000029 seconds

 1246: 18.462688, 18.686323 avg loss, 0.001300 rate, 14.388575 seconds, 39872 images, 1375.650133 hours left
Loaded: 0.000028 seconds

 1247: 22.936958, 19.111387 avg loss, 0.001300 rate, 14.980307 seconds, 39904 images, 1381.848001 hours left
Loaded: 0.000028 seconds

 1248: 17.869577, 18.987206 avg loss, 0.001300 rate, 13.683964 seconds, 39936 images, 1388.804472 hours left
Loaded: 0.000027 seconds

 1249: 27.211298, 19.809614 avg loss, 0.001300 rate, 15.405811 seconds, 39968 images, 1393.893553 hours left
Loaded: 0.000031 seconds

 1250: 18.850073, 19.713659 avg loss, 0.001300 rate, 14.139351 seconds, 40000 images, 1401.319575 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.250558 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1251: 15.975727, 19.339867 avg loss, 0.001300 rate, 7.714053 seconds, 40032 images, 1406.914966 hours left
Loaded: 0.000032 seconds

 1252: 17.002811, 19.106161 avg loss, 0.001300 rate, 7.964225 seconds, 40064 images, 1403.891175 hours left
Loaded: 0.000039 seconds

 1253: 25.582441, 19.753790 avg loss, 0.001300 rate, 8.713627 seconds, 40096 images, 1400.897109 hours left
Loaded: 0.000040 seconds

 1254: 11.042601, 18.882671 avg loss, 0.001300 rate, 7.242083 seconds, 40128 images, 1398.972239 hours left
Loaded: 0.000038 seconds

 1255: 17.606045, 18.755009 avg loss, 0.001300 rate, 7.705154 seconds, 40160 images, 1395.025866 hours left
Loaded: 0.000021 seconds

 1256: 25.789711, 19.458479 avg loss, 0.001300 rate, 8.168304 seconds, 40192 images, 1391.761116 hours left
Loaded: 0.000027 seconds

 1257: 20.654018, 19.578033 avg loss, 0.001300 rate, 7.808213 seconds, 40224 images, 1389.171258 hours left
Loaded: 0.000027 seconds

 1258: 20.000202, 19.620251 avg loss, 0.001300 rate, 7.763721 seconds, 40256 images, 1386.107915 hours left
Loaded: 0.000030 seconds

 1259: 28.728512, 20.531076 avg loss, 0.001300 rate, 9.037713 seconds, 40288 images, 1383.013485 hours left
Loaded: 0.000028 seconds

 1260: 29.340904, 21.412060 avg loss, 0.001300 rate, 9.136761 seconds, 40320 images, 1381.716729 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.026300 seconds

 1261: 19.641314, 21.234985 avg loss, 0.001300 rate, 10.296947 seconds, 40352 images, 1380.570272 hours left
Loaded: 0.000032 seconds

 1262: 21.720098, 21.283497 avg loss, 0.001300 rate, 10.462407 seconds, 40384 images, 1381.080605 hours left
Loaded: 0.000029 seconds

 1263: 16.738035, 20.828951 avg loss, 0.001300 rate, 9.863755 seconds, 40416 images, 1381.778834 hours left
Loaded: 0.000037 seconds

 1264: 21.067484, 20.852804 avg loss, 0.001300 rate, 10.416254 seconds, 40448 images, 1381.639851 hours left
Loaded: 0.000038 seconds

 1265: 16.476000, 20.415123 avg loss, 0.001300 rate, 9.759897 seconds, 40480 images, 1382.268432 hours left
Loaded: 0.000030 seconds

 1266: 15.076492, 19.881260 avg loss, 0.001300 rate, 9.577804 seconds, 40512 images, 1381.980487 hours left
Loaded: 0.000031 seconds

 1267: 21.281767, 20.021311 avg loss, 0.001300 rate, 10.214511 seconds, 40544 images, 1381.442864 hours left
Loaded: 0.000029 seconds

 1268: 23.567188, 20.375898 avg loss, 0.001300 rate, 10.957318 seconds, 40576 images, 1381.793550 hours left
Loaded: 0.000040 seconds

 1269: 22.392155, 20.577524 avg loss, 0.001300 rate, 10.486355 seconds, 40608 images, 1383.170806 hours left
Loaded: 0.000031 seconds

 1270: 18.290216, 20.348793 avg loss, 0.001300 rate, 9.935872 seconds, 40640 images, 1383.881149 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.396094 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1271: 21.462372, 20.460152 avg loss, 0.001300 rate, 6.434246 seconds, 40672 images, 1383.820963 hours left
Loaded: 0.000029 seconds

 1272: 19.770460, 20.391182 avg loss, 0.001300 rate, 6.070871 seconds, 40704 images, 1379.454722 hours left
Loaded: 0.000028 seconds

 1273: 12.057410, 19.557804 avg loss, 0.001300 rate, 5.561995 seconds, 40736 images, 1374.078974 hours left
Loaded: 0.000036 seconds

 1274: 20.159504, 19.617973 avg loss, 0.001300 rate, 6.277791 seconds, 40768 images, 1368.051286 hours left
Loaded: 0.000041 seconds

 1275: 26.755583, 20.331734 avg loss, 0.001300 rate, 6.769764 seconds, 40800 images, 1363.076492 hours left
Loaded: 0.000037 seconds

 1276: 17.739540, 20.072514 avg loss, 0.001300 rate, 5.930650 seconds, 40832 images, 1358.833673 hours left
Loaded: 0.000034 seconds

 1277: 16.014704, 19.666733 avg loss, 0.001300 rate, 5.923016 seconds, 40864 images, 1353.469629 hours left
Loaded: 0.000037 seconds

 1278: 13.736429, 19.073702 avg loss, 0.001300 rate, 5.703882 seconds, 40896 images, 1348.148619 hours left
Loaded: 0.000035 seconds

 1279: 16.532280, 18.819559 avg loss, 0.001300 rate, 5.999834 seconds, 40928 images, 1342.576929 hours left
Loaded: 0.000028 seconds

 1280: 18.041285, 18.741732 avg loss, 0.001300 rate, 6.004088 seconds, 40960 images, 1337.471340 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.000029 seconds

 1281: 24.280148, 19.295574 avg loss, 0.001300 rate, 10.741285 seconds, 40992 images, 1332.422679 hours left
Loaded: 0.000031 seconds

 1282: 15.020433, 18.868061 avg loss, 0.001300 rate, 9.799980 seconds, 41024 images, 1333.993657 hours left
Loaded: 0.000028 seconds

 1283: 12.062541, 18.187510 avg loss, 0.001300 rate, 9.284013 seconds, 41056 images, 1334.243573 hours left
Loaded: 0.000038 seconds

 1284: 20.280361, 18.396795 avg loss, 0.001300 rate, 10.220253 seconds, 41088 images, 1333.775460 hours left
Loaded: 0.000045 seconds

 1285: 20.777956, 18.634911 avg loss, 0.001300 rate, 10.242545 seconds, 41120 images, 1334.610310 hours left
Loaded: 0.000029 seconds

 1286: 17.086576, 18.480078 avg loss, 0.001300 rate, 10.218855 seconds, 41152 images, 1335.467707 hours left
Loaded: 0.000041 seconds

 1287: 28.643112, 19.496382 avg loss, 0.001300 rate, 11.896592 seconds, 41184 images, 1336.283627 hours left
Loaded: 0.000038 seconds

 1288: 23.868996, 19.933643 avg loss, 0.001300 rate, 11.218066 seconds, 41216 images, 1339.417899 hours left
Loaded: 0.000030 seconds

 1289: 22.627785, 20.203058 avg loss, 0.001300 rate, 10.730208 seconds, 41248 images, 1341.579877 hours left
Loaded: 0.000031 seconds

 1290: 19.269417, 20.109694 avg loss, 0.001300 rate, 9.755113 seconds, 41280 images, 1343.043683 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000029 seconds

 1291: 16.215239, 19.720247 avg loss, 0.001300 rate, 11.886815 seconds, 41312 images, 1343.140662 hours left
Loaded: 0.000029 seconds

 1292: 10.636481, 18.811871 avg loss, 0.001300 rate, 11.261753 seconds, 41344 images, 1346.192658 hours left
Loaded: 0.000029 seconds

 1293: 22.216400, 19.152323 avg loss, 0.001300 rate, 13.059836 seconds, 41376 images, 1348.347335 hours left
Loaded: 0.000039 seconds

 1294: 18.166164, 19.053707 avg loss, 0.001300 rate, 12.429214 seconds, 41408 images, 1352.973808 hours left
Loaded: 0.000035 seconds

 1295: 18.134121, 18.961748 avg loss, 0.001300 rate, 12.498931 seconds, 41440 images, 1356.679522 hours left
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Loaded: 0.000031 seconds

 1296: 17.905365, 18.856110 avg loss, 0.001300 rate, 12.529706 seconds, 41472 images, 1360.444814 hours left
Loaded: 0.000035 seconds

 1297: 18.563583, 18.826857 avg loss, 0.001300 rate, 12.200485 seconds, 41504 images, 1364.215088 hours left
Loaded: 0.000031 seconds

 1298: 15.475494, 18.491720 avg loss, 0.001300 rate, 11.633127 seconds, 41536 images, 1367.491107 hours left
Loaded: 0.000043 seconds

 1299: 11.004484, 17.742996 avg loss, 0.001300 rate, 10.894139 seconds, 41568 images, 1369.947587 hours left
Loaded: 0.000039 seconds

 1300: 18.787876, 17.847485 avg loss, 0.001300 rate, 12.130037 seconds, 41600 images, 1371.354752 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.344650 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1301: 19.394032, 18.002140 avg loss, 0.001300 rate, 6.987176 seconds, 41632 images, 1374.461591 hours left
Loaded: 0.000029 seconds

 1302: 21.986238, 18.400551 avg loss, 0.001300 rate, 7.511441 seconds, 41664 images, 1370.883767 hours left
Loaded: 0.000030 seconds

 1303: 19.157539, 18.476250 avg loss, 0.001300 rate, 7.262097 seconds, 41696 images, 1367.590806 hours left
Loaded: 0.000028 seconds

 1304: 26.360376, 19.264662 avg loss, 0.001300 rate, 7.920558 seconds, 41728 images, 1363.984999 hours left
Loaded: 0.000033 seconds

 1305: 19.323910, 19.270586 avg loss, 0.001300 rate, 7.090962 seconds, 41760 images, 1361.328287 hours left
Loaded: 0.000028 seconds

 1306: 27.165979, 20.060125 avg loss, 0.001300 rate, 7.874874 seconds, 41792 images, 1357.547764 hours left
Loaded: 0.000031 seconds

 1307: 18.232737, 19.877386 avg loss, 0.001300 rate, 7.092741 seconds, 41824 images, 1354.892032 hours left
Loaded: 0.000038 seconds

 1308: 23.815926, 20.271240 avg loss, 0.001300 rate, 7.522236 seconds, 41856 images, 1351.178298 hours left
Loaded: 0.000034 seconds

 1309: 15.433876, 19.787504 avg loss, 0.001300 rate, 6.793122 seconds, 41888 images, 1348.097249 hours left
Loaded: 0.000028 seconds

 1310: 17.246393, 19.533394 avg loss, 0.001300 rate, 7.042181 seconds, 41920 images, 1344.035962 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.391383 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1311: 26.177759, 20.197830 avg loss, 0.001300 rate, 7.317644 seconds, 41952 images, 1340.360615 hours left
Loaded: 0.000029 seconds

 1312: 20.140596, 20.192106 avg loss, 0.001300 rate, 6.935966 seconds, 41984 images, 1337.646635 hours left
Loaded: 0.000028 seconds

 1313: 14.228572, 19.595753 avg loss, 0.001300 rate, 6.498274 seconds, 42016 images, 1333.887864 hours left
Loaded: 0.000030 seconds

 1314: 18.724592, 19.508636 avg loss, 0.001300 rate, 7.111209 seconds, 42048 images, 1329.559741 hours left
Loaded: 0.000030 seconds

 1315: 17.174866, 19.275259 avg loss, 0.001300 rate, 6.899514 seconds, 42080 images, 1326.124799 hours left
Loaded: 0.000032 seconds

 1316: 14.567250, 18.804459 avg loss, 0.001300 rate, 6.753125 seconds, 42112 images, 1322.430644 hours left
Loaded: 0.000030 seconds

 1317: 24.428556, 19.366869 avg loss, 0.001300 rate, 7.719165 seconds, 42144 images, 1318.570429 hours left
Loaded: 0.000030 seconds

 1318: 15.366082, 18.966791 avg loss, 0.001300 rate, 6.621907 seconds, 42176 images, 1316.088325 hours left
Loaded: 0.000027 seconds

 1319: 20.877237, 19.157835 avg loss, 0.001300 rate, 7.304288 seconds, 42208 images, 1312.109542 hours left
Loaded: 0.000027 seconds

 1320: 20.577850, 19.299837 avg loss, 0.001300 rate, 7.008282 seconds, 42240 images, 1309.116722 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.383927 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1321: 25.497446, 19.919598 avg loss, 0.001300 rate, 6.487473 seconds, 42272 images, 1305.743367 hours left
Loaded: 0.000034 seconds

 1322: 18.486940, 19.776333 avg loss, 0.001300 rate, 6.328395 seconds, 42304 images, 1302.213884 hours left
Loaded: 0.000031 seconds

 1323: 17.849829, 19.583683 avg loss, 0.001300 rate, 6.337925 seconds, 42336 images, 1297.966807 hours left
Loaded: 0.000030 seconds

 1324: 23.960297, 20.021345 avg loss, 0.001300 rate, 6.787493 seconds, 42368 images, 1293.775380 hours left
Loaded: 0.000040 seconds

 1325: 18.388077, 19.858019 avg loss, 0.001300 rate, 6.341875 seconds, 42400 images, 1290.249220 hours left
Loaded: 0.000039 seconds

 1326: 21.019789, 19.974195 avg loss, 0.001300 rate, 6.540999 seconds, 42432 images, 1286.140423 hours left
Loaded: 0.000030 seconds

 1327: 15.634451, 19.540220 avg loss, 0.001300 rate, 5.999632 seconds, 42464 images, 1282.348800 hours left
Loaded: 0.000030 seconds

 1328: 20.926710, 19.678869 avg loss, 0.001300 rate, 6.504465 seconds, 42496 images, 1277.844406 hours left
Loaded: 0.000041 seconds

 1329: 15.143666, 19.225349 avg loss, 0.001300 rate, 6.052473 seconds, 42528 images, 1274.085037 hours left
Loaded: 0.000029 seconds

 1330: 24.483179, 19.751133 avg loss, 0.001300 rate, 6.387033 seconds, 42560 images, 1269.736532 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 1331: 20.740582, 19.850079 avg loss, 0.001300 rate, 16.549365 seconds, 42592 images, 1265.895373 hours left
Loaded: 0.000032 seconds

 1332: 21.906149, 20.055685 avg loss, 0.001300 rate, 16.066479 seconds, 42624 images, 1276.183498 hours left
Loaded: 0.000029 seconds

 1333: 23.692421, 20.419359 avg loss, 0.001300 rate, 16.581536 seconds, 42656 images, 1285.699144 hours left
Loaded: 0.000031 seconds

 1334: 16.063093, 19.983732 avg loss, 0.001300 rate, 15.024081 seconds, 42688 images, 1295.833750 hours left
Loaded: 0.000029 seconds

 1335: 18.430157, 19.828375 avg loss, 0.001300 rate, 15.519075 seconds, 42720 images, 1303.707443 hours left
Loaded: 0.000031 seconds

 1336: 25.274662, 20.373003 avg loss, 0.001300 rate, 16.344918 seconds, 42752 images, 1312.188698 hours left
Loaded: 0.000026 seconds

 1337: 17.831690, 20.118872 avg loss, 0.001300 rate, 15.111496 seconds, 42784 images, 1321.730187 hours left
Loaded: 0.000032 seconds

 1338: 21.471846, 20.254169 avg loss, 0.001300 rate, 15.763761 seconds, 42816 images, 1329.465990 hours left
Loaded: 0.000028 seconds

 1339: 23.175591, 20.546312 avg loss, 0.001300 rate, 16.326449 seconds, 42848 images, 1338.028807 hours left
Loaded: 0.000031 seconds

 1340: 25.179569, 21.009638 avg loss, 0.001300 rate, 16.182286 seconds, 42880 images, 1347.286145 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.272554 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1341: 19.303904, 20.839064 avg loss, 0.001300 rate, 5.435491 seconds, 42912 images, 1356.250978 hours left
Loaded: 0.000029 seconds

 1342: 22.000719, 20.955229 avg loss, 0.001300 rate, 5.637709 seconds, 42944 images, 1350.602987 hours left
Loaded: 0.000038 seconds

 1343: 14.868939, 20.346600 avg loss, 0.001300 rate, 5.206078 seconds, 42976 images, 1344.913975 hours left
Loaded: 0.000038 seconds

 1344: 25.674061, 20.879345 avg loss, 0.001300 rate, 5.758320 seconds, 43008 images, 1338.683374 hours left
Loaded: 0.000038 seconds

 1345: 16.078590, 20.399269 avg loss, 0.001300 rate, 5.183608 seconds, 43040 images, 1333.280773 hours left
Loaded: 0.000038 seconds

 1346: 15.771152, 19.936457 avg loss, 0.001300 rate, 5.334016 seconds, 43072 images, 1327.135320 hours left
Loaded: 0.000038 seconds

 1347: 23.802046, 20.323015 avg loss, 0.001300 rate, 5.767797 seconds, 43104 images, 1321.259854 hours left
Loaded: 0.000026 seconds

 1348: 19.170609, 20.207775 avg loss, 0.001300 rate, 5.717642 seconds, 43136 images, 1316.044578 hours left
Loaded: 0.000030 seconds

 1349: 22.942812, 20.481279 avg loss, 0.001300 rate, 5.952563 seconds, 43168 images, 1310.811884 hours left
Loaded: 0.000030 seconds

 1350: 22.474298, 20.680582 avg loss, 0.001300 rate, 5.910284 seconds, 43200 images, 1305.957231 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 1351: 19.288460, 20.541370 avg loss, 0.001300 rate, 11.486919 seconds, 43232 images, 1301.092487 hours left
Loaded: 0.000029 seconds

 1352: 19.082203, 20.395454 avg loss, 0.001300 rate, 11.524358 seconds, 43264 images, 1304.008513 hours left
Loaded: 0.000036 seconds

 1353: 16.539436, 20.009853 avg loss, 0.001300 rate, 10.807851 seconds, 43296 images, 1306.947262 hours left
Loaded: 0.000027 seconds

 1354: 21.180965, 20.126965 avg loss, 0.001300 rate, 12.021161 seconds, 43328 images, 1308.863147 hours left
Loaded: 0.000029 seconds

 1355: 22.584349, 20.372704 avg loss, 0.001300 rate, 11.943783 seconds, 43360 images, 1312.442107 hours left
Loaded: 0.000030 seconds

 1356: 14.829085, 19.818342 avg loss, 0.001300 rate, 10.649979 seconds, 43392 images, 1315.877959 hours left
Loaded: 0.000039 seconds

 1357: 15.231106, 19.359619 avg loss, 0.001300 rate, 10.709165 seconds, 43424 images, 1317.485549 hours left
Loaded: 0.000034 seconds

 1358: 21.938107, 19.617468 avg loss, 0.001300 rate, 11.616148 seconds, 43456 images, 1319.159108 hours left
Loaded: 0.000024 seconds

 1359: 22.679422, 19.923664 avg loss, 0.001300 rate, 11.409479 seconds, 43488 images, 1322.073431 hours left
Loaded: 0.000030 seconds

 1360: 12.909097, 19.222208 avg loss, 0.001300 rate, 10.171203 seconds, 43520 images, 1324.672017 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.093152 seconds

 1361: 18.243301, 19.124317 avg loss, 0.001300 rate, 14.179272 seconds, 43552 images, 1325.527725 hours left
Loaded: 0.000031 seconds

 1362: 29.261923, 20.138077 avg loss, 0.001300 rate, 15.446137 seconds, 43584 images, 1332.061139 hours left
Loaded: 0.000029 seconds

 1363: 14.481656, 19.572435 avg loss, 0.001300 rate, 13.334166 seconds, 43616 images, 1340.156568 hours left
Loaded: 0.000039 seconds

 1364: 21.874678, 19.802660 avg loss, 0.001300 rate, 14.472160 seconds, 43648 images, 1345.242767 hours left
Loaded: 0.000035 seconds

 1365: 16.686964, 19.491091 avg loss, 0.001300 rate, 13.731676 seconds, 43680 images, 1351.855896 hours left
Loaded: 0.000029 seconds

 1366: 22.941187, 19.836100 avg loss, 0.001300 rate, 14.733140 seconds, 43712 images, 1357.376178 hours left
Loaded: 0.000028 seconds

 1367: 25.799990, 20.432489 avg loss, 0.001300 rate, 14.941233 seconds, 43744 images, 1364.229723 hours left
Loaded: 0.000037 seconds

 1368: 15.213825, 19.910624 avg loss, 0.001300 rate, 13.471418 seconds, 43776 images, 1371.303208 hours left
Loaded: 0.000037 seconds

 1369: 21.222446, 20.041805 avg loss, 0.001300 rate, 13.848490 seconds, 43808 images, 1376.268063 hours left
Loaded: 0.000026 seconds

 1370: 27.915850, 20.829210 avg loss, 0.001300 rate, 14.907776 seconds, 43840 images, 1381.706033 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.472680 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1371: 20.999786, 20.846268 avg loss, 0.001300 rate, 7.241730 seconds, 43872 images, 1388.558237 hours left
Loaded: 0.000028 seconds

 1372: 18.440825, 20.605724 avg loss, 0.001300 rate, 7.127193 seconds, 43904 images, 1385.368462 hours left
Loaded: 0.000029 seconds

 1373: 22.330906, 20.778242 avg loss, 0.001300 rate, 7.420679 seconds, 43936 images, 1381.396446 hours left
Loaded: 0.000029 seconds

 1374: 18.711620, 20.571581 avg loss, 0.001300 rate, 7.184881 seconds, 43968 images, 1377.871037 hours left
Loaded: 0.000029 seconds

 1375: 26.535938, 21.168016 avg loss, 0.001300 rate, 7.838597 seconds, 44000 images, 1374.053939 hours left
Loaded: 0.000032 seconds

 1376: 23.843676, 21.435583 avg loss, 0.001300 rate, 7.727835 seconds, 44032 images, 1371.181343 hours left
Loaded: 0.000031 seconds

 1377: 23.759275, 21.667952 avg loss, 0.001300 rate, 7.602713 seconds, 44064 images, 1368.183888 hours left
Loaded: 0.000030 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 1378: 14.989199, 21.000076 avg loss, 0.001300 rate, 6.971685 seconds, 44096 images, 1365.042907 hours left
Loaded: 0.000036 seconds

 1379: 18.326834, 20.732752 avg loss, 0.001300 rate, 7.392664 seconds, 44128 images, 1361.058439 hours left
Loaded: 0.000031 seconds

 1380: 21.823723, 20.841848 avg loss, 0.001300 rate, 7.795417 seconds, 44160 images, 1357.697456 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.313727 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1381: 16.954988, 20.453163 avg loss, 0.001300 rate, 6.522124 seconds, 44192 images, 1354.928449 hours left
Loaded: 0.000030 seconds

 1382: 21.883511, 20.596197 avg loss, 0.001300 rate, 7.000719 seconds, 44224 images, 1350.856687 hours left
Loaded: 0.000028 seconds

 1383: 29.269350, 21.463512 avg loss, 0.001300 rate, 7.472878 seconds, 44256 images, 1347.054243 hours left
Loaded: 0.000039 seconds

 1384: 24.644939, 21.781654 avg loss, 0.001300 rate, 6.969823 seconds, 44288 images, 1343.944421 hours left
Loaded: 0.000030 seconds

 1385: 19.025007, 21.505989 avg loss, 0.001300 rate, 6.561449 seconds, 44320 images, 1340.168240 hours left
Loaded: 0.000032 seconds

 1386: 23.567274, 21.712118 avg loss, 0.001300 rate, 6.816862 seconds, 44352 images, 1335.863605 hours left
Loaded: 0.000036 seconds

 1387: 14.077663, 20.948673 avg loss, 0.001300 rate, 6.024571 seconds, 44384 images, 1331.956111 hours left
Loaded: 0.000039 seconds

 1388: 22.541868, 21.107992 avg loss, 0.001300 rate, 6.606805 seconds, 44416 images, 1326.989230 hours left
Loaded: 0.000038 seconds

 1389: 14.649834, 20.462177 avg loss, 0.001300 rate, 5.937752 seconds, 44448 images, 1322.879226 hours left
Loaded: 0.000031 seconds

 1390: 21.044355, 20.520395 avg loss, 0.001300 rate, 6.572955 seconds, 44480 images, 1317.882713 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 1391: 23.290287, 20.797384 avg loss, 0.001300 rate, 17.307778 seconds, 44512 images, 1313.816797 hours left
Loaded: 0.000034 seconds

 1392: 23.300579, 21.047703 avg loss, 0.001300 rate, 17.384109 seconds, 44544 images, 1324.674422 hours left
Loaded: 0.000029 seconds

 1393: 25.153252, 21.458258 avg loss, 0.001300 rate, 17.662218 seconds, 44576 images, 1335.529258 hours left
Loaded: 0.000031 seconds

 1394: 21.223488, 21.434780 avg loss, 0.001300 rate, 16.321259 seconds, 44608 images, 1346.661065 hours left
Loaded: 0.000029 seconds

 1395: 21.197161, 21.411018 avg loss, 0.001300 rate, 16.079989 seconds, 44640 images, 1355.822395 hours left
Loaded: 0.000031 seconds

 1396: 19.612885, 21.231205 avg loss, 0.001300 rate, 16.040841 seconds, 44672 images, 1364.557566 hours left
Loaded: 0.000028 seconds

 1397: 21.062479, 21.214333 avg loss, 0.001300 rate, 16.019804 seconds, 44704 images, 1373.151068 hours left
Loaded: 0.000030 seconds

 1398: 24.104120, 21.503311 avg loss, 0.001300 rate, 16.731191 seconds, 44736 images, 1381.629420 hours left
Loaded: 0.000029 seconds

 1399: 18.367922, 21.189772 avg loss, 0.001300 rate, 15.449858 seconds, 44768 images, 1391.009210 hours left
Loaded: 0.000036 seconds

 1400: 20.416857, 21.112480 avg loss, 0.001300 rate, 16.173550 seconds, 44800 images, 1398.518725 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.488382 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1401: 21.209837, 21.122215 avg loss, 0.001300 rate, 8.349739 seconds, 44832 images, 1406.956430 hours left
Loaded: 0.000029 seconds

 1402: 27.051792, 21.715174 avg loss, 0.001300 rate, 8.672612 seconds, 44864 images, 1405.139926 hours left
Loaded: 0.000037 seconds

 1403: 12.933184, 20.836975 avg loss, 0.001300 rate, 7.286310 seconds, 44896 images, 1403.112145 hours left
Loaded: 0.000030 seconds

 1404: 18.275513, 20.580830 avg loss, 0.001300 rate, 8.060459 seconds, 44928 images, 1399.182687 hours left
Loaded: 0.000030 seconds

 1405: 22.635286, 20.786276 avg loss, 0.001300 rate, 8.318971 seconds, 44960 images, 1396.365756 hours left
Loaded: 0.000033 seconds

 1406: 18.988821, 20.606531 avg loss, 0.001300 rate, 7.835252 seconds, 44992 images, 1393.935380 hours left
Loaded: 0.000037 seconds

 1407: 20.327742, 20.578651 avg loss, 0.001300 rate, 8.069826 seconds, 45024 images, 1390.858660 hours left
Loaded: 0.000038 seconds

 1408: 14.547895, 19.975576 avg loss, 0.001300 rate, 7.655542 seconds, 45056 images, 1388.137897 hours left
Loaded: 0.000038 seconds

 1409: 23.919516, 20.369970 avg loss, 0.001300 rate, 8.463322 seconds, 45088 images, 1384.869971 hours left
Loaded: 0.000037 seconds

 1410: 17.943560, 20.127329 avg loss, 0.001300 rate, 7.683431 seconds, 45120 images, 1382.754582 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 1411: 20.700794, 20.184675 avg loss, 0.001300 rate, 14.835084 seconds, 45152 images, 1379.579110 hours left
Loaded: 0.000029 seconds

 1412: 11.746017, 19.340809 avg loss, 0.001300 rate, 13.327465 seconds, 45184 images, 1386.350114 hours left
Loaded: 0.000038 seconds

 1413: 20.371811, 19.443909 avg loss, 0.001300 rate, 14.739277 seconds, 45216 images, 1390.963272 hours left
Loaded: 0.000028 seconds

 1414: 21.197699, 19.619287 avg loss, 0.001300 rate, 14.477094 seconds, 45248 images, 1397.487543 hours left
Loaded: 0.000029 seconds

 1415: 12.858006, 18.943159 avg loss, 0.001300 rate, 13.357658 seconds, 45280 images, 1403.583038 hours left
Loaded: 0.000029 seconds

 1416: 24.000761, 19.448919 avg loss, 0.001300 rate, 15.967933 seconds, 45312 images, 1408.065612 hours left
Loaded: 0.000029 seconds

 1417: 23.935398, 19.897568 avg loss, 0.001300 rate, 15.723278 seconds, 45344 images, 1416.122066 hours left
Loaded: 0.000029 seconds

 1418: 16.731342, 19.580946 avg loss, 0.001300 rate, 14.132712 seconds, 45376 images, 1423.758734 hours left
Loaded: 0.000030 seconds

 1419: 20.951336, 19.717985 avg loss, 0.001300 rate, 15.263607 seconds, 45408 images, 1429.113930 hours left
Loaded: 0.000029 seconds

 1420: 23.795856, 20.125772 avg loss, 0.001300 rate, 15.427394 seconds, 45440 images, 1435.983335 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.336370 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1421: 21.333452, 20.246540 avg loss, 0.001300 rate, 6.291500 seconds, 45472 images, 1443.011067 hours left
Loaded: 0.000043 seconds

 1422: 18.357519, 20.057638 avg loss, 0.001300 rate, 6.236008 seconds, 45504 images, 1437.769387 hours left
Loaded: 0.000028 seconds

 1423: 20.699194, 20.121794 avg loss, 0.001300 rate, 6.166934 seconds, 45536 images, 1432.036916 hours left
Loaded: 0.000036 seconds

 1424: 19.803530, 20.089968 avg loss, 0.001300 rate, 6.341138 seconds, 45568 images, 1426.265973 hours left
Loaded: 0.000030 seconds

 1425: 23.016659, 20.382637 avg loss, 0.001300 rate, 6.372915 seconds, 45600 images, 1420.794238 hours left
Loaded: 0.000029 seconds

 1426: 21.447929, 20.489166 avg loss, 0.001300 rate, 6.230235 seconds, 45632 images, 1415.421247 hours left
Loaded: 0.000028 seconds

 1427: 20.811260, 20.521376 avg loss, 0.001300 rate, 6.109813 seconds, 45664 images, 1409.904164 hours left
Loaded: 0.000029 seconds

 1428: 21.089239, 20.578161 avg loss, 0.001300 rate, 6.249919 seconds, 45696 images, 1404.275294 hours left
Loaded: 0.000024 seconds

 1429: 21.979528, 20.718298 avg loss, 0.001300 rate, 6.044547 seconds, 45728 images, 1398.896927 hours left
Loaded: 0.000029 seconds

 1430: 18.743637, 20.520832 avg loss, 0.001300 rate, 5.866095 seconds, 45760 images, 1393.287609 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 1431: 17.827595, 20.251509 avg loss, 0.001300 rate, 10.167941 seconds, 45792 images, 1387.486986 hours left
Loaded: 0.000027 seconds

 1432: 16.870754, 19.913433 avg loss, 0.001300 rate, 10.070699 seconds, 45824 images, 1387.708008 hours left
Loaded: 0.000026 seconds

 1433: 21.763971, 20.098488 avg loss, 0.001300 rate, 10.558188 seconds, 45856 images, 1387.791988 hours left
Loaded: 0.000025 seconds

 1434: 17.844761, 19.873116 avg loss, 0.001300 rate, 10.354540 seconds, 45888 images, 1388.550902 hours left
Loaded: 0.000035 seconds

 1435: 18.876781, 19.773481 avg loss, 0.001300 rate, 10.893956 seconds, 45920 images, 1389.019880 hours left
Loaded: 0.000031 seconds

 1436: 15.415572, 19.337690 avg loss, 0.001300 rate, 10.580657 seconds, 45952 images, 1390.231945 hours left
Loaded: 0.000029 seconds

 1437: 24.527205, 19.856642 avg loss, 0.001300 rate, 11.842185 seconds, 45984 images, 1390.997531 hours left
Loaded: 0.000026 seconds

 1438: 28.008429, 20.671820 avg loss, 0.001300 rate, 11.820871 seconds, 46016 images, 1393.504268 hours left
Loaded: 0.000030 seconds

 1439: 18.410324, 20.445671 avg loss, 0.001300 rate, 10.749232 seconds, 46048 images, 1395.956351 hours left
Loaded: 0.000041 seconds

 1440: 21.137482, 20.514853 avg loss, 0.001300 rate, 10.849904 seconds, 46080 images, 1396.898294 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.037761 seconds

 1441: 18.018459, 20.265213 avg loss, 0.001300 rate, 14.726306 seconds, 46112 images, 1397.970364 hours left
Loaded: 0.000033 seconds

 1442: 14.703654, 19.709057 avg loss, 0.001300 rate, 14.307303 seconds, 46144 images, 1404.457731 hours left
Loaded: 0.000027 seconds

 1443: 19.189987, 19.657150 avg loss, 0.001300 rate, 15.312659 seconds, 46176 images, 1410.247029 hours left
Loaded: 0.000029 seconds

 1444: 18.264730, 19.517908 avg loss, 0.001300 rate, 15.329204 seconds, 46208 images, 1417.372081 hours left
Loaded: 0.000028 seconds

 1445: 12.292042, 18.795322 avg loss, 0.001300 rate, 14.215315 seconds, 46240 images, 1424.448779 hours left
Loaded: 0.000028 seconds

 1446: 24.706583, 19.386448 avg loss, 0.001300 rate, 16.312670 seconds, 46272 images, 1429.910521 hours left
Loaded: 0.000028 seconds

 1447: 25.892107, 20.037014 avg loss, 0.001300 rate, 16.934907 seconds, 46304 images, 1438.225086 hours left
Loaded: 0.000031 seconds

 1448: 23.753613, 20.408674 avg loss, 0.001300 rate, 16.211626 seconds, 46336 images, 1447.319044 hours left
Loaded: 0.000028 seconds

 1449: 18.787615, 20.246569 avg loss, 0.001300 rate, 15.300804 seconds, 46368 images, 1455.319366 hours left
Loaded: 0.000030 seconds

 1450: 23.928860, 20.614798 avg loss, 0.001300 rate, 16.045903 seconds, 46400 images, 1461.977007 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.459900 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1451: 23.643700, 20.917688 avg loss, 0.001300 rate, 6.392198 seconds, 46432 images, 1469.600924 hours left
Loaded: 0.000037 seconds

 1452: 30.117128, 21.837633 avg loss, 0.001300 rate, 6.701012 seconds, 46464 images, 1464.403631 hours left
Loaded: 0.000033 seconds

 1453: 28.086994, 22.462570 avg loss, 0.001300 rate, 6.387187 seconds, 46496 images, 1459.048900 hours left
Loaded: 0.000029 seconds

 1454: 18.897041, 22.106018 avg loss, 0.001300 rate, 6.025494 seconds, 46528 images, 1453.312654 hours left
Loaded: 0.000030 seconds

 1455: 20.205954, 21.916012 avg loss, 0.001300 rate, 5.966481 seconds, 46560 images, 1447.132355 hours left
Loaded: 0.000032 seconds

 1456: 18.181915, 21.542603 avg loss, 0.001300 rate, 5.716283 seconds, 46592 images, 1440.932038 hours left
Loaded: 0.000049 seconds

 1457: 14.727142, 20.861057 avg loss, 0.001300 rate, 5.608038 seconds, 46624 images, 1434.446875 hours left
Loaded: 0.000036 seconds

 1458: 14.691003, 20.244051 avg loss, 0.001300 rate, 5.800634 seconds, 46656 images, 1427.876521 hours left
Loaded: 0.000037 seconds

 1459: 12.267454, 19.446392 avg loss, 0.001300 rate, 5.538944 seconds, 46688 images, 1421.638816 hours left
Loaded: 0.000030 seconds

 1460: 17.278688, 19.229622 avg loss, 0.001300 rate, 5.723739 seconds, 46720 images, 1415.100716 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000034 seconds

 1461: 13.071324, 18.613792 avg loss, 0.001300 rate, 12.850066 seconds, 46752 images, 1408.884136 hours left
Loaded: 0.000036 seconds

 1462: 14.008759, 18.153290 avg loss, 0.001300 rate, 13.023101 seconds, 46784 images, 1412.608367 hours left
Loaded: 0.000031 seconds

 1463: 24.879721, 18.825933 avg loss, 0.001300 rate, 15.247351 seconds, 46816 images, 1416.535187 hours left
Loaded: 0.000030 seconds

 1464: 21.099550, 19.053295 avg loss, 0.001300 rate, 13.633880 seconds, 46848 images, 1423.505982 hours left
Loaded: 0.000026 seconds

 1465: 19.638432, 19.111809 avg loss, 0.001300 rate, 13.245309 seconds, 46880 images, 1428.170415 hours left
Loaded: 0.000029 seconds

 1466: 18.692282, 19.069857 avg loss, 0.001300 rate, 13.257691 seconds, 46912 images, 1432.249516 hours left
Loaded: 0.000033 seconds

 1467: 23.498030, 19.512674 avg loss, 0.001300 rate, 14.066527 seconds, 46944 images, 1436.304958 hours left
Loaded: 0.000039 seconds

 1468: 25.683992, 20.129807 avg loss, 0.001300 rate, 15.087560 seconds, 46976 images, 1441.441027 hours left
Loaded: 0.000029 seconds

 1469: 15.212856, 19.638111 avg loss, 0.001300 rate, 13.253850 seconds, 47008 images, 1447.941060 hours left
Loaded: 0.000029 seconds

 1470: 14.855449, 19.159845 avg loss, 0.001300 rate, 12.648606 seconds, 47040 images, 1451.834153 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.497805 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1471: 16.956266, 18.939487 avg loss, 0.001300 rate, 12.067979 seconds, 47072 images, 1454.849291 hours left
Loaded: 0.000034 seconds

 1472: 24.277742, 19.473312 avg loss, 0.001300 rate, 12.869664 seconds, 47104 images, 1457.719396 hours left
Loaded: 0.000029 seconds

 1473: 18.436930, 19.369675 avg loss, 0.001300 rate, 12.360184 seconds, 47136 images, 1460.982047 hours left
Loaded: 0.000028 seconds

 1474: 19.700981, 19.402805 avg loss, 0.001300 rate, 12.276329 seconds, 47168 images, 1463.505795 hours left
Loaded: 0.000026 seconds

 1475: 20.552759, 19.517801 avg loss, 0.001300 rate, 12.412475 seconds, 47200 images, 1465.888031 hours left
Loaded: 0.000035 seconds

 1476: 21.318993, 19.697920 avg loss, 0.001300 rate, 12.716247 seconds, 47232 images, 1468.435133 hours left
Loaded: 0.000029 seconds

 1477: 20.462812, 19.774408 avg loss, 0.001300 rate, 12.608799 seconds, 47264 images, 1471.377823 hours left
Loaded: 0.000029 seconds

 1478: 21.692152, 19.966183 avg loss, 0.001300 rate, 13.325638 seconds, 47296 images, 1474.142100 hours left
Loaded: 0.000029 seconds

 1479: 12.660592, 19.235624 avg loss, 0.001300 rate, 12.246396 seconds, 47328 images, 1477.872362 hours left
Loaded: 0.000029 seconds

 1480: 21.129143, 19.424976 avg loss, 0.001300 rate, 13.478917 seconds, 47360 images, 1480.069273 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.072890 seconds

 1481: 23.303883, 19.812866 avg loss, 0.001300 rate, 16.416528 seconds, 47392 images, 1483.952659 hours left
Loaded: 0.000031 seconds

 1482: 18.039061, 19.635487 avg loss, 0.001300 rate, 15.305635 seconds, 47424 images, 1491.970183 hours left
Loaded: 0.000038 seconds

 1483: 18.870449, 19.558983 avg loss, 0.001300 rate, 15.681391 seconds, 47456 images, 1498.266612 hours left
Loaded: 0.000037 seconds

 1484: 20.734316, 19.676516 avg loss, 0.001300 rate, 15.983642 seconds, 47488 images, 1505.020901 hours left
Loaded: 0.000030 seconds

 1485: 24.324156, 20.141279 avg loss, 0.001300 rate, 16.586662 seconds, 47520 images, 1512.126574 hours left
Loaded: 0.000030 seconds

 1486: 16.700916, 19.797243 avg loss, 0.001300 rate, 14.887733 seconds, 47552 images, 1519.997011 hours left
Loaded: 0.000028 seconds

 1487: 19.750616, 19.792580 avg loss, 0.001300 rate, 15.516739 seconds, 47584 images, 1525.433726 hours left
Loaded: 0.000030 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 1488: 18.968472, 19.710169 avg loss, 0.001300 rate, 15.643363 seconds, 47616 images, 1531.687925 hours left
Loaded: 0.000036 seconds

 1489: 23.618008, 20.100952 avg loss, 0.001300 rate, 16.298448 seconds, 47648 images, 1538.055075 hours left
Loaded: 0.000030 seconds

 1490: 19.454233, 20.036280 avg loss, 0.001300 rate, 15.342043 seconds, 47680 images, 1545.266547 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.595697 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1491: 22.423244, 20.274977 avg loss, 0.001300 rate, 13.604938 seconds, 47712 images, 1551.080143 hours left
Loaded: 0.000033 seconds

 1492: 18.079666, 20.055447 avg loss, 0.001300 rate, 13.219199 seconds, 47744 images, 1555.253368 hours left
Loaded: 0.000036 seconds

 1493: 27.742233, 20.824125 avg loss, 0.001300 rate, 14.620479 seconds, 47776 images, 1558.024466 hours left
Loaded: 0.000038 seconds

 1494: 20.573929, 20.799107 avg loss, 0.001300 rate, 13.496543 seconds, 47808 images, 1562.710179 hours left
Loaded: 0.000029 seconds

 1495: 18.437857, 20.562981 avg loss, 0.001300 rate, 13.124728 seconds, 47840 images, 1565.791077 hours left
Loaded: 0.000039 seconds

 1496: 25.353991, 21.042082 avg loss, 0.001300 rate, 14.526731 seconds, 47872 images, 1568.325734 hours left
Loaded: 0.000048 seconds

 1497: 23.946512, 21.332525 avg loss, 0.001300 rate, 14.267769 seconds, 47904 images, 1572.778369 hours left
Loaded: 0.000039 seconds

 1498: 17.282724, 20.927546 avg loss, 0.001300 rate, 13.147328 seconds, 47936 images, 1576.827499 hours left
Loaded: 0.000041 seconds

 1499: 27.565794, 21.591370 avg loss, 0.001300 rate, 14.438709 seconds, 47968 images, 1579.283021 hours left
Loaded: 0.000028 seconds

 1500: 21.917957, 21.624029 avg loss, 0.001300 rate, 13.803337 seconds, 48000 images, 1583.503956 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.455295 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1501: 21.408731, 21.602499 avg loss, 0.001300 rate, 7.055568 seconds, 48032 images, 1586.801928 hours left
Loaded: 0.000026 seconds

 1502: 19.654543, 21.407703 avg loss, 0.001300 rate, 7.038615 seconds, 48064 images, 1581.344791 hours left
Loaded: 0.000023 seconds

 1503: 20.577154, 21.324648 avg loss, 0.001300 rate, 7.218950 seconds, 48096 images, 1575.287655 hours left
Loaded: 0.000027 seconds

 1504: 24.668026, 21.658985 avg loss, 0.001300 rate, 7.562732 seconds, 48128 images, 1569.541030 hours left
Loaded: 0.000027 seconds

 1505: 17.608362, 21.253923 avg loss, 0.001300 rate, 6.988032 seconds, 48160 images, 1564.328370 hours left
Loaded: 0.000034 seconds

 1506: 14.656611, 20.594193 avg loss, 0.001300 rate, 6.634470 seconds, 48192 images, 1558.371227 hours left
Loaded: 0.000041 seconds

 1507: 21.453598, 20.680134 avg loss, 0.001300 rate, 7.342293 seconds, 48224 images, 1551.983575 hours left
Loaded: 0.000036 seconds

 1508: 21.926052, 20.804726 avg loss, 0.001300 rate, 7.320202 seconds, 48256 images, 1546.640900 hours left
Loaded: 0.000037 seconds

 1509: 17.165670, 20.440821 avg loss, 0.001300 rate, 6.913194 seconds, 48288 images, 1541.321004 hours left
Loaded: 0.000028 seconds

 1510: 19.546692, 20.351408 avg loss, 0.001300 rate, 7.092059 seconds, 48320 images, 1535.490140 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.316700 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1511: 18.579601, 20.174227 avg loss, 0.001300 rate, 5.615172 seconds, 48352 images, 1529.965474 hours left
Loaded: 0.000028 seconds

 1512: 16.401140, 19.796919 avg loss, 0.001300 rate, 5.517837 seconds, 48384 images, 1522.887886 hours left
Loaded: 0.000030 seconds

 1513: 20.856129, 19.902840 avg loss, 0.001300 rate, 5.753254 seconds, 48416 images, 1515.307209 hours left
Loaded: 0.000028 seconds

 1514: 18.152599, 19.727816 avg loss, 0.001300 rate, 5.517216 seconds, 48448 images, 1508.128633 hours left
Loaded: 0.000030 seconds

 1515: 15.565305, 19.311565 avg loss, 0.001300 rate, 5.307302 seconds, 48480 images, 1500.694657 hours left
Loaded: 0.000029 seconds

 1516: 20.458090, 19.426218 avg loss, 0.001300 rate, 5.697818 seconds, 48512 images, 1493.044068 hours left
Loaded: 0.000028 seconds

 1517: 24.288630, 19.912458 avg loss, 0.001300 rate, 5.931458 seconds, 48544 images, 1486.011236 hours left
Loaded: 0.000030 seconds

 1518: 17.784431, 19.699656 avg loss, 0.001300 rate, 5.363873 seconds, 48576 images, 1479.372554 hours left
Loaded: 0.000026 seconds

 1519: 12.211862, 18.950876 avg loss, 0.001300 rate, 5.046515 seconds, 48608 images, 1472.013537 hours left
Loaded: 0.000034 seconds

 1520: 13.668580, 18.422647 avg loss, 0.001300 rate, 5.175273 seconds, 48640 images, 1464.288214 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.000030 seconds

 1521: 20.583031, 18.638685 avg loss, 0.001300 rate, 10.218324 seconds, 48672 images, 1456.818606 hours left
Loaded: 0.000029 seconds

 1522: 20.582012, 18.833017 avg loss, 0.001300 rate, 10.408293 seconds, 48704 images, 1456.413610 hours left
Loaded: 0.000029 seconds

 1523: 21.078819, 19.057598 avg loss, 0.001300 rate, 10.549385 seconds, 48736 images, 1456.275944 hours left
Loaded: 0.000030 seconds

 1524: 18.020239, 18.953861 avg loss, 0.001300 rate, 10.114513 seconds, 48768 images, 1456.335184 hours left
Loaded: 0.000029 seconds

 1525: 25.452568, 19.603731 avg loss, 0.001300 rate, 10.492878 seconds, 48800 images, 1455.791052 hours left
Loaded: 0.000029 seconds

 1526: 20.391289, 19.682487 avg loss, 0.001300 rate, 10.046376 seconds, 48832 images, 1455.776762 hours left
Loaded: 0.000029 seconds

 1527: 23.318005, 20.046040 avg loss, 0.001300 rate, 10.353170 seconds, 48864 images, 1455.143715 hours left
Loaded: 0.000036 seconds

 1528: 22.363903, 20.277826 avg loss, 0.001300 rate, 10.369103 seconds, 48896 images, 1454.942198 hours left
Loaded: 0.000037 seconds

 1529: 18.123493, 20.062393 avg loss, 0.001300 rate, 9.835924 seconds, 48928 images, 1454.764762 hours left
Loaded: 0.000041 seconds

 1530: 17.480997, 19.804253 avg loss, 0.001300 rate, 9.552769 seconds, 48960 images, 1453.850069 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.233508 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1531: 19.913382, 19.815166 avg loss, 0.001300 rate, 6.318737 seconds, 48992 images, 1452.552041 hours left
Loaded: 0.000027 seconds

 1532: 17.748642, 19.608515 avg loss, 0.001300 rate, 6.237928 seconds, 49024 images, 1447.108109 hours left
Loaded: 0.000029 seconds

 1533: 23.669645, 20.014627 avg loss, 0.001300 rate, 6.585075 seconds, 49056 images, 1441.282986 hours left
Loaded: 0.000039 seconds

 1534: 22.165340, 20.229698 avg loss, 0.001300 rate, 6.448893 seconds, 49088 images, 1435.997252 hours left
Loaded: 0.000041 seconds

 1535: 25.257414, 20.732470 avg loss, 0.001300 rate, 6.657935 seconds, 49120 images, 1430.575619 hours left
Loaded: 0.000038 seconds

 1536: 12.611593, 19.920382 avg loss, 0.001300 rate, 5.773002 seconds, 49152 images, 1425.497924 hours left
Loaded: 0.000030 seconds

 1537: 21.063776, 20.034721 avg loss, 0.001300 rate, 6.544424 seconds, 49184 images, 1419.244455 hours left
Loaded: 0.000035 seconds

 1538: 22.628317, 20.294081 avg loss, 0.001300 rate, 6.775476 seconds, 49216 images, 1414.122691 hours left
Loaded: 0.000038 seconds

 1539: 21.778934, 20.442566 avg loss, 0.001300 rate, 6.586994 seconds, 49248 images, 1409.372372 hours left
Loaded: 0.000038 seconds

 1540: 20.860029, 20.484312 avg loss, 0.001300 rate, 6.597449 seconds, 49280 images, 1404.408307 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 1541: 13.689073, 19.804789 avg loss, 0.001300 rate, 14.292029 seconds, 49312 images, 1399.508355 hours left
Loaded: 0.000028 seconds

 1542: 18.343033, 19.658613 avg loss, 0.001300 rate, 15.287364 seconds, 49344 images, 1405.322033 hours left
Loaded: 0.000027 seconds

 1543: 20.900764, 19.782829 avg loss, 0.001300 rate, 15.411763 seconds, 49376 images, 1412.457076 hours left
Loaded: 0.000026 seconds

 1544: 21.143930, 19.918940 avg loss, 0.001300 rate, 15.858677 seconds, 49408 images, 1419.693129 hours left
Loaded: 0.000027 seconds

 1545: 11.429624, 19.070007 avg loss, 0.001300 rate, 14.473012 seconds, 49440 images, 1427.476197 hours left
Loaded: 0.000030 seconds

 1546: 21.964478, 19.359455 avg loss, 0.001300 rate, 16.598952 seconds, 49472 images, 1433.260880 hours left
Loaded: 0.000023 seconds

 1547: 17.210199, 19.144529 avg loss, 0.001300 rate, 15.434462 seconds, 49504 images, 1441.934198 hours left
Loaded: 0.000031 seconds

 1548: 19.901775, 19.220253 avg loss, 0.001300 rate, 16.406274 seconds, 49536 images, 1448.906767 hours left
Loaded: 0.000030 seconds

 1549: 24.174131, 19.715641 avg loss, 0.001300 rate, 17.357746 seconds, 49568 images, 1457.156487 hours left
Loaded: 0.000028 seconds

 1550: 22.590799, 20.003157 avg loss, 0.001300 rate, 16.369700 seconds, 49600 images, 1466.642378 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.350768 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1551: 17.554598, 19.758301 avg loss, 0.001300 rate, 8.047250 seconds, 49632 images, 1474.663955 hours left
Loaded: 0.000029 seconds

 1552: 19.381756, 19.720646 avg loss, 0.001300 rate, 8.344103 seconds, 49664 images, 1471.556726 hours left
Loaded: 0.000029 seconds

 1553: 25.378265, 20.286407 avg loss, 0.001300 rate, 8.659442 seconds, 49696 images, 1468.405861 hours left
Loaded: 0.000038 seconds

 1554: 22.403027, 20.498070 avg loss, 0.001300 rate, 8.296023 seconds, 49728 images, 1465.723531 hours left
Loaded: 0.000037 seconds

 1555: 21.096685, 20.557932 avg loss, 0.001300 rate, 7.944726 seconds, 49760 images, 1462.564327 hours left
Loaded: 0.000037 seconds

 1556: 22.099337, 20.712072 avg loss, 0.001300 rate, 8.218313 seconds, 49792 images, 1458.949807 hours left
Loaded: 0.000037 seconds

 1557: 13.188141, 19.959679 avg loss, 0.001300 rate, 7.447164 seconds, 49824 images, 1455.750590 hours left
Loaded: 0.000037 seconds

 1558: 15.740705, 19.537781 avg loss, 0.001300 rate, 7.555193 seconds, 49856 images, 1451.514566 hours left
Loaded: 0.000033 seconds

 1559: 17.572630, 19.341267 avg loss, 0.001300 rate, 8.098167 seconds, 49888 images, 1447.470604 hours left
Loaded: 0.000030 seconds

 1560: 29.450954, 20.352236 avg loss, 0.001300 rate, 9.103655 seconds, 49920 images, 1444.219591 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.302833 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1561: 16.206259, 19.937637 avg loss, 0.001300 rate, 5.973171 seconds, 49952 images, 1442.394610 hours left
Loaded: 0.000038 seconds

 1562: 15.836341, 19.527508 avg loss, 0.001300 rate, 5.938438 seconds, 49984 images, 1436.668852 hours left
Loaded: 0.000038 seconds

 1563: 25.654591, 20.140217 avg loss, 0.001300 rate, 6.533939 seconds, 50016 images, 1430.532542 hours left
Loaded: 0.000039 seconds

 1564: 16.221350, 19.748329 avg loss, 0.001300 rate, 6.009935 seconds, 50048 images, 1425.282905 hours left
Loaded: 0.000038 seconds

 1565: 24.381401, 20.211636 avg loss, 0.001300 rate, 6.514012 seconds, 50080 images, 1419.359512 hours left
Loaded: 0.000038 seconds

 1566: 20.827454, 20.273218 avg loss, 0.001300 rate, 6.222160 seconds, 50112 images, 1414.193951 hours left
Loaded: 0.000030 seconds

 1567: 25.744293, 20.820326 avg loss, 0.001300 rate, 6.507750 seconds, 50144 images, 1408.675541 hours left
Loaded: 0.000032 seconds

 1568: 19.192879, 20.657581 avg loss, 0.001300 rate, 6.175285 seconds, 50176 images, 1403.608094 hours left
Loaded: 0.000039 seconds

 1569: 15.464142, 20.138237 avg loss, 0.001300 rate, 5.866783 seconds, 50208 images, 1398.130536 hours left
Loaded: 0.000040 seconds

 1570: 11.208654, 19.245279 avg loss, 0.001300 rate, 5.610111 seconds, 50240 images, 1392.280187 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.287384 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1571: 19.325994, 19.253351 avg loss, 0.001300 rate, 5.573932 seconds, 50272 images, 1386.132612 hours left
Loaded: 0.000031 seconds

 1572: 24.235859, 19.751602 avg loss, 0.001300 rate, 6.013412 seconds, 50304 images, 1380.394580 hours left
Loaded: 0.000030 seconds

 1573: 26.915913, 20.468033 avg loss, 0.001300 rate, 6.323554 seconds, 50336 images, 1374.924746 hours left
Loaded: 0.000030 seconds

 1574: 18.635136, 20.284742 avg loss, 0.001300 rate, 5.679520 seconds, 50368 images, 1369.939418 hours left
Loaded: 0.000028 seconds

 1575: 17.193691, 19.975637 avg loss, 0.001300 rate, 5.348035 seconds, 50400 images, 1364.111357 hours left
Loaded: 0.000036 seconds

 1576: 23.376081, 20.315681 avg loss, 0.001300 rate, 6.107810 seconds, 50432 images, 1357.882151 hours left
Loaded: 0.000030 seconds

 1577: 23.217070, 20.605820 avg loss, 0.001300 rate, 6.230716 seconds, 50464 images, 1352.768207 hours left
Loaded: 0.000038 seconds

 1578: 21.854996, 20.730738 avg loss, 0.001300 rate, 5.859304 seconds, 50496 images, 1347.875711 hours left
Loaded: 0.000031 seconds

 1579: 16.996515, 20.357315 avg loss, 0.001300 rate, 5.662851 seconds, 50528 images, 1342.517396 hours left
Loaded: 0.000037 seconds

 1580: 19.919455, 20.313530 avg loss, 0.001300 rate, 5.818246 seconds, 50560 images, 1336.940377 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.021046 seconds

 1581: 16.164114, 19.898588 avg loss, 0.001300 rate, 6.179026 seconds, 50592 images, 1331.634480 hours left
Loaded: 0.000027 seconds

 1582: 20.432432, 19.951973 avg loss, 0.001300 rate, 6.599708 seconds, 50624 images, 1326.910741 hours left
Loaded: 0.000038 seconds

 1583: 26.382719, 20.595047 avg loss, 0.001300 rate, 7.079835 seconds, 50656 images, 1322.788109 hours left
Loaded: 0.000041 seconds

 1584: 14.580538, 19.993595 avg loss, 0.001300 rate, 6.028272 seconds, 50688 images, 1319.372102 hours left
Loaded: 0.000037 seconds

 1585: 21.849142, 20.179150 avg loss, 0.001300 rate, 6.580549 seconds, 50720 images, 1314.532899 hours left
Loaded: 0.000038 seconds

 1586: 12.174020, 19.378637 avg loss, 0.001300 rate, 5.964964 seconds, 50752 images, 1310.507454 hours left
Loaded: 0.000039 seconds

 1587: 18.548660, 19.295639 avg loss, 0.001300 rate, 6.493859 seconds, 50784 images, 1305.669125 hours left
Loaded: 0.000031 seconds

 1588: 22.722084, 19.638283 avg loss, 0.001300 rate, 6.746587 seconds, 50816 images, 1301.612141 hours left
Loaded: 0.000038 seconds

 1589: 19.544968, 19.628952 avg loss, 0.001300 rate, 6.280250 seconds, 50848 images, 1297.945947 hours left
Loaded: 0.000034 seconds

 1590: 16.119808, 19.278038 avg loss, 0.001300 rate, 5.983249 seconds, 50880 images, 1293.670128 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 1591: 14.712377, 18.821472 avg loss, 0.001300 rate, 6.593843 seconds, 50912 images, 1289.025440 hours left
Loaded: 0.000030 seconds

 1592: 18.061598, 18.745485 avg loss, 0.001300 rate, 6.877248 seconds, 50944 images, 1285.273367 hours left
Loaded: 0.000032 seconds

 1593: 22.150417, 19.085979 avg loss, 0.001300 rate, 7.080678 seconds, 50976 images, 1281.951560 hours left
Loaded: 0.000030 seconds

 1594: 22.841978, 19.461578 avg loss, 0.001300 rate, 7.202270 seconds, 51008 images, 1278.944878 hours left
Loaded: 0.000031 seconds

 1595: 21.760403, 19.691462 avg loss, 0.001300 rate, 7.166442 seconds, 51040 images, 1276.136750 hours left
Loaded: 0.000029 seconds

 1596: 25.922997, 20.314615 avg loss, 0.001300 rate, 7.448330 seconds, 51072 images, 1273.307032 hours left
Loaded: 0.000037 seconds

 1597: 19.184038, 20.201557 avg loss, 0.001300 rate, 6.884917 seconds, 51104 images, 1270.896241 hours left
Loaded: 0.000040 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 1598: 17.205593, 19.901960 avg loss, 0.001300 rate, 6.717651 seconds, 51136 images, 1267.728749 hours left
Loaded: 0.000033 seconds

 1599: 26.767052, 20.588470 avg loss, 0.001300 rate, 7.269289 seconds, 51168 images, 1264.361122 hours left
Loaded: 0.000033 seconds

 1600: 15.833999, 20.113024 avg loss, 0.001300 rate, 6.605211 seconds, 51200 images, 1261.791613 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 1601: 21.967785, 20.298500 avg loss, 0.001300 rate, 13.904104 seconds, 51232 images, 1258.327477 hours left
Loaded: 0.000031 seconds

 1602: 19.443724, 20.213022 avg loss, 0.001300 rate, 13.010584 seconds, 51264 images, 1265.012987 hours left
Loaded: 0.000033 seconds

 1603: 17.163815, 19.908102 avg loss, 0.001300 rate, 13.177115 seconds, 51296 images, 1270.393341 hours left
Loaded: 0.000028 seconds

 1604: 18.587244, 19.776016 avg loss, 0.001300 rate, 13.383733 seconds, 51328 images, 1275.950643 hours left
Loaded: 0.000028 seconds

 1605: 19.912285, 19.789642 avg loss, 0.001300 rate, 13.624231 seconds, 51360 images, 1281.738664 hours left
Loaded: 0.000032 seconds

 1606: 22.315432, 20.042221 avg loss, 0.001300 rate, 14.053108 seconds, 51392 images, 1287.802054 hours left
Loaded: 0.000029 seconds

 1607: 19.724859, 20.010485 avg loss, 0.001300 rate, 13.357170 seconds, 51424 images, 1294.399123 hours left
Loaded: 0.000028 seconds

 1608: 18.431767, 19.852613 avg loss, 0.001300 rate, 13.178265 seconds, 51456 images, 1299.965738 hours left
Loaded: 0.000028 seconds

 1609: 17.659819, 19.633333 avg loss, 0.001300 rate, 13.213868 seconds, 51488 images, 1305.228719 hours left
Loaded: 0.000030 seconds

 1610: 22.752813, 19.945282 avg loss, 0.001300 rate, 14.121796 seconds, 51520 images, 1310.488371 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.314046 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1611: 17.414017, 19.692156 avg loss, 0.001300 rate, 6.775630 seconds, 51552 images, 1316.953606 hours left
Loaded: 0.000027 seconds

 1612: 12.309942, 18.953934 avg loss, 0.001300 rate, 6.426567 seconds, 51584 images, 1313.608974 hours left
Loaded: 0.000029 seconds

 1613: 18.746059, 18.933146 avg loss, 0.001300 rate, 6.858052 seconds, 51616 images, 1309.378871 hours left
Loaded: 0.000028 seconds

 1614: 18.013344, 18.841166 avg loss, 0.001300 rate, 6.888002 seconds, 51648 images, 1305.789005 hours left
Loaded: 0.000028 seconds

 1615: 16.938465, 18.650896 avg loss, 0.001300 rate, 6.812934 seconds, 51680 images, 1302.276519 hours left
Loaded: 0.000029 seconds

 1616: 22.291666, 19.014973 avg loss, 0.001300 rate, 7.383381 seconds, 51712 images, 1298.695113 hours left
Loaded: 0.000029 seconds

 1617: 24.550589, 19.568535 avg loss, 0.001300 rate, 7.596712 seconds, 51744 images, 1295.940023 hours left
Loaded: 0.000028 seconds

 1618: 17.791960, 19.390877 avg loss, 0.001300 rate, 7.037029 seconds, 51776 images, 1293.508093 hours left
Loaded: 0.000030 seconds

 1619: 16.008495, 19.052639 avg loss, 0.001300 rate, 6.895030 seconds, 51808 images, 1290.324861 hours left
Loaded: 0.000028 seconds

 1620: 19.697205, 19.117096 avg loss, 0.001300 rate, 7.124339 seconds, 51840 images, 1286.976665 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000036 seconds

 1621: 21.425714, 19.347958 avg loss, 0.001300 rate, 14.921379 seconds, 51872 images, 1283.979700 hours left
Loaded: 0.000029 seconds

 1622: 19.929630, 19.406124 avg loss, 0.001300 rate, 14.320077 seconds, 51904 images, 1291.817640 hours left
Loaded: 0.000029 seconds

 1623: 22.680313, 19.733543 avg loss, 0.001300 rate, 14.728570 seconds, 51936 images, 1298.743883 hours left
Loaded: 0.000028 seconds

 1624: 21.175602, 19.877748 avg loss, 0.001300 rate, 14.873918 seconds, 51968 images, 1306.166899 hours left
Loaded: 0.000028 seconds

 1625: 27.618622, 20.651836 avg loss, 0.001300 rate, 16.532851 seconds, 52000 images, 1313.717061 hours left
Loaded: 0.000028 seconds

 1626: 21.258507, 20.712503 avg loss, 0.001300 rate, 15.132941 seconds, 52032 images, 1323.490585 hours left
Loaded: 0.000030 seconds

 1627: 10.957673, 19.737020 avg loss, 0.001300 rate, 13.145576 seconds, 52064 images, 1331.226373 hours left
Loaded: 0.000029 seconds

 1628: 20.138819, 19.777201 avg loss, 0.001300 rate, 15.232360 seconds, 52096 images, 1336.130775 hours left
Loaded: 0.000033 seconds

 1629: 24.280457, 20.227526 avg loss, 0.001300 rate, 15.956403 seconds, 52128 images, 1343.877849 hours left
Loaded: 0.000029 seconds

 1630: 20.735643, 20.278337 avg loss, 0.001300 rate, 15.105534 seconds, 52160 images, 1352.550759 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.321478 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1631: 20.811195, 20.331623 avg loss, 0.001300 rate, 5.761249 seconds, 52192 images, 1359.957799 hours left
Loaded: 0.000040 seconds

 1632: 19.018246, 20.200285 avg loss, 0.001300 rate, 5.885566 seconds, 52224 images, 1354.787357 hours left
Loaded: 0.000039 seconds

 1633: 13.829329, 19.563189 avg loss, 0.001300 rate, 5.077433 seconds, 52256 images, 1349.395441 hours left
Loaded: 0.000039 seconds

 1634: 14.949261, 19.101795 avg loss, 0.001300 rate, 5.186742 seconds, 52288 images, 1342.937563 hours left
Loaded: 0.000036 seconds

 1635: 15.661473, 18.757763 avg loss, 0.001300 rate, 5.236796 seconds, 52320 images, 1336.695725 hours left
Loaded: 0.000038 seconds

 1636: 22.104939, 19.092480 avg loss, 0.001300 rate, 5.699669 seconds, 52352 images, 1330.585647 hours left
Loaded: 0.000036 seconds

 1637: 25.886827, 19.771915 avg loss, 0.001300 rate, 5.757849 seconds, 52384 images, 1325.178077 hours left
Loaded: 0.000037 seconds

 1638: 18.935114, 19.688236 avg loss, 0.001300 rate, 5.226635 seconds, 52416 images, 1319.905184 hours left
Loaded: 0.000037 seconds

 1639: 17.114164, 19.430828 avg loss, 0.001300 rate, 5.386443 seconds, 52448 images, 1313.948890 hours left
Loaded: 0.000030 seconds

 1640: 22.505386, 19.738283 avg loss, 0.001300 rate, 5.856300 seconds, 52480 images, 1308.273594 hours left
Resizing, random_coef = 1.40 

 384 x 384 
 try to allocate additional workspace_size = 42.47 MB 
 CUDA allocate done! 
Loaded: 0.326476 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1641: 20.420759, 19.806530 avg loss, 0.001300 rate, 5.070618 seconds, 52512 images, 1303.306118 hours left
Loaded: 0.000040 seconds

 1642: 29.599722, 20.785849 avg loss, 0.001300 rate, 5.314771 seconds, 52544 images, 1297.751927 hours left
Loaded: 0.000038 seconds

 1643: 15.723553, 20.279619 avg loss, 0.001300 rate, 4.675868 seconds, 52576 images, 1292.139243 hours left
Loaded: 0.000030 seconds

 1644: 19.645920, 20.216249 avg loss, 0.001300 rate, 4.729581 seconds, 52608 images, 1285.697331 hours left
Loaded: 0.000032 seconds

 1645: 17.931286, 19.987753 avg loss, 0.001300 rate, 4.765056 seconds, 52640 images, 1279.394247 hours left
Loaded: 0.000038 seconds

 1646: 19.144789, 19.903456 avg loss, 0.001300 rate, 4.923701 seconds, 52672 images, 1273.203340 hours left
Loaded: 0.000037 seconds

 1647: 22.615170, 20.174627 avg loss, 0.001300 rate, 5.066258 seconds, 52704 images, 1267.294173 hours left
Loaded: 0.000037 seconds

 1648: 16.783422, 19.835506 avg loss, 0.001300 rate, 4.771772 seconds, 52736 images, 1261.641629 hours left
Loaded: 0.000038 seconds

 1649: 24.330540, 20.285009 avg loss, 0.001300 rate, 5.172601 seconds, 52768 images, 1255.637523 hours left
Loaded: 0.000031 seconds

 1650: 19.608534, 20.217361 avg loss, 0.001300 rate, 4.912245 seconds, 52800 images, 1250.248874 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.027437 seconds

 1651: 19.488153, 20.144440 avg loss, 0.001300 rate, 5.731570 seconds, 52832 images, 1244.553312 hours left
Loaded: 0.000031 seconds

 1652: 19.774504, 20.107447 avg loss, 0.001300 rate, 5.682735 seconds, 52864 images, 1240.088002 hours left
Loaded: 0.000040 seconds

 1653: 15.909560, 19.687658 avg loss, 0.001300 rate, 5.469599 seconds, 52896 images, 1235.561694 hours left
Loaded: 0.000032 seconds

 1654: 25.430075, 20.261900 avg loss, 0.001300 rate, 6.206194 seconds, 52928 images, 1230.785293 hours left
Loaded: 0.000029 seconds

 1655: 23.517954, 20.587505 avg loss, 0.001300 rate, 6.165263 seconds, 52960 images, 1227.077318 hours left
Loaded: 0.000030 seconds

 1656: 26.345158, 21.163271 avg loss, 0.001300 rate, 6.353308 seconds, 52992 images, 1223.349684 hours left
Loaded: 0.000031 seconds

 1657: 16.447449, 20.691689 avg loss, 0.001300 rate, 5.578722 seconds, 53024 images, 1219.919879 hours left
Loaded: 0.000035 seconds

 1658: 20.422842, 20.664804 avg loss, 0.001300 rate, 5.813516 seconds, 53056 images, 1215.451033 hours left
Loaded: 0.000038 seconds

 1659: 20.995985, 20.697922 avg loss, 0.001300 rate, 5.960096 seconds, 53088 images, 1211.352211 hours left
Loaded: 0.000030 seconds

 1660: 18.957102, 20.523840 avg loss, 0.001300 rate, 5.856783 seconds, 53120 images, 1207.497479 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000032 seconds

 1661: 27.255360, 21.196993 avg loss, 0.001300 rate, 14.109054 seconds, 53152 images, 1203.538107 hours left
Loaded: 0.000029 seconds

 1662: 12.945096, 20.371803 avg loss, 0.001300 rate, 11.741470 seconds, 53184 images, 1211.053191 hours left
Loaded: 0.000028 seconds

 1663: 27.135506, 21.048174 avg loss, 0.001300 rate, 14.305673 seconds, 53216 images, 1215.212411 hours left
Loaded: 0.000029 seconds

 1664: 24.046440, 21.348000 avg loss, 0.001300 rate, 13.712493 seconds, 53248 images, 1222.883116 hours left
Loaded: 0.000030 seconds

 1665: 22.887865, 21.501986 avg loss, 0.001300 rate, 13.270949 seconds, 53280 images, 1229.655133 hours left
Loaded: 0.000032 seconds

 1666: 22.607531, 21.612539 avg loss, 0.001300 rate, 13.539778 seconds, 53312 images, 1235.747564 hours left
Loaded: 0.000029 seconds

 1667: 23.370907, 21.788376 avg loss, 0.001300 rate, 13.637814 seconds, 53344 images, 1242.151540 hours left
Loaded: 0.000028 seconds

 1668: 19.140453, 21.523584 avg loss, 0.001300 rate, 12.077746 seconds, 53376 images, 1248.627277 hours left
Loaded: 0.000029 seconds

 1669: 16.946283, 21.065855 avg loss, 0.001300 rate, 11.850830 seconds, 53408 images, 1252.876518 hours left
Loaded: 0.000028 seconds

 1670: 22.808073, 21.240076 avg loss, 0.001300 rate, 12.815836 seconds, 53440 images, 1256.768811 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.268637 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1671: 15.571893, 20.673258 avg loss, 0.001300 rate, 6.855348 seconds, 53472 images, 1261.959297 hours left
Loaded: 0.000033 seconds

 1672: 17.711826, 20.377115 avg loss, 0.001300 rate, 7.120249 seconds, 53504 images, 1259.210967 hours left
Loaded: 0.000039 seconds

 1673: 23.638107, 20.703215 avg loss, 0.001300 rate, 7.505013 seconds, 53536 images, 1256.484991 hours left
Loaded: 0.000040 seconds

 1674: 14.513447, 20.084238 avg loss, 0.001300 rate, 6.687392 seconds, 53568 images, 1254.319383 hours left
Loaded: 0.000038 seconds

 1675: 23.106340, 20.386448 avg loss, 0.001300 rate, 7.457143 seconds, 53600 images, 1251.042495 hours left
Loaded: 0.000037 seconds

 1676: 24.456463, 20.793449 avg loss, 0.001300 rate, 7.640218 seconds, 53632 images, 1248.864940 hours left
Loaded: 0.000038 seconds

 1677: 21.318394, 20.845943 avg loss, 0.001300 rate, 7.261265 seconds, 53664 images, 1246.962810 hours left
Loaded: 0.000029 seconds

 1678: 19.270655, 20.688416 avg loss, 0.001300 rate, 7.055816 seconds, 53696 images, 1244.554599 hours left
Loaded: 0.000031 seconds

 1679: 19.545031, 20.574078 avg loss, 0.001300 rate, 7.160984 seconds, 53728 images, 1241.885763 hours left
Loaded: 0.000029 seconds

 1680: 20.951077, 20.611778 avg loss, 0.001300 rate, 7.258370 seconds, 53760 images, 1239.389320 hours left
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 1681: 14.585453, 20.009146 avg loss, 0.001300 rate, 8.568704 seconds, 53792 images, 1237.052759 hours left
Loaded: 0.000031 seconds

 1682: 18.692303, 19.877460 avg loss, 0.001300 rate, 8.927198 seconds, 53824 images, 1236.555150 hours left
Loaded: 0.000029 seconds

 1683: 20.413830, 19.931097 avg loss, 0.001300 rate, 9.249560 seconds, 53856 images, 1236.559230 hours left
Loaded: 0.000039 seconds

 1684: 20.759541, 20.013941 avg loss, 0.001300 rate, 9.174140 seconds, 53888 images, 1237.009907 hours left
Loaded: 0.000031 seconds

 1685: 17.123301, 19.724876 avg loss, 0.001300 rate, 8.860132 seconds, 53920 images, 1237.351562 hours left
Loaded: 0.000027 seconds

 1686: 21.951710, 19.947559 avg loss, 0.001300 rate, 9.817742 seconds, 53952 images, 1237.254677 hours left
Loaded: 0.000033 seconds

 1687: 20.874020, 20.040205 avg loss, 0.001300 rate, 9.638289 seconds, 53984 images, 1238.485591 hours left
Loaded: 0.000040 seconds

 1688: 21.688969, 20.205082 avg loss, 0.001300 rate, 9.362876 seconds, 54016 images, 1239.455528 hours left
Loaded: 0.000032 seconds

 1689: 19.303631, 20.114937 avg loss, 0.001300 rate, 9.617361 seconds, 54048 images, 1240.034140 hours left
Loaded: 0.000029 seconds

 1690: 18.668242, 19.970268 avg loss, 0.001300 rate, 9.268160 seconds, 54080 images, 1240.959538 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.414231 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1691: 18.492132, 19.822454 avg loss, 0.001300 rate, 8.530442 seconds, 54112 images, 1241.391803 hours left
Loaded: 0.000028 seconds

 1692: 21.312124, 19.971422 avg loss, 0.001300 rate, 8.708464 seconds, 54144 images, 1241.371464 hours left
Loaded: 0.000029 seconds

 1693: 14.406722, 19.414951 avg loss, 0.001300 rate, 7.974491 seconds, 54176 images, 1241.024056 hours left
Loaded: 0.000040 seconds

 1694: 22.896606, 19.763117 avg loss, 0.001300 rate, 9.033760 seconds, 54208 images, 1239.663124 hours left
Loaded: 0.000037 seconds

 1695: 20.059433, 19.792747 avg loss, 0.001300 rate, 8.574481 seconds, 54240 images, 1239.783487 hours left
Loaded: 0.000041 seconds

 1696: 26.476809, 20.461153 avg loss, 0.001300 rate, 9.477331 seconds, 54272 images, 1239.266255 hours left
Loaded: 0.000041 seconds

 1697: 16.635168, 20.078554 avg loss, 0.001300 rate, 7.565409 seconds, 54304 images, 1240.005137 hours left
Loaded: 0.000026 seconds

 1698: 17.716305, 19.842329 avg loss, 0.001300 rate, 7.710668 seconds, 54336 images, 1238.087511 hours left
Loaded: 0.000034 seconds

 1699: 15.302001, 19.388296 avg loss, 0.001300 rate, 7.424538 seconds, 54368 images, 1236.390286 hours left
Loaded: 0.000023 seconds

 1700: 15.554127, 19.004879 avg loss, 0.001300 rate, 7.167874 seconds, 54400 images, 1234.313573 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.499454 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1701: 19.699768, 19.074368 avg loss, 0.001300 rate, 8.129686 seconds, 54432 images, 1231.901968 hours left
Loaded: 0.000030 seconds

 1702: 17.704445, 18.937376 avg loss, 0.001300 rate, 8.028090 seconds, 54464 images, 1231.539091 hours left
Loaded: 0.000028 seconds

 1703: 21.468937, 19.190533 avg loss, 0.001300 rate, 8.250050 seconds, 54496 images, 1230.347074 hours left
Loaded: 0.000039 seconds

 1704: 21.922920, 19.463772 avg loss, 0.001300 rate, 8.037093 seconds, 54528 images, 1229.474490 hours left
Loaded: 0.000026 seconds

 1705: 21.608656, 19.678261 avg loss, 0.001300 rate, 7.995962 seconds, 54560 images, 1228.315561 hours left
Loaded: 0.000030 seconds

 1706: 18.472719, 19.557707 avg loss, 0.001300 rate, 7.567096 seconds, 54592 images, 1227.111191 hours left
Loaded: 0.000035 seconds

 1707: 21.907433, 19.792679 avg loss, 0.001300 rate, 7.941440 seconds, 54624 images, 1225.324639 hours left
Loaded: 0.000026 seconds

 1708: 18.823862, 19.695797 avg loss, 0.001300 rate, 7.600257 seconds, 54656 images, 1224.074606 hours left
Loaded: 0.000027 seconds

 1709: 18.550312, 19.581249 avg loss, 0.001300 rate, 7.802775 seconds, 54688 images, 1222.364330 hours left
Loaded: 0.000034 seconds

 1710: 23.825403, 20.005665 avg loss, 0.001300 rate, 8.286850 seconds, 54720 images, 1220.951720 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.249408 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1711: 19.611279, 19.966227 avg loss, 0.001300 rate, 5.856637 seconds, 54752 images, 1220.223923 hours left
Loaded: 0.000030 seconds

 1712: 17.793514, 19.748955 avg loss, 0.001300 rate, 5.596259 seconds, 54784 images, 1216.481776 hours left
Loaded: 0.000041 seconds

 1713: 22.961321, 20.070190 avg loss, 0.001300 rate, 5.900796 seconds, 54816 images, 1212.070754 hours left
Loaded: 0.000030 seconds

 1714: 22.544338, 20.317606 avg loss, 0.001300 rate, 5.789829 seconds, 54848 images, 1208.125783 hours left
Loaded: 0.000029 seconds

 1715: 19.927820, 20.278627 avg loss, 0.001300 rate, 5.889034 seconds, 54880 images, 1204.066484 hours left
Loaded: 0.000025 seconds

 1716: 20.683121, 20.319077 avg loss, 0.001300 rate, 5.607266 seconds, 54912 images, 1200.185213 hours left
Loaded: 0.000026 seconds

 1717: 17.898310, 20.077000 avg loss, 0.001300 rate, 5.577162 seconds, 54944 images, 1195.952336 hours left
Loaded: 0.000035 seconds

 1718: 18.666531, 19.935953 avg loss, 0.001300 rate, 5.543969 seconds, 54976 images, 1191.720065 hours left
Loaded: 0.000029 seconds

 1719: 23.600010, 20.302359 avg loss, 0.001300 rate, 5.773597 seconds, 55008 images, 1187.484126 hours left
Loaded: 0.000029 seconds

 1720: 16.499247, 19.922047 avg loss, 0.001300 rate, 5.430295 seconds, 55040 images, 1183.608672 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.008231 seconds

 1721: 24.673462, 20.397188 avg loss, 0.001300 rate, 10.446968 seconds, 55072 images, 1179.296312 hours left
Loaded: 0.000028 seconds

 1722: 22.697378, 20.627207 avg loss, 0.001300 rate, 10.032886 seconds, 55104 images, 1181.989012 hours left
Loaded: 0.000028 seconds

 1723: 21.231930, 20.687679 avg loss, 0.001300 rate, 9.981305 seconds, 55136 images, 1184.069680 hours left
Loaded: 0.000027 seconds

 1724: 19.557158, 20.574627 avg loss, 0.001300 rate, 9.695096 seconds, 55168 images, 1186.058050 hours left
Loaded: 0.000035 seconds

 1725: 17.312164, 20.248381 avg loss, 0.001300 rate, 9.600000 seconds, 55200 images, 1187.629967 hours left
Loaded: 0.000029 seconds

 1726: 16.136400, 19.837183 avg loss, 0.001300 rate, 9.276569 seconds, 55232 images, 1189.054395 hours left
Loaded: 0.000027 seconds

 1727: 11.330139, 18.986479 avg loss, 0.001300 rate, 8.982803 seconds, 55264 images, 1190.016436 hours left
Loaded: 0.000035 seconds

 1728: 19.988979, 19.086729 avg loss, 0.001300 rate, 9.960771 seconds, 55296 images, 1190.561822 hours left
Loaded: 0.000034 seconds

 1729: 13.211423, 18.499199 avg loss, 0.001300 rate, 9.006215 seconds, 55328 images, 1192.456691 hours left
Loaded: 0.000036 seconds

 1730: 16.058033, 18.255083 avg loss, 0.001300 rate, 9.534913 seconds, 55360 images, 1193.010070 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.325764 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1731: 18.498301, 18.279406 avg loss, 0.001300 rate, 5.355940 seconds, 55392 images, 1194.290387 hours left
Loaded: 0.000037 seconds

 1732: 20.820717, 18.533537 avg loss, 0.001300 rate, 5.442703 seconds, 55424 images, 1190.219323 hours left
Loaded: 0.000027 seconds

 1733: 19.868879, 18.667070 avg loss, 0.001300 rate, 5.525611 seconds, 55456 images, 1185.857876 hours left
Loaded: 0.000030 seconds

 1734: 20.435787, 18.843943 avg loss, 0.001300 rate, 5.572661 seconds, 55488 images, 1181.654881 hours left
Loaded: 0.000027 seconds

 1735: 22.367760, 19.196325 avg loss, 0.001300 rate, 5.701480 seconds, 55520 images, 1177.559090 hours left
Loaded: 0.000032 seconds

 1736: 20.992477, 19.375940 avg loss, 0.001300 rate, 5.737121 seconds, 55552 images, 1173.682726 hours left
Loaded: 0.000025 seconds

 1737: 21.458569, 19.584204 avg loss, 0.001300 rate, 5.632642 seconds, 55584 images, 1169.894489 hours left
Loaded: 0.000038 seconds

 1738: 21.164127, 19.742197 avg loss, 0.001300 rate, 5.588702 seconds, 55616 images, 1165.999350 hours left
Loaded: 0.000041 seconds

 1739: 20.042717, 19.772249 avg loss, 0.001300 rate, 5.500095 seconds, 55648 images, 1162.082290 hours left
Loaded: 0.000039 seconds

 1740: 12.507635, 19.045788 avg loss, 0.001300 rate, 5.184438 seconds, 55680 images, 1158.081629 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.041398 seconds

 1741: 16.862064, 18.827415 avg loss, 0.001300 rate, 9.490446 seconds, 55712 images, 1153.683632 hours left
Loaded: 0.000028 seconds

 1742: 23.520487, 19.296722 avg loss, 0.001300 rate, 10.398007 seconds, 55744 images, 1155.352622 hours left
Loaded: 0.000038 seconds

 1743: 23.755924, 19.742643 avg loss, 0.001300 rate, 10.968486 seconds, 55776 images, 1158.204951 hours left
Loaded: 0.000029 seconds

 1744: 21.379511, 19.906330 avg loss, 0.001300 rate, 10.654122 seconds, 55808 images, 1161.819105 hours left
Loaded: 0.000030 seconds

 1745: 23.377380, 20.253435 avg loss, 0.001300 rate, 11.069297 seconds, 55840 images, 1164.961544 hours left
Loaded: 0.000030 seconds

 1746: 24.383034, 20.666395 avg loss, 0.001300 rate, 10.938981 seconds, 55872 images, 1168.647726 hours left
Loaded: 0.000029 seconds

 1747: 21.994438, 20.799200 avg loss, 0.001300 rate, 10.910515 seconds, 55904 images, 1172.116472 hours left
Loaded: 0.000040 seconds

 1748: 21.416719, 20.860952 avg loss, 0.001300 rate, 10.689581 seconds, 55936 images, 1175.511060 hours left
Loaded: 0.000028 seconds

 1749: 14.484792, 20.223337 avg loss, 0.001300 rate, 9.762177 seconds, 55968 images, 1178.565602 hours left
Loaded: 0.000030 seconds

 1750: 18.719156, 20.072920 avg loss, 0.001300 rate, 10.440193 seconds, 56000 images, 1180.304708 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.492911 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1751: 21.082727, 20.173901 avg loss, 0.001300 rate, 10.823486 seconds, 56032 images, 1182.965734 hours left
Loaded: 0.000038 seconds

 1752: 17.935812, 19.950092 avg loss, 0.001300 rate, 10.411330 seconds, 56064 images, 1186.813984 hours left
Loaded: 0.000040 seconds

 1753: 23.139246, 20.269009 avg loss, 0.001300 rate, 11.022330 seconds, 56096 images, 1189.369883 hours left
Loaded: 0.000041 seconds

 1754: 18.321741, 20.074282 avg loss, 0.001300 rate, 10.309942 seconds, 56128 images, 1192.746682 hours left
Loaded: 0.000039 seconds

 1755: 22.235292, 20.290382 avg loss, 0.001300 rate, 10.960421 seconds, 56160 images, 1195.102738 hours left
Loaded: 0.000030 seconds

 1756: 23.610769, 20.622421 avg loss, 0.001300 rate, 10.292029 seconds, 56192 images, 1198.336374 hours left
Loaded: 0.000026 seconds

 1757: 20.173485, 20.577528 avg loss, 0.001300 rate, 10.366919 seconds, 56224 images, 1200.611642 hours left
Loaded: 0.000035 seconds

 1758: 17.559525, 20.275728 avg loss, 0.001300 rate, 9.726981 seconds, 56256 images, 1202.967874 hours left
Loaded: 0.000034 seconds

 1759: 17.585171, 20.006672 avg loss, 0.001300 rate, 10.194730 seconds, 56288 images, 1204.413961 hours left
Loaded: 0.000029 seconds

 1760: 19.437965, 19.949800 avg loss, 0.001300 rate, 10.521392 seconds, 56320 images, 1206.493576 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000031 seconds

 1761: 22.892555, 20.244076 avg loss, 0.001300 rate, 16.706135 seconds, 56352 images, 1209.004914 hours left
Loaded: 0.000023 seconds

 1762: 15.301960, 19.749865 avg loss, 0.001300 rate, 14.823958 seconds, 56384 images, 1220.059369 hours left
Loaded: 0.000027 seconds

 1763: 19.764170, 19.751295 avg loss, 0.001300 rate, 16.970493 seconds, 56416 images, 1228.395695 hours left
Loaded: 0.000030 seconds

 1764: 14.232155, 19.199381 avg loss, 0.001300 rate, 14.924780 seconds, 56448 images, 1239.622380 hours left
Loaded: 0.000029 seconds

 1765: 13.337010, 18.613144 avg loss, 0.001300 rate, 15.279202 seconds, 56480 images, 1247.902668 hours left
Loaded: 0.000037 seconds

 1766: 23.116154, 19.063444 avg loss, 0.001300 rate, 17.718975 seconds, 56512 images, 1256.591120 hours left
Loaded: 0.000028 seconds

 1767: 22.965841, 19.453684 avg loss, 0.001300 rate, 16.823383 seconds, 56544 images, 1268.572650 hours left
Loaded: 0.000029 seconds

 1768: 26.172861, 20.125601 avg loss, 0.001300 rate, 17.873059 seconds, 56576 images, 1279.193575 hours left
Loaded: 0.000033 seconds

 1769: 27.420067, 20.855047 avg loss, 0.001300 rate, 18.438608 seconds, 56608 images, 1291.162435 hours left
Loaded: 0.000032 seconds

 1770: 17.227322, 20.492275 avg loss, 0.001300 rate, 15.598870 seconds, 56640 images, 1303.795051 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.668343 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1771: 23.185316, 20.761580 avg loss, 0.001300 rate, 16.061494 seconds, 56672 images, 1312.367224 hours left
Loaded: 0.000029 seconds

 1772: 15.625375, 20.247959 avg loss, 0.001300 rate, 13.993691 seconds, 56704 images, 1322.420384 hours left
Loaded: 0.000039 seconds

 1773: 15.848266, 19.807989 avg loss, 0.001300 rate, 13.754122 seconds, 56736 images, 1328.582472 hours left
Loaded: 0.000028 seconds

 1774: 22.586111, 20.085802 avg loss, 0.001300 rate, 14.940286 seconds, 56768 images, 1334.351025 hours left
Loaded: 0.000027 seconds

 1775: 22.749241, 20.352146 avg loss, 0.001300 rate, 15.128816 seconds, 56800 images, 1341.705091 hours left
Loaded: 0.000028 seconds

 1776: 23.602280, 20.677160 avg loss, 0.001300 rate, 15.189899 seconds, 56832 images, 1349.246752 hours left
Loaded: 0.000028 seconds

 1777: 15.435717, 20.153015 avg loss, 0.001300 rate, 13.519181 seconds, 56864 images, 1356.797578 hours left
Loaded: 0.000023 seconds

 1778: 11.428118, 19.280525 avg loss, 0.001300 rate, 13.626675 seconds, 56896 images, 1361.958338 hours left
Loaded: 0.000040 seconds

 1779: 14.087012, 18.761173 avg loss, 0.001300 rate, 14.178123 seconds, 56928 images, 1367.216365 hours left
Loaded: 0.000037 seconds

 1780: 11.961813, 18.081238 avg loss, 0.001300 rate, 13.695182 seconds, 56960 images, 1373.185737 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.346817 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1781: 22.814398, 18.554554 avg loss, 0.001300 rate, 6.390965 seconds, 56992 images, 1378.426336 hours left
Loaded: 0.000029 seconds

 1782: 21.826122, 18.881710 avg loss, 0.001300 rate, 6.276688 seconds, 57024 images, 1373.976141 hours left
Loaded: 0.000026 seconds

 1783: 20.874170, 19.080956 avg loss, 0.001300 rate, 5.993503 seconds, 57056 images, 1368.931702 hours left
Loaded: 0.000029 seconds

 1784: 16.433943, 18.816254 avg loss, 0.001300 rate, 5.807798 seconds, 57088 images, 1363.545383 hours left
Loaded: 0.000040 seconds

 1785: 19.315054, 18.866135 avg loss, 0.001300 rate, 5.724356 seconds, 57120 images, 1357.955654 hours left
Loaded: 0.000028 seconds

 1786: 19.886187, 18.968140 avg loss, 0.001300 rate, 5.588548 seconds, 57152 images, 1352.306228 hours left
Loaded: 0.000028 seconds

 1787: 24.710430, 19.542368 avg loss, 0.001300 rate, 5.901165 seconds, 57184 images, 1346.525125 hours left
Loaded: 0.000029 seconds

 1788: 20.699654, 19.658096 avg loss, 0.001300 rate, 5.566225 seconds, 57216 images, 1341.234891 hours left
Loaded: 0.000028 seconds

 1789: 19.334059, 19.625692 avg loss, 0.001300 rate, 5.448007 seconds, 57248 images, 1335.533548 hours left
Loaded: 0.000031 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 1790: 16.112810, 19.274405 avg loss, 0.001300 rate, 5.207912 seconds, 57280 images, 1329.725433 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.004001 seconds

 1791: 17.654549, 19.112419 avg loss, 0.001300 rate, 6.984004 seconds, 57312 images, 1323.642797 hours left
Loaded: 0.000030 seconds

 1792: 27.774609, 19.978638 avg loss, 0.001300 rate, 7.864286 seconds, 57344 images, 1320.086886 hours left
Loaded: 0.000030 seconds

 1793: 15.899307, 19.570705 avg loss, 0.001300 rate, 6.857807 seconds, 57376 images, 1317.780468 hours left
Loaded: 0.000039 seconds

 1794: 19.969809, 19.610615 avg loss, 0.001300 rate, 7.197571 seconds, 57408 images, 1314.102818 hours left
Loaded: 0.000038 seconds

 1795: 18.477320, 19.497286 avg loss, 0.001300 rate, 7.112504 seconds, 57440 images, 1310.932613 hours left
Loaded: 0.000038 seconds

 1796: 23.220272, 19.869585 avg loss, 0.001300 rate, 7.543978 seconds, 57472 images, 1307.676245 hours left
Loaded: 0.000029 seconds

 1797: 32.902180, 21.172844 avg loss, 0.001300 rate, 8.550969 seconds, 57504 images, 1305.050138 hours left
Loaded: 0.000034 seconds

 1798: 21.052614, 21.160822 avg loss, 0.001300 rate, 7.441232 seconds, 57536 images, 1303.845230 hours left
Loaded: 0.000030 seconds

 1799: 21.236912, 21.168430 avg loss, 0.001300 rate, 7.400043 seconds, 57568 images, 1301.115053 hours left
Loaded: 0.000037 seconds

 1800: 15.412783, 20.592865 avg loss, 0.001300 rate, 6.904596 seconds, 57600 images, 1298.355092 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.144267 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1801: 27.410599, 21.274639 avg loss, 0.001300 rate, 9.060197 seconds, 57632 images, 1294.936394 hours left
Loaded: 0.000029 seconds

 1802: 15.438034, 20.690979 avg loss, 0.001300 rate, 7.952326 seconds, 57664 images, 1294.737757 hours left
Loaded: 0.000037 seconds

 1803: 15.088674, 20.130749 avg loss, 0.001300 rate, 7.813033 seconds, 57696 images, 1292.806569 hours left
Loaded: 0.000039 seconds

 1804: 24.075611, 20.525234 avg loss, 0.001300 rate, 8.854901 seconds, 57728 images, 1290.701725 hours left
Loaded: 0.000031 seconds

 1805: 22.880287, 20.760740 avg loss, 0.001300 rate, 8.123194 seconds, 57760 images, 1290.061173 hours left
Loaded: 0.000027 seconds

 1806: 18.468538, 20.531521 avg loss, 0.001300 rate, 7.789942 seconds, 57792 images, 1288.413383 hours left
Loaded: 0.000027 seconds

 1807: 19.691898, 20.447559 avg loss, 0.001300 rate, 7.720103 seconds, 57824 images, 1286.320403 hours left
Loaded: 0.000026 seconds

 1808: 21.171545, 20.519958 avg loss, 0.001300 rate, 8.044949 seconds, 57856 images, 1284.151584 hours left
Loaded: 0.000035 seconds

 1809: 19.582685, 20.426231 avg loss, 0.001300 rate, 7.669273 seconds, 57888 images, 1282.454425 hours left
Loaded: 0.000034 seconds

 1810: 25.528515, 20.936460 avg loss, 0.001300 rate, 8.157000 seconds, 57920 images, 1280.253823 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.000041 seconds

 1811: 16.834404, 20.526255 avg loss, 0.001300 rate, 10.224010 seconds, 57952 images, 1278.750828 hours left
Loaded: 0.000035 seconds

 1812: 13.036689, 19.777298 avg loss, 0.001300 rate, 9.676256 seconds, 57984 images, 1280.126170 hours left
Loaded: 0.000037 seconds

 1813: 11.238931, 18.923462 avg loss, 0.001300 rate, 9.503508 seconds, 58016 images, 1280.728949 hours left
Loaded: 0.000035 seconds

 1814: 20.687433, 19.099859 avg loss, 0.001300 rate, 10.861817 seconds, 58048 images, 1281.086379 hours left
Loaded: 0.000026 seconds

 1815: 18.618967, 19.051769 avg loss, 0.001300 rate, 10.611045 seconds, 58080 images, 1283.321787 hours left
Loaded: 0.000025 seconds

 1816: 20.204910, 19.167084 avg loss, 0.001300 rate, 10.727614 seconds, 58112 images, 1285.187420 hours left
Loaded: 0.000035 seconds

 1817: 22.827524, 19.533127 avg loss, 0.001300 rate, 10.994669 seconds, 58144 images, 1287.195842 hours left
Loaded: 0.000025 seconds

 1818: 16.989733, 19.278788 avg loss, 0.001300 rate, 10.410787 seconds, 58176 images, 1289.554095 hours left
Loaded: 0.000034 seconds

 1819: 15.076584, 18.858566 avg loss, 0.001300 rate, 10.030881 seconds, 58208 images, 1291.079928 hours left
Loaded: 0.000036 seconds

 1820: 25.257925, 19.498503 avg loss, 0.001300 rate, 11.507425 seconds, 58240 images, 1292.064216 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.405628 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1821: 17.540634, 19.302715 avg loss, 0.001300 rate, 8.786588 seconds, 58272 images, 1295.083975 hours left
Loaded: 0.000035 seconds

 1822: 24.997669, 19.872211 avg loss, 0.001300 rate, 9.561282 seconds, 58304 images, 1294.866386 hours left
Loaded: 0.000028 seconds

 1823: 22.104847, 20.095474 avg loss, 0.001300 rate, 9.151753 seconds, 58336 images, 1295.162230 hours left
Loaded: 0.000028 seconds

 1824: 15.603239, 19.646252 avg loss, 0.001300 rate, 8.450280 seconds, 58368 images, 1294.887794 hours left
Loaded: 0.000039 seconds

 1825: 19.781214, 19.659748 avg loss, 0.001300 rate, 8.966114 seconds, 58400 images, 1293.644389 hours left
Loaded: 0.000032 seconds

 1826: 21.942968, 19.888069 avg loss, 0.001300 rate, 9.386831 seconds, 58432 images, 1293.127948 hours left
Loaded: 0.000051 seconds

 1827: 27.841314, 20.683393 avg loss, 0.001300 rate, 9.863289 seconds, 58464 images, 1293.199415 hours left
Loaded: 0.000032 seconds

 1828: 18.790867, 20.494141 avg loss, 0.001300 rate, 9.070799 seconds, 58496 images, 1293.930163 hours left
Loaded: 0.000030 seconds

 1829: 17.151382, 20.159864 avg loss, 0.001300 rate, 9.078779 seconds, 58528 images, 1293.555789 hours left
Loaded: 0.000038 seconds

 1830: 22.963116, 20.440189 avg loss, 0.001300 rate, 9.652326 seconds, 58560 images, 1293.196186 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.338255 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1831: 18.902994, 20.286470 avg loss, 0.001300 rate, 5.759621 seconds, 58592 images, 1293.634639 hours left
Loaded: 0.000033 seconds

 1832: 23.639914, 20.621815 avg loss, 0.001300 rate, 6.085927 seconds, 58624 images, 1289.145035 hours left
Loaded: 0.000030 seconds

 1833: 24.335817, 20.993216 avg loss, 0.001300 rate, 6.231637 seconds, 58656 images, 1284.683804 hours left
Loaded: 0.000030 seconds

 1834: 24.278963, 21.321791 avg loss, 0.001300 rate, 6.233756 seconds, 58688 images, 1280.468998 hours left
Loaded: 0.000030 seconds

 1835: 22.925451, 21.482157 avg loss, 0.001300 rate, 6.095513 seconds, 58720 images, 1276.299258 hours left
Loaded: 0.000031 seconds

 1836: 19.281902, 21.262131 avg loss, 0.001300 rate, 5.813847 seconds, 58752 images, 1271.979707 hours left
Loaded: 0.000039 seconds

 1837: 20.261761, 21.162094 avg loss, 0.001300 rate, 5.754245 seconds, 58784 images, 1267.313179 hours left
Loaded: 0.000032 seconds

 1838: 21.371746, 21.183060 avg loss, 0.001300 rate, 5.841817 seconds, 58816 images, 1262.610750 hours left
Loaded: 0.000042 seconds

 1839: 13.799910, 20.444744 avg loss, 0.001300 rate, 5.423408 seconds, 58848 images, 1258.076622 hours left
Loaded: 0.000032 seconds

 1840: 22.253841, 20.625654 avg loss, 0.001300 rate, 5.978817 seconds, 58880 images, 1253.008265 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000029 seconds

 1841: 17.894922, 20.352581 avg loss, 0.001300 rate, 15.829938 seconds, 58912 images, 1248.759899 hours left
Loaded: 0.000030 seconds

 1842: 14.780781, 19.795401 avg loss, 0.001300 rate, 15.625813 seconds, 58944 images, 1258.199412 hours left
Loaded: 0.000031 seconds

 1843: 17.151728, 19.531033 avg loss, 0.001300 rate, 15.809586 seconds, 58976 images, 1267.261742 hours left
Loaded: 0.000028 seconds

 1844: 18.082867, 19.386215 avg loss, 0.001300 rate, 15.500308 seconds, 59008 images, 1276.487961 hours left
Loaded: 0.000031 seconds

 1845: 18.392782, 19.286873 avg loss, 0.001300 rate, 15.292969 seconds, 59040 images, 1285.193471 hours left
Loaded: 0.000036 seconds

 1846: 17.152721, 19.073458 avg loss, 0.001300 rate, 15.129280 seconds, 59072 images, 1293.524702 hours left
Loaded: 0.000032 seconds

 1847: 19.441303, 19.110243 avg loss, 0.001300 rate, 15.601980 seconds, 59104 images, 1301.545839 hours left
Loaded: 0.000038 seconds

 1848: 19.835039, 19.182722 avg loss, 0.001300 rate, 16.792863 seconds, 59136 images, 1310.141477 hours left
Loaded: 0.000027 seconds

 1849: 18.962669, 19.160717 avg loss, 0.001300 rate, 16.545148 seconds, 59168 images, 1320.300670 hours left
Loaded: 0.000033 seconds

 1850: 18.806818, 19.125328 avg loss, 0.001300 rate, 16.419278 seconds, 59200 images, 1330.015088 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.458109 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1851: 25.305124, 19.743307 avg loss, 0.001300 rate, 12.214502 seconds, 59232 images, 1339.457976 hours left
Loaded: 0.000026 seconds

 1852: 20.108309, 19.779808 avg loss, 0.001300 rate, 10.744098 seconds, 59264 images, 1343.616703 hours left
Loaded: 0.000022 seconds

 1853: 22.426577, 20.044485 avg loss, 0.001300 rate, 10.977904 seconds, 59296 images, 1345.062593 hours left
Loaded: 0.000026 seconds

 1854: 22.406322, 20.280668 avg loss, 0.001300 rate, 11.140897 seconds, 59328 images, 1346.817839 hours left
Loaded: 0.000027 seconds

 1855: 18.222857, 20.074886 avg loss, 0.001300 rate, 10.299082 seconds, 59360 images, 1348.781275 hours left
Loaded: 0.000026 seconds

 1856: 16.016392, 19.669037 avg loss, 0.001300 rate, 9.965781 seconds, 59392 images, 1349.559028 hours left
Loaded: 0.000027 seconds

 1857: 20.098700, 19.712004 avg loss, 0.001300 rate, 10.699590 seconds, 59424 images, 1349.867311 hours left
Loaded: 0.000034 seconds

 1858: 18.902796, 19.631083 avg loss, 0.001300 rate, 10.544582 seconds, 59456 images, 1351.188898 hours left
Loaded: 0.000039 seconds

 1859: 21.773979, 19.845371 avg loss, 0.001300 rate, 11.402763 seconds, 59488 images, 1352.282545 hours left
Loaded: 0.000030 seconds

 1860: 19.283436, 19.789177 avg loss, 0.001300 rate, 11.083294 seconds, 59520 images, 1354.553912 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.280614 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1861: 19.321674, 19.742426 avg loss, 0.001300 rate, 10.420102 seconds, 59552 images, 1356.360021 hours left
Loaded: 0.000032 seconds

 1862: 17.249527, 19.493135 avg loss, 0.001300 rate, 9.972884 seconds, 59584 images, 1357.618085 hours left
Loaded: 0.000031 seconds

 1863: 23.210529, 19.864876 avg loss, 0.001300 rate, 10.307722 seconds, 59616 images, 1357.855458 hours left
Loaded: 0.000037 seconds

 1864: 14.752871, 19.353676 avg loss, 0.001300 rate, 9.274044 seconds, 59648 images, 1358.554215 hours left
Loaded: 0.000028 seconds

 1865: 18.343346, 19.252644 avg loss, 0.001300 rate, 9.799233 seconds, 59680 images, 1357.814215 hours left
Loaded: 0.000037 seconds

 1866: 22.637413, 19.591120 avg loss, 0.001300 rate, 10.829100 seconds, 59712 images, 1357.809015 hours left
Loaded: 0.000030 seconds

 1867: 23.627176, 19.994726 avg loss, 0.001300 rate, 10.747393 seconds, 59744 images, 1359.230317 hours left
Loaded: 0.000032 seconds

 1868: 22.019150, 20.197168 avg loss, 0.001300 rate, 10.581477 seconds, 59776 images, 1360.524194 hours left
Loaded: 0.000029 seconds

 1869: 15.336884, 19.711140 avg loss, 0.001300 rate, 10.169708 seconds, 59808 images, 1361.575296 hours left
Loaded: 0.000030 seconds

 1870: 27.654549, 20.505480 avg loss, 0.001300 rate, 11.435256 seconds, 59840 images, 1362.045520 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.401518 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1871: 19.242079, 20.379139 avg loss, 0.001300 rate, 8.366687 seconds, 59872 images, 1364.263904 hours left
Loaded: 0.000031 seconds

 1872: 21.418270, 20.483051 avg loss, 0.001300 rate, 8.758549 seconds, 59904 images, 1362.765960 hours left
Loaded: 0.000037 seconds

 1873: 20.449675, 20.479713 avg loss, 0.001300 rate, 8.271314 seconds, 59936 images, 1361.269627 hours left
Loaded: 0.000039 seconds

 1874: 16.968740, 20.128616 avg loss, 0.001300 rate, 8.286556 seconds, 59968 images, 1359.113385 hours left
Loaded: 0.000037 seconds

 1875: 22.704786, 20.386234 avg loss, 0.001300 rate, 8.881524 seconds, 60000 images, 1356.999796 hours left
Loaded: 0.000038 seconds

 1876: 15.547339, 19.902346 avg loss, 0.001300 rate, 7.980752 seconds, 60032 images, 1355.731390 hours left
Loaded: 0.000037 seconds

 1877: 13.262690, 19.238380 avg loss, 0.001300 rate, 7.582073 seconds, 60064 images, 1353.228015 hours left
Loaded: 0.000029 seconds

 1878: 25.707663, 19.885309 avg loss, 0.001300 rate, 9.112505 seconds, 60096 images, 1350.197454 hours left
Loaded: 0.000026 seconds

 1879: 19.885391, 19.885317 avg loss, 0.001300 rate, 8.249973 seconds, 60128 images, 1349.316909 hours left
Loaded: 0.000030 seconds

 1880: 21.010468, 19.997831 avg loss, 0.001300 rate, 8.557975 seconds, 60160 images, 1347.250482 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.294498 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1881: 14.262205, 19.424269 avg loss, 0.001300 rate, 6.015000 seconds, 60192 images, 1345.631304 hours left
Loaded: 0.000038 seconds

 1882: 22.891966, 19.771038 avg loss, 0.001300 rate, 6.679740 seconds, 60224 images, 1340.913993 hours left
Loaded: 0.000040 seconds

 1883: 17.511614, 19.545095 avg loss, 0.001300 rate, 6.087691 seconds, 60256 images, 1336.756693 hours left
Loaded: 0.000039 seconds

 1884: 16.925770, 19.283163 avg loss, 0.001300 rate, 6.136616 seconds, 60288 images, 1331.820935 hours left
Loaded: 0.000040 seconds

 1885: 17.177879, 19.072636 avg loss, 0.001300 rate, 6.092498 seconds, 60320 images, 1327.002279 hours left
Loaded: 0.000039 seconds

 1886: 11.839192, 18.349291 avg loss, 0.001300 rate, 5.999959 seconds, 60352 images, 1322.170687 hours left
Loaded: 0.000031 seconds

 1887: 21.147753, 18.629137 avg loss, 0.001300 rate, 6.626507 seconds, 60384 images, 1317.259224 hours left
Loaded: 0.000038 seconds

 1888: 21.366396, 18.902863 avg loss, 0.001300 rate, 6.748973 seconds, 60416 images, 1313.264641 hours left
Loaded: 0.000031 seconds

 1889: 21.755722, 19.188148 avg loss, 0.001300 rate, 6.664205 seconds, 60448 images, 1309.479612 hours left
Loaded: 0.000031 seconds

 1890: 19.134455, 19.182779 avg loss, 0.001300 rate, 6.458025 seconds, 60480 images, 1305.615000 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 1891: 17.634296, 19.027931 avg loss, 0.001300 rate, 7.925336 seconds, 60512 images, 1301.503451 hours left
Loaded: 0.000028 seconds

 1892: 19.741596, 19.099298 avg loss, 0.001300 rate, 8.225979 seconds, 60544 images, 1299.465252 hours left
Loaded: 0.000030 seconds

 1893: 17.222208, 18.911589 avg loss, 0.001300 rate, 7.934657 seconds, 60576 images, 1297.863816 hours left
Loaded: 0.000029 seconds

 1894: 22.712828, 19.291712 avg loss, 0.001300 rate, 8.484985 seconds, 60608 images, 1295.874886 hours left
Loaded: 0.000027 seconds

 1895: 20.562706, 19.418812 avg loss, 0.001300 rate, 8.291729 seconds, 60640 images, 1294.668037 hours left
Loaded: 0.000035 seconds

 1896: 17.924789, 19.269409 avg loss, 0.001300 rate, 7.896702 seconds, 60672 images, 1293.205566 hours left
Loaded: 0.000029 seconds

 1897: 14.986673, 18.841135 avg loss, 0.001300 rate, 7.585220 seconds, 60704 images, 1291.210591 hours left
Loaded: 0.000029 seconds

 1898: 23.864840, 19.343506 avg loss, 0.001300 rate, 8.663531 seconds, 60736 images, 1288.804131 hours left
Loaded: 0.000029 seconds

 1899: 15.326329, 18.941788 avg loss, 0.001300 rate, 7.804952 seconds, 60768 images, 1287.915182 hours left
Loaded: 0.000029 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 1900: 23.517698, 19.399380 avg loss, 0.001300 rate, 8.605088 seconds, 60800 images, 1285.845965 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.024738 seconds

 1901: 22.751207, 19.734562 avg loss, 0.001300 rate, 12.560187 seconds, 60832 images, 1284.905617 hours left
Loaded: 0.000027 seconds

 1902: 19.697521, 19.730858 avg loss, 0.001300 rate, 12.827334 seconds, 60864 images, 1289.486660 hours left
Loaded: 0.000031 seconds

 1903: 22.371510, 19.994923 avg loss, 0.001300 rate, 13.627374 seconds, 60896 images, 1294.357632 hours left
Loaded: 0.000025 seconds

 1904: 17.964403, 19.791870 avg loss, 0.001300 rate, 12.685052 seconds, 60928 images, 1300.287912 hours left
Loaded: 0.000039 seconds

 1905: 24.512463, 20.263929 avg loss, 0.001300 rate, 13.667195 seconds, 60960 images, 1304.853738 hours left
Loaded: 0.000038 seconds

 1906: 16.921547, 19.929691 avg loss, 0.001300 rate, 12.235516 seconds, 60992 images, 1310.734144 hours left
Loaded: 0.000026 seconds

 1907: 18.981894, 19.834911 avg loss, 0.001300 rate, 12.847017 seconds, 61024 images, 1314.572853 hours left
Loaded: 0.000033 seconds

 1908: 24.077805, 20.259201 avg loss, 0.001300 rate, 13.608998 seconds, 61056 images, 1319.220044 hours left
Loaded: 0.000051 seconds

 1909: 15.832356, 19.816517 avg loss, 0.001300 rate, 11.851986 seconds, 61088 images, 1324.876062 hours left
Loaded: 0.000038 seconds

 1910: 13.806866, 19.215551 avg loss, 0.001300 rate, 11.949953 seconds, 61120 images, 1328.042091 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.056452 seconds

 1911: 21.191437, 19.413139 avg loss, 0.001300 rate, 17.023835 seconds, 61152 images, 1331.312088 hours left
Loaded: 0.000030 seconds

 1912: 24.942877, 19.966114 avg loss, 0.001300 rate, 17.747411 seconds, 61184 images, 1341.654657 hours left
Loaded: 0.000042 seconds

 1913: 21.853167, 20.154819 avg loss, 0.001300 rate, 16.805369 seconds, 61216 images, 1352.817738 hours left
Loaded: 0.000039 seconds

 1914: 24.935951, 20.632933 avg loss, 0.001300 rate, 16.617784 seconds, 61248 images, 1362.564460 hours left
Loaded: 0.000036 seconds

 1915: 23.246256, 20.894264 avg loss, 0.001300 rate, 16.682273 seconds, 61280 images, 1371.953867 hours left
Loaded: 0.000029 seconds

 1916: 22.960720, 21.100910 avg loss, 0.001300 rate, 16.189885 seconds, 61312 images, 1381.338645 hours left
Loaded: 0.000028 seconds

 1917: 19.018303, 20.892649 avg loss, 0.001300 rate, 15.588810 seconds, 61344 images, 1389.947584 hours left
Loaded: 0.000033 seconds

 1918: 27.459444, 21.549328 avg loss, 0.001300 rate, 17.347498 seconds, 61376 images, 1397.637926 hours left
Loaded: 0.000030 seconds

 1919: 20.486050, 21.443001 avg loss, 0.001300 rate, 16.487682 seconds, 61408 images, 1407.687025 hours left
Loaded: 0.000029 seconds

 1920: 13.771583, 20.675859 avg loss, 0.001300 rate, 14.988147 seconds, 61440 images, 1416.444778 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.384488 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1921: 22.510876, 20.859362 avg loss, 0.001300 rate, 7.570487 seconds, 61472 images, 1423.038136 hours left
Loaded: 0.000030 seconds

 1922: 11.984834, 19.971909 avg loss, 0.001300 rate, 6.750894 seconds, 61504 images, 1419.824944 hours left
Loaded: 0.000037 seconds

 1923: 21.262177, 20.100935 avg loss, 0.001300 rate, 7.405611 seconds, 61536 images, 1414.976324 hours left
Loaded: 0.000035 seconds

 1924: 18.120060, 19.902847 avg loss, 0.001300 rate, 7.236943 seconds, 61568 images, 1411.082924 hours left
Loaded: 0.000028 seconds

 1925: 17.324436, 19.645006 avg loss, 0.001300 rate, 7.216267 seconds, 61600 images, 1406.994839 hours left
Loaded: 0.000034 seconds

 1926: 18.776777, 19.558184 avg loss, 0.001300 rate, 7.230776 seconds, 61632 images, 1402.918972 hours left
Loaded: 0.000030 seconds

 1927: 17.503202, 19.352686 avg loss, 0.001300 rate, 7.129448 seconds, 61664 images, 1398.903946 hours left
Loaded: 0.000030 seconds

 1928: 12.689821, 18.686399 avg loss, 0.001300 rate, 6.734761 seconds, 61696 images, 1394.788722 hours left
Loaded: 0.000040 seconds

 1929: 22.793917, 19.097151 avg loss, 0.001300 rate, 7.563356 seconds, 61728 images, 1390.168009 hours left
Loaded: 0.000030 seconds

 1930: 19.484852, 19.135921 avg loss, 0.001300 rate, 7.433653 seconds, 61760 images, 1386.741038 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.366732 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1931: 17.960003, 19.018330 avg loss, 0.001300 rate, 5.635498 seconds, 61792 images, 1383.168674 hours left
Loaded: 0.000031 seconds

 1932: 24.639248, 19.580421 avg loss, 0.001300 rate, 5.874182 seconds, 61824 images, 1377.649573 hours left
Loaded: 0.000028 seconds

 1933: 12.883760, 18.910755 avg loss, 0.001300 rate, 5.076060 seconds, 61856 images, 1372.008354 hours left
Loaded: 0.000029 seconds

 1934: 11.434492, 18.163128 avg loss, 0.001300 rate, 5.090595 seconds, 61888 images, 1365.318200 hours left
Loaded: 0.000038 seconds

 1935: 27.395473, 19.086363 avg loss, 0.001300 rate, 6.323970 seconds, 61920 images, 1358.715065 hours left
Loaded: 0.000031 seconds

 1936: 11.414916, 18.319218 avg loss, 0.001300 rate, 5.202273 seconds, 61952 images, 1353.886065 hours left
Loaded: 0.000030 seconds

 1937: 16.292395, 18.116535 avg loss, 0.001300 rate, 5.490579 seconds, 61984 images, 1347.551887 hours left
Loaded: 0.000039 seconds

 1938: 21.545477, 18.459429 avg loss, 0.001300 rate, 5.891317 seconds, 62016 images, 1341.680311 hours left
Loaded: 0.000030 seconds

 1939: 14.844698, 18.097956 avg loss, 0.001300 rate, 5.508077 seconds, 62048 images, 1336.422427 hours left
Loaded: 0.000030 seconds

 1940: 19.936106, 18.281771 avg loss, 0.001300 rate, 5.761873 seconds, 62080 images, 1330.686348 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 1941: 17.802460, 18.233839 avg loss, 0.001300 rate, 6.169952 seconds, 62112 images, 1325.359094 hours left
Loaded: 0.000040 seconds

 1942: 18.634470, 18.273903 avg loss, 0.001300 rate, 6.282392 seconds, 62144 images, 1320.650238 hours left
Loaded: 0.000030 seconds

 1943: 18.634604, 18.309973 avg loss, 0.001300 rate, 6.396585 seconds, 62176 images, 1316.144184 hours left
Loaded: 0.000033 seconds

 1944: 16.321131, 18.111088 avg loss, 0.001300 rate, 6.099988 seconds, 62208 images, 1311.841321 hours left
Loaded: 0.000031 seconds

 1945: 20.837370, 18.383717 avg loss, 0.001300 rate, 6.265096 seconds, 62240 images, 1307.170704 hours left
Loaded: 0.000029 seconds

 1946: 18.336212, 18.378965 avg loss, 0.001300 rate, 5.973400 seconds, 62272 images, 1302.775427 hours left
Loaded: 0.000032 seconds

 1947: 18.726137, 18.413683 avg loss, 0.001300 rate, 6.064364 seconds, 62304 images, 1298.020119 hours left
Loaded: 0.000027 seconds

 1948: 18.524261, 18.424742 avg loss, 0.001300 rate, 6.299735 seconds, 62336 images, 1293.438326 hours left
Loaded: 0.000029 seconds

 1949: 16.834612, 18.265728 avg loss, 0.001300 rate, 6.153429 seconds, 62368 images, 1289.228285 hours left
Loaded: 0.000029 seconds

 1950: 23.564659, 18.795622 avg loss, 0.001300 rate, 6.735623 seconds, 62400 images, 1284.857718 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 1951: 26.101831, 19.526243 avg loss, 0.001300 rate, 14.514493 seconds, 62432 images, 1281.337097 hours left
Loaded: 0.000031 seconds

 1952: 15.810078, 19.154627 avg loss, 0.001300 rate, 12.853033 seconds, 62464 images, 1288.624294 hours left
Loaded: 0.000037 seconds

 1953: 17.272257, 18.966391 avg loss, 0.001300 rate, 13.200133 seconds, 62496 images, 1293.537702 hours left
Loaded: 0.000037 seconds

 1954: 18.247089, 18.894461 avg loss, 0.001300 rate, 13.388037 seconds, 62528 images, 1298.882631 hours left
Loaded: 0.000037 seconds

 1955: 18.365067, 18.841522 avg loss, 0.001300 rate, 13.934558 seconds, 62560 images, 1304.434293 hours left
Loaded: 0.000033 seconds

 1956: 17.267502, 18.684120 avg loss, 0.001300 rate, 13.310143 seconds, 62592 images, 1310.687261 hours left
Loaded: 0.000032 seconds

 1957: 20.779381, 18.893646 avg loss, 0.001300 rate, 13.964039 seconds, 62624 images, 1316.012924 hours left
Loaded: 0.000031 seconds

 1958: 24.013781, 19.405659 avg loss, 0.001300 rate, 14.207898 seconds, 62656 images, 1322.190838 hours left
Loaded: 0.000032 seconds

 1959: 17.704700, 19.235563 avg loss, 0.001300 rate, 13.006538 seconds, 62688 images, 1328.644636 hours left
Loaded: 0.000029 seconds

 1960: 19.102983, 19.222305 avg loss, 0.001300 rate, 13.373475 seconds, 62720 images, 1333.370171 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.033340 seconds

 1961: 24.299810, 19.730057 avg loss, 0.001300 rate, 14.609330 seconds, 62752 images, 1338.556556 hours left
Loaded: 0.000027 seconds

 1962: 11.063662, 18.863417 avg loss, 0.001300 rate, 13.212253 seconds, 62784 images, 1345.448619 hours left
Loaded: 0.000030 seconds

 1963: 30.589575, 20.036032 avg loss, 0.001300 rate, 16.924693 seconds, 62816 images, 1350.290880 hours left
Loaded: 0.000026 seconds

 1964: 20.031199, 20.035549 avg loss, 0.001300 rate, 14.168017 seconds, 62848 images, 1360.225761 hours left
Loaded: 0.000028 seconds

 1965: 23.260401, 20.358034 avg loss, 0.001300 rate, 14.483733 seconds, 62880 images, 1366.243737 hours left
Loaded: 0.000026 seconds

 1966: 15.504196, 19.872650 avg loss, 0.001300 rate, 13.187653 seconds, 62912 images, 1372.638706 hours left
Loaded: 0.000027 seconds

 1967: 14.927904, 19.378176 avg loss, 0.001300 rate, 13.197163 seconds, 62944 images, 1377.174849 hours left
Loaded: 0.000027 seconds

 1968: 22.745375, 19.714895 avg loss, 0.001300 rate, 14.291700 seconds, 62976 images, 1381.678765 hours left
Loaded: 0.000032 seconds

 1969: 19.571075, 19.700514 avg loss, 0.001300 rate, 14.253578 seconds, 63008 images, 1387.653332 hours left
Loaded: 0.000030 seconds

 1970: 25.611452, 20.291607 avg loss, 0.001300 rate, 15.523158 seconds, 63040 images, 1393.515329 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.593442 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1971: 20.240437, 20.286489 avg loss, 0.001300 rate, 13.899892 seconds, 63072 images, 1401.076787 hours left
Loaded: 0.000032 seconds

 1972: 23.729910, 20.630831 avg loss, 0.001300 rate, 14.432249 seconds, 63104 images, 1407.136442 hours left
Loaded: 0.000028 seconds

 1973: 17.204859, 20.288233 avg loss, 0.001300 rate, 13.044679 seconds, 63136 images, 1413.050914 hours left
Loaded: 0.000030 seconds

 1974: 19.137772, 20.173187 avg loss, 0.001300 rate, 13.482068 seconds, 63168 images, 1416.984693 hours left
Loaded: 0.000028 seconds

 1975: 15.043189, 19.660187 avg loss, 0.001300 rate, 12.913850 seconds, 63200 images, 1421.484795 hours left
Loaded: 0.000029 seconds

 1976: 18.834158, 19.577583 avg loss, 0.001300 rate, 13.367289 seconds, 63232 images, 1425.152993 hours left
Loaded: 0.000028 seconds

 1977: 16.338438, 19.253670 avg loss, 0.001300 rate, 13.059482 seconds, 63264 images, 1429.412392 hours left
Loaded: 0.000028 seconds

 1978: 25.727716, 19.901075 avg loss, 0.001300 rate, 14.962177 seconds, 63296 images, 1433.202910 hours left
Loaded: 0.000037 seconds

 1979: 17.734591, 19.684427 avg loss, 0.001300 rate, 13.472559 seconds, 63328 images, 1439.590306 hours left
Loaded: 0.000028 seconds

 1980: 24.538067, 20.169792 avg loss, 0.001300 rate, 14.448373 seconds, 63360 images, 1443.851006 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.388418 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1981: 18.558252, 20.008638 avg loss, 0.001300 rate, 7.234453 seconds, 63392 images, 1449.420333 hours left
Saving weights to /darknet/myweights/backup//yolov4_2000.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Loaded: 0.000029 seconds

 1982: 23.025284, 20.310303 avg loss, 0.001300 rate, 7.677703 seconds, 63424 images, 1445.482105 hours left
Loaded: 0.000031 seconds

 1983: 26.372196, 20.916492 avg loss, 0.001300 rate, 7.848003 seconds, 63456 images, 1441.659207 hours left
Loaded: 0.000029 seconds

 1984: 18.936251, 20.718468 avg loss, 0.001300 rate, 6.918689 seconds, 63488 images, 1438.110345 hours left
Loaded: 0.000028 seconds

 1985: 18.632170, 20.509838 avg loss, 0.001300 rate, 7.181602 seconds, 63520 images, 1433.310064 hours left
Loaded: 0.000029 seconds

 1986: 17.441622, 20.203016 avg loss, 0.001300 rate, 7.029498 seconds, 63552 images, 1428.921838 hours left
Loaded: 0.000029 seconds

 1987: 20.166977, 20.199413 avg loss, 0.001300 rate, 7.110710 seconds, 63584 images, 1424.366847 hours left
Loaded: 0.000035 seconds

 1988: 18.421839, 20.021656 avg loss, 0.001300 rate, 7.060709 seconds, 63616 images, 1419.969846 hours left
Loaded: 0.000029 seconds

 1989: 22.295897, 20.249081 avg loss, 0.001300 rate, 7.489577 seconds, 63648 images, 1415.547563 hours left
Loaded: 0.000031 seconds

 1990: 22.656759, 20.489849 avg loss, 0.001300 rate, 7.285861 seconds, 63680 images, 1411.763352 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 1991: 16.213202, 20.062183 avg loss, 0.001300 rate, 11.886055 seconds, 63712 images, 1407.734870 hours left
Loaded: 0.000030 seconds

 1992: 15.833994, 19.639364 avg loss, 0.001300 rate, 12.007410 seconds, 63744 images, 1410.116751 hours left
Loaded: 0.000029 seconds

 1993: 15.782263, 19.253654 avg loss, 0.001300 rate, 12.029646 seconds, 63776 images, 1412.642835 hours left
Loaded: 0.000033 seconds

 1994: 21.530924, 19.481380 avg loss, 0.001300 rate, 13.211043 seconds, 63808 images, 1415.174412 hours left
Loaded: 0.000030 seconds

 1995: 18.035662, 19.336809 avg loss, 0.001300 rate, 12.779778 seconds, 63840 images, 1419.316574 hours left
Loaded: 0.000030 seconds

 1996: 21.700573, 19.573185 avg loss, 0.001300 rate, 13.216212 seconds, 63872 images, 1422.820085 hours left
Loaded: 0.000025 seconds

 1997: 20.150282, 19.630894 avg loss, 0.001300 rate, 12.828786 seconds, 63904 images, 1426.892870 hours left
Loaded: 0.000030 seconds

 1998: 20.314091, 19.699213 avg loss, 0.001300 rate, 12.909801 seconds, 63936 images, 1430.388402 hours left
Loaded: 0.000041 seconds

 1999: 22.134352, 19.942726 avg loss, 0.001300 rate, 13.003156 seconds, 63968 images, 1433.961133 hours left
Loaded: 0.000031 seconds

 2000: 17.901882, 19.738642 avg loss, 0.001300 rate, 12.383242 seconds, 64000 images, 1437.627388 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 2001: 23.293568, 20.094135 avg loss, 0.001300 rate, 13.196047 seconds, 64032 images, 1440.398523 hours left
Loaded: 0.000021 seconds

 2002: 12.328270, 19.317549 avg loss, 0.001300 rate, 12.336379 seconds, 64064 images, 1444.267410 hours left
Loaded: 0.000029 seconds

 2003: 17.644348, 19.150229 avg loss, 0.001300 rate, 13.439322 seconds, 64096 images, 1446.907168 hours left
Loaded: 0.000025 seconds

 2004: 20.122084, 19.247414 avg loss, 0.001300 rate, 13.686149 seconds, 64128 images, 1451.047766 hours left
Loaded: 0.000027 seconds

 2005: 21.434645, 19.466137 avg loss, 0.001300 rate, 13.731000 seconds, 64160 images, 1455.488700 hours left
Loaded: 0.000030 seconds

 2006: 21.855915, 19.705114 avg loss, 0.001300 rate, 13.953405 seconds, 64192 images, 1459.947294 hours left
Loaded: 0.000029 seconds

 2007: 20.929018, 19.827505 avg loss, 0.001300 rate, 13.775908 seconds, 64224 images, 1464.669234 hours left
Loaded: 0.000029 seconds

 2008: 26.361839, 20.480938 avg loss, 0.001300 rate, 14.978498 seconds, 64256 images, 1469.098134 hours left
Loaded: 0.000035 seconds

 2009: 17.184875, 20.151331 avg loss, 0.001300 rate, 13.086009 seconds, 64288 images, 1475.147933 hours left
Loaded: 0.000030 seconds

 2010: 17.332651, 19.869463 avg loss, 0.001300 rate, 13.166941 seconds, 64320 images, 1478.516676 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.272753 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2011: 17.964754, 19.678991 avg loss, 0.001300 rate, 7.083856 seconds, 64352 images, 1481.963767 hours left
Loaded: 0.000031 seconds

 2012: 21.376955, 19.848787 avg loss, 0.001300 rate, 7.530576 seconds, 64384 images, 1477.330779 hours left
Loaded: 0.000031 seconds

 2013: 21.795174, 20.043427 avg loss, 0.001300 rate, 7.522357 seconds, 64416 images, 1472.985031 hours left
Loaded: 0.000029 seconds

 2014: 20.585629, 20.097647 avg loss, 0.001300 rate, 7.215130 seconds, 64448 images, 1468.671341 hours left
Loaded: 0.000029 seconds

 2015: 20.724205, 20.160303 avg loss, 0.001300 rate, 7.303356 seconds, 64480 images, 1463.975350 hours left
Loaded: 0.000024 seconds

 2016: 28.084114, 20.952684 avg loss, 0.001300 rate, 7.999816 seconds, 64512 images, 1459.448464 hours left
Loaded: 0.000038 seconds

 2017: 14.093586, 20.266775 avg loss, 0.001300 rate, 6.627354 seconds, 64544 images, 1455.931193 hours left
Loaded: 0.000028 seconds

 2018: 18.217646, 20.061863 avg loss, 0.001300 rate, 7.112554 seconds, 64576 images, 1450.548678 hours left
Loaded: 0.000030 seconds

 2019: 25.799339, 20.635611 avg loss, 0.001300 rate, 7.632734 seconds, 64608 images, 1445.891798 hours left
Loaded: 0.000028 seconds

 2020: 19.599039, 20.531954 avg loss, 0.001300 rate, 7.257240 seconds, 64640 images, 1442.001747 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 2021: 16.876320, 20.166389 avg loss, 0.001300 rate, 11.489588 seconds, 64672 images, 1437.630639 hours left
Loaded: 0.000030 seconds

 2022: 16.118755, 19.761625 avg loss, 0.001300 rate, 11.117913 seconds, 64704 images, 1439.163601 hours left
Loaded: 0.000027 seconds

 2023: 27.211449, 20.506607 avg loss, 0.001300 rate, 12.557278 seconds, 64736 images, 1440.166562 hours left
Loaded: 0.000030 seconds

 2024: 19.779579, 20.433905 avg loss, 0.001300 rate, 11.365991 seconds, 64768 images, 1443.152487 hours left
Loaded: 0.000030 seconds

 2025: 23.672564, 20.757771 avg loss, 0.001300 rate, 12.022771 seconds, 64800 images, 1444.459000 hours left
Loaded: 0.000029 seconds

 2026: 15.951567, 20.277149 avg loss, 0.001300 rate, 10.801811 seconds, 64832 images, 1446.661827 hours left
Loaded: 0.000029 seconds

 2027: 17.694008, 20.018835 avg loss, 0.001300 rate, 11.219739 seconds, 64864 images, 1447.151990 hours left
Loaded: 0.000030 seconds

 2028: 21.787228, 20.195675 avg loss, 0.001300 rate, 11.481179 seconds, 64896 images, 1448.215904 hours left
Loaded: 0.000027 seconds

 2029: 18.059881, 19.982096 avg loss, 0.001300 rate, 10.537508 seconds, 64928 images, 1449.631150 hours left
Loaded: 0.000035 seconds

 2030: 15.941524, 19.578039 avg loss, 0.001300 rate, 10.329415 seconds, 64960 images, 1449.725561 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.429301 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2031: 24.818552, 20.102091 avg loss, 0.001300 rate, 6.992095 seconds, 64992 images, 1449.530877 hours left
Loaded: 0.000031 seconds

 2032: 21.097336, 20.201614 avg loss, 0.001300 rate, 6.870958 seconds, 65024 images, 1445.311516 hours left
Loaded: 0.000031 seconds

 2033: 24.804413, 20.661894 avg loss, 0.001300 rate, 6.934606 seconds, 65056 images, 1440.372215 hours left
Loaded: 0.000037 seconds

 2034: 24.915623, 21.087267 avg loss, 0.001300 rate, 6.979798 seconds, 65088 images, 1435.570416 hours left
Loaded: 0.000037 seconds

 2035: 16.242254, 20.602766 avg loss, 0.001300 rate, 6.035572 seconds, 65120 images, 1430.879199 hours left
Loaded: 0.000040 seconds

 2036: 18.211515, 20.363642 avg loss, 0.001300 rate, 6.215419 seconds, 65152 images, 1424.927475 hours left
Loaded: 0.000038 seconds

 2037: 19.644276, 20.291706 avg loss, 0.001300 rate, 6.613753 seconds, 65184 images, 1419.284275 hours left
Loaded: 0.000042 seconds

 2038: 26.984844, 20.961020 avg loss, 0.001300 rate, 6.961587 seconds, 65216 images, 1414.249041 hours left
Loaded: 0.000029 seconds

 2039: 16.432894, 20.508207 avg loss, 0.001300 rate, 6.079643 seconds, 65248 images, 1409.745753 hours left
Loaded: 0.000031 seconds

 2040: 23.936920, 20.851078 avg loss, 0.001300 rate, 6.631818 seconds, 65280 images, 1404.066307 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.396590 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2041: 23.271967, 21.093166 avg loss, 0.001300 rate, 5.874653 seconds, 65312 images, 1399.208190 hours left
Loaded: 0.000032 seconds

 2042: 25.758020, 21.559652 avg loss, 0.001300 rate, 6.103357 seconds, 65344 images, 1393.899336 hours left
Loaded: 0.000038 seconds

 2043: 17.280798, 21.131767 avg loss, 0.001300 rate, 5.474309 seconds, 65376 images, 1388.411143 hours left
Loaded: 0.000032 seconds

 2044: 17.389912, 20.757582 avg loss, 0.001300 rate, 5.677264 seconds, 65408 images, 1382.106841 hours left
Loaded: 0.000031 seconds

 2045: 22.413094, 20.923134 avg loss, 0.001300 rate, 5.752725 seconds, 65440 images, 1376.146569 hours left
Loaded: 0.000030 seconds

 2046: 27.675041, 21.598324 avg loss, 0.001300 rate, 6.027933 seconds, 65472 images, 1370.350367 hours left
Loaded: 0.000041 seconds

 2047: 26.057606, 22.044252 avg loss, 0.001300 rate, 5.763459 seconds, 65504 images, 1364.993160 hours left
Loaded: 0.000029 seconds

 2048: 13.479312, 21.187757 avg loss, 0.001300 rate, 5.097668 seconds, 65536 images, 1359.323335 hours left
Loaded: 0.000032 seconds

 2049: 15.757236, 20.644705 avg loss, 0.001300 rate, 5.244555 seconds, 65568 images, 1352.788329 hours left
Loaded: 0.000035 seconds

 2050: 16.089212, 20.189156 avg loss, 0.001300 rate, 5.319788 seconds, 65600 images, 1346.522039 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 2051: 15.771738, 19.747414 avg loss, 0.001300 rate, 15.093651 seconds, 65632 images, 1340.422570 hours left
Loaded: 0.000028 seconds

 2052: 22.668768, 20.039549 avg loss, 0.001300 rate, 17.181091 seconds, 65664 images, 1347.916770 hours left
Loaded: 0.000029 seconds

 2053: 16.834627, 19.719057 avg loss, 0.001300 rate, 15.853366 seconds, 65696 images, 1358.226211 hours left
Loaded: 0.000028 seconds

 2054: 18.588842, 19.606035 avg loss, 0.001300 rate, 16.406984 seconds, 65728 images, 1366.594177 hours left
Loaded: 0.000030 seconds

 2055: 18.967855, 19.542217 avg loss, 0.001300 rate, 16.589983 seconds, 65760 images, 1375.644943 hours left
Loaded: 0.000031 seconds

 2056: 17.054560, 19.293451 avg loss, 0.001300 rate, 16.244873 seconds, 65792 images, 1384.858532 hours left
Loaded: 0.000028 seconds

 2057: 23.468414, 19.710947 avg loss, 0.001300 rate, 17.709803 seconds, 65824 images, 1393.502113 hours left
Loaded: 0.000047 seconds

 2058: 19.803209, 19.720173 avg loss, 0.001300 rate, 16.566333 seconds, 65856 images, 1404.087498 hours left
Loaded: 0.000032 seconds

 2059: 20.468132, 19.794970 avg loss, 0.001300 rate, 17.121613 seconds, 65888 images, 1412.983802 hours left
Loaded: 0.000028 seconds

 2060: 21.616198, 19.977093 avg loss, 0.001300 rate, 17.115008 seconds, 65920 images, 1422.559894 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.342323 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2061: 14.729414, 19.452324 avg loss, 0.001300 rate, 10.118657 seconds, 65952 images, 1432.031033 hours left
Loaded: 0.000021 seconds

 2062: 21.447163, 19.651808 avg loss, 0.001300 rate, 11.137543 seconds, 65984 images, 1432.194515 hours left
Loaded: 0.000025 seconds

 2063: 15.614235, 19.248051 avg loss, 0.001300 rate, 10.161407 seconds, 66016 images, 1433.293097 hours left
Loaded: 0.000039 seconds

 2064: 25.620785, 19.885324 avg loss, 0.001300 rate, 12.556075 seconds, 66048 images, 1433.029161 hours left
Loaded: 0.000034 seconds

 2065: 22.705622, 20.167355 avg loss, 0.001300 rate, 11.091911 seconds, 66080 images, 1436.083393 hours left
Loaded: 0.000027 seconds

 2066: 17.239479, 19.874567 avg loss, 0.001300 rate, 10.375820 seconds, 66112 images, 1437.079832 hours left
Loaded: 0.000027 seconds

 2067: 15.919686, 19.479078 avg loss, 0.001300 rate, 10.349035 seconds, 66144 images, 1437.074811 hours left
Loaded: 0.000034 seconds

 2068: 27.340004, 20.265171 avg loss, 0.001300 rate, 11.787829 seconds, 66176 images, 1437.032725 hours left
Loaded: 0.000027 seconds

 2069: 19.455256, 20.184179 avg loss, 0.001300 rate, 10.918581 seconds, 66208 images, 1438.983099 hours left
Loaded: 0.000026 seconds

 2070: 19.384855, 20.104246 avg loss, 0.001300 rate, 10.889366 seconds, 66240 images, 1439.710427 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.468949 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2071: 31.472525, 21.241074 avg loss, 0.001300 rate, 7.664623 seconds, 66272 images, 1440.390000 hours left
Loaded: 0.000023 seconds

 2072: 15.591942, 20.676161 avg loss, 0.001300 rate, 6.071267 seconds, 66304 images, 1437.247248 hours left
Loaded: 0.000030 seconds

 2073: 10.709303, 19.679476 avg loss, 0.001300 rate, 5.651299 seconds, 66336 images, 1431.280625 hours left
Loaded: 0.000039 seconds

 2074: 22.822109, 19.993740 avg loss, 0.001300 rate, 6.742277 seconds, 66368 images, 1424.792206 hours left
Loaded: 0.000038 seconds

 2075: 17.650434, 19.759409 avg loss, 0.001300 rate, 6.570124 seconds, 66400 images, 1419.879147 hours left
Loaded: 0.000037 seconds

 2076: 24.555094, 20.238977 avg loss, 0.001300 rate, 6.966620 seconds, 66432 images, 1414.776848 hours left
Loaded: 0.000029 seconds

 2077: 26.581657, 20.873245 avg loss, 0.001300 rate, 7.286403 seconds, 66464 images, 1410.274508 hours left
Loaded: 0.000029 seconds

 2078: 20.322672, 20.818188 avg loss, 0.001300 rate, 6.407681 seconds, 66496 images, 1406.259901 hours left
Loaded: 0.000029 seconds

 2079: 19.272982, 20.663668 avg loss, 0.001300 rate, 6.200887 seconds, 66528 images, 1401.068825 hours left
Loaded: 0.000031 seconds

 2080: 15.861804, 20.183481 avg loss, 0.001300 rate, 6.037127 seconds, 66560 images, 1395.643335 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 2081: 14.018906, 19.567024 avg loss, 0.001300 rate, 14.177485 seconds, 66592 images, 1390.045361 hours left
Loaded: 0.000031 seconds

 2082: 20.622589, 19.672581 avg loss, 0.001300 rate, 15.834334 seconds, 66624 images, 1395.773643 hours left
Loaded: 0.000028 seconds

 2083: 16.132776, 19.318600 avg loss, 0.001300 rate, 14.459091 seconds, 66656 images, 1403.738510 hours left
Loaded: 0.000029 seconds

 2084: 23.118589, 19.698599 avg loss, 0.001300 rate, 16.258523 seconds, 66688 images, 1409.719668 hours left
Loaded: 0.000030 seconds

 2085: 21.404299, 19.869169 avg loss, 0.001300 rate, 15.720736 seconds, 66720 images, 1418.132270 hours left
Loaded: 0.000029 seconds

 2086: 18.676884, 19.749941 avg loss, 0.001300 rate, 14.945535 seconds, 66752 images, 1425.716144 hours left
Loaded: 0.000030 seconds

 2087: 20.487265, 19.823673 avg loss, 0.001300 rate, 15.147563 seconds, 66784 images, 1432.150879 hours left
Loaded: 0.000034 seconds

 2088: 19.325346, 19.773840 avg loss, 0.001300 rate, 15.048478 seconds, 66816 images, 1438.800932 hours left
Loaded: 0.000030 seconds

 2089: 23.881145, 20.184570 avg loss, 0.001300 rate, 16.096340 seconds, 66848 images, 1445.247265 hours left
Loaded: 0.000038 seconds

 2090: 23.591490, 20.525263 avg loss, 0.001300 rate, 15.838224 seconds, 66880 images, 1453.079828 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.438852 seconds - performance bottleneck on CPU or Disk HDD/SSD

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 2091: 23.270584, 20.799795 avg loss, 0.001300 rate, 8.140191 seconds, 66912 images, 1460.476678 hours left
Loaded: 0.000043 seconds

 2092: 23.968042, 21.116619 avg loss, 0.001300 rate, 8.123165 seconds, 66944 images, 1457.749359 hours left
Loaded: 0.000033 seconds

 2093: 15.648345, 20.569792 avg loss, 0.001300 rate, 7.302659 seconds, 66976 images, 1454.418188 hours left
Loaded: 0.000035 seconds

 2094: 14.213766, 19.934189 avg loss, 0.001300 rate, 7.172259 seconds, 67008 images, 1449.984332 hours left
Loaded: 0.000034 seconds

 2095: 20.999479, 20.040718 avg loss, 0.001300 rate, 7.979681 seconds, 67040 images, 1445.414263 hours left
Loaded: 0.000031 seconds

 2096: 22.328156, 20.269463 avg loss, 0.001300 rate, 8.277866 seconds, 67072 images, 1442.007717 hours left
Loaded: 0.000028 seconds

 2097: 18.193914, 20.061909 avg loss, 0.001300 rate, 8.166852 seconds, 67104 images, 1439.048033 hours left
Loaded: 0.000039 seconds

 2098: 21.601692, 20.215887 avg loss, 0.001300 rate, 8.474992 seconds, 67136 images, 1435.964226 hours left
Loaded: 0.000038 seconds

 2099: 23.637711, 20.558069 avg loss, 0.001300 rate, 8.710314 seconds, 67168 images, 1433.337855 hours left
Loaded: 0.000043 seconds

 2100: 16.661057, 20.168367 avg loss, 0.001300 rate, 7.405118 seconds, 67200 images, 1431.063511 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.413905 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2101: 16.171335, 19.768663 avg loss, 0.001300 rate, 5.869617 seconds, 67232 images, 1427.004921 hours left
Loaded: 0.000033 seconds

 2102: 24.635744, 20.255371 avg loss, 0.001300 rate, 6.414250 seconds, 67264 images, 1421.434053 hours left
Loaded: 0.000035 seconds

 2103: 21.054649, 20.335299 avg loss, 0.001300 rate, 6.285841 seconds, 67296 images, 1416.099906 hours left
Loaded: 0.000022 seconds

 2104: 18.409252, 20.142694 avg loss, 0.001300 rate, 6.010907 seconds, 67328 images, 1410.641314 hours left
Loaded: 0.000029 seconds

 2105: 20.135426, 20.141968 avg loss, 0.001300 rate, 6.125304 seconds, 67360 images, 1404.856642 hours left
Loaded: 0.000035 seconds

 2106: 18.556719, 19.983442 avg loss, 0.001300 rate, 6.101593 seconds, 67392 images, 1399.288184 hours left
Loaded: 0.000034 seconds

 2107: 18.219658, 19.807064 avg loss, 0.001300 rate, 6.032054 seconds, 67424 images, 1393.742578 hours left
Loaded: 0.000028 seconds

 2108: 20.201441, 19.846502 avg loss, 0.001300 rate, 6.180835 seconds, 67456 images, 1388.156137 hours left
Loaded: 0.000044 seconds

 2109: 21.738243, 20.035677 avg loss, 0.001300 rate, 6.765156 seconds, 67488 images, 1382.831516 hours left
Loaded: 0.000053 seconds

 2110: 18.713549, 19.903463 avg loss, 0.001300 rate, 6.072946 seconds, 67520 images, 1378.369089 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.376604 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2111: 20.862368, 19.999353 avg loss, 0.001300 rate, 5.994011 seconds, 67552 images, 1372.992972 hours left
Loaded: 0.000038 seconds

 2112: 23.216322, 20.321051 avg loss, 0.001300 rate, 6.134675 seconds, 67584 images, 1368.082624 hours left
Loaded: 0.000030 seconds

 2113: 20.172935, 20.306240 avg loss, 0.001300 rate, 5.769206 seconds, 67616 images, 1362.894775 hours left
Loaded: 0.000029 seconds

 2114: 15.541080, 19.829723 avg loss, 0.001300 rate, 5.450812 seconds, 67648 images, 1357.252821 hours left
Loaded: 0.000026 seconds

 2115: 16.344753, 19.481226 avg loss, 0.001300 rate, 5.534849 seconds, 67680 images, 1351.226481 hours left
Loaded: 0.000033 seconds

 2116: 17.380640, 19.271168 avg loss, 0.001300 rate, 5.715921 seconds, 67712 images, 1345.376727 hours left
Loaded: 0.000037 seconds

 2117: 16.209616, 18.965012 avg loss, 0.001300 rate, 5.633423 seconds, 67744 images, 1339.836138 hours left
Loaded: 0.000039 seconds

 2118: 21.711426, 19.239653 avg loss, 0.001300 rate, 6.205151 seconds, 67776 images, 1334.236738 hours left
Loaded: 0.000038 seconds

 2119: 14.660914, 18.781778 avg loss, 0.001300 rate, 5.265993 seconds, 67808 images, 1329.484813 hours left
Loaded: 0.000028 seconds

 2120: 18.959558, 18.799557 avg loss, 0.001300 rate, 5.402670 seconds, 67840 images, 1323.480239 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 2121: 18.483889, 18.767990 avg loss, 0.001300 rate, 7.847105 seconds, 67872 images, 1317.724884 hours left
Loaded: 0.000030 seconds

 2122: 17.794792, 18.670670 avg loss, 0.001300 rate, 8.062475 seconds, 67904 images, 1315.411109 hours left
Loaded: 0.000029 seconds

 2123: 24.127245, 19.216328 avg loss, 0.001300 rate, 8.715010 seconds, 67936 images, 1313.418609 hours left
Loaded: 0.000030 seconds

 2124: 22.621429, 19.556837 avg loss, 0.001300 rate, 8.910754 seconds, 67968 images, 1312.349367 hours left
Loaded: 0.000032 seconds

 2125: 17.339767, 19.335131 avg loss, 0.001300 rate, 8.096476 seconds, 68000 images, 1311.561780 hours left
Loaded: 0.000029 seconds

 2126: 18.147007, 19.216318 avg loss, 0.001300 rate, 8.362786 seconds, 68032 images, 1309.654779 hours left
Loaded: 0.000033 seconds

 2127: 14.804722, 18.775158 avg loss, 0.001300 rate, 7.669317 seconds, 68064 images, 1308.135494 hours left
Loaded: 0.000029 seconds

 2128: 21.363409, 19.033983 avg loss, 0.001300 rate, 8.467027 seconds, 68096 images, 1305.671367 hours left
Loaded: 0.000030 seconds

 2129: 11.117047, 18.242290 avg loss, 0.001300 rate, 7.650455 seconds, 68128 images, 1304.336177 hours left
Loaded: 0.000029 seconds

 2130: 22.209188, 18.638981 avg loss, 0.001300 rate, 8.312752 seconds, 68160 images, 1301.883884 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.510788 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2131: 24.105528, 19.185635 avg loss, 0.001300 rate, 7.403695 seconds, 68192 images, 1300.372949 hours left
Loaded: 0.000028 seconds

 2132: 24.020182, 19.669090 avg loss, 0.001300 rate, 7.325173 seconds, 68224 images, 1298.325713 hours left
Loaded: 0.000027 seconds

 2133: 20.126415, 19.714823 avg loss, 0.001300 rate, 7.120401 seconds, 68256 images, 1295.483149 hours left
Loaded: 0.000021 seconds

 2134: 20.039989, 19.747339 avg loss, 0.001300 rate, 7.171011 seconds, 68288 images, 1292.385514 hours left
Loaded: 0.000025 seconds

 2135: 20.649817, 19.837587 avg loss, 0.001300 rate, 7.098243 seconds, 68320 images, 1289.388888 hours left
Loaded: 0.000036 seconds

 2136: 17.901766, 19.644005 avg loss, 0.001300 rate, 6.806176 seconds, 68352 images, 1286.321480 hours left
Loaded: 0.000039 seconds

 2137: 12.615230, 18.941128 avg loss, 0.001300 rate, 6.510618 seconds, 68384 images, 1282.880418 hours left
Loaded: 0.000036 seconds

 2138: 19.606327, 19.007648 avg loss, 0.001300 rate, 7.199276 seconds, 68416 images, 1279.064599 hours left
Loaded: 0.000033 seconds

 2139: 20.884398, 19.195324 avg loss, 0.001300 rate, 7.239642 seconds, 68448 images, 1276.240253 hours left
Loaded: 0.000035 seconds

 2140: 15.681124, 18.843904 avg loss, 0.001300 rate, 6.898210 seconds, 68480 images, 1273.500005 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 2141: 21.677298, 19.127243 avg loss, 0.001300 rate, 15.187844 seconds, 68512 images, 1270.314486 hours left
Loaded: 0.000033 seconds

 2142: 26.499960, 19.864515 avg loss, 0.001300 rate, 15.155541 seconds, 68544 images, 1278.636391 hours left
Loaded: 0.000028 seconds

 2143: 25.220669, 20.400131 avg loss, 0.001300 rate, 14.994426 seconds, 68576 images, 1286.830323 hours left
Loaded: 0.000029 seconds

 2144: 20.561142, 20.416233 avg loss, 0.001300 rate, 14.059645 seconds, 68608 images, 1294.719231 hours left
Loaded: 0.000027 seconds

 2145: 14.611541, 19.835764 avg loss, 0.001300 rate, 12.928946 seconds, 68640 images, 1301.235170 hours left
Loaded: 0.000031 seconds

 2146: 18.440166, 19.696205 avg loss, 0.001300 rate, 14.198996 seconds, 68672 images, 1306.120662 hours left
Loaded: 0.000031 seconds

 2147: 17.875793, 19.514164 avg loss, 0.001300 rate, 13.827491 seconds, 68704 images, 1312.715420 hours left
Loaded: 0.000026 seconds

 2148: 14.484391, 19.011187 avg loss, 0.001300 rate, 12.868533 seconds, 68736 images, 1318.729921 hours left
Loaded: 0.000031 seconds

 2149: 15.210966, 18.631165 avg loss, 0.001300 rate, 13.134582 seconds, 68768 images, 1323.356725 hours left
Loaded: 0.000030 seconds

 2150: 24.607452, 19.228794 avg loss, 0.001300 rate, 14.935033 seconds, 68800 images, 1328.305527 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.370563 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2151: 22.133989, 19.519314 avg loss, 0.001300 rate, 6.027399 seconds, 68832 images, 1335.697175 hours left
Loaded: 0.000030 seconds

 2152: 20.019131, 19.569296 avg loss, 0.001300 rate, 5.817891 seconds, 68864 images, 1331.196934 hours left
Loaded: 0.000031 seconds

 2153: 18.043596, 19.416725 avg loss, 0.001300 rate, 5.482393 seconds, 68896 images, 1325.938729 hours left
Loaded: 0.000030 seconds

 2154: 25.145582, 19.989611 avg loss, 0.001300 rate, 6.107858 seconds, 68928 images, 1320.268660 hours left
Loaded: 0.000038 seconds

 2155: 24.270237, 20.417673 avg loss, 0.001300 rate, 5.648290 seconds, 68960 images, 1315.521103 hours left
Loaded: 0.000028 seconds

 2156: 18.669415, 20.242847 avg loss, 0.001300 rate, 5.277244 seconds, 68992 images, 1310.184838 hours left
Loaded: 0.000022 seconds

 2157: 19.827179, 20.201281 avg loss, 0.001300 rate, 5.352718 seconds, 69024 images, 1304.388271 hours left
Loaded: 0.000033 seconds

 2158: 23.246456, 20.505798 avg loss, 0.001300 rate, 6.047730 seconds, 69056 images, 1298.754123 hours left
Loaded: 0.000029 seconds

 2159: 18.991760, 20.354395 avg loss, 0.001300 rate, 5.333957 seconds, 69088 images, 1294.138413 hours left
Loaded: 0.000027 seconds

 2160: 17.770357, 20.095991 avg loss, 0.001300 rate, 5.293013 seconds, 69120 images, 1288.580775 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 2161: 22.047180, 20.291111 avg loss, 0.001300 rate, 12.360231 seconds, 69152 images, 1283.022016 hours left
Loaded: 0.000027 seconds

 2162: 16.409437, 19.902943 avg loss, 0.001300 rate, 11.803533 seconds, 69184 images, 1287.301804 hours left
Loaded: 0.000035 seconds

 2163: 19.823866, 19.895035 avg loss, 0.001300 rate, 12.236106 seconds, 69216 images, 1290.768140 hours left
Loaded: 0.000039 seconds

 2164: 15.161543, 19.421686 avg loss, 0.001300 rate, 11.648205 seconds, 69248 images, 1294.798589 hours left
Loaded: 0.000035 seconds

 2165: 18.217400, 19.301258 avg loss, 0.001300 rate, 12.134084 seconds, 69280 images, 1297.974891 hours left
Loaded: 0.000030 seconds

 2166: 14.916254, 18.862759 avg loss, 0.001300 rate, 11.902691 seconds, 69312 images, 1301.791978 hours left
Loaded: 0.000029 seconds

 2167: 25.164251, 19.492908 avg loss, 0.001300 rate, 13.455758 seconds, 69344 images, 1305.250544 hours left
Loaded: 0.000028 seconds

 2168: 24.380077, 19.981625 avg loss, 0.001300 rate, 13.555024 seconds, 69376 images, 1310.824336 hours left
Loaded: 0.000034 seconds

 2169: 20.945496, 20.078012 avg loss, 0.001300 rate, 12.801693 seconds, 69408 images, 1316.479762 hours left
Loaded: 0.000027 seconds

 2170: 22.367758, 20.306988 avg loss, 0.001300 rate, 13.151449 seconds, 69440 images, 1321.035804 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.102353 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2171: 27.381357, 21.014425 avg loss, 0.001300 rate, 18.791448 seconds, 69472 images, 1326.030390 hours left
Loaded: 0.000030 seconds

 2172: 20.235893, 20.936573 avg loss, 0.001300 rate, 16.132276 seconds, 69504 images, 1338.923792 hours left
Loaded: 0.000024 seconds

 2173: 11.772449, 20.020161 avg loss, 0.001300 rate, 14.459763 seconds, 69536 images, 1347.865623 hours left
Loaded: 0.000028 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 2174: 22.337542, 20.251900 avg loss, 0.001300 rate, 16.782424 seconds, 69568 images, 1354.402820 hours left
Loaded: 0.000029 seconds

 2175: 22.770121, 20.503721 avg loss, 0.001300 rate, 16.505234 seconds, 69600 images, 1364.089740 hours left
Loaded: 0.000027 seconds

 2176: 21.159128, 20.569262 avg loss, 0.001300 rate, 15.822954 seconds, 69632 images, 1373.296036 hours left
Loaded: 0.000029 seconds

 2177: 17.774622, 20.289797 avg loss, 0.001300 rate, 16.211618 seconds, 69664 images, 1381.465785 hours left
Loaded: 0.000034 seconds

 2178: 15.652122, 19.826029 avg loss, 0.001300 rate, 15.726953 seconds, 69696 images, 1390.091798 hours left
Loaded: 0.000028 seconds

 2179: 31.089165, 20.952343 avg loss, 0.001300 rate, 18.603558 seconds, 69728 images, 1397.960627 hours left
Loaded: 0.000028 seconds

 2180: 25.001051, 21.357214 avg loss, 0.001300 rate, 17.396518 seconds, 69760 images, 1409.732582 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.418562 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2181: 23.786600, 21.600153 avg loss, 0.001300 rate, 11.248189 seconds, 69792 images, 1419.715954 hours left
Loaded: 0.000027 seconds

 2182: 21.875340, 21.627672 avg loss, 0.001300 rate, 11.147042 seconds, 69824 images, 1421.668151 hours left
Loaded: 0.000026 seconds

 2183: 25.037893, 21.968695 avg loss, 0.001300 rate, 12.274525 seconds, 69856 images, 1422.881440 hours left
Loaded: 0.000031 seconds

 2184: 17.557884, 21.527615 avg loss, 0.001300 rate, 11.142736 seconds, 69888 images, 1425.643243 hours left
Loaded: 0.000045 seconds

 2185: 22.274878, 21.602341 avg loss, 0.001300 rate, 11.461836 seconds, 69920 images, 1426.810767 hours left
Loaded: 0.000039 seconds

 2186: 24.342825, 21.876389 avg loss, 0.001300 rate, 11.325094 seconds, 69952 images, 1428.408303 hours left
Loaded: 0.000035 seconds

 2187: 23.026121, 21.991362 avg loss, 0.001300 rate, 11.070634 seconds, 69984 images, 1429.800545 hours left
Loaded: 0.000027 seconds

 2188: 21.821508, 21.974377 avg loss, 0.001300 rate, 10.808454 seconds, 70016 images, 1430.826601 hours left
Loaded: 0.000026 seconds

 2189: 16.644699, 21.441408 avg loss, 0.001300 rate, 10.589785 seconds, 70048 images, 1431.479447 hours left
Loaded: 0.000040 seconds

 2190: 18.954487, 21.192717 avg loss, 0.001300 rate, 10.465703 seconds, 70080 images, 1431.823052 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.071151 seconds

 2191: 17.204563, 20.793901 avg loss, 0.001300 rate, 12.103696 seconds, 70112 images, 1431.991456 hours left
Loaded: 0.000029 seconds

 2192: 21.312443, 20.845757 avg loss, 0.001300 rate, 13.496010 seconds, 70144 images, 1434.523876 hours left
Loaded: 0.000024 seconds

 2193: 17.859999, 20.547180 avg loss, 0.001300 rate, 12.431522 seconds, 70176 images, 1438.859718 hours left
Loaded: 0.000031 seconds

 2194: 19.484758, 20.440937 avg loss, 0.001300 rate, 12.745541 seconds, 70208 images, 1441.678708 hours left
Loaded: 0.000030 seconds

 2195: 24.219242, 20.818768 avg loss, 0.001300 rate, 13.184299 seconds, 70240 images, 1444.904144 hours left
Loaded: 0.000031 seconds

 2196: 21.229256, 20.859816 avg loss, 0.001300 rate, 12.569393 seconds, 70272 images, 1448.704608 hours left
Loaded: 0.000027 seconds

 2197: 26.953100, 21.469145 avg loss, 0.001300 rate, 12.917584 seconds, 70304 images, 1451.615892 hours left
Loaded: 0.000026 seconds

 2198: 15.979068, 20.920137 avg loss, 0.001300 rate, 11.558979 seconds, 70336 images, 1454.979979 hours left
Loaded: 0.000038 seconds

 2199: 22.043476, 21.032471 avg loss, 0.001300 rate, 12.372660 seconds, 70368 images, 1456.429846 hours left
Loaded: 0.000034 seconds

 2200: 15.880768, 20.517300 avg loss, 0.001300 rate, 11.463720 seconds, 70400 images, 1458.991470 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.207642 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2201: 14.124874, 19.878057 avg loss, 0.001300 rate, 5.139338 seconds, 70432 images, 1460.269313 hours left
Loaded: 0.000028 seconds

 2202: 21.063850, 19.996637 avg loss, 0.001300 rate, 5.547798 seconds, 70464 images, 1453.067741 hours left
Loaded: 0.000024 seconds

 2203: 13.060181, 19.302992 avg loss, 0.001300 rate, 5.001699 seconds, 70496 images, 1446.216160 hours left
Loaded: 0.000023 seconds

 2204: 26.015240, 19.974216 avg loss, 0.001300 rate, 5.945956 seconds, 70528 images, 1438.677185 hours left
Loaded: 0.000029 seconds

 2205: 17.396751, 19.716471 avg loss, 0.001300 rate, 5.813429 seconds, 70560 images, 1432.520586 hours left
Loaded: 0.000031 seconds

 2206: 18.559484, 19.600773 avg loss, 0.001300 rate, 5.591268 seconds, 70592 images, 1426.242108 hours left
Loaded: 0.000038 seconds

 2207: 18.448503, 19.485546 avg loss, 0.001300 rate, 5.657768 seconds, 70624 images, 1419.718897 hours left
Loaded: 0.000039 seconds

 2208: 19.597393, 19.496731 avg loss, 0.001300 rate, 5.923265 seconds, 70656 images, 1413.352959 hours left
Loaded: 0.000030 seconds

 2209: 15.190906, 19.066149 avg loss, 0.001300 rate, 5.329651 seconds, 70688 images, 1407.418153 hours left
Loaded: 0.000027 seconds

 2210: 20.026203, 19.162155 avg loss, 0.001300 rate, 5.560270 seconds, 70720 images, 1400.721017 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 2211: 29.595364, 20.205477 avg loss, 0.001300 rate, 11.692369 seconds, 70752 images, 1394.410043 hours left
Loaded: 0.000040 seconds

 2212: 23.171461, 20.502075 avg loss, 0.001300 rate, 10.582187 seconds, 70784 images, 1396.649822 hours left
Loaded: 0.000030 seconds

 2213: 19.440315, 20.395899 avg loss, 0.001300 rate, 9.978708 seconds, 70816 images, 1397.330550 hours left
Loaded: 0.000029 seconds

 2214: 24.277109, 20.784019 avg loss, 0.001300 rate, 10.354666 seconds, 70848 images, 1397.169134 hours left
Loaded: 0.000028 seconds

 2215: 18.544497, 20.560066 avg loss, 0.001300 rate, 9.799256 seconds, 70880 images, 1397.529676 hours left
Loaded: 0.000038 seconds

 2216: 18.001728, 20.304232 avg loss, 0.001300 rate, 9.833385 seconds, 70912 images, 1397.117824 hours left
Loaded: 0.000035 seconds

 2217: 17.893612, 20.063169 avg loss, 0.001300 rate, 9.968427 seconds, 70944 images, 1396.757319 hours left
Loaded: 0.000026 seconds

 2218: 23.006563, 20.357510 avg loss, 0.001300 rate, 10.841401 seconds, 70976 images, 1396.587302 hours left
Loaded: 0.000037 seconds

 2219: 16.135149, 19.935274 avg loss, 0.001300 rate, 9.816920 seconds, 71008 images, 1397.627242 hours left
Loaded: 0.000038 seconds

 2220: 23.425198, 20.284267 avg loss, 0.001300 rate, 10.794796 seconds, 71040 images, 1397.238770 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.364782 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2221: 24.975306, 20.753372 avg loss, 0.001300 rate, 6.248394 seconds, 71072 images, 1398.207646 hours left
Loaded: 0.000031 seconds

 2222: 22.383747, 20.916410 avg loss, 0.001300 rate, 6.195957 seconds, 71104 images, 1393.378935 hours left
Loaded: 0.000033 seconds

 2223: 16.858189, 20.510588 avg loss, 0.001300 rate, 5.641815 seconds, 71136 images, 1388.021060 hours left
Loaded: 0.000039 seconds

 2224: 18.957771, 20.355307 avg loss, 0.001300 rate, 5.677256 seconds, 71168 images, 1381.949761 hours left
Loaded: 0.000039 seconds

 2225: 21.828114, 20.502588 avg loss, 0.001300 rate, 6.072423 seconds, 71200 images, 1375.988221 hours left
Loaded: 0.000030 seconds

 2226: 25.563900, 21.008720 avg loss, 0.001300 rate, 6.353076 seconds, 71232 images, 1370.633230 hours left
Loaded: 0.000040 seconds

 2227: 19.534340, 20.861282 avg loss, 0.001300 rate, 5.574471 seconds, 71264 images, 1365.720211 hours left
Loaded: 0.000028 seconds

 2228: 22.603245, 21.035479 avg loss, 0.001300 rate, 5.977185 seconds, 71296 images, 1359.778655 hours left
Loaded: 0.000029 seconds

 2229: 23.317982, 21.263729 avg loss, 0.001300 rate, 6.074870 seconds, 71328 images, 1354.453875 hours left
Loaded: 0.000034 seconds

 2230: 18.763235, 21.013680 avg loss, 0.001300 rate, 5.674843 seconds, 71360 images, 1349.317545 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.000023 seconds

 2231: 16.008377, 20.513149 avg loss, 0.001300 rate, 10.380094 seconds, 71392 images, 1343.678886 hours left
Loaded: 0.000026 seconds

 2232: 21.257933, 20.587627 avg loss, 0.001300 rate, 11.336046 seconds, 71424 images, 1344.609028 hours left
Loaded: 0.000028 seconds

 2233: 26.460482, 21.174913 avg loss, 0.001300 rate, 11.925470 seconds, 71456 images, 1346.852955 hours left
Loaded: 0.000028 seconds

 2234: 24.790319, 21.536453 avg loss, 0.001300 rate, 11.528608 seconds, 71488 images, 1349.890221 hours left
Loaded: 0.000027 seconds

 2235: 17.346865, 21.117495 avg loss, 0.001300 rate, 10.563629 seconds, 71520 images, 1352.347796 hours left
Loaded: 0.000040 seconds

 2236: 11.544752, 20.160221 avg loss, 0.001300 rate, 9.911507 seconds, 71552 images, 1353.445164 hours left
Loaded: 0.000034 seconds

 2237: 14.158266, 19.560026 avg loss, 0.001300 rate, 10.058403 seconds, 71584 images, 1353.628965 hours left
Loaded: 0.000028 seconds

 2238: 16.176792, 19.221703 avg loss, 0.001300 rate, 11.465438 seconds, 71616 images, 1354.014208 hours left
Loaded: 0.000028 seconds

 2239: 25.985420, 19.898075 avg loss, 0.001300 rate, 12.388832 seconds, 71648 images, 1356.342987 hours left
Loaded: 0.000030 seconds

 2240: 20.155643, 19.923832 avg loss, 0.001300 rate, 11.831888 seconds, 71680 images, 1359.926477 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.134536 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2241: 20.707382, 20.002188 avg loss, 0.001300 rate, 13.066846 seconds, 71712 images, 1362.703257 hours left
Loaded: 0.000037 seconds

 2242: 24.689543, 20.470922 avg loss, 0.001300 rate, 13.867715 seconds, 71744 images, 1367.347646 hours left
Loaded: 0.000036 seconds

 2243: 16.305416, 20.054371 avg loss, 0.001300 rate, 12.157231 seconds, 71776 images, 1372.867846 hours left
Loaded: 0.000030 seconds

 2244: 19.685501, 20.017485 avg loss, 0.001300 rate, 12.677417 seconds, 71808 images, 1375.965414 hours left
Loaded: 0.000029 seconds

 2245: 24.506247, 20.466360 avg loss, 0.001300 rate, 13.432002 seconds, 71840 images, 1379.751924 hours left
Loaded: 0.000030 seconds

 2246: 21.614843, 20.581209 avg loss, 0.001300 rate, 13.173711 seconds, 71872 images, 1384.544909 hours left
Loaded: 0.000036 seconds

 2247: 24.434944, 20.966583 avg loss, 0.001300 rate, 13.300681 seconds, 71904 images, 1388.932443 hours left
Loaded: 0.000044 seconds

 2248: 16.550554, 20.524981 avg loss, 0.001300 rate, 11.361163 seconds, 71936 images, 1393.451805 hours left
Loaded: 0.000027 seconds

 2249: 10.714996, 19.543982 avg loss, 0.001300 rate, 11.153493 seconds, 71968 images, 1395.241589 hours left
Loaded: 0.000030 seconds

 2250: 24.493828, 20.038967 avg loss, 0.001300 rate, 13.135749 seconds, 72000 images, 1396.725998 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.153596 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2251: 16.570566, 19.692127 avg loss, 0.001300 rate, 5.516275 seconds, 72032 images, 1400.939035 hours left
Loaded: 0.000032 seconds

 2252: 19.434359, 19.666351 avg loss, 0.001300 rate, 5.616515 seconds, 72064 images, 1394.776902 hours left
Loaded: 0.000029 seconds

 2253: 17.808546, 19.480572 avg loss, 0.001300 rate, 5.729074 seconds, 72096 images, 1388.602571 hours left
Loaded: 0.000027 seconds

 2254: 30.520958, 20.584610 avg loss, 0.001300 rate, 6.534059 seconds, 72128 images, 1382.645750 hours left
Loaded: 0.000030 seconds

 2255: 25.391237, 21.065273 avg loss, 0.001300 rate, 6.049766 seconds, 72160 images, 1377.862588 hours left
Loaded: 0.000037 seconds

 2256: 18.325438, 20.791290 avg loss, 0.001300 rate, 5.797774 seconds, 72192 images, 1372.456976 hours left
Loaded: 0.000041 seconds

 2257: 19.073566, 20.619518 avg loss, 0.001300 rate, 5.764455 seconds, 72224 images, 1366.756669 hours left
Loaded: 0.000036 seconds

 2258: 28.355526, 21.393120 avg loss, 0.001300 rate, 6.452326 seconds, 72256 images, 1361.067225 hours left
Loaded: 0.000030 seconds

 2259: 16.604918, 20.914299 avg loss, 0.001300 rate, 5.411751 seconds, 72288 images, 1356.386671 hours left
Loaded: 0.000024 seconds

 2260: 20.563251, 20.879194 avg loss, 0.001300 rate, 5.751997 seconds, 72320 images, 1350.312738 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.068496 seconds

 2261: 21.588202, 20.950094 avg loss, 0.001300 rate, 6.448110 seconds, 72352 images, 1344.770420 hours left
Loaded: 0.000026 seconds

 2262: 26.751383, 21.530224 avg loss, 0.001300 rate, 6.691666 seconds, 72384 images, 1340.341693 hours left
Loaded: 0.000039 seconds

 2263: 20.027262, 21.379929 avg loss, 0.001300 rate, 6.204868 seconds, 72416 images, 1336.199552 hours left
Loaded: 0.000028 seconds

 2264: 24.180149, 21.659950 avg loss, 0.001300 rate, 6.589337 seconds, 72448 images, 1331.425108 hours left
Loaded: 0.000028 seconds

 2265: 16.047880, 21.098743 avg loss, 0.001300 rate, 6.183623 seconds, 72480 images, 1327.230476 hours left
Loaded: 0.000031 seconds

 2266: 21.730684, 21.161938 avg loss, 0.001300 rate, 6.803990 seconds, 72512 images, 1322.516274 hours left
Loaded: 0.000032 seconds

 2267: 24.965622, 21.542307 avg loss, 0.001300 rate, 7.222795 seconds, 72544 images, 1318.707777 hours left
Loaded: 0.000030 seconds

 2268: 13.539999, 20.742077 avg loss, 0.001300 rate, 6.185223 seconds, 72576 images, 1315.516965 hours left
Loaded: 0.000042 seconds

 2269: 25.546303, 21.222500 avg loss, 0.001300 rate, 7.232758 seconds, 72608 images, 1310.922060 hours left
Loaded: 0.000041 seconds

 2270: 16.729208, 20.773170 avg loss, 0.001300 rate, 6.261283 seconds, 72640 images, 1307.822867 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.033822 seconds

 2271: 22.458670, 20.941721 avg loss, 0.001300 rate, 7.648147 seconds, 72672 images, 1303.410150 hours left
Loaded: 0.000032 seconds

 2272: 20.571739, 20.904722 avg loss, 0.001300 rate, 7.550385 seconds, 72704 images, 1301.007673 hours left
Loaded: 0.000030 seconds

 2273: 24.714930, 21.285744 avg loss, 0.001300 rate, 8.025485 seconds, 72736 images, 1298.447136 hours left
Loaded: 0.000030 seconds

 2274: 22.255650, 21.382734 avg loss, 0.001300 rate, 7.546593 seconds, 72768 images, 1296.569700 hours left
Loaded: 0.000028 seconds

 2275: 21.243647, 21.368826 avg loss, 0.001300 rate, 7.255168 seconds, 72800 images, 1294.048249 hours left
Loaded: 0.000029 seconds

 2276: 19.805458, 21.212490 avg loss, 0.001300 rate, 7.193750 seconds, 72832 images, 1291.148670 hours left
Loaded: 0.000031 seconds

 2277: 18.647493, 20.955990 avg loss, 0.001300 rate, 7.174416 seconds, 72864 images, 1288.193067 hours left
Loaded: 0.000032 seconds

 2278: 21.541891, 21.014580 avg loss, 0.001300 rate, 7.226239 seconds, 72896 images, 1285.240246 hours left
Loaded: 0.000038 seconds

 2279: 8.755363, 19.788658 avg loss, 0.001300 rate, 6.149327 seconds, 72928 images, 1282.388654 hours left
Loaded: 0.000039 seconds

 2280: 13.885994, 19.198391 avg loss, 0.001300 rate, 6.937131 seconds, 72960 images, 1278.075178 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.054932 seconds

 2281: 16.880779, 18.966629 avg loss, 0.001300 rate, 8.044023 seconds, 72992 images, 1274.895098 hours left
Loaded: 0.000026 seconds

 2282: 17.990034, 18.868969 avg loss, 0.001300 rate, 8.087677 seconds, 73024 images, 1273.354644 hours left
Loaded: 0.000030 seconds

 2283: 16.296850, 18.611757 avg loss, 0.001300 rate, 7.780831 seconds, 73056 images, 1271.813997 hours left
Loaded: 0.000029 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 2284: 26.242208, 19.374802 avg loss, 0.001300 rate, 9.153414 seconds, 73088 images, 1269.864085 hours left
Loaded: 0.000042 seconds

 2285: 23.950918, 19.832413 avg loss, 0.001300 rate, 8.731831 seconds, 73120 images, 1269.833227 hours left
Loaded: 0.000029 seconds

 2286: 19.136162, 19.762787 avg loss, 0.001300 rate, 8.276595 seconds, 73152 images, 1269.219213 hours left
Loaded: 0.000030 seconds

 2287: 21.257772, 19.912285 avg loss, 0.001300 rate, 8.734131 seconds, 73184 images, 1267.981284 hours left
Loaded: 0.000038 seconds

 2288: 21.623215, 20.083378 avg loss, 0.001300 rate, 8.684554 seconds, 73216 images, 1267.388908 hours left
Loaded: 0.000031 seconds

 2289: 18.144745, 19.889515 avg loss, 0.001300 rate, 8.250658 seconds, 73248 images, 1266.733832 hours left
Loaded: 0.000036 seconds

 2290: 20.922569, 19.992821 avg loss, 0.001300 rate, 8.505034 seconds, 73280 images, 1265.484797 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.027901 seconds

 2291: 16.696428, 19.663181 avg loss, 0.001300 rate, 9.176525 seconds, 73312 images, 1264.600271 hours left
Loaded: 0.000031 seconds

 2292: 23.155973, 20.012461 avg loss, 0.001300 rate, 10.027363 seconds, 73344 images, 1264.692413 hours left
Loaded: 0.000028 seconds

 2293: 17.909019, 19.802116 avg loss, 0.001300 rate, 9.246153 seconds, 73376 images, 1265.922525 hours left
Loaded: 0.000040 seconds

 2294: 21.742748, 19.996180 avg loss, 0.001300 rate, 9.540858 seconds, 73408 images, 1266.059179 hours left
Loaded: 0.000037 seconds

 2295: 27.863146, 20.782877 avg loss, 0.001300 rate, 10.284568 seconds, 73440 images, 1266.602303 hours left
Loaded: 0.000036 seconds

 2296: 20.679649, 20.772554 avg loss, 0.001300 rate, 9.415270 seconds, 73472 images, 1268.169186 hours left
Loaded: 0.000038 seconds

 2297: 17.156153, 20.410913 avg loss, 0.001300 rate, 9.014243 seconds, 73504 images, 1268.517349 hours left
Loaded: 0.000037 seconds

 2298: 20.660381, 20.435860 avg loss, 0.001300 rate, 9.343196 seconds, 73536 images, 1268.307027 hours left
Loaded: 0.000030 seconds

 2299: 15.106065, 19.902880 avg loss, 0.001300 rate, 8.796074 seconds, 73568 images, 1268.554019 hours left
Loaded: 0.000029 seconds

 2300: 23.945967, 20.307188 avg loss, 0.001300 rate, 9.151160 seconds, 73600 images, 1268.041347 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.387280 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2301: 19.315834, 20.208054 avg loss, 0.001300 rate, 8.067537 seconds, 73632 images, 1268.025173 hours left
Loaded: 0.000029 seconds

 2302: 16.863390, 19.873587 avg loss, 0.001300 rate, 7.812251 seconds, 73664 images, 1267.045438 hours left
Loaded: 0.000040 seconds

 2303: 21.227171, 20.008945 avg loss, 0.001300 rate, 8.483560 seconds, 73696 images, 1265.186281 hours left
Loaded: 0.000030 seconds

 2304: 17.180346, 19.726086 avg loss, 0.001300 rate, 7.919048 seconds, 73728 images, 1264.274722 hours left
Loaded: 0.000031 seconds

 2305: 24.863962, 20.239874 avg loss, 0.001300 rate, 8.877683 seconds, 73760 images, 1262.591025 hours left
Loaded: 0.000032 seconds

 2306: 22.300726, 20.445959 avg loss, 0.001300 rate, 8.606144 seconds, 73792 images, 1262.250773 hours left
Loaded: 0.000041 seconds

 2307: 18.438795, 20.245243 avg loss, 0.001300 rate, 8.131018 seconds, 73824 images, 1261.538126 hours left
Loaded: 0.000037 seconds

 2308: 19.350277, 20.155746 avg loss, 0.001300 rate, 8.371021 seconds, 73856 images, 1260.175081 hours left
Loaded: 0.000038 seconds

 2309: 22.193142, 20.359486 avg loss, 0.001300 rate, 8.737211 seconds, 73888 images, 1259.157771 hours left
Loaded: 0.000030 seconds

 2310: 17.039194, 20.027456 avg loss, 0.001300 rate, 7.977827 seconds, 73920 images, 1258.657371 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.281549 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2311: 17.082932, 19.733004 avg loss, 0.001300 rate, 5.561749 seconds, 73952 images, 1257.111056 hours left
Loaded: 0.000030 seconds

 2312: 22.721830, 20.031887 avg loss, 0.001300 rate, 6.074799 seconds, 73984 images, 1252.626268 hours left
Loaded: 0.000038 seconds

 2313: 22.434828, 20.272181 avg loss, 0.001300 rate, 5.960142 seconds, 74016 images, 1248.506704 hours left
Loaded: 0.000040 seconds

 2314: 12.865906, 19.531553 avg loss, 0.001300 rate, 5.227850 seconds, 74048 images, 1244.269660 hours left
Loaded: 0.000037 seconds

 2315: 20.993364, 19.677734 avg loss, 0.001300 rate, 5.898806 seconds, 74080 images, 1239.061591 hours left
Loaded: 0.000040 seconds

 2316: 28.726040, 20.582565 avg loss, 0.001300 rate, 6.590997 seconds, 74112 images, 1234.834085 hours left
Loaded: 0.000031 seconds

 2317: 20.422688, 20.566578 avg loss, 0.001300 rate, 5.793348 seconds, 74144 images, 1231.606727 hours left
Loaded: 0.000038 seconds

 2318: 19.519405, 20.461861 avg loss, 0.001300 rate, 5.764868 seconds, 74176 images, 1227.307791 hours left
Loaded: 0.000041 seconds

 2319: 23.109657, 20.726641 avg loss, 0.001300 rate, 6.076440 seconds, 74208 images, 1223.012427 hours left
Loaded: 0.000030 seconds

 2320: 26.516037, 21.305580 avg loss, 0.001300 rate, 6.237284 seconds, 74240 images, 1219.191170 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 2321: 22.518740, 21.426895 avg loss, 0.001300 rate, 13.157192 seconds, 74272 images, 1215.630674 hours left
Loaded: 0.000029 seconds

 2322: 14.691752, 20.753382 avg loss, 0.001300 rate, 11.616516 seconds, 74304 images, 1221.681744 hours left
Loaded: 0.000028 seconds

 2323: 16.161324, 20.294176 avg loss, 0.001300 rate, 12.004525 seconds, 74336 images, 1225.540237 hours left
Loaded: 0.000031 seconds

 2324: 20.807705, 20.345530 avg loss, 0.001300 rate, 12.970980 seconds, 74368 images, 1229.897049 hours left
Loaded: 0.000029 seconds

 2325: 19.244047, 20.235382 avg loss, 0.001300 rate, 12.567199 seconds, 74400 images, 1235.547667 hours left
Loaded: 0.000029 seconds

 2326: 18.283619, 20.040205 avg loss, 0.001300 rate, 12.574248 seconds, 74432 images, 1240.582978 hours left
Loaded: 0.000029 seconds

 2327: 15.391876, 19.575373 avg loss, 0.001300 rate, 12.247687 seconds, 74464 images, 1245.577656 hours left
Loaded: 0.000031 seconds

 2328: 17.816973, 19.399532 avg loss, 0.001300 rate, 12.407273 seconds, 74496 images, 1250.070453 hours left
Loaded: 0.000029 seconds

 2329: 26.745117, 20.134090 avg loss, 0.001300 rate, 14.455581 seconds, 74528 images, 1254.739128 hours left
Loaded: 0.000029 seconds

 2330: 12.691381, 19.389820 avg loss, 0.001300 rate, 11.699573 seconds, 74560 images, 1262.195544 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.412822 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2331: 22.394741, 19.690311 avg loss, 0.001300 rate, 7.488089 seconds, 74592 images, 1265.763577 hours left
Loaded: 0.000028 seconds

 2332: 17.656950, 19.486975 avg loss, 0.001300 rate, 7.174860 seconds, 74624 images, 1264.039256 hours left
Loaded: 0.000026 seconds

 2333: 21.957546, 19.734032 avg loss, 0.001300 rate, 7.617902 seconds, 74656 images, 1261.327486 hours left
Loaded: 0.000029 seconds

 2334: 18.030806, 19.563709 avg loss, 0.001300 rate, 7.228414 seconds, 74688 images, 1259.255893 hours left
Loaded: 0.000029 seconds

 2335: 24.525707, 20.059910 avg loss, 0.001300 rate, 7.901061 seconds, 74720 images, 1256.666026 hours left
Loaded: 0.000032 seconds

 2336: 21.636501, 20.217569 avg loss, 0.001300 rate, 7.340283 seconds, 74752 images, 1255.032843 hours left
Loaded: 0.000029 seconds

 2337: 17.542025, 19.950014 avg loss, 0.001300 rate, 7.151644 seconds, 74784 images, 1252.639973 hours left
Loaded: 0.000030 seconds

 2338: 18.058121, 19.760824 avg loss, 0.001300 rate, 7.195080 seconds, 74816 images, 1250.009973 hours left
Loaded: 0.000030 seconds

 2339: 21.590124, 19.943754 avg loss, 0.001300 rate, 7.656296 seconds, 74848 images, 1247.466360 hours left
Loaded: 0.000038 seconds

 2340: 21.215239, 20.070902 avg loss, 0.001300 rate, 7.456645 seconds, 74880 images, 1245.586385 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.437639 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2341: 21.832966, 20.247108 avg loss, 0.001300 rate, 5.855270 seconds, 74912 images, 1243.448939 hours left
Loaded: 0.000029 seconds

 2342: 19.442259, 20.166624 avg loss, 0.001300 rate, 5.815745 seconds, 74944 images, 1239.722433 hours left
Loaded: 0.000031 seconds

 2343: 22.985052, 20.448467 avg loss, 0.001300 rate, 5.880821 seconds, 74976 images, 1235.372929 hours left
Loaded: 0.000033 seconds

 2344: 16.437277, 20.047348 avg loss, 0.001300 rate, 5.366665 seconds, 75008 images, 1231.156957 hours left
Loaded: 0.000030 seconds

 2345: 16.037951, 19.646408 avg loss, 0.001300 rate, 5.477543 seconds, 75040 images, 1226.271658 hours left
Loaded: 0.000030 seconds

 2346: 15.090907, 19.190859 avg loss, 0.001300 rate, 5.434300 seconds, 75072 images, 1221.588622 hours left
Loaded: 0.000031 seconds

 2347: 14.466098, 18.718382 avg loss, 0.001300 rate, 5.409135 seconds, 75104 images, 1216.892563 hours left
Loaded: 0.000038 seconds

 2348: 21.792587, 19.025803 avg loss, 0.001300 rate, 5.799806 seconds, 75136 images, 1212.208630 hours left
Loaded: 0.000039 seconds

 2349: 19.327194, 19.055943 avg loss, 0.001300 rate, 5.837709 seconds, 75168 images, 1208.112124 hours left
Loaded: 0.000039 seconds

 2350: 22.715418, 19.421890 avg loss, 0.001300 rate, 6.070886 seconds, 75200 images, 1204.109016 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.000351 seconds

 2351: 19.774881, 19.457190 avg loss, 0.001300 rate, 7.591035 seconds, 75232 images, 1200.468581 hours left
Loaded: 0.000029 seconds

 2352: 20.732117, 19.584682 avg loss, 0.001300 rate, 7.297891 seconds, 75264 images, 1198.968468 hours left
Loaded: 0.000030 seconds

 2353: 15.330770, 19.159290 avg loss, 0.001300 rate, 6.777368 seconds, 75296 images, 1197.077253 hours left
Loaded: 0.000029 seconds

 2354: 20.732971, 19.316658 avg loss, 0.001300 rate, 7.211423 seconds, 75328 images, 1194.484661 hours left
Loaded: 0.000038 seconds

 2355: 24.413815, 19.826374 avg loss, 0.001300 rate, 7.863101 seconds, 75360 images, 1192.518595 hours left
Loaded: 0.000039 seconds

 2356: 24.892513, 20.332989 avg loss, 0.001300 rate, 7.755383 seconds, 75392 images, 1191.473931 hours left
Loaded: 0.000038 seconds

 2357: 19.310760, 20.230766 avg loss, 0.001300 rate, 7.346138 seconds, 75424 images, 1190.290641 hours left
Loaded: 0.000039 seconds

 2358: 19.228476, 20.130537 avg loss, 0.001300 rate, 7.175807 seconds, 75456 images, 1188.552878 hours left
Loaded: 0.000032 seconds

 2359: 19.502369, 20.067720 avg loss, 0.001300 rate, 7.224424 seconds, 75488 images, 1186.596780 hours left
Loaded: 0.000028 seconds

 2360: 15.204079, 19.581356 avg loss, 0.001300 rate, 6.685802 seconds, 75520 images, 1184.727486 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.300864 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2361: 19.313263, 19.554546 avg loss, 0.001300 rate, 5.894497 seconds, 75552 images, 1182.131555 hours left
Loaded: 0.000034 seconds

 2362: 17.831575, 19.382250 avg loss, 0.001300 rate, 5.933103 seconds, 75584 images, 1178.882894 hours left
Loaded: 0.000038 seconds

 2363: 21.857563, 19.629782 avg loss, 0.001300 rate, 6.118986 seconds, 75616 images, 1175.303860 hours left
Loaded: 0.000038 seconds

 2364: 23.140802, 19.980885 avg loss, 0.001300 rate, 6.197024 seconds, 75648 images, 1172.017813 hours left
Loaded: 0.000030 seconds

 2365: 23.773104, 20.360107 avg loss, 0.001300 rate, 6.322273 seconds, 75680 images, 1168.872592 hours left
Loaded: 0.000038 seconds

 2366: 12.623770, 19.586473 avg loss, 0.001300 rate, 5.293517 seconds, 75712 images, 1165.932104 hours left
Loaded: 0.000039 seconds

 2367: 16.795580, 19.307384 avg loss, 0.001300 rate, 5.826723 seconds, 75744 images, 1161.597517 hours left
Loaded: 0.000035 seconds

 2368: 20.099844, 19.386631 avg loss, 0.001300 rate, 5.858404 seconds, 75776 images, 1158.044075 hours left
Loaded: 0.000031 seconds

 2369: 19.176855, 19.365654 avg loss, 0.001300 rate, 5.884425 seconds, 75808 images, 1154.569969 hours left
Loaded: 0.000038 seconds

 2370: 18.595984, 19.288687 avg loss, 0.001300 rate, 5.873234 seconds, 75840 images, 1151.166589 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.000030 seconds

 2371: 24.001926, 19.760010 avg loss, 0.001300 rate, 11.656228 seconds, 75872 images, 1147.781749 hours left
Loaded: 0.000029 seconds

 2372: 23.086836, 20.092693 avg loss, 0.001300 rate, 11.098835 seconds, 75904 images, 1152.432612 hours left
Loaded: 0.000030 seconds

 2373: 19.811771, 20.064602 avg loss, 0.001300 rate, 10.586729 seconds, 75936 images, 1156.265674 hours left
Loaded: 0.000038 seconds

 2374: 22.968655, 20.355007 avg loss, 0.001300 rate, 11.348122 seconds, 75968 images, 1159.351783 hours left
Loaded: 0.000025 seconds

 2375: 18.577320, 20.177238 avg loss, 0.001300 rate, 10.560226 seconds, 76000 images, 1163.460539 hours left
Loaded: 0.000030 seconds

 2376: 20.184137, 20.177929 avg loss, 0.001300 rate, 10.270035 seconds, 76032 images, 1166.437961 hours left
Loaded: 0.000029 seconds

 2377: 11.611428, 19.321280 avg loss, 0.001300 rate, 9.269895 seconds, 76064 images, 1168.984056 hours left
Loaded: 0.000025 seconds

 2378: 26.411480, 20.030300 avg loss, 0.001300 rate, 11.360347 seconds, 76096 images, 1170.120790 hours left
Loaded: 0.000029 seconds

 2379: 19.279299, 19.955200 avg loss, 0.001300 rate, 10.451854 seconds, 76128 images, 1174.138627 hours left
Loaded: 0.000029 seconds

 2380: 22.544516, 20.214132 avg loss, 0.001300 rate, 10.847236 seconds, 76160 images, 1176.859205 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000031 seconds

 2381: 18.839039, 20.076622 avg loss, 0.001300 rate, 12.932774 seconds, 76192 images, 1180.099627 hours left
Loaded: 0.000033 seconds

 2382: 20.932449, 20.162205 avg loss, 0.001300 rate, 14.084370 seconds, 76224 images, 1186.193298 hours left
Loaded: 0.000027 seconds

 2383: 18.611826, 20.007168 avg loss, 0.001300 rate, 13.801446 seconds, 76256 images, 1193.819418 hours left
Loaded: 0.000041 seconds

 2384: 22.267548, 20.233206 avg loss, 0.001300 rate, 14.195263 seconds, 76288 images, 1200.977761 hours left
Loaded: 0.000028 seconds

 2385: 19.921942, 20.202080 avg loss, 0.001300 rate, 13.573346 seconds, 76320 images, 1208.609408 hours left
Loaded: 0.000027 seconds

 2386: 24.149012, 20.596773 avg loss, 0.001300 rate, 14.300819 seconds, 76352 images, 1215.304164 hours left
Loaded: 0.000036 seconds

 2387: 21.336113, 20.670708 avg loss, 0.001300 rate, 13.805997 seconds, 76384 images, 1222.938502 hours left
Loaded: 0.000037 seconds

 2388: 27.809469, 21.384584 avg loss, 0.001300 rate, 14.835345 seconds, 76416 images, 1229.811809 hours left
Loaded: 0.000027 seconds

 2389: 19.445295, 21.190655 avg loss, 0.001300 rate, 13.257497 seconds, 76448 images, 1238.040598 hours left
Loaded: 0.000031 seconds

 2390: 19.439100, 21.015499 avg loss, 0.001300 rate, 13.168499 seconds, 76480 images, 1244.003869 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.048217 seconds

 2391: 11.581091, 20.072058 avg loss, 0.001300 rate, 9.838492 seconds, 76512 images, 1249.784334 hours left
Loaded: 0.000024 seconds

 2392: 20.760433, 20.140896 avg loss, 0.001300 rate, 10.954435 seconds, 76544 images, 1250.966113 hours left
Loaded: 0.000039 seconds

 2393: 12.944037, 19.421209 avg loss, 0.001300 rate, 10.028034 seconds, 76576 images, 1253.613421 hours left
Loaded: 0.000027 seconds

 2394: 24.533524, 19.932442 avg loss, 0.001300 rate, 11.492359 seconds, 76608 images, 1254.952445 hours left
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Loaded: 0.000030 seconds

 2395: 22.033445, 20.142542 avg loss, 0.001300 rate, 11.105219 seconds, 76640 images, 1258.304118 hours left
Loaded: 0.000036 seconds

 2396: 24.066648, 20.534952 avg loss, 0.001300 rate, 11.349667 seconds, 76672 images, 1261.086589 hours left
Loaded: 0.000027 seconds

 2397: 19.586508, 20.440107 avg loss, 0.001300 rate, 10.971374 seconds, 76704 images, 1264.179437 hours left
Loaded: 0.000029 seconds

 2398: 20.530807, 20.449177 avg loss, 0.001300 rate, 11.080033 seconds, 76736 images, 1266.717900 hours left
Loaded: 0.000037 seconds

 2399: 17.202930, 20.124552 avg loss, 0.001300 rate, 10.896283 seconds, 76768 images, 1269.381293 hours left
Loaded: 0.000026 seconds

 2400: 16.509510, 19.763048 avg loss, 0.001300 rate, 10.539837 seconds, 76800 images, 1271.763792 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.049365 seconds

 2401: 22.461391, 20.032883 avg loss, 0.001300 rate, 13.149945 seconds, 76832 images, 1273.629239 hours left
Loaded: 0.000029 seconds

 2402: 22.122377, 20.241833 avg loss, 0.001300 rate, 13.110904 seconds, 76864 images, 1279.155635 hours left
Loaded: 0.000028 seconds

 2403: 20.444584, 20.262108 avg loss, 0.001300 rate, 12.967041 seconds, 76896 images, 1284.504452 hours left
Loaded: 0.000029 seconds

 2404: 14.141774, 19.650074 avg loss, 0.001300 rate, 11.555707 seconds, 76928 images, 1289.600692 hours left
Loaded: 0.000038 seconds

 2405: 15.276403, 19.212708 avg loss, 0.001300 rate, 12.018395 seconds, 76960 images, 1292.693215 hours left
Loaded: 0.000029 seconds

 2406: 18.607271, 19.152164 avg loss, 0.001300 rate, 12.573486 seconds, 76992 images, 1296.394965 hours left
Loaded: 0.000025 seconds

 2407: 20.476511, 19.284599 avg loss, 0.001300 rate, 12.957289 seconds, 77024 images, 1300.827675 hours left
Loaded: 0.000022 seconds

 2408: 26.368464, 19.992985 avg loss, 0.001300 rate, 13.631726 seconds, 77056 images, 1305.747044 hours left
Loaded: 0.000034 seconds

 2409: 15.945477, 19.588234 avg loss, 0.001300 rate, 11.869142 seconds, 77088 images, 1311.550322 hours left
Loaded: 0.000026 seconds

 2410: 14.927567, 19.122168 avg loss, 0.001300 rate, 11.559351 seconds, 77120 images, 1314.856859 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.411598 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2411: 12.915066, 18.501457 avg loss, 0.001300 rate, 10.489436 seconds, 77152 images, 1317.701666 hours left
Loaded: 0.000030 seconds

 2412: 24.015015, 19.052813 avg loss, 0.001300 rate, 11.796167 seconds, 77184 images, 1319.607120 hours left
Loaded: 0.000023 seconds

 2413: 15.341740, 18.681705 avg loss, 0.001300 rate, 10.428572 seconds, 77216 images, 1322.732019 hours left
Loaded: 0.000029 seconds

 2414: 20.513538, 18.864889 avg loss, 0.001300 rate, 11.499462 seconds, 77248 images, 1323.933456 hours left
Loaded: 0.000027 seconds

 2415: 27.945911, 19.772991 avg loss, 0.001300 rate, 12.104141 seconds, 77280 images, 1326.604510 hours left
Loaded: 0.000040 seconds

 2416: 11.737877, 18.969481 avg loss, 0.001300 rate, 9.883351 seconds, 77312 images, 1330.085435 hours left
Loaded: 0.000035 seconds

 2417: 18.120815, 18.884613 avg loss, 0.001300 rate, 10.753519 seconds, 77344 images, 1330.458923 hours left
Loaded: 0.000034 seconds

 2418: 20.571846, 19.053337 avg loss, 0.001300 rate, 10.928268 seconds, 77376 images, 1332.032576 hours left
Loaded: 0.000034 seconds

 2419: 19.309000, 19.078903 avg loss, 0.001300 rate, 11.088443 seconds, 77408 images, 1333.832236 hours left
Loaded: 0.000029 seconds

 2420: 20.996143, 19.270628 avg loss, 0.001300 rate, 11.286182 seconds, 77440 images, 1335.835481 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.027767 seconds

 2421: 22.968851, 19.640450 avg loss, 0.001300 rate, 14.698529 seconds, 77472 images, 1338.092238 hours left
Loaded: 0.000034 seconds

 2422: 16.097113, 19.286116 avg loss, 0.001300 rate, 13.895059 seconds, 77504 images, 1345.085936 hours left
Loaded: 0.000027 seconds

 2423: 15.607659, 18.918270 avg loss, 0.001300 rate, 13.803846 seconds, 77536 images, 1350.859659 hours left
Loaded: 0.000027 seconds

 2424: 21.108658, 19.137308 avg loss, 0.001300 rate, 14.788142 seconds, 77568 images, 1356.449385 hours left
Loaded: 0.000028 seconds

 2425: 18.101864, 19.033764 avg loss, 0.001300 rate, 13.822256 seconds, 77600 images, 1363.344993 hours left
Loaded: 0.000027 seconds

 2426: 19.244209, 19.054808 avg loss, 0.001300 rate, 14.065127 seconds, 77632 images, 1368.835261 hours left
Loaded: 0.000030 seconds

 2427: 22.306971, 19.380024 avg loss, 0.001300 rate, 15.264260 seconds, 77664 images, 1374.606608 hours left
Loaded: 0.000032 seconds

 2428: 25.058989, 19.947920 avg loss, 0.001300 rate, 15.395824 seconds, 77696 images, 1381.979251 hours left
Loaded: 0.000033 seconds

 2429: 18.624084, 19.815536 avg loss, 0.001300 rate, 13.843815 seconds, 77728 images, 1389.460150 hours left
Loaded: 0.000036 seconds

 2430: 12.981370, 19.132120 avg loss, 0.001300 rate, 13.072177 seconds, 77760 images, 1394.718948 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.345652 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2431: 23.702293, 19.589138 avg loss, 0.001300 rate, 5.849569 seconds, 77792 images, 1398.857542 hours left
Loaded: 0.000035 seconds

 2432: 21.883211, 19.818546 avg loss, 0.001300 rate, 5.647296 seconds, 77824 images, 1393.440222 hours left
Loaded: 0.000035 seconds

 2433: 20.354885, 19.872181 avg loss, 0.001300 rate, 5.569187 seconds, 77856 images, 1387.319039 hours left
Loaded: 0.000037 seconds

 2434: 19.325796, 19.817543 avg loss, 0.001300 rate, 5.372344 seconds, 77888 images, 1381.150986 hours left
Loaded: 0.000038 seconds

 2435: 22.958151, 20.131603 avg loss, 0.001300 rate, 5.790659 seconds, 77920 images, 1374.772266 hours left
Loaded: 0.000028 seconds

 2436: 20.856258, 20.204069 avg loss, 0.001300 rate, 5.523658 seconds, 77952 images, 1369.036065 hours left
Loaded: 0.000029 seconds

 2437: 19.889936, 20.172655 avg loss, 0.001300 rate, 5.399582 seconds, 77984 images, 1362.987799 hours left
Loaded: 0.000036 seconds

 2438: 25.117828, 20.667171 avg loss, 0.001300 rate, 5.721627 seconds, 78016 images, 1356.828339 hours left
Loaded: 0.000036 seconds

 2439: 12.988832, 19.899338 avg loss, 0.001300 rate, 4.996377 seconds, 78048 images, 1351.176021 hours left
Loaded: 0.000036 seconds

 2440: 22.415575, 20.150961 avg loss, 0.001300 rate, 5.507711 seconds, 78080 images, 1344.576824 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.014067 seconds

 2441: 22.762255, 20.412090 avg loss, 0.001300 rate, 7.905960 seconds, 78112 images, 1338.751036 hours left
Loaded: 0.000031 seconds

 2442: 21.313709, 20.502253 avg loss, 0.001300 rate, 7.852629 seconds, 78144 images, 1336.320874 hours left
Loaded: 0.000030 seconds

 2443: 15.847263, 20.036755 avg loss, 0.001300 rate, 7.318769 seconds, 78176 images, 1333.821789 hours left
Loaded: 0.000026 seconds

 2444: 19.310627, 19.964142 avg loss, 0.001300 rate, 7.698251 seconds, 78208 images, 1330.609081 hours left
Loaded: 0.000037 seconds

 2445: 18.389925, 19.806721 avg loss, 0.001300 rate, 7.562350 seconds, 78240 images, 1327.953483 hours left
Loaded: 0.000028 seconds

 2446: 19.379803, 19.764029 avg loss, 0.001300 rate, 7.691408 seconds, 78272 images, 1325.136418 hours left
Loaded: 0.000028 seconds

 2447: 20.665459, 19.854172 avg loss, 0.001300 rate, 7.838890 seconds, 78304 images, 1322.526039 hours left
Loaded: 0.000026 seconds

 2448: 19.494396, 19.818193 avg loss, 0.001300 rate, 7.628821 seconds, 78336 images, 1320.145779 hours left
Loaded: 0.000028 seconds

 2449: 27.012047, 20.537579 avg loss, 0.001300 rate, 8.460138 seconds, 78368 images, 1317.498674 hours left
Loaded: 0.000024 seconds

 2450: 13.313334, 19.815155 avg loss, 0.001300 rate, 7.121068 seconds, 78400 images, 1316.028130 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.036992 seconds

 2451: 22.186985, 20.052338 avg loss, 0.001300 rate, 10.385716 seconds, 78432 images, 1312.719705 hours left
Loaded: 0.000031 seconds

 2452: 21.317877, 20.178892 avg loss, 0.001300 rate, 9.848372 seconds, 78464 images, 1314.012020 hours left
Loaded: 0.000029 seconds

 2453: 14.486332, 19.609636 avg loss, 0.001300 rate, 9.196468 seconds, 78496 images, 1314.496850 hours left
Loaded: 0.000028 seconds

 2454: 21.768429, 19.825516 avg loss, 0.001300 rate, 9.692118 seconds, 78528 images, 1314.074915 hours left
Loaded: 0.000026 seconds

 2455: 18.098873, 19.652851 avg loss, 0.001300 rate, 9.384328 seconds, 78560 images, 1314.342884 hours left
Loaded: 0.000029 seconds

 2456: 18.220888, 19.509655 avg loss, 0.001300 rate, 9.553646 seconds, 78592 images, 1314.182329 hours left
Loaded: 0.000032 seconds

 2457: 20.191015, 19.577791 avg loss, 0.001300 rate, 9.859553 seconds, 78624 images, 1314.257603 hours left
Loaded: 0.000028 seconds

 2458: 16.833456, 19.303358 avg loss, 0.001300 rate, 9.286642 seconds, 78656 images, 1314.755310 hours left
Loaded: 0.000027 seconds

 2459: 23.861752, 19.759197 avg loss, 0.001300 rate, 10.052974 seconds, 78688 images, 1314.455413 hours left
Loaded: 0.000030 seconds

 2460: 19.138266, 19.697104 avg loss, 0.001300 rate, 9.424679 seconds, 78720 images, 1315.218668 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.018916 seconds

 2461: 22.954475, 20.022840 avg loss, 0.001300 rate, 10.897725 seconds, 78752 images, 1315.105055 hours left
Loaded: 0.000025 seconds

 2462: 19.541168, 19.974674 avg loss, 0.001300 rate, 10.548940 seconds, 78784 images, 1317.056553 hours left
Loaded: 0.000035 seconds

 2463: 19.755610, 19.952768 avg loss, 0.001300 rate, 10.505496 seconds, 78816 images, 1318.479847 hours left
Loaded: 0.000036 seconds

 2464: 23.449467, 20.302439 avg loss, 0.001300 rate, 10.980650 seconds, 78848 images, 1319.828791 hours left
Loaded: 0.000034 seconds

 2465: 11.891002, 19.461294 avg loss, 0.001300 rate, 9.443578 seconds, 78880 images, 1321.821564 hours left
Loaded: 0.000027 seconds

 2466: 21.584795, 19.673645 avg loss, 0.001300 rate, 10.981687 seconds, 78912 images, 1321.667941 hours left
Loaded: 0.000029 seconds

 2467: 21.405350, 19.846815 avg loss, 0.001300 rate, 10.970870 seconds, 78944 images, 1323.643684 hours left
Loaded: 0.000035 seconds

 2468: 16.590717, 19.521206 avg loss, 0.001300 rate, 10.157541 seconds, 78976 images, 1325.584675 hours left
Loaded: 0.000025 seconds

 2469: 24.260324, 19.995117 avg loss, 0.001300 rate, 10.991314 seconds, 79008 images, 1326.381057 hours left
Loaded: 0.000024 seconds

 2470: 25.527363, 20.548342 avg loss, 0.001300 rate, 11.035543 seconds, 79040 images, 1328.322889 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 2471: 13.290362, 19.822544 avg loss, 0.001300 rate, 12.825087 seconds, 79072 images, 1330.306458 hours left
Loaded: 0.000027 seconds

 2472: 19.534822, 19.793772 avg loss, 0.001300 rate, 13.977023 seconds, 79104 images, 1334.745847 hours left
Loaded: 0.000027 seconds

 2473: 25.210072, 20.335402 avg loss, 0.001300 rate, 14.808623 seconds, 79136 images, 1340.734407 hours left
Loaded: 0.000028 seconds

 2474: 23.617922, 20.663654 avg loss, 0.001300 rate, 14.599969 seconds, 79168 images, 1347.813484 hours left
Loaded: 0.000033 seconds

 2475: 12.115161, 19.808805 avg loss, 0.001300 rate, 12.511872 seconds, 79200 images, 1354.533078 hours left
Loaded: 0.000037 seconds

 2476: 16.376028, 19.465528 avg loss, 0.001300 rate, 13.440234 seconds, 79232 images, 1358.296764 hours left
Loaded: 0.000034 seconds

 2477: 17.383003, 19.257277 avg loss, 0.001300 rate, 14.048767 seconds, 79264 images, 1363.307098 hours left
Loaded: 0.000027 seconds

Saving weights to /darknet/myweights/backup//yolov4_last.weights
 2478: 22.160545, 19.547604 avg loss, 0.001300 rate, 14.781514 seconds, 79296 images, 1369.109113 hours left
Loaded: 0.000026 seconds

 2479: 12.714564, 18.864300 avg loss, 0.001300 rate, 13.253828 seconds, 79328 images, 1375.866748 hours left
Loaded: 0.000028 seconds

 2480: 19.132977, 18.891167 avg loss, 0.001300 rate, 14.468563 seconds, 79360 images, 1380.443364 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000038 seconds

 2481: 12.229527, 18.225002 avg loss, 0.001300 rate, 13.492330 seconds, 79392 images, 1386.654631 hours left
Loaded: 0.000028 seconds

 2482: 19.727634, 18.375265 avg loss, 0.001300 rate, 15.759081 seconds, 79424 images, 1391.453252 hours left
Loaded: 0.000026 seconds

 2483: 21.162357, 18.653975 avg loss, 0.001300 rate, 16.003851 seconds, 79456 images, 1399.339621 hours left
Loaded: 0.000028 seconds

 2484: 21.005327, 18.889111 avg loss, 0.001300 rate, 15.934808 seconds, 79488 images, 1407.485689 hours left
Loaded: 0.000029 seconds

 2485: 24.423090, 19.442509 avg loss, 0.001300 rate, 16.478515 seconds, 79520 images, 1415.454744 hours left
Loaded: 0.000029 seconds

 2486: 22.051548, 19.703413 avg loss, 0.001300 rate, 16.230350 seconds, 79552 images, 1424.096216 hours left
Loaded: 0.000028 seconds

 2487: 28.093861, 20.542458 avg loss, 0.001300 rate, 17.084338 seconds, 79584 images, 1432.307921 hours left
Loaded: 0.000027 seconds

 2488: 20.262321, 20.514444 avg loss, 0.001300 rate, 15.399385 seconds, 79616 images, 1441.618844 hours left
Loaded: 0.000027 seconds

 2489: 22.161083, 20.679108 avg loss, 0.001300 rate, 15.984226 seconds, 79648 images, 1448.505700 hours left
Loaded: 0.000030 seconds

 2490: 21.476265, 20.758823 avg loss, 0.001300 rate, 15.545250 seconds, 79680 images, 1456.132694 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.459688 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2491: 24.383339, 21.121275 avg loss, 0.001300 rate, 12.345452 seconds, 79712 images, 1463.076115 hours left
Loaded: 0.000029 seconds

 2492: 15.396688, 20.548817 avg loss, 0.001300 rate, 11.052789 seconds, 79744 images, 1466.159464 hours left
Loaded: 0.000022 seconds

 2493: 15.075796, 20.001514 avg loss, 0.001300 rate, 11.117087 seconds, 79776 images, 1466.787860 hours left
Loaded: 0.000026 seconds

 2494: 17.307745, 19.732138 avg loss, 0.001300 rate, 11.239185 seconds, 79808 images, 1467.498876 hours left
Loaded: 0.000025 seconds

 2495: 13.654448, 19.124369 avg loss, 0.001300 rate, 10.800129 seconds, 79840 images, 1468.371661 hours left
Loaded: 0.000035 seconds

 2496: 20.199383, 19.231871 avg loss, 0.001300 rate, 11.787722 seconds, 79872 images, 1468.628320 hours left
Loaded: 0.000027 seconds

 2497: 19.267115, 19.235395 avg loss, 0.001300 rate, 11.559934 seconds, 79904 images, 1470.248578 hours left
Loaded: 0.000026 seconds

 2498: 20.365189, 19.348375 avg loss, 0.001300 rate, 11.552400 seconds, 79936 images, 1471.537480 hours left
Loaded: 0.000026 seconds

 2499: 18.308746, 19.244411 avg loss, 0.001300 rate, 11.590844 seconds, 79968 images, 1472.803038 hours left
Loaded: 0.000026 seconds

 2500: 20.240471, 19.344017 avg loss, 0.001300 rate, 11.701823 seconds, 80000 images, 1474.109089 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.384608 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2501: 17.161860, 19.125801 avg loss, 0.001300 rate, 10.503060 seconds, 80032 images, 1475.555568 hours left
Loaded: 0.000027 seconds

 2502: 29.963406, 20.209562 avg loss, 0.001300 rate, 12.098986 seconds, 80064 images, 1475.861269 hours left
Loaded: 0.000029 seconds

 2503: 20.424219, 20.231028 avg loss, 0.001300 rate, 10.925549 seconds, 80096 images, 1477.839569 hours left
Loaded: 0.000027 seconds

 2504: 24.749943, 20.682919 avg loss, 0.001300 rate, 11.449371 seconds, 80128 images, 1478.174811 hours left
Loaded: 0.000027 seconds

 2505: 22.229877, 20.837614 avg loss, 0.001300 rate, 11.115773 seconds, 80160 images, 1479.231283 hours left
Loaded: 0.000040 seconds

 2506: 19.302076, 20.684061 avg loss, 0.001300 rate, 10.531382 seconds, 80192 images, 1479.815700 hours left
Loaded: 0.000034 seconds

 2507: 17.533175, 20.368973 avg loss, 0.001300 rate, 10.488359 seconds, 80224 images, 1479.585847 hours left
Loaded: 0.000036 seconds

 2508: 23.032024, 20.635279 avg loss, 0.001300 rate, 11.290513 seconds, 80256 images, 1479.298741 hours left
Loaded: 0.000029 seconds

 2509: 25.986103, 21.170361 avg loss, 0.001300 rate, 11.732345 seconds, 80288 images, 1480.124107 hours left
Loaded: 0.000030 seconds

 2510: 19.875086, 21.040833 avg loss, 0.001300 rate, 10.788493 seconds, 80320 images, 1481.552369 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.283885 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2511: 21.788353, 21.115585 avg loss, 0.001300 rate, 5.802898 seconds, 80352 images, 1481.660682 hours left
Loaded: 0.000028 seconds

 2512: 22.099091, 21.213936 avg loss, 0.001300 rate, 5.674818 seconds, 80384 images, 1475.263951 hours left
Loaded: 0.000027 seconds

 2513: 19.423679, 21.034910 avg loss, 0.001300 rate, 5.508546 seconds, 80416 images, 1468.361338 hours left
Loaded: 0.000024 seconds

 2514: 22.486134, 21.180033 avg loss, 0.001300 rate, 5.666970 seconds, 80448 images, 1461.297731 hours left
Loaded: 0.000034 seconds

 2515: 20.841629, 21.146193 avg loss, 0.001300 rate, 5.508889 seconds, 80480 images, 1454.523888 hours left
Loaded: 0.000035 seconds

 2516: 17.091198, 20.740692 avg loss, 0.001300 rate, 5.234338 seconds, 80512 images, 1447.599107 hours left
Loaded: 0.000027 seconds

 2517: 16.464571, 20.313080 avg loss, 0.001300 rate, 5.202394 seconds, 80544 images, 1440.363777 hours left
Loaded: 0.000027 seconds

 2518: 23.384239, 20.620195 avg loss, 0.001300 rate, 5.595959 seconds, 80576 images, 1433.156587 hours left
Loaded: 0.000034 seconds

 2519: 19.651613, 20.523336 avg loss, 0.001300 rate, 5.443360 seconds, 80608 images, 1426.565866 hours left
Loaded: 0.000030 seconds

 2520: 16.057625, 20.076765 avg loss, 0.001300 rate, 5.311039 seconds, 80640 images, 1419.829960 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000032 seconds

 2521: 17.936857, 19.862774 avg loss, 0.001300 rate, 13.803926 seconds, 80672 images, 1412.978355 hours left
Loaded: 0.000027 seconds

 2522: 21.231192, 19.999615 avg loss, 0.001300 rate, 14.360261 seconds, 80704 images, 1417.943255 hours left
Loaded: 0.000031 seconds

 2523: 20.587410, 20.058393 avg loss, 0.001300 rate, 14.208976 seconds, 80736 images, 1423.628022 hours left
Loaded: 0.000022 seconds

 2524: 10.379312, 19.090485 avg loss, 0.001300 rate, 12.568775 seconds, 80768 images, 1429.046639 hours left
Loaded: 0.000028 seconds

 2525: 23.646233, 19.546059 avg loss, 0.001300 rate, 15.224801 seconds, 80800 images, 1432.142184 hours left
Loaded: 0.000029 seconds

 2526: 15.869632, 19.178415 avg loss, 0.001300 rate, 13.772886 seconds, 80832 images, 1438.880730 hours left
Loaded: 0.000026 seconds

 2527: 29.229452, 20.183519 avg loss, 0.001300 rate, 15.706071 seconds, 80864 images, 1443.543473 hours left
Loaded: 0.000026 seconds

 2528: 18.033741, 19.968542 avg loss, 0.001300 rate, 14.253628 seconds, 80896 images, 1450.833641 hours left
Loaded: 0.000027 seconds

 2529: 14.335597, 19.405247 avg loss, 0.001300 rate, 12.973263 seconds, 80928 images, 1456.041762 hours left
Loaded: 0.000034 seconds

 2530: 15.084856, 18.973207 avg loss, 0.001300 rate, 13.413618 seconds, 80960 images, 1459.426694 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.328629 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2531: 24.367891, 19.512676 avg loss, 0.001300 rate, 5.806694 seconds, 80992 images, 1463.386874 hours left
Loaded: 0.000029 seconds

 2532: 18.079523, 19.369362 avg loss, 0.001300 rate, 5.512177 seconds, 81024 images, 1457.239686 hours left
Loaded: 0.000029 seconds

 2533: 22.028740, 19.635300 avg loss, 0.001300 rate, 5.601717 seconds, 81056 images, 1450.292044 hours left
Loaded: 0.000035 seconds

 2534: 16.316950, 19.303465 avg loss, 0.001300 rate, 5.171150 seconds, 81088 images, 1443.537703 hours left
Loaded: 0.000033 seconds

 2535: 28.126047, 20.185722 avg loss, 0.001300 rate, 5.837789 seconds, 81120 images, 1436.255323 hours left
Loaded: 0.000036 seconds

 2536: 15.748204, 19.741970 avg loss, 0.001300 rate, 5.100989 seconds, 81152 images, 1429.967868 hours left
Loaded: 0.000036 seconds

 2537: 16.194031, 19.387177 avg loss, 0.001300 rate, 5.061621 seconds, 81184 images, 1422.724110 hours left
Loaded: 0.000028 seconds

 2538: 16.318853, 19.080345 avg loss, 0.001300 rate, 5.127310 seconds, 81216 images, 1415.498318 hours left
Loaded: 0.000027 seconds

 2539: 21.162354, 19.288546 avg loss, 0.001300 rate, 5.357634 seconds, 81248 images, 1408.435624 hours left
Loaded: 0.000026 seconds

 2540: 19.727552, 19.332447 avg loss, 0.001300 rate, 5.237209 seconds, 81280 images, 1401.762131 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 2541: 20.259407, 19.425142 avg loss, 0.001300 rate, 5.801621 seconds, 81312 images, 1394.988782 hours left
Loaded: 0.000026 seconds

 2542: 15.812569, 19.063885 avg loss, 0.001300 rate, 5.569075 seconds, 81344 images, 1389.063854 hours left
Loaded: 0.000021 seconds

 2543: 16.450495, 18.802546 avg loss, 0.001300 rate, 5.555839 seconds, 81376 images, 1382.876501 hours left
Loaded: 0.000027 seconds

 2544: 22.503839, 19.172674 avg loss, 0.001300 rate, 5.964343 seconds, 81408 images, 1376.732692 hours left
Loaded: 0.000035 seconds

 2545: 11.683453, 18.423752 avg loss, 0.001300 rate, 5.327479 seconds, 81440 images, 1371.215359 hours left
Loaded: 0.000037 seconds

 2546: 21.751245, 18.756500 avg loss, 0.001300 rate, 5.998289 seconds, 81472 images, 1364.872279 hours left
Loaded: 0.000034 seconds

 2547: 17.111919, 18.592043 avg loss, 0.001300 rate, 6.029140 seconds, 81504 images, 1359.520487 hours left
Loaded: 0.000033 seconds

 2548: 22.461071, 18.978947 avg loss, 0.001300 rate, 6.241208 seconds, 81536 images, 1354.264865 hours left
Loaded: 0.000037 seconds

 2549: 22.426649, 19.323717 avg loss, 0.001300 rate, 6.301419 seconds, 81568 images, 1349.355113 hours left
Loaded: 0.000034 seconds

 2550: 24.250443, 19.816389 avg loss, 0.001300 rate, 6.485644 seconds, 81600 images, 1344.577731 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 2551: 24.769928, 20.311743 avg loss, 0.001300 rate, 14.980617 seconds, 81632 images, 1340.102920 hours left
Loaded: 0.000027 seconds

 2552: 21.674587, 20.448027 avg loss, 0.001300 rate, 14.406256 seconds, 81664 images, 1347.423002 hours left
Loaded: 0.000025 seconds

 2553: 28.309347, 21.234159 avg loss, 0.001300 rate, 15.916082 seconds, 81696 images, 1353.875397 hours left
Loaded: 0.000031 seconds

 2554: 18.466665, 20.957411 avg loss, 0.001300 rate, 13.974697 seconds, 81728 images, 1362.351594 hours left
Loaded: 0.000036 seconds

 2555: 10.893661, 19.951036 avg loss, 0.001300 rate, 12.453712 seconds, 81760 images, 1368.057701 hours left
Loaded: 0.000027 seconds

 2556: 18.335869, 19.789520 avg loss, 0.001300 rate, 14.084479 seconds, 81792 images, 1371.602918 hours left
Loaded: 0.000033 seconds

 2557: 19.228106, 19.733379 avg loss, 0.001300 rate, 14.017389 seconds, 81824 images, 1377.368277 hours left
Loaded: 0.000023 seconds

 2558: 13.450206, 19.105062 avg loss, 0.001300 rate, 13.115151 seconds, 81856 images, 1382.983155 hours left
Loaded: 0.000033 seconds

 2559: 21.765591, 19.371115 avg loss, 0.001300 rate, 14.793448 seconds, 81888 images, 1387.293880 hours left
Loaded: 0.000027 seconds

 2560: 16.599909, 19.093994 avg loss, 0.001300 rate, 13.859383 seconds, 81920 images, 1393.882843 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.408156 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2561: 22.540506, 19.438644 avg loss, 0.001300 rate, 11.187100 seconds, 81952 images, 1399.113901 hours left
Loaded: 0.000029 seconds

 2562: 18.606653, 19.355446 avg loss, 0.001300 rate, 10.690449 seconds, 81984 images, 1401.160914 hours left
Loaded: 0.000027 seconds

 2563: 23.162477, 19.736149 avg loss, 0.001300 rate, 11.310220 seconds, 82016 images, 1401.935971 hours left
Loaded: 0.000038 seconds

 2564: 23.780489, 20.140583 avg loss, 0.001300 rate, 11.566460 seconds, 82048 images, 1403.560486 hours left
Loaded: 0.000020 seconds

 2565: 24.220934, 20.548618 avg loss, 0.001300 rate, 11.221834 seconds, 82080 images, 1405.523161 hours left
Loaded: 0.000027 seconds

 2566: 20.007210, 20.494478 avg loss, 0.001300 rate, 10.727712 seconds, 82112 images, 1406.989480 hours left
Loaded: 0.000026 seconds

 2567: 17.723379, 20.217369 avg loss, 0.001300 rate, 10.077604 seconds, 82144 images, 1407.757671 hours left
Loaded: 0.000025 seconds

 2568: 18.662283, 20.061861 avg loss, 0.001300 rate, 10.321874 seconds, 82176 images, 1407.618951 hours left
Loaded: 0.000025 seconds

 2569: 16.202761, 19.675951 avg loss, 0.001300 rate, 9.935516 seconds, 82208 images, 1407.819450 hours left
Loaded: 0.000036 seconds

 2570: 21.084770, 19.816833 avg loss, 0.001300 rate, 10.464033 seconds, 82240 images, 1407.483529 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.062258 seconds

 2571: 26.763083, 20.511459 avg loss, 0.001300 rate, 12.784336 seconds, 82272 images, 1407.881967 hours left
Loaded: 0.000027 seconds

 2572: 24.001957, 20.860510 avg loss, 0.001300 rate, 12.598796 seconds, 82304 images, 1411.571748 hours left
Loaded: 0.000027 seconds

 2573: 23.958801, 21.170340 avg loss, 0.001300 rate, 12.371397 seconds, 82336 images, 1414.881896 hours left
Loaded: 0.000027 seconds

 2574: 20.273062, 21.080612 avg loss, 0.001300 rate, 11.731319 seconds, 82368 images, 1417.844383 hours left
Loaded: 0.000037 seconds

 2575: 18.296272, 20.802177 avg loss, 0.001300 rate, 11.503752 seconds, 82400 images, 1419.891903 hours left
Loaded: 0.000034 seconds

 2576: 26.805332, 21.402493 avg loss, 0.001300 rate, 12.440232 seconds, 82432 images, 1421.604175 hours left
Loaded: 0.000020 seconds

 2577: 24.397739, 21.702017 avg loss, 0.001300 rate, 12.117456 seconds, 82464 images, 1424.594554 hours left
Loaded: 0.000026 seconds

 2578: 24.524744, 21.984289 avg loss, 0.001300 rate, 12.411975 seconds, 82496 images, 1427.108537 hours left
Loaded: 0.000027 seconds

 2579: 19.769899, 21.762850 avg loss, 0.001300 rate, 11.878677 seconds, 82528 images, 1430.004709 hours left
Loaded: 0.000028 seconds

 2580: 24.222912, 22.008856 avg loss, 0.001300 rate, 11.802646 seconds, 82560 images, 1432.134275 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.332319 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2581: 24.702147, 22.278185 avg loss, 0.001300 rate, 7.041749 seconds, 82592 images, 1434.137353 hours left
Loaded: 0.000024 seconds

 2582: 22.798479, 22.330214 avg loss, 0.001300 rate, 7.106342 seconds, 82624 images, 1429.995125 hours left
Loaded: 0.000023 seconds

 2583: 16.900894, 21.787281 avg loss, 0.001300 rate, 6.510653 seconds, 82656 images, 1425.524044 hours left
Loaded: 0.000027 seconds

 2584: 19.672209, 21.575773 avg loss, 0.001300 rate, 6.696378 seconds, 82688 images, 1420.273749 hours left
Loaded: 0.000028 seconds

 2585: 29.907917, 22.408987 avg loss, 0.001300 rate, 7.677425 seconds, 82720 images, 1415.332822 hours left
Loaded: 0.000022 seconds

 2586: 26.878563, 22.855946 avg loss, 0.001300 rate, 7.277588 seconds, 82752 images, 1411.798170 hours left
Loaded: 0.000026 seconds

 2587: 26.160873, 23.186438 avg loss, 0.001300 rate, 7.472268 seconds, 82784 images, 1407.745823 hours left
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Loaded: 0.000027 seconds

 2588: 18.357868, 22.703581 avg loss, 0.001300 rate, 6.749264 seconds, 82816 images, 1404.003244 hours left
Loaded: 0.000026 seconds

 2589: 22.187744, 22.651997 avg loss, 0.001300 rate, 7.126664 seconds, 82848 images, 1399.298093 hours left
Loaded: 0.000039 seconds

 2590: 18.795025, 22.266300 avg loss, 0.001300 rate, 6.906676 seconds, 82880 images, 1395.161949 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000022 seconds

 2591: 21.521442, 22.191814 avg loss, 0.001300 rate, 12.003178 seconds, 82912 images, 1390.762904 hours left
Loaded: 0.000027 seconds

 2592: 19.805887, 21.953222 avg loss, 0.001300 rate, 12.110944 seconds, 82944 images, 1393.456680 hours left
Loaded: 0.000027 seconds

 2593: 21.846802, 21.942581 avg loss, 0.001300 rate, 12.660526 seconds, 82976 images, 1396.272541 hours left
Loaded: 0.000032 seconds

 2594: 19.287683, 21.677092 avg loss, 0.001300 rate, 11.921254 seconds, 83008 images, 1399.820322 hours left
Loaded: 0.000026 seconds

 2595: 21.683897, 21.677773 avg loss, 0.001300 rate, 12.459970 seconds, 83040 images, 1402.310132 hours left
Loaded: 0.000021 seconds

 2596: 24.603111, 21.970306 avg loss, 0.001300 rate, 13.025344 seconds, 83072 images, 1405.520083 hours left
Loaded: 0.000033 seconds

 2597: 23.865788, 22.159855 avg loss, 0.001300 rate, 12.750826 seconds, 83104 images, 1409.479842 hours left
Loaded: 0.000030 seconds

 2598: 22.901878, 22.234056 avg loss, 0.001300 rate, 12.475065 seconds, 83136 images, 1413.020307 hours left
Loaded: 0.000026 seconds

 2599: 20.491529, 22.059803 avg loss, 0.001300 rate, 12.161834 seconds, 83168 images, 1416.143934 hours left
Loaded: 0.000028 seconds

 2600: 23.928661, 22.246689 avg loss, 0.001300 rate, 12.650434 seconds, 83200 images, 1418.803069 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.286579 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2601: 15.798538, 21.601873 avg loss, 0.001300 rate, 7.201409 seconds, 83232 images, 1422.111343 hours left
Loaded: 0.000025 seconds

 2602: 30.838400, 22.525526 avg loss, 0.001300 rate, 8.990439 seconds, 83264 images, 1418.246525 hours left
Loaded: 0.000027 seconds

 2603: 19.822485, 22.255222 avg loss, 0.001300 rate, 7.522163 seconds, 83296 images, 1416.498332 hours left
Loaded: 0.000027 seconds

 2604: 17.885681, 21.818268 avg loss, 0.001300 rate, 7.456121 seconds, 83328 images, 1412.736905 hours left
Loaded: 0.000026 seconds

 2605: 20.858402, 21.722281 avg loss, 0.001300 rate, 7.893961 seconds, 83360 images, 1408.921732 hours left
Loaded: 0.000027 seconds

 2606: 16.522953, 21.202347 avg loss, 0.001300 rate, 7.436851 seconds, 83392 images, 1405.750240 hours left
Loaded: 0.000038 seconds

 2607: 14.633821, 20.545494 avg loss, 0.001300 rate, 7.147791 seconds, 83424 images, 1401.978242 hours left
Loaded: 0.000024 seconds

 2608: 20.301908, 20.521135 avg loss, 0.001300 rate, 7.431600 seconds, 83456 images, 1397.844176 hours left
Loaded: 0.000025 seconds

 2609: 18.545155, 20.323538 avg loss, 0.001300 rate, 7.409560 seconds, 83488 images, 1394.143929 hours left
Loaded: 0.000035 seconds

 2610: 27.346933, 21.025877 avg loss, 0.001300 rate, 8.076728 seconds, 83520 images, 1390.450182 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000023 seconds

 2611: 14.256834, 20.348972 avg loss, 0.001300 rate, 13.610585 seconds, 83552 images, 1387.716079 hours left
Loaded: 0.000025 seconds

 2612: 16.344994, 19.948574 avg loss, 0.001300 rate, 14.076048 seconds, 83584 images, 1392.662741 hours left
Loaded: 0.000025 seconds

 2613: 16.000202, 19.553738 avg loss, 0.001300 rate, 14.202867 seconds, 83616 images, 1398.203646 hours left
Loaded: 0.000027 seconds

 2614: 17.121883, 19.310553 avg loss, 0.001300 rate, 14.691904 seconds, 83648 images, 1403.864499 hours left
Loaded: 0.000026 seconds

 2615: 19.290302, 19.308527 avg loss, 0.001300 rate, 15.395911 seconds, 83680 images, 1410.145052 hours left
Loaded: 0.000027 seconds

 2616: 17.220560, 19.099730 avg loss, 0.001300 rate, 14.992225 seconds, 83712 images, 1417.336419 hours left
Loaded: 0.000033 seconds

 2617: 23.330460, 19.522802 avg loss, 0.001300 rate, 16.492949 seconds, 83744 images, 1423.897524 hours left
Loaded: 0.000026 seconds

 2618: 16.510820, 19.221603 avg loss, 0.001300 rate, 15.183335 seconds, 83776 images, 1432.468491 hours left
Loaded: 0.000035 seconds

 2619: 16.313951, 18.930838 avg loss, 0.001300 rate, 14.742316 seconds, 83808 images, 1439.142491 hours left
Loaded: 0.000027 seconds

 2620: 19.501001, 18.987854 avg loss, 0.001300 rate, 15.593092 seconds, 83840 images, 1445.139791 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.526221 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2621: 30.585934, 20.147661 avg loss, 0.001300 rate, 12.250940 seconds, 83872 images, 1452.253689 hours left
Loaded: 0.000028 seconds

 2622: 23.823906, 20.515285 avg loss, 0.001300 rate, 11.319749 seconds, 83904 images, 1455.401943 hours left
Loaded: 0.000026 seconds

 2623: 18.466549, 20.310411 avg loss, 0.001300 rate, 10.566096 seconds, 83936 images, 1456.503126 hours left
Loaded: 0.000028 seconds

 2624: 23.960222, 20.675392 avg loss, 0.001300 rate, 11.160974 seconds, 83968 images, 1456.550967 hours left
Loaded: 0.000026 seconds

 2625: 23.038784, 20.911732 avg loss, 0.001300 rate, 11.162768 seconds, 84000 images, 1457.421012 hours left
Loaded: 0.000028 seconds

 2626: 17.242092, 20.544767 avg loss, 0.001300 rate, 10.459332 seconds, 84032 images, 1458.284804 hours left
Loaded: 0.000037 seconds

 2627: 22.120693, 20.702360 avg loss, 0.001300 rate, 11.051357 seconds, 84064 images, 1458.167087 hours left
Loaded: 0.000028 seconds

 2628: 22.100044, 20.842129 avg loss, 0.001300 rate, 11.009918 seconds, 84096 images, 1458.869292 hours left
Loaded: 0.000027 seconds

 2629: 22.167290, 20.974646 avg loss, 0.001300 rate, 11.179252 seconds, 84128 images, 1459.507122 hours left
Loaded: 0.000027 seconds

 2630: 16.004498, 20.477631 avg loss, 0.001300 rate, 10.200920 seconds, 84160 images, 1460.372725 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 2631: 14.760768, 19.905945 avg loss, 0.001300 rate, 11.034750 seconds, 84192 images, 1459.876637 hours left
Loaded: 0.000036 seconds

 2632: 21.134171, 20.028767 avg loss, 0.001300 rate, 12.293215 seconds, 84224 images, 1460.538640 hours left
Loaded: 0.000033 seconds

 2633: 17.528162, 19.778706 avg loss, 0.001300 rate, 11.738415 seconds, 84256 images, 1462.934422 hours left
Loaded: 0.000027 seconds

 2634: 23.091223, 20.109957 avg loss, 0.001300 rate, 12.407316 seconds, 84288 images, 1464.538939 hours left
Loaded: 0.000036 seconds

 2635: 22.683819, 20.367344 avg loss, 0.001300 rate, 12.425589 seconds, 84320 images, 1467.052435 hours left
Loaded: 0.000027 seconds

 2636: 24.701881, 20.800798 avg loss, 0.001300 rate, 12.629987 seconds, 84352 images, 1469.566044 hours left
Loaded: 0.000026 seconds

 2637: 19.013504, 20.622068 avg loss, 0.001300 rate, 12.346749 seconds, 84384 images, 1472.337144 hours left
Loaded: 0.000024 seconds

 2638: 21.250219, 20.684883 avg loss, 0.001300 rate, 12.630004 seconds, 84416 images, 1474.688792 hours left
Loaded: 0.000031 seconds

 2639: 25.503845, 21.166779 avg loss, 0.001300 rate, 12.679577 seconds, 84448 images, 1477.408614 hours left
Loaded: 0.000020 seconds

 2640: 21.191359, 21.169237 avg loss, 0.001300 rate, 12.251283 seconds, 84480 images, 1480.169769 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.298275 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2641: 20.790182, 21.131332 avg loss, 0.001300 rate, 7.153949 seconds, 84512 images, 1482.310953 hours left
Loaded: 0.000026 seconds

 2642: 28.146261, 21.832825 avg loss, 0.001300 rate, 7.660506 seconds, 84544 images, 1477.793847 hours left
Loaded: 0.000026 seconds

 2643: 23.646299, 22.014172 avg loss, 0.001300 rate, 7.266861 seconds, 84576 images, 1473.609978 hours left
Loaded: 0.000026 seconds

 2644: 21.251871, 21.937943 avg loss, 0.001300 rate, 6.923728 seconds, 84608 images, 1468.923530 hours left
Loaded: 0.000026 seconds

 2645: 16.869644, 21.431112 avg loss, 0.001300 rate, 6.670464 seconds, 84640 images, 1463.809398 hours left
Loaded: 0.000032 seconds

 2646: 26.202673, 21.908268 avg loss, 0.001300 rate, 7.200597 seconds, 84672 images, 1458.396141 hours left
Loaded: 0.000034 seconds

 2647: 15.265372, 21.243979 avg loss, 0.001300 rate, 6.576134 seconds, 84704 images, 1453.770140 hours left
Loaded: 0.000033 seconds

 2648: 22.217222, 21.341303 avg loss, 0.001300 rate, 6.972546 seconds, 84736 images, 1448.326796 hours left
Loaded: 0.000033 seconds

 2649: 24.114365, 21.618608 avg loss, 0.001300 rate, 7.011797 seconds, 84768 images, 1443.486074 hours left
Loaded: 0.000033 seconds

 2650: 18.991331, 21.355881 avg loss, 0.001300 rate, 6.549158 seconds, 84800 images, 1438.748019 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 2651: 26.318146, 21.852108 avg loss, 0.001300 rate, 8.444874 seconds, 84832 images, 1433.417535 hours left
Loaded: 0.000027 seconds

 2652: 26.811869, 22.348083 avg loss, 0.001300 rate, 8.217951 seconds, 84864 images, 1430.761937 hours left
Loaded: 0.000027 seconds

 2653: 24.353537, 22.548630 avg loss, 0.001300 rate, 7.968202 seconds, 84896 images, 1427.819063 hours left
Loaded: 0.000036 seconds

 2654: 19.459173, 22.239685 avg loss, 0.001300 rate, 7.328695 seconds, 84928 images, 1424.560214 hours left
Loaded: 0.000026 seconds

 2655: 20.553947, 22.071112 avg loss, 0.001300 rate, 7.457612 seconds, 84960 images, 1420.449566 hours left
Loaded: 0.000048 seconds

 2656: 19.180246, 21.782024 avg loss, 0.001300 rate, 7.328431 seconds, 84992 images, 1416.558270 hours left
Loaded: 0.000027 seconds

 2657: 17.565540, 21.360376 avg loss, 0.001300 rate, 7.270680 seconds, 85024 images, 1412.527253 hours left
Loaded: 0.000026 seconds

 2658: 17.170500, 20.941389 avg loss, 0.001300 rate, 7.133578 seconds, 85056 images, 1408.456633 hours left
Loaded: 0.000035 seconds

 2659: 18.512592, 20.698509 avg loss, 0.001300 rate, 7.406233 seconds, 85088 images, 1404.237100 hours left
Loaded: 0.000033 seconds

 2660: 17.132627, 20.341921 avg loss, 0.001300 rate, 7.346876 seconds, 85120 images, 1400.436806 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.290668 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2661: 18.030230, 20.110752 avg loss, 0.001300 rate, 5.174015 seconds, 85152 images, 1396.592409 hours left
Loaded: 0.000034 seconds

 2662: 15.858722, 19.685549 avg loss, 0.001300 rate, 5.232915 seconds, 85184 images, 1390.183530 hours left
Loaded: 0.000028 seconds

 2663: 16.910742, 19.408068 avg loss, 0.001300 rate, 5.130756 seconds, 85216 images, 1383.518264 hours left
Loaded: 0.000026 seconds

 2664: 17.594208, 19.226681 avg loss, 0.001300 rate, 5.155979 seconds, 85248 images, 1376.778355 hours left
Loaded: 0.000030 seconds

 2665: 21.870211, 19.491034 avg loss, 0.001300 rate, 5.283053 seconds, 85280 images, 1370.140707 hours left
Loaded: 0.000035 seconds

 2666: 20.158367, 19.557766 avg loss, 0.001300 rate, 5.227773 seconds, 85312 images, 1363.745155 hours left
Loaded: 0.000034 seconds

 2667: 15.427773, 19.144766 avg loss, 0.001300 rate, 5.038298 seconds, 85344 images, 1357.337106 hours left
Loaded: 0.000036 seconds

 2668: 13.391771, 18.569466 avg loss, 0.001300 rate, 4.868220 seconds, 85376 images, 1350.731101 hours left
Loaded: 0.000035 seconds

 2669: 19.647104, 18.677229 avg loss, 0.001300 rate, 5.262381 seconds, 85408 images, 1343.955951 hours left
Loaded: 0.000033 seconds

1^C
jax@getafix:~/projects/yolov4$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
ba3d743acd7a        yolov4              "/darknet/darknet de…"   7 hours ago         Up 7 hours                                   reverent_hawking
81cbca676a0a        registry:2          "/entrypoint.sh /etc…"   7 weeks ago         Up 7 hours          0.0.0.0:5000->5000/tcp   registry
jax@getafix:~/projects/yolov4$ docker stop ba3
ba3
jax@getafix:~/projects/yolov4$ docker pa
docker: 'pa' is not a docker command.
See 'docker --help'
jax@getafix:~/projects/yolov4$ docker pa
docker: 'pa' is not a docker command.
See 'docker --help'
jax@getafix:~/projects/yolov4$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
81cbca676a0a        registry:2          "/entrypoint.sh /etc…"   7 weeks ago         Up 7 hours          0.0.0.0:5000->5000/tcp   registry
jax@getafix:~/projects/yolov4$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                        PORTS                    NAMES
ba3d743acd7a        yolov4              "/darknet/darknet de…"   7 hours ago         Exited (137) 25 seconds ago                            reverent_hawking
9b497291a659        yolov4              "/darknet/darknet de…"   2 days ago          Exited (137) 44 hours ago                              kind_hopper
7a5590bec383        pypa/bandersnatch   "bandersnatch mirror"    2 days ago          Exited (0) 43 hours ago                                funny_noether
0bb58a56e82c        yolov4              "/darknet/darknet de…"   2 days ago          Exited (137) 2 days ago                                silly_mestorf
c8b3d95120f5        yolov4              "/darknet/darknet de…"   2 days ago          Exited (137) 2 days ago                                elegant_engelbart
d5cbeaeb5db8        yolov4              "bash"                   2 days ago          Exited (1) 2 days ago                                  ecstatic_dijkstra
88369f5c7d64        yolov4              "/darknet/darknet de…"   2 days ago          Exited (1) 2 days ago                                  fervent_cohen
26e670ffdc38        yolov4              "/darknet/darknet de…"   2 days ago          Exited (1) 2 days ago                                  hungry_brattain
7a18bb05613e        yolov4              "bash"                   2 days ago          Exited (0) 2 days ago                                  romantic_burnell
99a3766e05f7        yolov4              "/darknet/darknet de…"   2 days ago          Exited (1) 2 days ago                                  strange_taussig
c4d36b18ecf7        yolov4              "/darknet/darknet de…"   2 days ago          Exited (1) 2 days ago                                  tender_rosalind
50c7f65de123        yolov4              "/darknet/darknet pa…"   2 days ago          Exited (0) 2 days ago                                  quizzical_sammet
bd0b87db5c6d        yolov4              "/darknet/darknet pa…"   2 days ago          Exited (0) 2 days ago                                  gallant_ishizaka
8e23ec82dbef        yolov4              "bash"                   2 days ago          Exited (1) 2 days ago                                  nifty_euclid
bde72cb76b61        yolov4              "bash"                   2 days ago          Exited (0) 2 days ago                                  gracious_nobel
62fb5bbbb3cd        yolov4              "bash"                   2 days ago          Exited (0) 2 days ago                                  inspiring_mcclintock
11110b6ce87c        yolov4              "bash"                   2 days ago          Exited (0) 2 days ago                                  mystifying_satoshi
c9a71810d4aa        014151abd8dd        "/bin/bash"              2 days ago          Exited (0) 2 days ago                                  competent_benz
665c2771f049        014151abd8dd        "bash"                   2 days ago          Exited (0) 2 days ago                                  naughty_williamson
c1c85db9db8e        014151abd8dd        "/darknet/darknet de…"   2 days ago          Exited (1) 2 days ago                                  hopeful_payne
d883e859ee64        014151abd8dd        "/darknet/darknet de…"   2 days ago          Exited (1) 2 days ago                                  frosty_jennings
265192c2d6a3        2f78711fb970        "/darknet/darknet de…"   3 days ago          Exited (1) 3 days ago                                  mystifying_chaplygin
6c426e49ed28        2f78711fb970        "/darknet/darknet de…"   3 days ago          Exited (1) 3 days ago                                  reverent_hoover
3499776a4e05        2f78711fb970        "/darknet/darknet de…"   3 days ago          Exited (0) 3 days ago                                  vigilant_proskuriakova
2a6875c718bc        2f78711fb970        "ls -ll darknet/myda…"   3 days ago          Exited (0) 3 days ago                                  blissful_noyce
cd050cbc60c3        2f78711fb970        "/darknet/darknet de…"   3 days ago          Exited (1) 3 days ago                                  quizzical_volhard
83a901ba9b9e        2f78711fb970        "ls -ll darknet/myco…"   3 days ago          Exited (0) 3 days ago                                  pedantic_shirley
957f46ec4947        2f78711fb970        "ls -ll darknet"         3 days ago          Exited (0) 3 days ago                                  compassionate_murdock
850c325bf832        2f78711fb970        "ls -ll"                 3 days ago          Exited (0) 3 days ago                                  wizardly_williamson
78f6583edf1e        2f78711fb970        "bash"                   3 days ago          Exited (0) 3 days ago                                  priceless_burnell
5001f8be603a        2f78711fb970        "bash"                   3 days ago          Exited (0) 3 days ago                                  strange_ishizaka
9b71bdefb941        2f78711fb970        "/darknet/darknet de…"   3 days ago          Exited (1) 3 days ago                                  charming_chandrasekhar
d45a7f9080bb        2f78711fb970        "/darknet/darknet de…"   3 days ago          Exited (1) 3 days ago                                  clever_mcclintock
8c1f86d2a2b9        2f78711fb970        "/darknet/darknet de…"   3 days ago          Exited (1) 3 days ago                                  nervous_proskuriakova
0834da44617f        2f78711fb970        "bash"                   3 days ago          Exited (1) 3 days ago                                  happy_knuth
6ead290114ea        2ed8e8f8640f        "/bin/sh -c 'wget ht…"   3 days ago          Exited (1) 3 days ago                                  trusting_yalow
e2df32209faf        2ed8e8f8640f        "/bin/sh -c 'wget ht…"   3 days ago          Exited (1) 3 days ago                                  beautiful_bhabha
79ae299dd71d        2ed8e8f8640f        "/bin/sh -c 'wget ht…"   3 days ago          Exited (1) 3 days ago                                  brave_payne
839e8c513b74        1bb3c6820c1d        "bash"                   3 days ago          Exited (0) 3 days ago                                  hungry_dubinsky
9f1bc5e66661        002cca23375f        "/bin/sh -c 'cd dark…"   3 days ago          Created                                                relaxed_almeida
79c4c6733d3a        002cca23375f        "/bin/sh -c 'cd dark…"   3 days ago          Created                                                magical_benz
06a5f56a1557        002cca23375f        "/bin/sh -c 'cd dark…"   3 days ago          Exited (2) 3 days ago                                  quirky_mendeleev
81cbca676a0a        registry:2          "/entrypoint.sh /etc…"   7 weeks ago         Up 7 hours                    0.0.0.0:5000->5000/tcp   registry
jax@getafix:~/projects/yolov4$ docker logs ba3 > logs.txt
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
  12 conv     64       1 x 1/ 1    128 x 128 x 128 ->  128 x 128 x  64 0.268 BF
  13 route  11 		                           ->  128 x 128 x 128 
  14 conv     64       1 x 1/ 1    128 x 128 x 128 ->  128 x 128 x  64 0.268 BF
  15 conv     64       1 x 1/ 1    128 x 128 x  64 ->  128 x 128 x  64 0.134 BF
  16 conv     64       3 x 3/ 1    128 x 128 x  64 ->  128 x 128 x  64 1.208 BF
  17 Shortcut Layer: 14,  wt = 0, wn = 0, outputs: 128 x 128 x  64 0.001 BF
  18 conv     64       1 x 1/ 1    128 x 128 x  64 ->  128 x 128 x  64 0.134 BF
  19 conv     64       3 x 3/ 1    128 x 128 x  64 ->  128 x 128 x  64 1.208 BF
  20 Shortcut Layer: 17,  wt = 0, wn = 0, outputs: 128 x 128 x  64 0.001 BF
  21 conv     64       1 x 1/ 1    128 x 128 x  64 ->  128 x 128 x  64 0.134 BF
  22 route  21 12 	                           ->  128 x 128 x 128 
  23 conv    128       1 x 1/ 1    128 x 128 x 128 ->  128 x 128 x 128 0.537 BF
  24 conv    256       3 x 3/ 2    128 x 128 x 128 ->   64 x  64 x 256 2.416 BF
  25 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
  26 route  24 		                           ->   64 x  64 x 256 
  27 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
  28 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  29 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  30 Shortcut Layer: 27,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  31 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  32 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  33 Shortcut Layer: 30,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  34 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  35 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  36 Shortcut Layer: 33,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  37 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  38 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  39 Shortcut Layer: 36,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  40 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  41 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  42 Shortcut Layer: 39,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  43 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  44 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  45 Shortcut Layer: 42,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  46 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  47 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  48 Shortcut Layer: 45,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  49 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  50 conv    128       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 128 1.208 BF
  51 Shortcut Layer: 48,  wt = 0, wn = 0, outputs:  64 x  64 x 128 0.001 BF
  52 conv    128       1 x 1/ 1     64 x  64 x 128 ->   64 x  64 x 128 0.134 BF
  53 route  52 25 	                           ->   64 x  64 x 256 
  54 conv    256       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 256 0.537 BF
  55 conv    512       3 x 3/ 2     64 x  64 x 256 ->   32 x  32 x 512 2.416 BF
  56 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
  57 route  55 		                           ->   32 x  32 x 512 
  58 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
  59 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  60 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  61 Shortcut Layer: 58,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  62 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  63 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  64 Shortcut Layer: 61,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  65 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  66 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  67 Shortcut Layer: 64,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  68 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  69 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  70 Shortcut Layer: 67,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  71 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  72 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  73 Shortcut Layer: 70,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  74 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  75 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  76 Shortcut Layer: 73,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  77 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  78 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  79 Shortcut Layer: 76,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  80 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  81 conv    256       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 256 1.208 BF
  82 Shortcut Layer: 79,  wt = 0, wn = 0, outputs:  32 x  32 x 256 0.000 BF
  83 conv    256       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 256 0.134 BF
  84 route  83 56 	                           ->   32 x  32 x 512 
  85 conv    512       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 512 0.537 BF
  86 conv   1024       3 x 3/ 2     32 x  32 x 512 ->   16 x  16 x1024 2.416 BF
  87 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
  88 route  86 		                           ->   16 x  16 x1024 
  89 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
  90 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
  91 conv    512       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x 512 1.208 BF
  92 Shortcut Layer: 89,  wt = 0, wn = 0, outputs:  16 x  16 x 512 0.000 BF
  93 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
  94 conv    512       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x 512 1.208 BF
  95 Shortcut Layer: 92,  wt = 0, wn = 0, outputs:  16 x  16 x 512 0.000 BF
  96 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
  97 conv    512       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x 512 1.208 BF
  98 Shortcut Layer: 95,  wt = 0, wn = 0, outputs:  16 x  16 x 512 0.000 BF
  99 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
 100 conv    512       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x 512 1.208 BF
 101 Shortcut Layer: 98,  wt = 0, wn = 0, outputs:  16 x  16 x 512 0.000 BF
 102 conv    512       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.134 BF
 103 route  102 87 	                           ->   16 x  16 x1024 
 104 conv   1024       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x1024 0.537 BF
 105 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 106 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 107 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 108 max                5x 5/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.003 BF
 109 route  107 		                           ->   16 x  16 x 512 
 110 max                9x 9/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.011 BF
 111 route  107 		                           ->   16 x  16 x 512 
 112 max               13x13/ 1     16 x  16 x 512 ->   16 x  16 x 512 0.022 BF
 113 route  112 110 108 107 	                   ->   16 x  16 x2048 
 114 conv    512       1 x 1/ 1     16 x  16 x2048 ->   16 x  16 x 512 0.537 BF
 115 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 116 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 117 conv    256       1 x 1/ 1     16 x  16 x 512 ->   16 x  16 x 256 0.067 BF
 118 upsample                 2x    16 x  16 x 256 ->   32 x  32 x 256
 119 route  85 		                           ->   32 x  32 x 512 
 120 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 121 route  120 118 	                           ->   32 x  32 x 512 
 122 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 123 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 124 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 125 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 126 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 127 conv    128       1 x 1/ 1     32 x  32 x 256 ->   32 x  32 x 128 0.067 BF
 128 upsample                 2x    32 x  32 x 128 ->   64 x  64 x 128
 129 route  54 		                           ->   64 x  64 x 256 
 130 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
 131 route  130 128 	                           ->   64 x  64 x 256 
 132 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
 133 conv    256       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 256 2.416 BF
 134 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
 135 conv    256       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 256 2.416 BF
 136 conv    128       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 128 0.268 BF
 137 conv    256       3 x 3/ 1     64 x  64 x 128 ->   64 x  64 x 256 2.416 BF
 138 conv    255       1 x 1/ 1     64 x  64 x 256 ->   64 x  64 x 255 0.535 BF
 139 yolo
[yolo] params: iou loss: ciou (4), iou_norm: 0.07, cls_norm: 1.00, scale_x_y: 1.20
 140 route  136 		                           ->   64 x  64 x 128 
 141 conv    256       3 x 3/ 2     64 x  64 x 128 ->   32 x  32 x 256 0.604 BF
 142 route  141 126 	                           ->   32 x  32 x 512 
 143 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 144 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 145 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 146 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 147 conv    256       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 256 0.268 BF
 148 conv    512       3 x 3/ 1     32 x  32 x 256 ->   32 x  32 x 512 2.416 BF
 149 conv    255       1 x 1/ 1     32 x  32 x 512 ->   32 x  32 x 255 0.267 BF
 150 yolo
[yolo] params: iou loss: ciou (4), iou_norm: 0.07, cls_norm: 1.00, scale_x_y: 1.10
 151 route  147 		                           ->   32 x  32 x 256 
 152 conv    512       3 x 3/ 2     32 x  32 x 256 ->   16 x  16 x 512 0.604 BF
 153 route  152 116 	                           ->   16 x  16 x1024 
 154 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 155 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 156 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 157 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 158 conv    512       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 512 0.268 BF
 159 conv   1024       3 x 3/ 1     16 x  16 x 512 ->   16 x  16 x1024 2.416 BF
 160 conv    255       1 x 1/ 1     16 x  16 x1024 ->   16 x  16 x 255 0.134 BF
 161 yolo
[yolo] params: iou loss: ciou (4), iou_norm: 0.07, cls_norm: 1.00, scale_x_y: 1.05
Total BFLOPS 91.095 
avg_outputs = 757643 
 Allocate additional workspace_size = 75.50 MB 
Loading weights from /darknet/myweights/csdarknet53-omega.conv.105...Done! Loaded 105 layers from weights-file 
 Create 6 permanent cpu-threads 
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_1000.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_2000.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
Saving weights to /darknet/myweights/backup//yolov4_last.weights
jax@getafix:~/projects/yolov4$ ls
Dockerfile  checkcv.py	 get_coco_dataset.sh  myconfig	myweights   testInfer.sh
README.md   daemon.json  logs.txt	      mydata	setupVM.sh  testTraining1gpu.sh
jax@getafix:~/projects/yolov4$ cat logs.txt 
yolov4
net.optimized_memory = 0 
mini_batch = 1, batch = 32, time_steps = 1, train = 1 
nms_kind: greedynms (1), beta = 0.600000 
nms_kind: greedynms (1), beta = 0.600000 
nms_kind: greedynms (1), beta = 0.600000 

 seen 64, trained: 0 K-images (0 Kilo-batches_64) 
Learning Rate: 0.0013, Momentum: 0.949, Decay: 0.0005
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 1: 4173.809082, 4173.809082 avg loss, 0.000000 rate, 12.090222 seconds, 32 images, -1.000000 hours left
Loaded: 0.000027 seconds

 2: 4149.802734, 4171.408203 avg loss, 0.000000 rate, 11.797990 seconds, 64 images, 1680.877665 hours left
Loaded: 0.000022 seconds

 3: 4226.664062, 4176.933594 avg loss, 0.000000 rate, 12.455998 seconds, 96 images, 1680.471355 hours left
Loaded: 0.000029 seconds

 4: 4132.355469, 4172.475586 avg loss, 0.000000 rate, 12.052404 seconds, 128 images, 1680.983876 hours left
Loaded: 0.000024 seconds

 5: 4216.416504, 4176.869629 avg loss, 0.000000 rate, 12.681887 seconds, 160 images, 1680.930145 hours left
Loaded: 0.000024 seconds

 6: 4207.911621, 4179.973633 avg loss, 0.000000 rate, 12.689269 seconds, 192 images, 1681.752057 hours left
Loaded: 0.000031 seconds

 7: 4218.544434, 4183.830566 avg loss, 0.000000 rate, 12.900318 seconds, 224 images, 1682.575978 hours left
Loaded: 0.000032 seconds

 8: 4233.218750, 4188.769531 avg loss, 0.000000 rate, 12.962915 seconds, 256 images, 1683.685047 hours left
Loaded: 0.000037 seconds

 9: 4161.471191, 4186.039551 avg loss, 0.000000 rate, 12.644999 seconds, 288 images, 1684.870017 hours left
Loaded: 0.000033 seconds

 10: 4193.373535, 4186.772949 avg loss, 0.000000 rate, 12.631808 seconds, 320 images, 1685.601124 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.367014 seconds - performance bottleneck on CPU or Disk HDD/SSD

 11: 3487.893799, 4116.885254 avg loss, 0.000000 rate, 10.647831 seconds, 352 images, 1686.306541 hours left
Loaded: 0.000025 seconds

 12: 3580.657959, 4063.262451 avg loss, 0.000000 rate, 11.223797 seconds, 384 images, 1684.756846 hours left
Loaded: 0.000025 seconds

 13: 3581.504883, 4015.086670 avg loss, 0.000000 rate, 11.180193 seconds, 416 images, 1683.513146 hours left
Loaded: 0.000023 seconds

 14: 3557.247314, 3969.302734 avg loss, 0.000000 rate, 10.830639 seconds, 448 images, 1682.221232 hours left
Loaded: 0.000030 seconds

 15: 3493.402588, 3921.712646 avg loss, 0.000000 rate, 10.504375 seconds, 480 images, 1680.456240 hours left
Loaded: 0.000024 seconds

 16: 3538.359863, 3883.377441 avg loss, 0.000000 rate, 10.813901 seconds, 512 images, 1678.255292 hours left
Loaded: 0.000024 seconds

 17: 3522.840820, 3847.323730 avg loss, 0.000000 rate, 10.856585 seconds, 544 images, 1676.506631 hours left
Loaded: 0.000020 seconds

 18: 3491.266602, 3811.718018 avg loss, 0.000000 rate, 10.680745 seconds, 576 images, 1674.834767 hours left
Loaded: 0.000033 seconds

 19: 3631.731689, 3793.719482 avg loss, 0.000000 rate, 11.529724 seconds, 608 images, 1672.935128 hours left
Loaded: 0.000032 seconds

 20: 3429.565186, 3757.303955 avg loss, 0.000000 rate, 10.270648 seconds, 640 images, 1672.234745 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.302879 seconds - performance bottleneck on CPU or Disk HDD/SSD

 21: 1707.391724, 3552.312744 avg loss, 0.000000 rate, 5.263111 seconds, 672 images, 1669.790938 hours left
Loaded: 0.000039 seconds

 22: 1704.254639, 3367.506836 avg loss, 0.000000 rate, 5.234863 seconds, 704 images, 1660.830987 hours left
Loaded: 0.000025 seconds

 23: 1728.384766, 3203.594727 avg loss, 0.000000 rate, 5.180797 seconds, 736 images, 1651.500336 hours left
Loaded: 0.000024 seconds

 24: 1688.889648, 3052.124268 avg loss, 0.000000 rate, 5.089346 seconds, 768 images, 1642.187794 hours left
Loaded: 0.000031 seconds

 25: 1596.875122, 2906.599365 avg loss, 0.000000 rate, 4.812213 seconds, 800 images, 1632.841226 hours left
Loaded: 0.000031 seconds

 26: 1606.161499, 2776.555664 avg loss, 0.000000 rate, 4.927789 seconds, 832 images, 1623.202847 hours left
Loaded: 0.000031 seconds

 27: 1757.293457, 2674.629395 avg loss, 0.000000 rate, 5.351794 seconds, 864 images, 1613.821512 hours left
Loaded: 0.000035 seconds

 28: 1752.522461, 2582.418701 avg loss, 0.000000 rate, 5.315434 seconds, 896 images, 1605.123439 hours left
Loaded: 0.000032 seconds

 29: 1735.167114, 2497.693604 avg loss, 0.000000 rate, 5.275038 seconds, 928 images, 1596.461781 hours left
Loaded: 0.000031 seconds

 30: 1747.484009, 2422.672607 avg loss, 0.000000 rate, 5.294252 seconds, 960 images, 1587.830560 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.342458 seconds - performance bottleneck on CPU or Disk HDD/SSD

 31: 1507.310059, 2331.136230 avg loss, 0.000000 rate, 4.850393 seconds, 992 images, 1579.312349 hours left
Loaded: 0.000025 seconds

 32: 1486.674927, 2246.690186 avg loss, 0.000000 rate, 4.861186 seconds, 1024 images, 1570.738295 hours left
Loaded: 0.000035 seconds

 33: 1530.359497, 2175.057129 avg loss, 0.000000 rate, 4.996417 seconds, 1056 images, 1561.788926 hours left
Loaded: 0.000034 seconds

 34: 1446.722656, 2102.223633 avg loss, 0.000000 rate, 4.774529 seconds, 1088 images, 1553.117047 hours left
Loaded: 0.000036 seconds

 35: 1522.697876, 2044.270996 avg loss, 0.000000 rate, 5.037859 seconds, 1120 images, 1544.223405 hours left
Loaded: 0.000034 seconds

 36: 1518.074707, 1991.651367 avg loss, 0.000000 rate, 4.966377 seconds, 1152 images, 1535.784767 hours left
Loaded: 0.000033 seconds

 37: 1531.819458, 1945.668213 avg loss, 0.000000 rate, 5.035477 seconds, 1184 images, 1527.331126 hours left
Loaded: 0.000048 seconds

 38: 1445.424316, 1895.643799 avg loss, 0.000000 rate, 4.813233 seconds, 1216 images, 1519.058068 hours left
Loaded: 0.000037 seconds

 39: 1425.401001, 1848.619507 avg loss, 0.000000 rate, 4.750328 seconds, 1248 images, 1510.558789 hours left
Loaded: 0.000027 seconds

 40: 1487.342163, 1812.491821 avg loss, 0.000000 rate, 4.852411 seconds, 1280 images, 1502.057026 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.000023 seconds

 41: 2121.773682, 1843.420044 avg loss, 0.000000 rate, 6.606806 seconds, 1312 images, 1493.782166 hours left
Loaded: 0.000031 seconds

 42: 2100.970459, 1869.175049 avg loss, 0.000000 rate, 6.552457 seconds, 1344 images, 1488.028930 hours left
Loaded: 0.000033 seconds

 43: 2081.394531, 1890.396973 avg loss, 0.000000 rate, 6.560110 seconds, 1376 images, 1482.257666 hours left
Loaded: 0.000032 seconds

 44: 2075.794189, 1908.936646 avg loss, 0.000000 rate, 6.528168 seconds, 1408 images, 1476.554739 hours left
Loaded: 0.000034 seconds

 45: 2120.338623, 1930.076904 avg loss, 0.000000 rate, 6.726192 seconds, 1440 images, 1470.864418 hours left
Loaded: 0.000025 seconds

 46: 2014.129150, 1938.482178 avg loss, 0.000000 rate, 6.499687 seconds, 1472 images, 1465.506268 hours left
Loaded: 0.000030 seconds

 47: 2041.871826, 1948.821167 avg loss, 0.000000 rate, 6.525722 seconds, 1504 images, 1459.886798 hours left
Loaded: 0.000029 seconds

 48: 2056.140137, 1959.553101 avg loss, 0.000000 rate, 6.679307 seconds, 1536 images, 1454.359699 hours left
Loaded: 0.000028 seconds

 49: 2066.513184, 1970.249146 avg loss, 0.000000 rate, 6.692412 seconds, 1568 images, 1449.101356 hours left
Loaded: 0.000033 seconds

 50: 1970.875854, 1970.311768 avg loss, 0.000000 rate, 6.421933 seconds, 1600 images, 1443.913793 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.008391 seconds

 51: 2716.897217, 2044.970337 avg loss, 0.000000 rate, 9.532230 seconds, 1632 images, 1438.402093 hours left
Loaded: 0.000035 seconds

 52: 2616.321777, 2102.105469 avg loss, 0.000000 rate, 9.111886 seconds, 1664 images, 1437.280847 hours left
Loaded: 0.000035 seconds

 53: 2693.073975, 2161.202393 avg loss, 0.000000 rate, 9.478677 seconds, 1696 images, 1435.574836 hours left
Loaded: 0.000026 seconds

 54: 2612.814697, 2206.363525 avg loss, 0.000000 rate, 9.211340 seconds, 1728 images, 1434.395748 hours left
Loaded: 0.000028 seconds

 55: 2675.333740, 2253.260498 avg loss, 0.000000 rate, 9.592247 seconds, 1760 images, 1432.856790 hours left
Loaded: 0.000025 seconds

 56: 2577.797852, 2285.714355 avg loss, 0.000000 rate, 9.202851 seconds, 1792 images, 1431.862694 hours left
Loaded: 0.000024 seconds

 57: 2565.435547, 2313.686523 avg loss, 0.000000 rate, 9.314364 seconds, 1824 images, 1430.337201 hours left
Loaded: 0.000035 seconds

 58: 2572.105469, 2339.528320 avg loss, 0.000000 rate, 9.575367 seconds, 1856 images, 1428.981952 hours left
Loaded: 0.000028 seconds

 59: 2576.638916, 2363.239502 avg loss, 0.000000 rate, 9.726888 seconds, 1888 images, 1428.003071 hours left
Loaded: 0.000025 seconds

 60: 2376.454102, 2364.561035 avg loss, 0.000000 rate, 9.060367 seconds, 1920 images, 1427.244573 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.200603 seconds - performance bottleneck on CPU or Disk HDD/SSD

 61: 1413.966309, 2269.501465 avg loss, 0.000000 rate, 5.543922 seconds, 1952 images, 1425.567090 hours left
Loaded: 0.000027 seconds

 62: 1365.237671, 2179.075195 avg loss, 0.000000 rate, 5.454839 seconds, 1984 images, 1419.296944 hours left
Loaded: 0.000026 seconds

 63: 1303.532471, 2091.520996 avg loss, 0.000000 rate, 5.312785 seconds, 2016 images, 1412.686826 hours left
Loaded: 0.000027 seconds

 64: 1235.940308, 2005.962891 avg loss, 0.000000 rate, 5.173002 seconds, 2048 images, 1405.945325 hours left
Loaded: 0.000029 seconds

 65: 1258.312134, 1931.197876 avg loss, 0.000000 rate, 5.392919 seconds, 2080 images, 1399.076912 hours left
Loaded: 0.000026 seconds

 66: 1280.790039, 1866.157104 avg loss, 0.000000 rate, 5.322211 seconds, 2112 images, 1392.582877 hours left
Loaded: 0.000034 seconds

 67: 1223.883179, 1801.929688 avg loss, 0.000000 rate, 5.367076 seconds, 2144 images, 1386.055472 hours left
Loaded: 0.000038 seconds

 68: 1286.167847, 1750.353516 avg loss, 0.000000 rate, 5.589015 seconds, 2176 images, 1379.655705 hours left
Loaded: 0.000031 seconds

 69: 1144.565430, 1689.774658 avg loss, 0.000000 rate, 5.346576 seconds, 2208 images, 1373.628440 hours left
Loaded: 0.000024 seconds

 70: 1186.022827, 1639.399414 avg loss, 0.000000 rate, 5.546896 seconds, 2240 images, 1367.324415 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000022 seconds

 71: 2636.747803, 1739.134277 avg loss, 0.000000 rate, 13.955210 seconds, 2272 images, 1361.361867 hours left
Loaded: 0.000028 seconds

 72: 2545.147461, 1819.735596 avg loss, 0.000000 rate, 13.779991 seconds, 2304 images, 1367.147159 hours left
Loaded: 0.000028 seconds

 73: 2326.800049, 1870.442017 avg loss, 0.000000 rate, 12.637121 seconds, 2336 images, 1372.630998 hours left
Loaded: 0.000027 seconds

 74: 2290.386475, 1912.436523 avg loss, 0.000000 rate, 13.164900 seconds, 2368 images, 1376.471284 hours left
Loaded: 0.000028 seconds

 75: 2212.937500, 1942.486572 avg loss, 0.000000 rate, 13.381128 seconds, 2400 images, 1381.006785 hours left
Loaded: 0.000029 seconds

 76: 2027.360962, 1950.973999 avg loss, 0.000000 rate, 13.071362 seconds, 2432 images, 1385.797466 hours left
Loaded: 0.000044 seconds

 77: 1988.435669, 1954.720215 avg loss, 0.000000 rate, 13.782337 seconds, 2464 images, 1390.109609 hours left
Loaded: 0.000028 seconds

 78: 1822.297363, 1941.477905 avg loss, 0.000000 rate, 13.264564 seconds, 2496 images, 1395.366915 hours left
Loaded: 0.000028 seconds

 79: 1671.128418, 1914.442993 avg loss, 0.000000 rate, 12.834194 seconds, 2528 images, 1399.851852 hours left
Loaded: 0.000026 seconds

 80: 1637.605347, 1886.759277 avg loss, 0.000000 rate, 13.712697 seconds, 2560 images, 1403.693663 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.292600 seconds - performance bottleneck on CPU or Disk HDD/SSD

 81: 717.125488, 1769.795898 avg loss, 0.000000 rate, 5.919347 seconds, 2592 images, 1408.718187 hours left
Loaded: 0.000033 seconds

 82: 697.591919, 1662.575562 avg loss, 0.000000 rate, 6.160026 seconds, 2624 images, 1403.265965 hours left
Loaded: 0.000028 seconds

 83: 749.172607, 1571.235229 avg loss, 0.000000 rate, 6.519270 seconds, 2656 images, 1397.796108 hours left
Loaded: 0.000021 seconds

 84: 645.051025, 1478.616821 avg loss, 0.000000 rate, 6.203209 seconds, 2688 images, 1392.880294 hours left
Loaded: 0.000033 seconds

 85: 608.184998, 1391.573608 avg loss, 0.000000 rate, 6.202337 seconds, 2720 images, 1387.574268 hours left
Loaded: 0.000027 seconds

 86: 514.002625, 1303.816528 avg loss, 0.000000 rate, 5.984340 seconds, 2752 images, 1382.320089 hours left
Loaded: 0.000027 seconds

 87: 457.329590, 1219.167847 avg loss, 0.000000 rate, 5.749182 seconds, 2784 images, 1376.815403 hours left
Loaded: 0.000028 seconds

 88: 495.793427, 1146.830444 avg loss, 0.000000 rate, 6.141510 seconds, 2816 images, 1371.038870 hours left
Loaded: 0.000033 seconds

 89: 421.956055, 1074.343018 avg loss, 0.000000 rate, 5.912280 seconds, 2848 images, 1365.865435 hours left
Loaded: 0.000028 seconds

 90: 456.262421, 1012.534973 avg loss, 0.000000 rate, 6.354924 seconds, 2880 images, 1360.425089 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.433668 seconds - performance bottleneck on CPU or Disk HDD/SSD

 91: 494.085114, 960.690002 avg loss, 0.000000 rate, 5.949176 seconds, 2912 images, 1355.654412 hours left
Loaded: 0.000029 seconds

 92: 382.984131, 902.919434 avg loss, 0.000000 rate, 5.591126 seconds, 2944 images, 1350.970194 hours left
Loaded: 0.000030 seconds

 93: 361.352875, 848.762756 avg loss, 0.000000 rate, 5.517861 seconds, 2976 images, 1345.232336 hours left
Loaded: 0.000038 seconds

 94: 503.326416, 814.219116 avg loss, 0.000000 rate, 5.998763 seconds, 3008 images, 1339.450001 hours left
Loaded: 0.000027 seconds

 95: 473.628143, 780.160034 avg loss, 0.000000 rate, 6.163004 seconds, 3040 images, 1334.393949 hours left
Loaded: 0.000027 seconds

 96: 403.230957, 742.467102 avg loss, 0.000000 rate, 5.817914 seconds, 3072 images, 1329.616722 hours left
Loaded: 0.000028 seconds

 97: 347.729980, 702.993408 avg loss, 0.000000 rate, 5.685118 seconds, 3104 images, 1324.407572 hours left
Loaded: 0.000036 seconds

 98: 301.123444, 662.806396 avg loss, 0.000000 rate, 5.494353 seconds, 3136 images, 1319.065910 hours left
Loaded: 0.000033 seconds

 99: 409.173920, 637.443176 avg loss, 0.000000 rate, 5.978704 seconds, 3168 images, 1313.512496 hours left
Loaded: 0.000036 seconds

 100: 279.734375, 601.672302 avg loss, 0.000000 rate, 5.330096 seconds, 3200 images, 1308.687845 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000023 seconds

 101: 425.808411, 584.085938 avg loss, 0.000000 rate, 11.886361 seconds, 3232 images, 1303.009863 hours left
Loaded: 0.000027 seconds

 102: 355.880768, 561.265442 avg loss, 0.000000 rate, 11.294668 seconds, 3264 images, 1306.501818 hours left
Loaded: 0.000027 seconds

 103: 285.962006, 533.735107 avg loss, 0.000000 rate, 10.910865 seconds, 3296 images, 1309.136378 hours left
Loaded: 0.000027 seconds

 104: 314.598602, 511.821472 avg loss, 0.000000 rate, 11.258168 seconds, 3328 images, 1311.211077 hours left
Loaded: 0.000027 seconds

 105: 360.863922, 496.725708 avg loss, 0.000000 rate, 11.660817 seconds, 3360 images, 1313.747745 hours left
Loaded: 0.000032 seconds

 106: 340.853455, 481.138489 avg loss, 0.000000 rate, 11.769280 seconds, 3392 images, 1316.818693 hours left
Loaded: 0.000026 seconds

 107: 454.811493, 478.505798 avg loss, 0.000000 rate, 12.552841 seconds, 3424 images, 1320.009667 hours left
Loaded: 0.000027 seconds

 108: 345.645447, 465.219757 avg loss, 0.000000 rate, 11.751118 seconds, 3456 images, 1324.257825 hours left
Loaded: 0.000026 seconds

 109: 207.159683, 439.413757 avg loss, 0.000000 rate, 11.051067 seconds, 3488 images, 1327.349091 hours left
Loaded: 0.000026 seconds

 110: 294.879730, 424.960358 avg loss, 0.000000 rate, 11.644643 seconds, 3520 images, 1329.436368 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.077354 seconds

 111: 277.499268, 410.214233 avg loss, 0.000000 rate, 12.834502 seconds, 3552 images, 1332.327784 hours left
Loaded: 0.000029 seconds

 112: 268.757477, 396.068542 avg loss, 0.000000 rate, 12.655604 seconds, 3584 images, 1336.951607 hours left
Loaded: 0.000030 seconds

 113: 255.175003, 381.979187 avg loss, 0.000000 rate, 12.177301 seconds, 3616 images, 1341.173013 hours left
Loaded: 0.000027 seconds

 114: 272.848114, 371.066071 avg loss, 0.000000 rate, 12.423076 seconds, 3648 images, 1344.687348 hours left
Loaded: 0.000027 seconds

 115: 318.877075, 365.847168 avg loss, 0.000000 rate, 12.953582 seconds, 3680 images, 1348.508118 hours left
Loaded: 0.000023 seconds

 116: 342.588318, 363.521271 avg loss, 0.000000 rate, 13.558823 seconds, 3712 images, 1353.028029 hours left
Loaded: 0.000026 seconds

 117: 312.894714, 358.458618 avg loss, 0.000000 rate, 13.042645 seconds, 3744 images, 1358.343956 hours left
Loaded: 0.000028 seconds

 118: 236.508789, 346.263641 avg loss, 0.000000 rate, 12.606205 seconds, 3776 images, 1362.889227 hours left
Loaded: 0.000028 seconds

 119: 315.452209, 343.182495 avg loss, 0.000000 rate, 13.055994 seconds, 3808 images, 1366.782387 hours left
Loaded: 0.000027 seconds

 120: 188.677628, 327.731995 avg loss, 0.000000 rate, 12.080338 seconds, 3840 images, 1371.261756 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.376501 seconds - performance bottleneck on CPU or Disk HDD/SSD

 121: 279.079132, 322.866699 avg loss, 0.000000 rate, 6.590676 seconds, 3872 images, 1374.340189 hours left
Loaded: 0.000029 seconds

 122: 248.802261, 315.460266 avg loss, 0.000000 rate, 6.353224 seconds, 3904 images, 1370.280771 hours left
Loaded: 0.000028 seconds

 123: 258.911102, 309.805359 avg loss, 0.000000 rate, 6.284440 seconds, 3936 images, 1365.408610 hours left
Loaded: 0.000027 seconds

 124: 297.550598, 308.579895 avg loss, 0.000000 rate, 6.524535 seconds, 3968 images, 1360.489546 hours left
Loaded: 0.000029 seconds

 125: 197.452026, 297.467102 avg loss, 0.000000 rate, 5.995200 seconds, 4000 images, 1355.953371 hours left
Loaded: 0.000029 seconds

 126: 268.017029, 294.522095 avg loss, 0.000000 rate, 6.331842 seconds, 4032 images, 1350.726801 hours left
Loaded: 0.000027 seconds

 127: 245.067322, 289.576630 avg loss, 0.000000 rate, 6.188571 seconds, 4064 images, 1346.020389 hours left
Loaded: 0.000036 seconds

 128: 204.002304, 281.019196 avg loss, 0.000000 rate, 6.059177 seconds, 4096 images, 1341.161885 hours left
Loaded: 0.000027 seconds

 129: 240.626831, 276.979950 avg loss, 0.000000 rate, 6.237739 seconds, 4128 images, 1336.172113 hours left
Loaded: 0.000036 seconds

 130: 192.039734, 268.485931 avg loss, 0.000000 rate, 5.973976 seconds, 4160 images, 1331.480398 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 131: 237.258881, 265.363220 avg loss, 0.000000 rate, 11.593608 seconds, 4192 images, 1326.468985 hours left
Loaded: 0.000037 seconds

 132: 325.659302, 271.392822 avg loss, 0.000000 rate, 12.314132 seconds, 4224 images, 1329.318462 hours left
Loaded: 0.000029 seconds

 133: 255.124847, 269.766022 avg loss, 0.000000 rate, 11.560262 seconds, 4256 images, 1333.140892 hours left
Loaded: 0.000044 seconds

 134: 117.595871, 254.549011 avg loss, 0.000000 rate, 10.724108 seconds, 4288 images, 1335.877240 hours left
Loaded: 0.000025 seconds

 135: 201.341019, 249.228210 avg loss, 0.000000 rate, 11.479370 seconds, 4320 images, 1337.424043 hours left
Loaded: 0.000032 seconds

 136: 176.025925, 241.907990 avg loss, 0.000000 rate, 11.248451 seconds, 4352 images, 1340.005059 hours left
Loaded: 0.000027 seconds

 137: 195.975159, 237.314713 avg loss, 0.000000 rate, 11.726273 seconds, 4384 images, 1342.239293 hours left
Loaded: 0.000043 seconds

 138: 298.293549, 243.412598 avg loss, 0.000000 rate, 12.438408 seconds, 4416 images, 1345.115277 hours left
Loaded: 0.000028 seconds

 139: 162.473862, 235.318726 avg loss, 0.000000 rate, 11.332060 seconds, 4448 images, 1348.952286 hours left
Loaded: 0.000030 seconds

 140: 236.942276, 235.481079 avg loss, 0.000000 rate, 12.121992 seconds, 4480 images, 1351.213153 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.039771 seconds

 141: 263.185028, 238.251480 avg loss, 0.000001 rate, 14.163974 seconds, 4512 images, 1354.549300 hours left
Loaded: 0.000027 seconds

 142: 234.001068, 237.826447 avg loss, 0.000001 rate, 14.073945 seconds, 4544 images, 1360.745408 hours left
Loaded: 0.000033 seconds

 143: 226.812149, 236.725021 avg loss, 0.000001 rate, 13.920842 seconds, 4576 images, 1366.699149 hours left
Loaded: 0.000036 seconds

 144: 244.037582, 237.456284 avg loss, 0.000001 rate, 14.003847 seconds, 4608 images, 1372.380525 hours left
Loaded: 0.000033 seconds

 145: 214.392212, 235.149872 avg loss, 0.000001 rate, 14.290621 seconds, 4640 images, 1378.120418 hours left
Loaded: 0.000030 seconds

 146: 273.906616, 239.025543 avg loss, 0.000001 rate, 14.808863 seconds, 4672 images, 1384.201450 hours left
Loaded: 0.000030 seconds

 147: 229.631790, 238.086166 avg loss, 0.000001 rate, 13.947899 seconds, 4704 images, 1390.941918 hours left
Loaded: 0.000027 seconds

 148: 222.931168, 236.570663 avg loss, 0.000001 rate, 13.633262 seconds, 4736 images, 1396.418314 hours left
Loaded: 0.000027 seconds

 149: 272.315582, 240.145157 avg loss, 0.000001 rate, 14.063818 seconds, 4768 images, 1401.402598 hours left
Loaded: 0.000033 seconds

 150: 218.835266, 238.014175 avg loss, 0.000001 rate, 14.183264 seconds, 4800 images, 1406.935417 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.013231 seconds

 151: 103.205315, 224.533295 avg loss, 0.000001 rate, 5.040129 seconds, 4832 images, 1412.578891 hours left
Loaded: 0.000027 seconds

 152: 277.454132, 229.825378 avg loss, 0.000001 rate, 5.706291 seconds, 4864 images, 1405.476570 hours left
Loaded: 0.000028 seconds

 153: 242.354340, 231.078278 avg loss, 0.000001 rate, 5.579786 seconds, 4896 images, 1399.352775 hours left
Loaded: 0.000028 seconds

 154: 220.197144, 229.990158 avg loss, 0.000001 rate, 5.476456 seconds, 4928 images, 1393.114380 hours left
Loaded: 0.000028 seconds

 155: 260.433319, 233.034470 avg loss, 0.000001 rate, 5.599881 seconds, 4960 images, 1386.794740 hours left
Loaded: 0.000028 seconds

 156: 142.568649, 223.987885 avg loss, 0.000001 rate, 5.254853 seconds, 4992 images, 1380.709822 hours left
Loaded: 0.000028 seconds

 157: 237.087830, 225.297882 avg loss, 0.000001 rate, 5.603258 seconds, 5024 images, 1374.206204 hours left
Loaded: 0.000028 seconds

 158: 181.950165, 220.963104 avg loss, 0.000001 rate, 5.339908 seconds, 5056 images, 1368.251835 hours left
Loaded: 0.000029 seconds

 159: 213.776978, 220.244492 avg loss, 0.000001 rate, 5.474097 seconds, 5088 images, 1361.990981 hours left
Loaded: 0.000023 seconds

 160: 232.193130, 221.439362 avg loss, 0.000001 rate, 5.673026 seconds, 5120 images, 1355.979225 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000029 seconds

 161: 212.305771, 220.526001 avg loss, 0.000001 rate, 13.364745 seconds, 5152 images, 1350.304038 hours left
Loaded: 0.000029 seconds

 162: 220.006531, 220.474060 avg loss, 0.000001 rate, 12.939536 seconds, 5184 images, 1355.375784 hours left
Loaded: 0.000036 seconds

 163: 199.554321, 218.382080 avg loss, 0.000001 rate, 12.655831 seconds, 5216 images, 1359.805807 hours left
Loaded: 0.000027 seconds

 164: 232.594101, 219.803284 avg loss, 0.000001 rate, 12.970404 seconds, 5248 images, 1363.797202 hours left
Loaded: 0.000029 seconds

 165: 236.897598, 221.512711 avg loss, 0.000001 rate, 12.944031 seconds, 5280 images, 1368.185837 hours left
Loaded: 0.000028 seconds

 166: 124.805183, 211.841965 avg loss, 0.000001 rate, 11.905354 seconds, 5312 images, 1372.493899 hours left
Loaded: 0.000032 seconds

 167: 186.087189, 209.266479 avg loss, 0.000001 rate, 12.494501 seconds, 5344 images, 1375.315272 hours left
Loaded: 0.000040 seconds

 168: 167.565979, 205.096436 avg loss, 0.000001 rate, 12.415798 seconds, 5376 images, 1378.927207 hours left
Loaded: 0.000027 seconds

 169: 279.006195, 212.487411 avg loss, 0.000001 rate, 13.578050 seconds, 5408 images, 1382.393620 hours left
Loaded: 0.000034 seconds

 170: 190.444321, 210.283096 avg loss, 0.000001 rate, 12.522228 seconds, 5440 images, 1387.440621 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.344794 seconds - performance bottleneck on CPU or Disk HDD/SSD

 171: 171.764816, 206.431274 avg loss, 0.000001 rate, 5.306653 seconds, 5472 images, 1390.969738 hours left
Loaded: 0.000029 seconds

 172: 148.864655, 200.674606 avg loss, 0.000001 rate, 5.334212 seconds, 5504 images, 1384.914450 hours left
Loaded: 0.000037 seconds

 173: 233.692673, 203.976410 avg loss, 0.000001 rate, 5.641779 seconds, 5536 images, 1378.478846 hours left
Loaded: 0.000038 seconds

 174: 207.229248, 204.301697 avg loss, 0.000001 rate, 5.511594 seconds, 5568 images, 1372.535050 hours left
Loaded: 0.000039 seconds

 175: 187.380508, 202.609573 avg loss, 0.000001 rate, 5.433427 seconds, 5600 images, 1366.469748 hours left
Loaded: 0.000034 seconds

 176: 181.652206, 200.513840 avg loss, 0.000001 rate, 5.446341 seconds, 5632 images, 1360.356450 hours left
Loaded: 0.000042 seconds

 177: 163.910507, 196.853500 avg loss, 0.000001 rate, 5.348402 seconds, 5664 images, 1354.322211 hours left
Loaded: 0.000030 seconds

 178: 258.875427, 203.055695 avg loss, 0.000001 rate, 5.781585 seconds, 5696 images, 1348.212196 hours left
Loaded: 0.000027 seconds

 179: 295.498993, 212.300018 avg loss, 0.000001 rate, 5.910540 seconds, 5728 images, 1342.765279 hours left
Loaded: 0.000027 seconds

 180: 271.562592, 218.226273 avg loss, 0.000001 rate, 5.729134 seconds, 5760 images, 1337.552029 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.423735 seconds - performance bottleneck on CPU or Disk HDD/SSD

 181: 241.583740, 220.562012 avg loss, 0.000001 rate, 5.108733 seconds, 5792 images, 1332.138782 hours left
Loaded: 0.000029 seconds

 182: 182.243042, 216.730118 avg loss, 0.000001 rate, 4.904603 seconds, 5824 images, 1326.506293 hours left
Loaded: 0.000032 seconds

 183: 196.541245, 214.711227 avg loss, 0.000001 rate, 4.967712 seconds, 5856 images, 1320.057563 hours left
Loaded: 0.000029 seconds

 184: 143.979492, 207.638062 avg loss, 0.000001 rate, 4.734337 seconds, 5888 images, 1313.761020 hours left
Loaded: 0.000027 seconds

 185: 262.026306, 213.076889 avg loss, 0.000002 rate, 5.099304 seconds, 5920 images, 1307.203086 hours left
Loaded: 0.000026 seconds

 186: 244.489761, 216.218170 avg loss, 0.000002 rate, 5.263336 seconds, 5952 images, 1301.217934 hours left
Loaded: 0.000029 seconds

 187: 183.963150, 212.992676 avg loss, 0.000002 rate, 4.983943 seconds, 5984 images, 1295.520584 hours left
Loaded: 0.000030 seconds

 188: 199.423065, 211.635712 avg loss, 0.000002 rate, 5.225881 seconds, 6016 images, 1289.491909 hours left
Loaded: 0.000033 seconds

 189: 214.964188, 211.968567 avg loss, 0.000002 rate, 5.320187 seconds, 6048 images, 1283.859744 hours left
Loaded: 0.000039 seconds

 190: 201.957901, 210.967499 avg loss, 0.000002 rate, 5.096817 seconds, 6080 images, 1278.414951 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.000023 seconds

 191: 224.355026, 212.306244 avg loss, 0.000002 rate, 9.054060 seconds, 6112 images, 1272.714171 hours left
Loaded: 0.000032 seconds

 192: 207.623505, 211.837967 avg loss, 0.000002 rate, 8.813693 seconds, 6144 images, 1272.569930 hours left
Loaded: 0.000029 seconds

 193: 122.225685, 202.876740 avg loss, 0.000002 rate, 8.306881 seconds, 6176 images, 1272.093081 hours left
Loaded: 0.000029 seconds

 194: 189.463943, 201.535461 avg loss, 0.000002 rate, 8.844219 seconds, 6208 images, 1270.916623 hours left
Loaded: 0.000039 seconds

 195: 138.297562, 195.211670 avg loss, 0.000002 rate, 8.480901 seconds, 6240 images, 1270.498666 hours left
Loaded: 0.000037 seconds

 196: 155.072037, 191.197708 avg loss, 0.000002 rate, 8.523954 seconds, 6272 images, 1269.579962 hours left
Loaded: 0.000030 seconds

 197: 123.224449, 184.400375 avg loss, 0.000002 rate, 8.419671 seconds, 6304 images, 1268.730250 hours left
Loaded: 0.000029 seconds

 198: 221.780441, 188.138382 avg loss, 0.000002 rate, 9.119436 seconds, 6336 images, 1267.744076 hours left
Loaded: 0.000031 seconds

 199: 179.266449, 187.251190 avg loss, 0.000002 rate, 8.843088 seconds, 6368 images, 1267.740223 hours left
Loaded: 0.000037 seconds

 200: 179.456055, 186.471680 avg loss, 0.000002 rate, 8.810084 seconds, 6400 images, 1267.352338 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.404196 seconds - performance bottleneck on CPU or Disk HDD/SSD

 201: 208.446716, 188.669189 avg loss, 0.000002 rate, 5.254430 seconds, 6432 images, 1266.922450 hours left
Loaded: 0.000031 seconds

 202: 181.754471, 187.977722 avg loss, 0.000002 rate, 5.187371 seconds, 6464 images, 1262.117143 hours left
Loaded: 0.000040 seconds

 203: 177.730820, 186.953033 avg loss, 0.000002 rate, 5.173356 seconds, 6496 images, 1256.705006 hours left
Loaded: 0.000039 seconds

 204: 167.589539, 185.016678 avg loss, 0.000002 rate, 4.984311 seconds, 6528 images, 1251.327512 hours left
Loaded: 0.000029 seconds

 205: 143.404007, 180.855408 avg loss, 0.000002 rate, 5.002899 seconds, 6560 images, 1245.741057 hours left
Loaded: 0.000029 seconds

 206: 191.696274, 181.939499 avg loss, 0.000002 rate, 5.144530 seconds, 6592 images, 1240.236271 hours left
Loaded: 0.000029 seconds

 207: 163.076813, 180.053223 avg loss, 0.000002 rate, 4.986005 seconds, 6624 images, 1234.983344 hours left
Loaded: 0.000037 seconds

 208: 184.984528, 180.546356 avg loss, 0.000002 rate, 5.128334 seconds, 6656 images, 1229.562628 hours left
Loaded: 0.000037 seconds

 209: 218.891571, 184.380875 avg loss, 0.000002 rate, 5.230139 seconds, 6688 images, 1224.393913 hours left
Loaded: 0.000039 seconds

 210: 153.263199, 181.269104 avg loss, 0.000003 rate, 4.943319 seconds, 6720 images, 1219.418348 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.432956 seconds - performance bottleneck on CPU or Disk HDD/SSD

 211: 225.461700, 185.688370 avg loss, 0.000003 rate, 5.242342 seconds, 6752 images, 1214.093934 hours left
Loaded: 0.000029 seconds

 212: 170.428268, 184.162354 avg loss, 0.000003 rate, 4.957968 seconds, 6784 images, 1209.839922 hours left
Loaded: 0.000029 seconds

 213: 123.172478, 178.063370 avg loss, 0.000003 rate, 4.789413 seconds, 6816 images, 1204.631610 hours left
Loaded: 0.000029 seconds

 214: 178.708496, 178.127884 avg loss, 0.000003 rate, 4.993761 seconds, 6848 images, 1199.241127 hours left
Loaded: 0.000032 seconds

 215: 178.261566, 178.141251 avg loss, 0.000003 rate, 5.010627 seconds, 6880 images, 1194.188516 hours left
Loaded: 0.000035 seconds

 216: 201.880875, 180.515213 avg loss, 0.000003 rate, 5.148306 seconds, 6912 images, 1189.209858 hours left
Loaded: 0.000037 seconds

 217: 137.918396, 176.255524 avg loss, 0.000003 rate, 4.881720 seconds, 6944 images, 1184.472307 hours left
Loaded: 0.000037 seconds

 218: 154.650696, 174.095047 avg loss, 0.000003 rate, 5.019718 seconds, 6976 images, 1179.411654 hours left
Loaded: 0.000038 seconds

 219: 160.616852, 172.747223 avg loss, 0.000003 rate, 4.985946 seconds, 7008 images, 1174.593365 hours left
Loaded: 0.000029 seconds

 220: 161.808960, 171.653397 avg loss, 0.000003 rate, 5.005955 seconds, 7040 images, 1169.776313 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.040800 seconds

 221: 132.017975, 167.689850 avg loss, 0.000003 rate, 6.996962 seconds, 7072 images, 1165.035223 hours left
Loaded: 0.000030 seconds

 222: 147.001724, 165.621033 avg loss, 0.000003 rate, 7.103619 seconds, 7104 images, 1163.165008 hours left
Loaded: 0.000024 seconds

 223: 120.491882, 161.108124 avg loss, 0.000003 rate, 6.551154 seconds, 7136 images, 1161.405037 hours left
Loaded: 0.000027 seconds

 224: 112.508713, 156.248184 avg loss, 0.000003 rate, 6.527615 seconds, 7168 images, 1158.894900 hours left
Loaded: 0.000034 seconds

 225: 139.759598, 154.599319 avg loss, 0.000003 rate, 6.740614 seconds, 7200 images, 1156.377139 hours left
Loaded: 0.000027 seconds

 226: 129.676651, 152.107056 avg loss, 0.000003 rate, 6.591610 seconds, 7232 images, 1154.180540 hours left
Loaded: 0.000033 seconds

 227: 133.463394, 150.242691 avg loss, 0.000003 rate, 6.725743 seconds, 7264 images, 1151.798816 hours left
Loaded: 0.000034 seconds

 228: 126.509514, 147.869370 avg loss, 0.000004 rate, 6.666905 seconds, 7296 images, 1149.627296 hours left
Loaded: 0.000027 seconds

 229: 138.127472, 146.895172 avg loss, 0.000004 rate, 6.699443 seconds, 7328 images, 1147.395710 hours left
Loaded: 0.000026 seconds

 230: 133.090744, 145.514725 avg loss, 0.000004 rate, 6.854731 seconds, 7360 images, 1145.231628 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.375955 seconds - performance bottleneck on CPU or Disk HDD/SSD

 231: 181.016693, 149.064926 avg loss, 0.000004 rate, 6.876701 seconds, 7392 images, 1143.304961 hours left
Loaded: 0.000029 seconds

 232: 96.567375, 143.815170 avg loss, 0.000004 rate, 6.278533 seconds, 7424 images, 1141.950479 hours left
Loaded: 0.000027 seconds

 233: 142.294586, 143.663116 avg loss, 0.000004 rate, 6.232214 seconds, 7456 images, 1139.255886 hours left
Loaded: 0.000026 seconds

 234: 136.773804, 142.974182 avg loss, 0.000004 rate, 6.251396 seconds, 7488 images, 1136.523852 hours left
Loaded: 0.000029 seconds

 235: 110.677681, 139.744537 avg loss, 0.000004 rate, 6.059090 seconds, 7520 images, 1133.845776 hours left
Loaded: 0.000029 seconds

 236: 107.935509, 136.563629 avg loss, 0.000004 rate, 6.201697 seconds, 7552 images, 1130.927233 hours left
Loaded: 0.000027 seconds

 237: 150.323730, 137.939636 avg loss, 0.000004 rate, 6.433364 seconds, 7584 images, 1128.236029 hours left
Loaded: 0.000027 seconds

 238: 157.173370, 139.863007 avg loss, 0.000004 rate, 6.397619 seconds, 7616 images, 1125.893646 hours left
Loaded: 0.000029 seconds

 239: 111.572647, 137.033966 avg loss, 0.000004 rate, 6.193722 seconds, 7648 images, 1123.524998 hours left
Loaded: 0.000028 seconds

 240: 119.522079, 135.282776 avg loss, 0.000004 rate, 6.325492 seconds, 7680 images, 1120.896683 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000032 seconds

 241: 163.222214, 138.076721 avg loss, 0.000004 rate, 11.911647 seconds, 7712 images, 1118.477740 hours left
Loaded: 0.000032 seconds

 242: 112.720924, 135.541138 avg loss, 0.000004 rate, 11.093544 seconds, 7744 images, 1123.845548 hours left
Loaded: 0.000030 seconds

 243: 102.766136, 132.263641 avg loss, 0.000005 rate, 10.967704 seconds, 7776 images, 1128.022801 hours left
Loaded: 0.000039 seconds

 244: 74.397499, 126.477028 avg loss, 0.000005 rate, 10.546904 seconds, 7808 images, 1131.983382 hours left
Loaded: 0.000030 seconds

 245: 103.799156, 124.209244 avg loss, 0.000005 rate, 10.925043 seconds, 7840 images, 1135.319594 hours left
Loaded: 0.000024 seconds

 246: 117.937202, 123.582039 avg loss, 0.000005 rate, 11.304243 seconds, 7872 images, 1139.147864 hours left
Loaded: 0.000030 seconds

 247: 107.615540, 121.985390 avg loss, 0.000005 rate, 10.873018 seconds, 7904 images, 1143.464745 hours left
Loaded: 0.000030 seconds

 248: 113.367668, 121.123619 avg loss, 0.000005 rate, 10.990232 seconds, 7936 images, 1147.139220 hours left
Loaded: 0.000029 seconds

 249: 77.881973, 116.799454 avg loss, 0.000005 rate, 10.379985 seconds, 7968 images, 1150.939788 hours left
Loaded: 0.000042 seconds

 250: 112.510887, 116.370598 avg loss, 0.000005 rate, 10.954667 seconds, 8000 images, 1153.854327 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.091904 seconds

 251: 96.408577, 114.374397 avg loss, 0.000005 rate, 11.882089 seconds, 8032 images, 1157.538279 hours left
Loaded: 0.000030 seconds

 252: 120.600578, 114.997017 avg loss, 0.000005 rate, 12.096136 seconds, 8064 images, 1162.601738 hours left
Loaded: 0.000029 seconds

 253: 81.153061, 111.612625 avg loss, 0.000005 rate, 11.481467 seconds, 8096 images, 1167.784296 hours left
Loaded: 0.000029 seconds

 254: 122.557632, 112.707123 avg loss, 0.000005 rate, 12.388112 seconds, 8128 images, 1172.060869 hours left
Loaded: 0.000030 seconds

 255: 76.454376, 109.081848 avg loss, 0.000005 rate, 11.712105 seconds, 8160 images, 1177.554491 hours left
Loaded: 0.000030 seconds

 256: 89.752296, 107.148895 avg loss, 0.000006 rate, 11.699639 seconds, 8192 images, 1182.053783 hours left
Loaded: 0.000029 seconds

 257: 126.525505, 109.086555 avg loss, 0.000006 rate, 12.020946 seconds, 8224 images, 1186.490729 hours left
Loaded: 0.000027 seconds

 258: 98.351021, 108.013000 avg loss, 0.000006 rate, 11.613113 seconds, 8256 images, 1191.329748 hours left
Loaded: 0.000025 seconds

 259: 119.293571, 109.141060 avg loss, 0.000006 rate, 12.072338 seconds, 8288 images, 1195.553631 hours left
Loaded: 0.000032 seconds

 260: 91.618629, 107.388817 avg loss, 0.000006 rate, 11.667581 seconds, 8320 images, 1200.373359 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.603162 seconds - performance bottleneck on CPU or Disk HDD/SSD

 261: 91.429245, 105.792862 avg loss, 0.000006 rate, 9.067511 seconds, 8352 images, 1204.582435 hours left
Loaded: 0.000030 seconds

 262: 65.725647, 101.786140 avg loss, 0.000006 rate, 8.817868 seconds, 8384 images, 1205.974536 hours left
Loaded: 0.000037 seconds

 263: 71.535706, 98.761101 avg loss, 0.000006 rate, 8.895929 seconds, 8416 images, 1206.167715 hours left
Loaded: 0.000039 seconds

 264: 93.480637, 98.233055 avg loss, 0.000006 rate, 9.175321 seconds, 8448 images, 1206.467417 hours left
Loaded: 0.000038 seconds

 265: 93.572586, 97.767006 avg loss, 0.000006 rate, 9.505445 seconds, 8480 images, 1207.152327 hours left
Loaded: 0.000029 seconds

 266: 92.029167, 97.193222 avg loss, 0.000007 rate, 9.218483 seconds, 8512 images, 1208.289082 hours left
Loaded: 0.000036 seconds

 267: 83.669884, 95.840889 avg loss, 0.000007 rate, 9.382573 seconds, 8544 images, 1209.015688 hours left
Loaded: 0.000031 seconds

 268: 94.567726, 95.713570 avg loss, 0.000007 rate, 8.856396 seconds, 8576 images, 1209.963019 hours left
Loaded: 0.000027 seconds

 269: 84.512970, 94.593506 avg loss, 0.000007 rate, 8.887007 seconds, 8608 images, 1210.169703 hours left
Loaded: 0.000026 seconds

 270: 65.017517, 91.635910 avg loss, 0.000007 rate, 8.416864 seconds, 8640 images, 1210.416824 hours left
Resizing, random_coef = 1.40 

 384 x 384 
 try to allocate additional workspace_size = 42.47 MB 
 CUDA allocate done! 
Loaded: 0.243380 seconds - performance bottleneck on CPU or Disk HDD/SSD

 271: 67.725014, 89.244820 avg loss, 0.000007 rate, 4.465087 seconds, 8672 images, 1210.008171 hours left
Loaded: 0.000039 seconds

 272: 95.664871, 89.886826 avg loss, 0.000007 rate, 4.655544 seconds, 8704 images, 1204.450637 hours left
Loaded: 0.000038 seconds

 273: 90.094040, 89.907547 avg loss, 0.000007 rate, 4.604671 seconds, 8736 images, 1198.875181 hours left
Loaded: 0.000040 seconds

 274: 64.617035, 87.378494 avg loss, 0.000007 rate, 4.404940 seconds, 8768 images, 1193.284776 hours left
Loaded: 0.000029 seconds

 275: 112.308907, 89.871536 avg loss, 0.000007 rate, 4.803593 seconds, 8800 images, 1187.472735 hours left
Loaded: 0.000038 seconds

 276: 97.226814, 90.607063 avg loss, 0.000008 rate, 4.538242 seconds, 8832 images, 1182.272722 hours left
Loaded: 0.000030 seconds

 277: 86.523315, 90.198685 avg loss, 0.000008 rate, 4.493831 seconds, 8864 images, 1176.755999 hours left
Loaded: 0.000037 seconds

 278: 88.034500, 89.982269 avg loss, 0.000008 rate, 4.437561 seconds, 8896 images, 1171.232709 hours left
Loaded: 0.000036 seconds

 279: 62.470001, 87.231041 avg loss, 0.000008 rate, 4.288944 seconds, 8928 images, 1165.686460 hours left
Loaded: 0.000037 seconds

 280: 56.643879, 84.172325 avg loss, 0.000008 rate, 4.177222 seconds, 8960 images, 1159.989159 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 281: 57.254150, 81.480507 avg loss, 0.000008 rate, 6.690905 seconds, 8992 images, 1154.193581 hours left
Loaded: 0.000034 seconds

 282: 54.726898, 78.805145 avg loss, 0.000008 rate, 6.642699 seconds, 9024 images, 1151.948687 hours left
Loaded: 0.000032 seconds

 283: 41.702724, 75.094902 avg loss, 0.000008 rate, 6.609392 seconds, 9056 images, 1149.659252 hours left
Loaded: 0.000026 seconds

 284: 63.372581, 73.922668 avg loss, 0.000008 rate, 7.047121 seconds, 9088 images, 1147.346410 hours left
Loaded: 0.000026 seconds

 285: 68.546043, 73.385010 avg loss, 0.000009 rate, 6.969924 seconds, 9120 images, 1145.664890 hours left
Loaded: 0.000034 seconds

 286: 47.669563, 70.813461 avg loss, 0.000009 rate, 6.840206 seconds, 9152 images, 1143.892903 hours left
Loaded: 0.000027 seconds

 287: 75.743378, 71.306450 avg loss, 0.000009 rate, 7.051782 seconds, 9184 images, 1141.958386 hours left
Loaded: 0.000035 seconds

 288: 23.462509, 66.522057 avg loss, 0.000009 rate, 6.334892 seconds, 9216 images, 1140.337164 hours left
Loaded: 0.000033 seconds

 289: 66.720146, 66.541862 avg loss, 0.000009 rate, 6.921364 seconds, 9248 images, 1137.736044 hours left
Loaded: 0.000036 seconds

 290: 38.771202, 63.764797 avg loss, 0.000009 rate, 6.638670 seconds, 9280 images, 1135.975804 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.094699 seconds

 291: 48.646389, 62.252956 avg loss, 0.000009 rate, 8.324364 seconds, 9312 images, 1133.840355 hours left
Loaded: 0.000029 seconds

 292: 33.308716, 59.358532 avg loss, 0.000009 rate, 7.919865 seconds, 9344 images, 1134.199998 hours left
Loaded: 0.000029 seconds

 293: 45.104282, 57.933105 avg loss, 0.000010 rate, 8.155190 seconds, 9376 images, 1133.862440 hours left
Loaded: 0.000029 seconds

 294: 25.951593, 54.734955 avg loss, 0.000010 rate, 7.897826 seconds, 9408 images, 1133.855214 hours left
Loaded: 0.000038 seconds

 295: 50.377033, 54.299164 avg loss, 0.000010 rate, 8.249885 seconds, 9440 images, 1133.490438 hours left
Loaded: 0.000032 seconds

 296: 53.992603, 54.268509 avg loss, 0.000010 rate, 8.407584 seconds, 9472 images, 1133.618471 hours left
Loaded: 0.000030 seconds

 297: 63.428192, 55.184479 avg loss, 0.000010 rate, 8.752266 seconds, 9504 images, 1133.964308 hours left
Loaded: 0.000033 seconds

 298: 61.793503, 55.845383 avg loss, 0.000010 rate, 8.669390 seconds, 9536 images, 1134.785581 hours left
Loaded: 0.000029 seconds

 299: 30.930370, 53.353882 avg loss, 0.000010 rate, 7.936213 seconds, 9568 images, 1135.483470 hours left
Loaded: 0.000029 seconds

 300: 54.433289, 53.461823 avg loss, 0.000011 rate, 8.230170 seconds, 9600 images, 1135.155640 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.031990 seconds

 301: 49.394459, 53.055084 avg loss, 0.000011 rate, 13.492431 seconds, 9632 images, 1135.239502 hours left
Loaded: 0.000030 seconds

 302: 39.097122, 51.659286 avg loss, 0.000011 rate, 12.758831 seconds, 9664 images, 1142.678516 hours left
Loaded: 0.000032 seconds

 303: 39.544704, 50.447830 avg loss, 0.000011 rate, 12.875537 seconds, 9696 images, 1148.979404 hours left
Loaded: 0.000040 seconds

 304: 36.291386, 49.032185 avg loss, 0.000011 rate, 13.061926 seconds, 9728 images, 1155.379417 hours left
Loaded: 0.000037 seconds

 305: 41.360065, 48.264973 avg loss, 0.000011 rate, 13.385446 seconds, 9760 images, 1161.974369 hours left
Loaded: 0.000038 seconds

 306: 53.720627, 48.810539 avg loss, 0.000011 rate, 13.729752 seconds, 9792 images, 1168.952840 hours left
Loaded: 0.000037 seconds

 307: 25.762768, 46.505760 avg loss, 0.000012 rate, 12.502738 seconds, 9824 images, 1176.339877 hours left
Loaded: 0.000029 seconds

 308: 48.262390, 46.681423 avg loss, 0.000012 rate, 13.470471 seconds, 9856 images, 1181.948162 hours left
Loaded: 0.000039 seconds

 309: 37.243889, 45.737671 avg loss, 0.000012 rate, 13.436465 seconds, 9888 images, 1188.844908 hours left
Loaded: 0.000044 seconds

 310: 46.954323, 45.859337 avg loss, 0.000012 rate, 13.227187 seconds, 9920 images, 1195.625414 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.508253 seconds - performance bottleneck on CPU or Disk HDD/SSD

 311: 40.060730, 45.279476 avg loss, 0.000012 rate, 11.364718 seconds, 9952 images, 1202.047310 hours left
Loaded: 0.000029 seconds

 312: 34.766827, 44.228210 avg loss, 0.000012 rate, 11.439783 seconds, 9984 images, 1206.523320 hours left
Loaded: 0.000028 seconds

 313: 44.066196, 44.212009 avg loss, 0.000012 rate, 11.632140 seconds, 10016 images, 1210.352703 hours left
Loaded: 0.000025 seconds

 314: 42.078987, 43.998707 avg loss, 0.000013 rate, 11.747136 seconds, 10048 images, 1214.411020 hours left
Loaded: 0.000027 seconds

 315: 32.814476, 42.880283 avg loss, 0.000013 rate, 11.317186 seconds, 10080 images, 1218.588493 hours left
Loaded: 0.000027 seconds

 316: 32.425556, 41.834812 avg loss, 0.000013 rate, 11.497336 seconds, 10112 images, 1222.126790 hours left
Loaded: 0.000026 seconds

 317: 21.828638, 39.834194 avg loss, 0.000013 rate, 11.170157 seconds, 10144 images, 1225.879972 hours left
Loaded: 0.000027 seconds

 318: 39.524914, 39.803265 avg loss, 0.000013 rate, 12.345402 seconds, 10176 images, 1229.141007 hours left
Loaded: 0.000028 seconds

 319: 51.654476, 40.988384 avg loss, 0.000013 rate, 12.427738 seconds, 10208 images, 1234.002280 hours left
Loaded: 0.000028 seconds

 320: 33.071613, 40.196709 avg loss, 0.000014 rate, 11.787742 seconds, 10240 images, 1238.929306 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.341374 seconds - performance bottleneck on CPU or Disk HDD/SSD

 321: 48.416229, 41.018661 avg loss, 0.000014 rate, 6.711152 seconds, 10272 images, 1242.917822 hours left
Loaded: 0.000033 seconds

 322: 35.724873, 40.489281 avg loss, 0.000014 rate, 6.286954 seconds, 10304 images, 1240.287338 hours left
Loaded: 0.000028 seconds

 323: 47.441189, 41.184471 avg loss, 0.000014 rate, 6.528012 seconds, 10336 images, 1236.619514 hours left
Loaded: 0.000026 seconds

 324: 40.261005, 41.092125 avg loss, 0.000014 rate, 6.246551 seconds, 10368 images, 1233.323262 hours left
Loaded: 0.000027 seconds

 325: 32.749523, 40.257866 avg loss, 0.000015 rate, 6.094129 seconds, 10400 images, 1229.668897 hours left
Loaded: 0.000027 seconds

 326: 50.262012, 41.258282 avg loss, 0.000015 rate, 6.419207 seconds, 10432 images, 1225.839288 hours left
Loaded: 0.000033 seconds

 327: 26.719198, 39.804375 avg loss, 0.000015 rate, 6.070976 seconds, 10464 images, 1222.499616 hours left
Loaded: 0.000026 seconds

 328: 18.240824, 37.648018 avg loss, 0.000015 rate, 5.837383 seconds, 10496 images, 1218.709507 hours left
Loaded: 0.000028 seconds

 329: 49.123043, 38.795521 avg loss, 0.000015 rate, 6.478556 seconds, 10528 images, 1214.632724 hours left
Loaded: 0.000027 seconds

 330: 44.512516, 39.367222 avg loss, 0.000015 rate, 6.637588 seconds, 10560 images, 1211.487520 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.019708 seconds

 331: 34.363380, 38.866837 avg loss, 0.000016 rate, 10.089510 seconds, 10592 images, 1208.594703 hours left
Loaded: 0.000028 seconds

 332: 25.056065, 37.485760 avg loss, 0.000016 rate, 9.702632 seconds, 10624 images, 1210.554096 hours left
Loaded: 0.000027 seconds

 333: 36.367210, 37.373905 avg loss, 0.000016 rate, 10.035082 seconds, 10656 images, 1211.929014 hours left
Loaded: 0.000029 seconds

 334: 15.792513, 35.215767 avg loss, 0.000016 rate, 9.147076 seconds, 10688 images, 1213.752044 hours left
Loaded: 0.000043 seconds

 335: 43.314075, 36.025597 avg loss, 0.000016 rate, 10.430238 seconds, 10720 images, 1214.323069 hours left
Loaded: 0.000030 seconds

 336: 33.421341, 35.765171 avg loss, 0.000017 rate, 10.572236 seconds, 10752 images, 1216.671135 hours left
Loaded: 0.000031 seconds

 337: 32.395500, 35.428204 avg loss, 0.000017 rate, 10.418828 seconds, 10784 images, 1219.192957 hours left
Loaded: 0.000030 seconds

 338: 33.693939, 35.254776 avg loss, 0.000017 rate, 10.290605 seconds, 10816 images, 1221.476397 hours left
Loaded: 0.000029 seconds

 339: 28.807762, 34.610073 avg loss, 0.000017 rate, 10.021792 seconds, 10848 images, 1223.558825 hours left
Loaded: 0.000029 seconds

 340: 29.805780, 34.129642 avg loss, 0.000017 rate, 9.996084 seconds, 10880 images, 1225.246931 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 341: 21.134045, 32.830082 avg loss, 0.000018 rate, 12.243472 seconds, 10912 images, 1226.882408 hours left
Loaded: 0.000038 seconds

 342: 39.687569, 33.515831 avg loss, 0.000018 rate, 13.145773 seconds, 10944 images, 1231.623865 hours left
Loaded: 0.000028 seconds

 343: 19.902037, 32.154453 avg loss, 0.000018 rate, 12.035891 seconds, 10976 images, 1237.571480 hours left
Loaded: 0.000027 seconds

 344: 21.167973, 31.055805 avg loss, 0.000018 rate, 12.329706 seconds, 11008 images, 1241.917580 hours left
Loaded: 0.000027 seconds

 345: 35.659084, 31.516132 avg loss, 0.000018 rate, 13.184722 seconds, 11040 images, 1246.628389 hours left
Loaded: 0.000040 seconds

 346: 29.752050, 31.339724 avg loss, 0.000019 rate, 13.011353 seconds, 11072 images, 1252.479946 hours left
Loaded: 0.000033 seconds

 347: 32.557133, 31.461464 avg loss, 0.000019 rate, 12.824771 seconds, 11104 images, 1258.032104 hours left
Loaded: 0.000031 seconds

 348: 31.598362, 31.475153 avg loss, 0.000019 rate, 12.948406 seconds, 11136 images, 1263.269475 hours left
Loaded: 0.000027 seconds

 349: 40.940849, 32.421722 avg loss, 0.000019 rate, 13.201337 seconds, 11168 images, 1268.626200 hours left
Loaded: 0.000028 seconds

 350: 27.769323, 31.956482 avg loss, 0.000020 rate, 12.799820 seconds, 11200 images, 1274.280716 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.083908 seconds

 351: 34.341576, 32.194992 avg loss, 0.000020 rate, 15.029700 seconds, 11232 images, 1279.320821 hours left
Loaded: 0.000038 seconds

 352: 30.873779, 32.062870 avg loss, 0.000020 rate, 14.440636 seconds, 11264 images, 1287.525003 hours left
Loaded: 0.000031 seconds

 353: 26.912876, 31.547871 avg loss, 0.000020 rate, 14.455835 seconds, 11296 images, 1294.712195 hours left
Loaded: 0.000030 seconds

 354: 20.078796, 30.400963 avg loss, 0.000020 rate, 13.353886 seconds, 11328 images, 1301.848582 hours left
Loaded: 0.000027 seconds

 355: 21.156008, 29.476467 avg loss, 0.000021 rate, 13.329284 seconds, 11360 images, 1307.382631 hours left
Loaded: 0.000028 seconds

 356: 29.997902, 29.528610 avg loss, 0.000021 rate, 14.129244 seconds, 11392 images, 1312.827118 hours left
Loaded: 0.000026 seconds

 357: 26.183033, 29.194052 avg loss, 0.000021 rate, 13.782611 seconds, 11424 images, 1319.328500 hours left
Loaded: 0.000035 seconds

 358: 31.172022, 29.391850 avg loss, 0.000021 rate, 14.075061 seconds, 11456 images, 1325.283253 hours left
Loaded: 0.000033 seconds

 359: 29.899439, 29.442608 avg loss, 0.000022 rate, 14.088082 seconds, 11488 images, 1331.584730 hours left
Loaded: 0.000027 seconds

 360: 33.850639, 29.883411 avg loss, 0.000022 rate, 14.329463 seconds, 11520 images, 1337.841252 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.762703 seconds - performance bottleneck on CPU or Disk HDD/SSD

 361: 39.599426, 30.855013 avg loss, 0.000022 rate, 13.038246 seconds, 11552 images, 1344.370495 hours left
Loaded: 0.000035 seconds

 362: 16.126938, 29.382206 avg loss, 0.000022 rate, 11.558950 seconds, 11584 images, 1350.100119 hours left
Loaded: 0.000037 seconds

 363: 32.447338, 29.688719 avg loss, 0.000023 rate, 12.951671 seconds, 11616 images, 1352.657709 hours left
Loaded: 0.000036 seconds

 364: 25.201826, 29.240030 avg loss, 0.000023 rate, 12.025430 seconds, 11648 images, 1357.124560 hours left
Loaded: 0.000038 seconds

 365: 24.507404, 28.766768 avg loss, 0.000023 rate, 11.925255 seconds, 11680 images, 1360.259907 hours left
Loaded: 0.000036 seconds

 366: 33.618717, 29.251963 avg loss, 0.000023 rate, 12.268757 seconds, 11712 images, 1363.224701 hours left
Loaded: 0.000027 seconds

 367: 23.045469, 28.631313 avg loss, 0.000024 rate, 11.590417 seconds, 11744 images, 1366.637026 hours left
Loaded: 0.000034 seconds

 368: 18.928661, 27.661049 avg loss, 0.000024 rate, 11.513327 seconds, 11776 images, 1369.072791 hours left
Loaded: 0.000028 seconds

 369: 31.237642, 28.018707 avg loss, 0.000024 rate, 12.165634 seconds, 11808 images, 1371.377078 hours left
Loaded: 0.000028 seconds

 370: 25.641672, 27.781004 avg loss, 0.000024 rate, 11.772770 seconds, 11840 images, 1374.564501 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.083199 seconds

 371: 22.482735, 27.251177 avg loss, 0.000025 rate, 12.954160 seconds, 11872 images, 1377.174231 hours left
Loaded: 0.000030 seconds

 372: 23.057444, 26.831804 avg loss, 0.000025 rate, 12.529360 seconds, 11904 images, 1381.514617 hours left
Loaded: 0.000027 seconds

 373: 33.521358, 27.500759 avg loss, 0.000025 rate, 13.591470 seconds, 11936 images, 1385.105869 hours left
Loaded: 0.000031 seconds

 374: 26.361254, 27.386808 avg loss, 0.000025 rate, 13.240578 seconds, 11968 images, 1390.136699 hours left
Loaded: 0.000030 seconds

 375: 21.788750, 26.827003 avg loss, 0.000026 rate, 12.895583 seconds, 12000 images, 1394.629715 hours left
Loaded: 0.000031 seconds

 376: 30.814987, 27.225801 avg loss, 0.000026 rate, 13.345285 seconds, 12032 images, 1398.598483 hours left
Loaded: 0.000031 seconds

 377: 16.326828, 26.135904 avg loss, 0.000026 rate, 12.447933 seconds, 12064 images, 1403.152271 hours left
Loaded: 0.000026 seconds

 378: 18.774355, 25.399750 avg loss, 0.000027 rate, 12.977309 seconds, 12096 images, 1406.413857 hours left
Loaded: 0.000026 seconds

 379: 29.909531, 25.850727 avg loss, 0.000027 rate, 13.706255 seconds, 12128 images, 1410.378208 hours left
Loaded: 0.000028 seconds

 380: 19.366899, 25.202345 avg loss, 0.000027 rate, 13.042852 seconds, 12160 images, 1415.315549 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.628491 seconds - performance bottleneck on CPU or Disk HDD/SSD

 381: 32.962223, 25.978333 avg loss, 0.000027 rate, 11.503295 seconds, 12192 images, 1419.281868 hours left
Loaded: 0.000030 seconds

 382: 35.645756, 26.945074 avg loss, 0.000028 rate, 11.773257 seconds, 12224 images, 1421.942777 hours left
Loaded: 0.000028 seconds

 383: 27.144310, 26.964998 avg loss, 0.000028 rate, 10.855945 seconds, 12256 images, 1424.079010 hours left
Loaded: 0.000027 seconds

 384: 20.136370, 26.282135 avg loss, 0.000028 rate, 10.397384 seconds, 12288 images, 1424.919501 hours left
Loaded: 0.000026 seconds

 385: 41.350853, 27.789007 avg loss, 0.000029 rate, 11.820702 seconds, 12320 images, 1425.114517 hours left
Loaded: 0.000035 seconds

 386: 20.938675, 27.103973 avg loss, 0.000029 rate, 10.724910 seconds, 12352 images, 1427.284838 hours left
Loaded: 0.000034 seconds

 387: 35.573540, 27.950930 avg loss, 0.000029 rate, 11.543437 seconds, 12384 images, 1427.911165 hours left
Loaded: 0.000029 seconds

 388: 27.289167, 27.884754 avg loss, 0.000029 rate, 11.138938 seconds, 12416 images, 1429.668290 hours left
Loaded: 0.000038 seconds

 389: 15.069977, 26.603277 avg loss, 0.000030 rate, 10.192751 seconds, 12448 images, 1430.845872 hours left
Loaded: 0.000038 seconds

 390: 26.752811, 26.618231 avg loss, 0.000030 rate, 11.346281 seconds, 12480 images, 1430.697221 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.531270 seconds - performance bottleneck on CPU or Disk HDD/SSD

 391: 24.998409, 26.456249 avg loss, 0.000030 rate, 9.987297 seconds, 12512 images, 1432.152508 hours left
Loaded: 0.000028 seconds

 392: 22.350555, 26.045679 avg loss, 0.000031 rate, 9.898313 seconds, 12544 images, 1432.443304 hours left
Loaded: 0.000030 seconds

 393: 30.009722, 26.442083 avg loss, 0.000031 rate, 10.236144 seconds, 12576 images, 1431.869550 hours left
Loaded: 0.000028 seconds

 394: 29.320028, 26.729877 avg loss, 0.000031 rate, 10.367952 seconds, 12608 images, 1431.770819 hours left
Loaded: 0.000031 seconds

 395: 16.139256, 25.670815 avg loss, 0.000032 rate, 9.601718 seconds, 12640 images, 1431.856150 hours left
Loaded: 0.000031 seconds

 396: 14.682250, 24.571959 avg loss, 0.000032 rate, 9.696568 seconds, 12672 images, 1430.876166 hours left
Loaded: 0.000044 seconds

 397: 27.609335, 24.875696 avg loss, 0.000032 rate, 10.631434 seconds, 12704 images, 1430.037718 hours left
Loaded: 0.000031 seconds

 398: 27.940746, 25.182201 avg loss, 0.000033 rate, 10.601972 seconds, 12736 images, 1430.506340 hours left
Loaded: 0.000030 seconds

 399: 24.033907, 25.067371 avg loss, 0.000033 rate, 10.105681 seconds, 12768 images, 1430.929299 hours left
Loaded: 0.000043 seconds

 400: 23.216297, 24.882263 avg loss, 0.000033 rate, 9.662591 seconds, 12800 images, 1430.658566 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.288009 seconds - performance bottleneck on CPU or Disk HDD/SSD

 401: 23.949524, 24.788990 avg loss, 0.000034 rate, 4.921059 seconds, 12832 images, 1429.775002 hours left
Loaded: 0.000029 seconds

 402: 29.580410, 25.268131 avg loss, 0.000034 rate, 5.038345 seconds, 12864 images, 1422.713513 hours left
Loaded: 0.000034 seconds

 403: 26.592518, 25.400570 avg loss, 0.000034 rate, 5.021364 seconds, 12896 images, 1415.485504 hours left
Loaded: 0.000028 seconds

 404: 31.084721, 25.968985 avg loss, 0.000035 rate, 5.183443 seconds, 12928 images, 1408.306178 hours left
Loaded: 0.000029 seconds

 405: 29.273087, 26.299395 avg loss, 0.000035 rate, 4.992062 seconds, 12960 images, 1401.423777 hours left
Loaded: 0.000027 seconds

 406: 29.747581, 26.644213 avg loss, 0.000035 rate, 5.136678 seconds, 12992 images, 1394.344329 hours left
Loaded: 0.000038 seconds

 407: 23.822161, 26.362007 avg loss, 0.000036 rate, 4.977813 seconds, 13024 images, 1387.536552 hours left
Loaded: 0.000029 seconds

 408: 22.324099, 25.958216 avg loss, 0.000036 rate, 4.985867 seconds, 13056 images, 1380.576166 hours left
Loaded: 0.000030 seconds

 409: 28.332817, 26.195675 avg loss, 0.000036 rate, 5.195557 seconds, 13088 images, 1373.696548 hours left
Loaded: 0.000040 seconds

 410: 35.115391, 27.087646 avg loss, 0.000037 rate, 5.282480 seconds, 13120 images, 1367.177002 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.013778 seconds

 411: 36.696007, 28.048483 avg loss, 0.000037 rate, 5.793724 seconds, 13152 images, 1360.843398 hours left
Loaded: 0.000030 seconds

 412: 30.837154, 28.327351 avg loss, 0.000037 rate, 5.754753 seconds, 13184 images, 1355.302388 hours left
Loaded: 0.000028 seconds

 413: 20.902828, 27.584898 avg loss, 0.000038 rate, 5.772829 seconds, 13216 images, 1349.743537 hours left
Loaded: 0.000030 seconds

 414: 20.821766, 26.908585 avg loss, 0.000038 rate, 5.598924 seconds, 13248 images, 1344.265379 hours left
Loaded: 0.000033 seconds

 415: 33.013428, 27.519070 avg loss, 0.000039 rate, 5.742920 seconds, 13280 images, 1338.600400 hours left
Loaded: 0.000030 seconds

 416: 23.209709, 27.088133 avg loss, 0.000039 rate, 5.583855 seconds, 13312 images, 1333.192088 hours left
Loaded: 0.000043 seconds

 417: 24.251598, 26.804480 avg loss, 0.000039 rate, 5.563390 seconds, 13344 images, 1327.616878 hours left
Loaded: 0.000029 seconds

 418: 19.473877, 26.071419 avg loss, 0.000040 rate, 5.581714 seconds, 13376 images, 1322.068995 hours left
Loaded: 0.000030 seconds

 419: 20.603127, 25.524590 avg loss, 0.000040 rate, 5.629326 seconds, 13408 images, 1316.602010 hours left
Loaded: 0.000040 seconds

 420: 34.498287, 26.421959 avg loss, 0.000040 rate, 6.065882 seconds, 13440 images, 1311.255821 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.545028 seconds - performance bottleneck on CPU or Disk HDD/SSD

 421: 36.043159, 27.384079 avg loss, 0.000041 rate, 6.045144 seconds, 13472 images, 1306.569516 hours left
Loaded: 0.000040 seconds

 422: 39.062786, 28.551950 avg loss, 0.000041 rate, 6.188770 seconds, 13504 images, 1302.658298 hours left
Loaded: 0.000036 seconds

 423: 19.653234, 27.662079 avg loss, 0.000042 rate, 5.507224 seconds, 13536 images, 1298.228639 hours left
Loaded: 0.000039 seconds

 424: 23.105684, 27.206440 avg loss, 0.000042 rate, 5.599019 seconds, 13568 images, 1292.896517 hours left
Loaded: 0.000038 seconds

 425: 27.122421, 27.198038 avg loss, 0.000042 rate, 5.819380 seconds, 13600 images, 1287.745218 hours left
Loaded: 0.000038 seconds

 426: 17.094711, 26.187706 avg loss, 0.000043 rate, 5.441467 seconds, 13632 images, 1282.951515 hours left
Loaded: 0.000037 seconds

 427: 21.569246, 25.725861 avg loss, 0.000043 rate, 5.465946 seconds, 13664 images, 1277.680777 hours left
Loaded: 0.000038 seconds

 428: 31.254669, 26.278742 avg loss, 0.000044 rate, 5.795342 seconds, 13696 images, 1272.496733 hours left
Loaded: 0.000036 seconds

 429: 16.644880, 25.315355 avg loss, 0.000044 rate, 5.430785 seconds, 13728 images, 1267.822076 hours left
Loaded: 0.000032 seconds

 430: 18.947302, 24.678551 avg loss, 0.000044 rate, 5.401892 seconds, 13760 images, 1262.687747 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.069981 seconds

 431: 24.350817, 24.645777 avg loss, 0.000045 rate, 7.186730 seconds, 13792 images, 1257.564606 hours left
Loaded: 0.000031 seconds

 432: 27.613369, 24.942535 avg loss, 0.000045 rate, 7.454588 seconds, 13824 images, 1255.069129 hours left
Loaded: 0.000036 seconds

 433: 26.476797, 25.095963 avg loss, 0.000046 rate, 7.345679 seconds, 13856 images, 1252.873495 hours left
Loaded: 0.000031 seconds

 434: 23.142214, 24.900587 avg loss, 0.000046 rate, 7.112644 seconds, 13888 images, 1250.548523 hours left
Loaded: 0.000038 seconds

 435: 19.872173, 24.397745 avg loss, 0.000047 rate, 7.057364 seconds, 13920 images, 1247.923071 hours left
Loaded: 0.000031 seconds

 436: 27.187332, 24.676704 avg loss, 0.000047 rate, 7.449683 seconds, 13952 images, 1245.247076 hours left
Loaded: 0.000032 seconds

 437: 34.508278, 25.659863 avg loss, 0.000047 rate, 7.584210 seconds, 13984 images, 1243.142769 hours left
Loaded: 0.000023 seconds

 438: 26.595333, 25.753410 avg loss, 0.000048 rate, 7.060773 seconds, 14016 images, 1241.246352 hours left
Loaded: 0.000028 seconds

 439: 22.188562, 25.396925 avg loss, 0.000048 rate, 7.032995 seconds, 14048 images, 1238.641780 hours left
Loaded: 0.000038 seconds

 440: 17.482397, 24.605473 avg loss, 0.000049 rate, 6.908476 seconds, 14080 images, 1236.024655 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.472647 seconds - performance bottleneck on CPU or Disk HDD/SSD

 441: 20.305264, 24.175451 avg loss, 0.000049 rate, 6.955751 seconds, 14112 images, 1233.260731 hours left
Loaded: 0.000028 seconds

 442: 38.063362, 25.564243 avg loss, 0.000050 rate, 7.954329 seconds, 14144 images, 1231.246573 hours left
Loaded: 0.000037 seconds

 443: 21.110409, 25.118860 avg loss, 0.000050 rate, 6.981586 seconds, 14176 images, 1229.983119 hours left
Loaded: 0.000027 seconds

 444: 21.927036, 24.799679 avg loss, 0.000051 rate, 7.120796 seconds, 14208 images, 1227.381105 hours left
Loaded: 0.000028 seconds

 445: 24.974419, 24.817152 avg loss, 0.000051 rate, 7.610043 seconds, 14240 images, 1224.998446 hours left
Loaded: 0.000030 seconds

 446: 18.722918, 24.207729 avg loss, 0.000051 rate, 7.159695 seconds, 14272 images, 1223.319182 hours left
Loaded: 0.000030 seconds

 447: 29.514791, 24.738436 avg loss, 0.000052 rate, 7.629594 seconds, 14304 images, 1221.031139 hours left
Loaded: 0.000038 seconds

 448: 18.183937, 24.082985 avg loss, 0.000052 rate, 7.070220 seconds, 14336 images, 1219.418664 hours left
Loaded: 0.000030 seconds

 449: 22.867298, 23.961416 avg loss, 0.000053 rate, 7.368604 seconds, 14368 images, 1217.045314 hours left
Loaded: 0.000030 seconds

 450: 26.651512, 24.230427 avg loss, 0.000053 rate, 7.550507 seconds, 14400 images, 1215.110132 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000035 seconds

 451: 23.089657, 24.116350 avg loss, 0.000054 rate, 13.609617 seconds, 14432 images, 1213.446950 hours left
Loaded: 0.000031 seconds

 452: 23.024349, 24.007151 avg loss, 0.000054 rate, 13.272755 seconds, 14464 images, 1220.216643 hours left
Loaded: 0.000028 seconds

 453: 23.493053, 23.955742 avg loss, 0.000055 rate, 13.334624 seconds, 14496 images, 1226.450686 hours left
Loaded: 0.000028 seconds

 454: 22.068737, 23.767042 avg loss, 0.000055 rate, 13.615614 seconds, 14528 images, 1232.708284 hours left
Loaded: 0.000029 seconds

 455: 16.487885, 23.039127 avg loss, 0.000056 rate, 13.216734 seconds, 14560 images, 1239.293568 hours left
Loaded: 0.000039 seconds

 456: 24.744709, 23.209686 avg loss, 0.000056 rate, 14.177301 seconds, 14592 images, 1245.258914 hours left
Loaded: 0.000028 seconds

 457: 22.861347, 23.174852 avg loss, 0.000057 rate, 13.739576 seconds, 14624 images, 1252.498820 hours left
Loaded: 0.000028 seconds

 458: 22.301472, 23.087515 avg loss, 0.000057 rate, 13.650768 seconds, 14656 images, 1259.058272 hours left
Loaded: 0.000028 seconds

 459: 24.793251, 23.258089 avg loss, 0.000058 rate, 14.697201 seconds, 14688 images, 1265.428733 hours left
Loaded: 0.000029 seconds

 460: 18.804098, 22.812691 avg loss, 0.000058 rate, 13.766716 seconds, 14720 images, 1273.188953 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.111724 seconds - performance bottleneck on CPU or Disk HDD/SSD

 461: 21.824163, 22.713839 avg loss, 0.000059 rate, 14.796443 seconds, 14752 images, 1279.579086 hours left
Loaded: 0.000028 seconds

 462: 25.823385, 23.024794 avg loss, 0.000059 rate, 15.255269 seconds, 14784 images, 1287.490711 hours left
Loaded: 0.000030 seconds

 463: 20.690161, 22.791330 avg loss, 0.000060 rate, 14.706253 seconds, 14816 images, 1295.805339 hours left
Loaded: 0.000028 seconds

 464: 32.318367, 23.744034 avg loss, 0.000060 rate, 16.819845 seconds, 14848 images, 1303.274202 hours left
Loaded: 0.000030 seconds

 465: 23.425280, 23.712158 avg loss, 0.000061 rate, 15.460113 seconds, 14880 images, 1313.604090 hours left
Loaded: 0.000029 seconds

 466: 17.519266, 23.092869 avg loss, 0.000061 rate, 14.427569 seconds, 14912 images, 1321.941986 hours left
Loaded: 0.000028 seconds

 467: 26.252136, 23.408796 avg loss, 0.000062 rate, 15.575061 seconds, 14944 images, 1328.762273 hours left
Loaded: 0.000030 seconds

 468: 25.305605, 23.598476 avg loss, 0.000062 rate, 15.460730 seconds, 14976 images, 1337.108159 hours left
Loaded: 0.000029 seconds

 469: 23.891016, 23.627731 avg loss, 0.000063 rate, 14.907087 seconds, 15008 images, 1345.211743 hours left
Loaded: 0.000027 seconds

 470: 17.226192, 22.987577 avg loss, 0.000063 rate, 14.252113 seconds, 15040 images, 1352.465262 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.414031 seconds - performance bottleneck on CPU or Disk HDD/SSD

 471: 26.934036, 23.382223 avg loss, 0.000064 rate, 7.494270 seconds, 15072 images, 1358.736449 hours left
Loaded: 0.000037 seconds

 472: 16.317547, 22.675755 avg loss, 0.000065 rate, 7.008403 seconds, 15104 images, 1356.133485 hours left
Loaded: 0.000037 seconds

 473: 28.351025, 23.243282 avg loss, 0.000065 rate, 7.727915 seconds, 15136 images, 1352.306654 hours left
Loaded: 0.000039 seconds

 474: 10.958869, 22.014841 avg loss, 0.000066 rate, 6.714386 seconds, 15168 images, 1349.517446 hours left
Loaded: 0.000031 seconds

 475: 32.659676, 23.079325 avg loss, 0.000066 rate, 8.008709 seconds, 15200 images, 1345.348361 hours left
Loaded: 0.000029 seconds

 476: 31.324400, 23.903831 avg loss, 0.000067 rate, 7.851363 seconds, 15232 images, 1343.018696 hours left
Loaded: 0.000023 seconds

 477: 26.326708, 24.146118 avg loss, 0.000067 rate, 7.605726 seconds, 15264 images, 1340.493759 hours left
Loaded: 0.000041 seconds

 478: 20.213766, 23.752884 avg loss, 0.000068 rate, 7.248720 seconds, 15296 images, 1337.652860 hours left
Loaded: 0.000028 seconds

 479: 15.680904, 22.945686 avg loss, 0.000068 rate, 6.946114 seconds, 15328 images, 1334.344510 hours left
Loaded: 0.000030 seconds

 480: 12.870579, 21.938175 avg loss, 0.000069 rate, 6.706183 seconds, 15360 images, 1330.648902 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 481: 26.879940, 22.432352 avg loss, 0.000070 rate, 14.222219 seconds, 15392 images, 1326.656983 hours left
Loaded: 0.000036 seconds

 482: 15.409622, 21.730080 avg loss, 0.000070 rate, 12.655528 seconds, 15424 images, 1333.144293 hours left
Loaded: 0.000027 seconds

 483: 21.313002, 21.688372 avg loss, 0.000071 rate, 13.661383 seconds, 15456 images, 1337.390672 hours left
Loaded: 0.000038 seconds

 484: 20.131100, 21.532644 avg loss, 0.000071 rate, 13.593015 seconds, 15488 images, 1342.991604 hours left
Loaded: 0.000030 seconds

 485: 19.901804, 21.369560 avg loss, 0.000072 rate, 13.457126 seconds, 15520 images, 1348.441547 hours left
Loaded: 0.000039 seconds

 486: 18.420786, 21.074682 avg loss, 0.000073 rate, 13.592652 seconds, 15552 images, 1353.648202 hours left
Loaded: 0.000031 seconds

 487: 22.403002, 21.207514 avg loss, 0.000073 rate, 13.747321 seconds, 15584 images, 1358.991001 hours left
Loaded: 0.000032 seconds

 488: 17.800436, 20.866806 avg loss, 0.000074 rate, 13.349032 seconds, 15616 images, 1364.495147 hours left
Loaded: 0.000038 seconds

 489: 13.688698, 20.148994 avg loss, 0.000074 rate, 12.652300 seconds, 15648 images, 1369.391021 hours left
Loaded: 0.000030 seconds

 490: 19.967693, 20.130865 avg loss, 0.000075 rate, 13.761347 seconds, 15680 images, 1373.270203 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.038696 seconds

 491: 25.822977, 20.700077 avg loss, 0.000076 rate, 15.296942 seconds, 15712 images, 1378.650922 hours left
Loaded: 0.000028 seconds

 492: 25.459803, 21.176050 avg loss, 0.000076 rate, 15.484285 seconds, 15744 images, 1386.164307 hours left
Loaded: 0.000034 seconds

 493: 10.773039, 20.135750 avg loss, 0.000077 rate, 13.603718 seconds, 15776 images, 1393.809012 hours left
Loaded: 0.000029 seconds

 494: 25.186478, 20.640823 avg loss, 0.000077 rate, 15.403506 seconds, 15808 images, 1398.765300 hours left
Loaded: 0.000029 seconds

 495: 28.021555, 21.378897 avg loss, 0.000078 rate, 15.572744 seconds, 15840 images, 1406.171718 hours left
Loaded: 0.000030 seconds

 496: 17.386044, 20.979610 avg loss, 0.000079 rate, 14.384564 seconds, 15872 images, 1413.739083 hours left
Loaded: 0.000032 seconds

 497: 22.178576, 21.099506 avg loss, 0.000079 rate, 14.992635 seconds, 15904 images, 1419.580467 hours left
Loaded: 0.000030 seconds

 498: 21.548733, 21.144428 avg loss, 0.000080 rate, 14.731104 seconds, 15936 images, 1426.207963 hours left
Loaded: 0.000027 seconds

 499: 24.768021, 21.506788 avg loss, 0.000081 rate, 14.819296 seconds, 15968 images, 1432.405906 hours left
Loaded: 0.000028 seconds

 500: 19.299984, 21.286108 avg loss, 0.000081 rate, 14.284049 seconds, 16000 images, 1438.664294 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.400882 seconds - performance bottleneck on CPU or Disk HDD/SSD

 501: 20.336567, 21.191154 avg loss, 0.000082 rate, 11.357912 seconds, 16032 images, 1444.116661 hours left
Loaded: 0.000042 seconds

 502: 23.805588, 21.452599 avg loss, 0.000083 rate, 11.858123 seconds, 16064 images, 1446.007132 hours left
Loaded: 0.000022 seconds

 503: 21.541098, 21.461449 avg loss, 0.000083 rate, 11.309588 seconds, 16096 images, 1448.016683 hours left
Loaded: 0.000029 seconds

 504: 20.955742, 21.410877 avg loss, 0.000084 rate, 11.484789 seconds, 16128 images, 1449.244227 hours left
Loaded: 0.000028 seconds

 505: 23.506660, 21.620455 avg loss, 0.000085 rate, 11.617861 seconds, 16160 images, 1450.702807 hours left
Loaded: 0.000027 seconds

 506: 18.816954, 21.340105 avg loss, 0.000085 rate, 11.458257 seconds, 16192 images, 1452.331587 hours left
Loaded: 0.000023 seconds

 507: 28.941587, 22.100254 avg loss, 0.000086 rate, 12.632273 seconds, 16224 images, 1453.722379 hours left
Loaded: 0.000029 seconds

 508: 19.674080, 21.857637 avg loss, 0.000087 rate, 11.421084 seconds, 16256 images, 1456.729779 hours left
Loaded: 0.000030 seconds

 509: 24.737413, 22.145615 avg loss, 0.000087 rate, 11.790204 seconds, 16288 images, 1458.024899 hours left
Loaded: 0.000031 seconds

 510: 14.894899, 21.420544 avg loss, 0.000088 rate, 10.953385 seconds, 16320 images, 1459.819697 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.345043 seconds - performance bottleneck on CPU or Disk HDD/SSD

 511: 23.481676, 21.626657 avg loss, 0.000089 rate, 7.002530 seconds, 16352 images, 1460.434287 hours left
Loaded: 0.000030 seconds

 512: 12.192317, 20.683224 avg loss, 0.000089 rate, 6.124594 seconds, 16384 images, 1456.034696 hours left
Loaded: 0.000029 seconds

 513: 25.841528, 21.199055 avg loss, 0.000090 rate, 6.810807 seconds, 16416 images, 1449.980581 hours left
Loaded: 0.000032 seconds

 514: 22.695507, 21.348700 avg loss, 0.000091 rate, 6.858957 seconds, 16448 images, 1444.940037 hours left
Loaded: 0.000028 seconds

 515: 22.934835, 21.507313 avg loss, 0.000091 rate, 6.991890 seconds, 16480 images, 1440.016756 hours left
Loaded: 0.000029 seconds

 516: 24.812378, 21.837820 avg loss, 0.000092 rate, 6.850247 seconds, 16512 images, 1435.327308 hours left
Loaded: 0.000028 seconds

 517: 24.573637, 22.111403 avg loss, 0.000093 rate, 6.800663 seconds, 16544 images, 1430.488015 hours left
Loaded: 0.000028 seconds

 518: 26.768864, 22.577148 avg loss, 0.000094 rate, 6.896069 seconds, 16576 images, 1425.628231 hours left
Loaded: 0.000030 seconds

 519: 32.879486, 23.607382 avg loss, 0.000094 rate, 7.587390 seconds, 16608 images, 1420.949530 hours left
Loaded: 0.000031 seconds

 520: 26.389639, 23.885607 avg loss, 0.000095 rate, 7.238855 seconds, 16640 images, 1417.277730 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.032542 seconds

 521: 17.490685, 23.246115 avg loss, 0.000096 rate, 7.580885 seconds, 16672 images, 1413.158573 hours left
Loaded: 0.000041 seconds

 522: 31.505127, 24.072016 avg loss, 0.000097 rate, 8.220029 seconds, 16704 images, 1409.600762 hours left
Loaded: 0.000037 seconds

 523: 21.952894, 23.860104 avg loss, 0.000097 rate, 7.672607 seconds, 16736 images, 1406.921030 hours left
Loaded: 0.000037 seconds

 524: 23.734428, 23.847536 avg loss, 0.000098 rate, 7.584108 seconds, 16768 images, 1403.507794 hours left
Loaded: 0.000029 seconds

 525: 24.250172, 23.887800 avg loss, 0.000099 rate, 7.526433 seconds, 16800 images, 1400.005773 hours left
Loaded: 0.000033 seconds

 526: 18.600563, 23.359077 avg loss, 0.000100 rate, 7.222502 seconds, 16832 images, 1396.458625 hours left
Loaded: 0.000029 seconds

 527: 13.688610, 22.392031 avg loss, 0.000100 rate, 6.843360 seconds, 16864 images, 1392.524829 hours left
Loaded: 0.000038 seconds

 528: 15.197964, 21.672625 avg loss, 0.000101 rate, 6.788626 seconds, 16896 images, 1388.103789 hours left
Loaded: 0.000027 seconds

 529: 18.250481, 21.330410 avg loss, 0.000102 rate, 7.291262 seconds, 16928 images, 1383.650937 hours left
Loaded: 0.000030 seconds

 530: 26.370314, 21.834400 avg loss, 0.000103 rate, 7.628220 seconds, 16960 images, 1379.940644 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.418182 seconds - performance bottleneck on CPU or Disk HDD/SSD

 531: 21.416000, 21.792561 avg loss, 0.000103 rate, 7.163123 seconds, 16992 images, 1376.735406 hours left
Loaded: 0.000028 seconds

 532: 27.667458, 22.380051 avg loss, 0.000104 rate, 7.549423 seconds, 17024 images, 1373.497002 hours left
Loaded: 0.000028 seconds

 533: 20.426945, 22.184740 avg loss, 0.000105 rate, 7.191308 seconds, 17056 images, 1370.246723 hours left
Loaded: 0.000029 seconds

 534: 23.018414, 22.268108 avg loss, 0.000106 rate, 7.340584 seconds, 17088 images, 1366.531575 hours left
Loaded: 0.000028 seconds

 535: 19.782074, 22.019505 avg loss, 0.000107 rate, 6.887709 seconds, 17120 images, 1363.060874 hours left
Loaded: 0.000027 seconds

 536: 21.073467, 21.924900 avg loss, 0.000107 rate, 7.142960 seconds, 17152 images, 1358.995910 hours left
Loaded: 0.000027 seconds

 537: 13.129409, 21.045351 avg loss, 0.000108 rate, 6.688548 seconds, 17184 images, 1355.326080 hours left
Loaded: 0.000028 seconds

 538: 13.539480, 20.294764 avg loss, 0.000109 rate, 6.629816 seconds, 17216 images, 1351.061833 hours left
Loaded: 0.000038 seconds

 539: 15.739989, 19.839287 avg loss, 0.000110 rate, 6.927153 seconds, 17248 images, 1346.758644 hours left
Loaded: 0.000029 seconds

 540: 20.895325, 19.944891 avg loss, 0.000111 rate, 7.318840 seconds, 17280 images, 1342.911418 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.442941 seconds - performance bottleneck on CPU or Disk HDD/SSD

 541: 23.960882, 20.346491 avg loss, 0.000111 rate, 5.243035 seconds, 17312 images, 1339.646599 hours left
Loaded: 0.000039 seconds

 542: 21.802399, 20.492081 avg loss, 0.000112 rate, 5.055253 seconds, 17344 images, 1334.146687 hours left
Loaded: 0.000036 seconds

 543: 22.353979, 20.678270 avg loss, 0.000113 rate, 5.138688 seconds, 17376 images, 1327.825883 hours left
Loaded: 0.000029 seconds

 544: 24.028135, 21.013256 avg loss, 0.000114 rate, 5.183284 seconds, 17408 images, 1321.684139 hours left
Loaded: 0.000028 seconds

 545: 16.343689, 20.546299 avg loss, 0.000115 rate, 4.976441 seconds, 17440 images, 1315.665722 hours left
Loaded: 0.000029 seconds

 546: 21.396540, 20.631323 avg loss, 0.000116 rate, 5.158041 seconds, 17472 images, 1309.420218 hours left
Loaded: 0.000032 seconds

 547: 25.979324, 21.166122 avg loss, 0.000116 rate, 5.458998 seconds, 17504 images, 1303.489355 hours left
Loaded: 0.000031 seconds

 548: 25.386271, 21.588137 avg loss, 0.000117 rate, 5.458249 seconds, 17536 images, 1298.035748 hours left
Loaded: 0.000030 seconds

 549: 23.536282, 21.782951 avg loss, 0.000118 rate, 5.290121 seconds, 17568 images, 1292.635621 hours left
Loaded: 0.000037 seconds

 550: 20.376703, 21.642326 avg loss, 0.000119 rate, 5.370834 seconds, 17600 images, 1287.055989 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 551: 22.668121, 21.744905 avg loss, 0.000120 rate, 15.808184 seconds, 17632 images, 1281.644239 hours left
Loaded: 0.000036 seconds

 552: 21.305855, 21.701000 avg loss, 0.000121 rate, 15.652066 seconds, 17664 images, 1290.781430 hours left
Loaded: 0.000035 seconds

 553: 24.195808, 21.950481 avg loss, 0.000122 rate, 16.243613 seconds, 17696 images, 1299.610400 hours left
Loaded: 0.000030 seconds

 554: 24.444626, 22.199896 avg loss, 0.000122 rate, 15.713567 seconds, 17728 images, 1309.172543 hours left
Loaded: 0.000030 seconds

 555: 14.169308, 21.396837 avg loss, 0.000123 rate, 14.189335 seconds, 17760 images, 1317.902915 hours left
Loaded: 0.000030 seconds

 556: 20.421669, 21.299320 avg loss, 0.000124 rate, 15.973743 seconds, 17792 images, 1324.429183 hours left
Loaded: 0.000030 seconds

 557: 27.296589, 21.899048 avg loss, 0.000125 rate, 17.440464 seconds, 17824 images, 1333.368216 hours left
Loaded: 0.000029 seconds

 558: 21.513653, 21.860508 avg loss, 0.000126 rate, 16.216755 seconds, 17856 images, 1344.254695 hours left
Loaded: 0.000032 seconds

 559: 13.019670, 20.976423 avg loss, 0.000127 rate, 14.608161 seconds, 17888 images, 1353.332861 hours left
Loaded: 0.000037 seconds

 560: 28.362598, 21.715040 avg loss, 0.000128 rate, 16.822765 seconds, 17920 images, 1360.086310 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.333956 seconds - performance bottleneck on CPU or Disk HDD/SSD

 561: 15.544153, 21.097952 avg loss, 0.000129 rate, 11.023068 seconds, 17952 images, 1369.847660 hours left
Loaded: 0.000027 seconds

 562: 24.202721, 21.408428 avg loss, 0.000130 rate, 12.190740 seconds, 17984 images, 1371.920917 hours left
Loaded: 0.000028 seconds

 563: 28.116814, 22.079268 avg loss, 0.000131 rate, 12.501351 seconds, 18016 images, 1375.131243 hours left
Loaded: 0.000036 seconds

 564: 19.165234, 21.787865 avg loss, 0.000132 rate, 12.018185 seconds, 18048 images, 1378.740781 hours left
Loaded: 0.000028 seconds

 565: 23.832823, 21.992361 avg loss, 0.000132 rate, 12.454249 seconds, 18080 images, 1381.643227 hours left
Loaded: 0.000030 seconds

 566: 17.188425, 21.511967 avg loss, 0.000133 rate, 11.638906 seconds, 18112 images, 1385.122169 hours left
Loaded: 0.000030 seconds

 567: 19.249369, 21.285707 avg loss, 0.000134 rate, 11.974086 seconds, 18144 images, 1387.434017 hours left
Loaded: 0.000029 seconds

 568: 19.218250, 21.078962 avg loss, 0.000135 rate, 12.139867 seconds, 18176 images, 1390.188182 hours left
Loaded: 0.000037 seconds

 569: 19.399794, 20.911045 avg loss, 0.000136 rate, 11.913696 seconds, 18208 images, 1393.144987 hours left
Loaded: 0.000029 seconds

 570: 22.266199, 21.046560 avg loss, 0.000137 rate, 12.222714 seconds, 18240 images, 1395.758119 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.529640 seconds - performance bottleneck on CPU or Disk HDD/SSD

 571: 24.803301, 21.422234 avg loss, 0.000138 rate, 13.041832 seconds, 18272 images, 1398.774207 hours left
Loaded: 0.000030 seconds

 572: 21.243120, 21.404322 avg loss, 0.000139 rate, 12.300552 seconds, 18304 images, 1403.633069 hours left
Loaded: 0.000028 seconds

 573: 25.836058, 21.847496 avg loss, 0.000140 rate, 12.500380 seconds, 18336 images, 1406.678434 hours left
Loaded: 0.000027 seconds

 574: 20.429672, 21.705713 avg loss, 0.000141 rate, 11.498835 seconds, 18368 images, 1409.970807 hours left
Loaded: 0.000027 seconds

 575: 16.059038, 21.141047 avg loss, 0.000142 rate, 11.055770 seconds, 18400 images, 1411.839389 hours left
Loaded: 0.000023 seconds

 576: 17.857359, 20.812677 avg loss, 0.000143 rate, 11.691489 seconds, 18432 images, 1413.073978 hours left
Loaded: 0.000030 seconds

 577: 20.934032, 20.824814 avg loss, 0.000144 rate, 12.094429 seconds, 18464 images, 1415.178997 hours left
Loaded: 0.000029 seconds

 578: 15.761300, 20.318462 avg loss, 0.000145 rate, 11.220873 seconds, 18496 images, 1417.822495 hours left
Loaded: 0.000027 seconds

 579: 19.707058, 20.257322 avg loss, 0.000146 rate, 11.604465 seconds, 18528 images, 1419.226437 hours left
Loaded: 0.000038 seconds

 580: 16.200653, 19.851656 avg loss, 0.000147 rate, 11.553063 seconds, 18560 images, 1421.149001 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.327664 seconds - performance bottleneck on CPU or Disk HDD/SSD

 581: 19.853741, 19.851864 avg loss, 0.000148 rate, 7.595819 seconds, 18592 images, 1422.980933 hours left
Loaded: 0.000027 seconds

 582: 14.977466, 19.364424 avg loss, 0.000149 rate, 7.335407 seconds, 18624 images, 1419.754192 hours left
Loaded: 0.000028 seconds

 583: 16.816320, 19.109613 avg loss, 0.000150 rate, 7.351808 seconds, 18656 images, 1415.743096 hours left
Loaded: 0.000030 seconds

 584: 19.951899, 19.193842 avg loss, 0.000151 rate, 7.391494 seconds, 18688 images, 1411.794867 hours left
Loaded: 0.000026 seconds

 585: 24.215508, 19.696009 avg loss, 0.000152 rate, 7.750456 seconds, 18720 images, 1407.941212 hours left
Loaded: 0.000025 seconds

 586: 14.764524, 19.202860 avg loss, 0.000153 rate, 7.182436 seconds, 18752 images, 1404.624538 hours left
Loaded: 0.000035 seconds

 587: 22.698593, 19.552433 avg loss, 0.000154 rate, 8.011177 seconds, 18784 images, 1400.552230 hours left
Loaded: 0.000032 seconds

 588: 13.216066, 18.918797 avg loss, 0.000155 rate, 7.235429 seconds, 18816 images, 1397.671468 hours left
Loaded: 0.000028 seconds

 589: 18.736881, 18.900604 avg loss, 0.000156 rate, 7.555249 seconds, 18848 images, 1393.742248 hours left
Loaded: 0.000027 seconds

 590: 21.472528, 19.157797 avg loss, 0.000158 rate, 7.783018 seconds, 18880 images, 1390.296410 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 591: 17.283730, 18.970390 avg loss, 0.000159 rate, 15.001407 seconds, 18912 images, 1387.201301 hours left
Loaded: 0.000030 seconds

 592: 21.991768, 19.272528 avg loss, 0.000160 rate, 15.977485 seconds, 18944 images, 1394.160832 hours left
Loaded: 0.000030 seconds

 593: 22.474560, 19.592731 avg loss, 0.000161 rate, 16.108287 seconds, 18976 images, 1402.406148 hours left
Loaded: 0.000031 seconds

 594: 24.094618, 20.042919 avg loss, 0.000162 rate, 16.550560 seconds, 19008 images, 1410.750602 hours left
Loaded: 0.000032 seconds

 595: 22.328283, 20.271456 avg loss, 0.000163 rate, 15.528050 seconds, 19040 images, 1419.625722 hours left
Loaded: 0.000029 seconds

 596: 16.236820, 19.867992 avg loss, 0.000164 rate, 14.534824 seconds, 19072 images, 1426.992161 hours left
Loaded: 0.000029 seconds

 597: 19.801138, 19.861307 avg loss, 0.000165 rate, 15.052665 seconds, 19104 images, 1432.905674 hours left
Loaded: 0.000037 seconds

 598: 21.271242, 20.002300 avg loss, 0.000166 rate, 15.320940 seconds, 19136 images, 1439.479093 hours left
Loaded: 0.000035 seconds

 599: 18.369123, 19.838982 avg loss, 0.000167 rate, 15.467956 seconds, 19168 images, 1446.359278 hours left
Loaded: 0.000028 seconds

 600: 22.735083, 20.128592 avg loss, 0.000168 rate, 16.049995 seconds, 19200 images, 1453.374767 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.346030 seconds - performance bottleneck on CPU or Disk HDD/SSD

 601: 16.312443, 19.746977 avg loss, 0.000170 rate, 5.457637 seconds, 19232 images, 1461.128270 hours left
Loaded: 0.000030 seconds

 602: 25.253746, 20.297653 avg loss, 0.000171 rate, 5.739229 seconds, 19264 images, 1454.576022 hours left
Loaded: 0.000037 seconds

 603: 24.843904, 20.752277 avg loss, 0.000172 rate, 5.788726 seconds, 19296 images, 1447.999842 hours left
Loaded: 0.000036 seconds

 604: 23.533636, 21.030413 avg loss, 0.000173 rate, 5.861874 seconds, 19328 images, 1441.558149 hours left
Loaded: 0.000037 seconds

 605: 27.313585, 21.658730 avg loss, 0.000174 rate, 5.833346 seconds, 19360 images, 1435.282430 hours left
Loaded: 0.000037 seconds

 606: 24.175522, 21.910408 avg loss, 0.000175 rate, 5.591321 seconds, 19392 images, 1429.029837 hours left
Loaded: 0.000038 seconds

 607: 25.217131, 22.241081 avg loss, 0.000176 rate, 5.695129 seconds, 19424 images, 1422.503682 hours left
Loaded: 0.000037 seconds

 608: 15.825791, 21.599552 avg loss, 0.000178 rate, 5.124957 seconds, 19456 images, 1416.186919 hours left
Loaded: 0.000038 seconds

 609: 17.605825, 21.200180 avg loss, 0.000179 rate, 5.333322 seconds, 19488 images, 1409.141573 hours left
Loaded: 0.000030 seconds

 610: 15.001820, 20.580343 avg loss, 0.000180 rate, 5.139104 seconds, 19520 images, 1402.456000 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 611: 29.366169, 21.458925 avg loss, 0.000181 rate, 9.178920 seconds, 19552 images, 1395.567568 hours left
Loaded: 0.000029 seconds

 612: 22.552355, 21.568268 avg loss, 0.000182 rate, 8.796900 seconds, 19584 images, 1394.357611 hours left
Loaded: 0.000032 seconds

 613: 21.505970, 21.562038 avg loss, 0.000184 rate, 8.868295 seconds, 19616 images, 1392.629269 hours left
Loaded: 0.000029 seconds

 614: 19.204222, 21.326258 avg loss, 0.000185 rate, 8.469845 seconds, 19648 images, 1391.017327 hours left
Loaded: 0.000031 seconds

 615: 21.702404, 21.363873 avg loss, 0.000186 rate, 8.780056 seconds, 19680 images, 1388.868199 hours left
Loaded: 0.000029 seconds

 616: 13.776505, 20.605135 avg loss, 0.000187 rate, 8.105638 seconds, 19712 images, 1387.171293 hours left
Loaded: 0.000038 seconds

 617: 23.332838, 20.877905 avg loss, 0.000188 rate, 9.004266 seconds, 19744 images, 1384.554853 hours left
Loaded: 0.000036 seconds

 618: 13.956402, 20.185755 avg loss, 0.000190 rate, 8.145945 seconds, 19776 images, 1383.212369 hours left
Loaded: 0.000040 seconds

 619: 20.996059, 20.266785 avg loss, 0.000191 rate, 8.922781 seconds, 19808 images, 1380.691452 hours left
Loaded: 0.000030 seconds

 620: 23.518127, 20.591919 avg loss, 0.000192 rate, 9.286548 seconds, 19840 images, 1379.274407 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.490885 seconds - performance bottleneck on CPU or Disk HDD/SSD

 621: 22.386875, 20.771414 avg loss, 0.000193 rate, 7.914069 seconds, 19872 images, 1378.376615 hours left
Loaded: 0.000030 seconds

 622: 23.388479, 21.033121 avg loss, 0.000195 rate, 8.170222 seconds, 19904 images, 1376.263585 hours left
Loaded: 0.000028 seconds

 623: 20.794271, 21.009235 avg loss, 0.000196 rate, 8.187875 seconds, 19936 images, 1373.845766 hours left
Loaded: 0.000031 seconds

 624: 26.673529, 21.575665 avg loss, 0.000197 rate, 8.256461 seconds, 19968 images, 1371.476612 hours left
Loaded: 0.000030 seconds

 625: 18.164856, 21.234583 avg loss, 0.000198 rate, 7.684498 seconds, 20000 images, 1369.226366 hours left
Loaded: 0.000037 seconds

 626: 20.304829, 21.141607 avg loss, 0.000200 rate, 7.949899 seconds, 20032 images, 1366.204412 hours left
Loaded: 0.000032 seconds

 627: 19.306261, 20.958073 avg loss, 0.000201 rate, 7.884509 seconds, 20064 images, 1363.581179 hours left
Loaded: 0.000025 seconds

 628: 19.496035, 20.811869 avg loss, 0.000202 rate, 7.969328 seconds, 20096 images, 1360.893351 hours left
Loaded: 0.000039 seconds

 629: 26.103977, 21.341080 avg loss, 0.000203 rate, 8.735021 seconds, 20128 images, 1358.350144 hours left
Loaded: 0.000038 seconds

 630: 21.209305, 21.327902 avg loss, 0.000205 rate, 8.182353 seconds, 20160 images, 1356.895554 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.438294 seconds - performance bottleneck on CPU or Disk HDD/SSD

 631: 19.820393, 21.177151 avg loss, 0.000206 rate, 6.073328 seconds, 20192 images, 1354.688090 hours left
Loaded: 0.000028 seconds

 632: 16.686918, 20.728127 avg loss, 0.000207 rate, 5.904997 seconds, 20224 images, 1350.182771 hours left
Loaded: 0.000028 seconds

 633: 27.333208, 21.388636 avg loss, 0.000209 rate, 6.396946 seconds, 20256 images, 1344.880215 hours left
Loaded: 0.000037 seconds

 634: 17.451008, 20.994873 avg loss, 0.000210 rate, 5.953098 seconds, 20288 images, 1340.313748 hours left
Loaded: 0.000030 seconds

 635: 24.799160, 21.375301 avg loss, 0.000211 rate, 6.496554 seconds, 20320 images, 1335.176663 hours left
Loaded: 0.000027 seconds

 636: 28.937868, 22.131557 avg loss, 0.000213 rate, 6.578815 seconds, 20352 images, 1330.845506 hours left
Loaded: 0.000026 seconds

 637: 17.274900, 21.645891 avg loss, 0.000214 rate, 6.279395 seconds, 20384 images, 1326.671859 hours left
Loaded: 0.000033 seconds

 638: 23.874205, 21.868723 avg loss, 0.000215 rate, 6.690319 seconds, 20416 images, 1322.124182 hours left
Loaded: 0.000028 seconds

 639: 21.770054, 21.858856 avg loss, 0.000217 rate, 6.362117 seconds, 20448 images, 1318.192544 hours left
Loaded: 0.000038 seconds

 640: 21.521555, 21.825127 avg loss, 0.000218 rate, 6.601841 seconds, 20480 images, 1313.844488 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 641: 20.729071, 21.715521 avg loss, 0.000219 rate, 12.740387 seconds, 20512 images, 1309.872765 hours left
Loaded: 0.000030 seconds

 642: 28.598900, 22.403858 avg loss, 0.000221 rate, 13.371014 seconds, 20544 images, 1314.464080 hours left
Loaded: 0.000033 seconds

 643: 18.892473, 22.052719 avg loss, 0.000222 rate, 12.055999 seconds, 20576 images, 1319.885082 hours left
Loaded: 0.000028 seconds

 644: 22.668110, 22.114258 avg loss, 0.000224 rate, 13.432007 seconds, 20608 images, 1323.425944 hours left
Loaded: 0.000029 seconds

 645: 18.342707, 21.737103 avg loss, 0.000225 rate, 12.632782 seconds, 20640 images, 1328.841930 hours left
Loaded: 0.000038 seconds

 646: 24.962439, 22.059635 avg loss, 0.000226 rate, 13.350948 seconds, 20672 images, 1333.094007 hours left
Loaded: 0.000029 seconds

 647: 13.574438, 21.211115 avg loss, 0.000228 rate, 11.375226 seconds, 20704 images, 1338.300702 hours left
Loaded: 0.000032 seconds

 648: 17.368734, 20.826878 avg loss, 0.000229 rate, 11.975196 seconds, 20736 images, 1340.712029 hours left
Loaded: 0.000024 seconds

 649: 27.544420, 21.498632 avg loss, 0.000231 rate, 13.263466 seconds, 20768 images, 1343.932262 hours left
Loaded: 0.000027 seconds

 650: 20.488241, 21.397593 avg loss, 0.000232 rate, 12.589475 seconds, 20800 images, 1348.908977 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.108338 seconds - performance bottleneck on CPU or Disk HDD/SSD

 651: 28.053858, 22.063219 avg loss, 0.000233 rate, 15.222416 seconds, 20832 images, 1352.900075 hours left
Loaded: 0.000029 seconds

 652: 25.323032, 22.389200 avg loss, 0.000235 rate, 14.713995 seconds, 20864 images, 1360.657373 hours left
Loaded: 0.000029 seconds

 653: 20.714930, 22.221773 avg loss, 0.000236 rate, 12.936152 seconds, 20896 images, 1367.480745 hours left
Loaded: 0.000032 seconds

 654: 17.147532, 21.714350 avg loss, 0.000238 rate, 12.630394 seconds, 20928 images, 1371.767372 hours left
Loaded: 0.000028 seconds

 655: 16.022375, 21.145153 avg loss, 0.000239 rate, 12.338174 seconds, 20960 images, 1375.586567 hours left
Loaded: 0.000028 seconds

 656: 18.033018, 20.833939 avg loss, 0.000241 rate, 12.848252 seconds, 20992 images, 1378.961794 hours left
Loaded: 0.000023 seconds

 657: 24.159288, 21.166473 avg loss, 0.000242 rate, 13.904014 seconds, 21024 images, 1383.011456 hours left
Loaded: 0.000028 seconds

 658: 22.493843, 21.299210 avg loss, 0.000244 rate, 13.582504 seconds, 21056 images, 1388.486452 hours left
Loaded: 0.000031 seconds

 659: 25.709370, 21.740225 avg loss, 0.000245 rate, 14.235994 seconds, 21088 images, 1393.460271 hours left
Loaded: 0.000026 seconds

 660: 22.246143, 21.790817 avg loss, 0.000247 rate, 13.615076 seconds, 21120 images, 1399.291651 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.410459 seconds - performance bottleneck on CPU or Disk HDD/SSD

 661: 20.315517, 21.643288 avg loss, 0.000248 rate, 7.474766 seconds, 21152 images, 1404.202561 hours left
Loaded: 0.000031 seconds

 662: 20.652147, 21.544174 avg loss, 0.000250 rate, 7.523293 seconds, 21184 images, 1401.108738 hours left
Loaded: 0.000029 seconds

 663: 22.511900, 21.640947 avg loss, 0.000251 rate, 7.716683 seconds, 21216 images, 1397.543342 hours left
Loaded: 0.000037 seconds

 664: 18.949453, 21.371798 avg loss, 0.000253 rate, 7.297411 seconds, 21248 images, 1394.282082 hours left
Loaded: 0.000036 seconds

 665: 10.917226, 20.326340 avg loss, 0.000254 rate, 6.520994 seconds, 21280 images, 1390.471295 hours left
Loaded: 0.000028 seconds

 666: 22.644880, 20.558193 avg loss, 0.000256 rate, 7.529829 seconds, 21312 images, 1385.620594 hours left
Loaded: 0.000040 seconds

 667: 14.998119, 20.002186 avg loss, 0.000257 rate, 7.033029 seconds, 21344 images, 1382.219064 hours left
Loaded: 0.000031 seconds

 668: 26.323223, 20.634289 avg loss, 0.000259 rate, 8.010859 seconds, 21376 images, 1378.161776 hours left
Loaded: 0.000029 seconds

 669: 28.838226, 21.454683 avg loss, 0.000260 rate, 8.140959 seconds, 21408 images, 1375.502669 hours left
Loaded: 0.000025 seconds

 670: 23.654825, 21.674698 avg loss, 0.000262 rate, 7.476018 seconds, 21440 images, 1373.050765 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.462857 seconds - performance bottleneck on CPU or Disk HDD/SSD

 671: 24.937212, 22.000950 avg loss, 0.000264 rate, 6.751768 seconds, 21472 images, 1369.700134 hours left
Loaded: 0.000029 seconds

 672: 20.761087, 21.876965 avg loss, 0.000265 rate, 6.767204 seconds, 21504 images, 1366.020030 hours left
Loaded: 0.000040 seconds

 673: 22.259470, 21.915215 avg loss, 0.000267 rate, 6.787211 seconds, 21536 images, 1361.755547 hours left
Loaded: 0.000031 seconds

 674: 20.433796, 21.767073 avg loss, 0.000268 rate, 6.539282 seconds, 21568 images, 1357.561482 hours left
Loaded: 0.000031 seconds

 675: 17.599815, 21.350348 avg loss, 0.000270 rate, 6.412765 seconds, 21600 images, 1353.065100 hours left
Loaded: 0.000028 seconds

 676: 19.400631, 21.155376 avg loss, 0.000271 rate, 6.521326 seconds, 21632 images, 1348.438007 hours left
Loaded: 0.000030 seconds

 677: 20.093241, 21.049164 avg loss, 0.000273 rate, 6.357930 seconds, 21664 images, 1344.007891 hours left
Loaded: 0.000032 seconds

 678: 16.058619, 20.550110 avg loss, 0.000275 rate, 6.129410 seconds, 21696 images, 1339.395199 hours left
Loaded: 0.000039 seconds

 679: 20.854877, 20.580587 avg loss, 0.000276 rate, 6.624586 seconds, 21728 images, 1334.511345 hours left
Loaded: 0.000030 seconds

 680: 24.085409, 20.931070 avg loss, 0.000278 rate, 6.934070 seconds, 21760 images, 1330.363821 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000037 seconds

 681: 18.369448, 20.674908 avg loss, 0.000280 rate, 12.453304 seconds, 21792 images, 1326.687423 hours left
Loaded: 0.000038 seconds

 682: 20.149521, 20.622370 avg loss, 0.000281 rate, 11.973578 seconds, 21824 images, 1330.710608 hours left
Loaded: 0.000028 seconds

 683: 26.725557, 21.232689 avg loss, 0.000283 rate, 13.008554 seconds, 21856 images, 1334.027483 hours left
Loaded: 0.000028 seconds

 684: 22.537121, 21.363132 avg loss, 0.000285 rate, 12.395167 seconds, 21888 images, 1338.748081 hours left
Loaded: 0.000026 seconds

 685: 18.708576, 21.097677 avg loss, 0.000286 rate, 11.856757 seconds, 21920 images, 1342.569826 hours left
Loaded: 0.000037 seconds

 686: 26.282717, 21.616180 avg loss, 0.000288 rate, 12.856634 seconds, 21952 images, 1345.605801 hours left
Loaded: 0.000022 seconds

 687: 23.694193, 21.823982 avg loss, 0.000290 rate, 12.306746 seconds, 21984 images, 1349.999602 hours left
Loaded: 0.000027 seconds

 688: 20.158005, 21.657385 avg loss, 0.000291 rate, 12.093807 seconds, 22016 images, 1353.585959 hours left
Loaded: 0.000027 seconds

 689: 18.802946, 21.371941 avg loss, 0.000293 rate, 11.686472 seconds, 22048 images, 1356.840786 hours left
Loaded: 0.000027 seconds

 690: 22.560001, 21.490747 avg loss, 0.000295 rate, 12.147734 seconds, 22080 images, 1359.497504 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.497506 seconds - performance bottleneck on CPU or Disk HDD/SSD

 691: 15.319481, 20.873621 avg loss, 0.000296 rate, 11.054094 seconds, 22112 images, 1362.768031 hours left
Loaded: 0.000033 seconds

 692: 12.290628, 20.015322 avg loss, 0.000298 rate, 10.731388 seconds, 22144 images, 1365.178124 hours left
Loaded: 0.000028 seconds

 693: 13.569133, 19.370703 avg loss, 0.000300 rate, 11.110171 seconds, 22176 images, 1366.425383 hours left
Loaded: 0.000027 seconds

 694: 16.353888, 19.069021 avg loss, 0.000302 rate, 11.332288 seconds, 22208 images, 1368.186025 hours left
Loaded: 0.000026 seconds

 695: 21.264671, 19.288586 avg loss, 0.000303 rate, 12.087130 seconds, 22240 images, 1370.237399 hours left
Loaded: 0.000026 seconds

 696: 19.252058, 19.284933 avg loss, 0.000305 rate, 11.456687 seconds, 22272 images, 1373.316207 hours left
Loaded: 0.000032 seconds

 697: 14.765551, 18.832994 avg loss, 0.000307 rate, 11.421672 seconds, 22304 images, 1375.488921 hours left
Loaded: 0.000023 seconds

 698: 24.554865, 19.405182 avg loss, 0.000309 rate, 12.173548 seconds, 22336 images, 1377.591272 hours left
Loaded: 0.000026 seconds

 699: 15.819342, 19.046598 avg loss, 0.000310 rate, 11.105131 seconds, 22368 images, 1380.716415 hours left
Loaded: 0.000031 seconds

 700: 15.648455, 18.706783 avg loss, 0.000312 rate, 11.146725 seconds, 22400 images, 1382.326954 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.229560 seconds - performance bottleneck on CPU or Disk HDD/SSD

 701: 13.181457, 18.154251 avg loss, 0.000314 rate, 5.125528 seconds, 22432 images, 1383.979110 hours left
Loaded: 0.000024 seconds

 702: 18.956169, 18.234444 avg loss, 0.000316 rate, 5.405306 seconds, 22464 images, 1377.573964 hours left
Loaded: 0.000028 seconds

 703: 22.311863, 18.642185 avg loss, 0.000318 rate, 5.782714 seconds, 22496 images, 1371.302606 hours left
Loaded: 0.000028 seconds

 704: 21.280476, 18.906013 avg loss, 0.000319 rate, 5.591274 seconds, 22528 images, 1365.617918 hours left
Loaded: 0.000029 seconds

 705: 30.206959, 20.036108 avg loss, 0.000321 rate, 6.240939 seconds, 22560 images, 1359.724282 hours left
Loaded: 0.000028 seconds

 706: 20.276913, 20.060188 avg loss, 0.000323 rate, 5.559295 seconds, 22592 images, 1354.791509 hours left
Loaded: 0.000039 seconds

 707: 20.917339, 20.145903 avg loss, 0.000325 rate, 5.644996 seconds, 22624 images, 1348.961707 hours left
Loaded: 0.000036 seconds

 708: 23.836565, 20.514969 avg loss, 0.000327 rate, 5.813414 seconds, 22656 images, 1343.309184 hours left
Loaded: 0.000032 seconds

 709: 31.181372, 21.581610 avg loss, 0.000328 rate, 6.778014 seconds, 22688 images, 1337.946985 hours left
Loaded: 0.000030 seconds

 710: 25.157551, 21.939203 avg loss, 0.000330 rate, 6.454956 seconds, 22720 images, 1333.977548 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.028568 seconds

 711: 18.487349, 21.594017 avg loss, 0.000332 rate, 6.342082 seconds, 22752 images, 1329.599279 hours left
Loaded: 0.000029 seconds

 712: 19.804256, 21.415041 avg loss, 0.000334 rate, 6.437302 seconds, 22784 images, 1325.147691 hours left
Loaded: 0.000030 seconds

 713: 20.282394, 21.301777 avg loss, 0.000336 rate, 6.398039 seconds, 22816 images, 1320.833178 hours left
Loaded: 0.000031 seconds

 714: 11.905465, 20.362146 avg loss, 0.000338 rate, 5.852639 seconds, 22848 images, 1316.507281 hours left
Loaded: 0.000031 seconds

 715: 24.320576, 20.757990 avg loss, 0.000340 rate, 6.934906 seconds, 22880 images, 1311.467452 hours left
Loaded: 0.000042 seconds

 716: 21.451147, 20.827305 avg loss, 0.000342 rate, 6.665126 seconds, 22912 images, 1307.980506 hours left
Loaded: 0.000038 seconds

 717: 20.206808, 20.765255 avg loss, 0.000344 rate, 6.446762 seconds, 22944 images, 1304.153894 hours left
Loaded: 0.000032 seconds

 718: 12.411417, 19.929871 avg loss, 0.000345 rate, 5.738874 seconds, 22976 images, 1300.062383 hours left
Loaded: 0.000033 seconds

 719: 16.672596, 19.604143 avg loss, 0.000347 rate, 6.270512 seconds, 23008 images, 1295.029001 hours left
Loaded: 0.000040 seconds

 720: 21.362801, 19.780008 avg loss, 0.000349 rate, 6.802871 seconds, 23040 images, 1290.784000 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.048549 seconds

 721: 24.212992, 20.223307 avg loss, 0.000351 rate, 12.270374 seconds, 23072 images, 1287.320504 hours left
Loaded: 0.000030 seconds

 722: 25.459492, 20.746925 avg loss, 0.000353 rate, 12.428870 seconds, 23104 images, 1291.549366 hours left
Loaded: 0.000029 seconds

 723: 23.658825, 21.038115 avg loss, 0.000355 rate, 11.939496 seconds, 23136 images, 1295.888584 hours left
Loaded: 0.000046 seconds

 724: 20.142258, 20.948528 avg loss, 0.000357 rate, 11.288825 seconds, 23168 images, 1299.504990 hours left
Loaded: 0.000037 seconds

 725: 22.660505, 21.119726 avg loss, 0.000359 rate, 11.451004 seconds, 23200 images, 1302.181917 hours left
Loaded: 0.000037 seconds

 726: 23.720287, 21.379782 avg loss, 0.000361 rate, 11.678958 seconds, 23232 images, 1305.057179 hours left
Loaded: 0.000033 seconds

 727: 17.659893, 21.007793 avg loss, 0.000363 rate, 10.772658 seconds, 23264 images, 1308.220115 hours left
Loaded: 0.000029 seconds

 728: 20.776999, 20.984715 avg loss, 0.000365 rate, 11.437765 seconds, 23296 images, 1310.093206 hours left
Loaded: 0.000029 seconds

 729: 22.870457, 21.173288 avg loss, 0.000367 rate, 11.558728 seconds, 23328 images, 1312.870869 hours left
Loaded: 0.000028 seconds

 730: 21.218420, 21.177801 avg loss, 0.000369 rate, 11.316387 seconds, 23360 images, 1315.788652 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.282330 seconds - performance bottleneck on CPU or Disk HDD/SSD

 731: 13.262851, 20.386307 avg loss, 0.000371 rate, 8.293521 seconds, 23392 images, 1318.340794 hours left
Loaded: 0.000029 seconds

 732: 18.406395, 20.188316 avg loss, 0.000373 rate, 9.062547 seconds, 23424 images, 1317.062801 hours left
Loaded: 0.000030 seconds

 733: 20.824347, 20.251919 avg loss, 0.000375 rate, 9.287966 seconds, 23456 images, 1316.473258 hours left
Loaded: 0.000030 seconds

 734: 24.524670, 20.679193 avg loss, 0.000377 rate, 9.690593 seconds, 23488 images, 1316.202522 hours left
Loaded: 0.000031 seconds

 735: 28.440878, 21.455362 avg loss, 0.000379 rate, 9.946652 seconds, 23520 images, 1316.493411 hours left
Loaded: 0.000029 seconds

 736: 26.834366, 21.993263 avg loss, 0.000381 rate, 9.788921 seconds, 23552 images, 1317.136835 hours left
Loaded: 0.000024 seconds

 737: 18.715494, 21.665485 avg loss, 0.000384 rate, 8.612092 seconds, 23584 images, 1317.554826 hours left
Loaded: 0.000031 seconds

 738: 21.373831, 21.636320 avg loss, 0.000386 rate, 9.010247 seconds, 23616 images, 1316.334894 hours left
Loaded: 0.000025 seconds

 739: 22.987051, 21.771393 avg loss, 0.000388 rate, 9.149176 seconds, 23648 images, 1315.679877 hours left
Loaded: 0.000028 seconds

 740: 18.132856, 21.407539 avg loss, 0.000390 rate, 8.502949 seconds, 23680 images, 1315.224242 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.025987 seconds

 741: 19.507565, 21.217543 avg loss, 0.000392 rate, 11.563131 seconds, 23712 images, 1313.876035 hours left
Loaded: 0.000028 seconds

 742: 19.961111, 21.091900 avg loss, 0.000394 rate, 11.746044 seconds, 23744 images, 1316.825526 hours left
Loaded: 0.000028 seconds

 743: 21.286003, 21.111311 avg loss, 0.000396 rate, 12.022639 seconds, 23776 images, 1319.963377 hours left
Loaded: 0.000026 seconds

 744: 16.939432, 20.694122 avg loss, 0.000398 rate, 11.215558 seconds, 23808 images, 1323.453791 hours left
Loaded: 0.000029 seconds

 745: 15.775943, 20.202305 avg loss, 0.000400 rate, 11.161412 seconds, 23840 images, 1325.788865 hours left
Loaded: 0.000031 seconds

 746: 12.964977, 19.478573 avg loss, 0.000403 rate, 10.922392 seconds, 23872 images, 1328.025408 hours left
Loaded: 0.000028 seconds

 747: 22.299551, 19.760670 avg loss, 0.000405 rate, 12.206762 seconds, 23904 images, 1329.907736 hours left
Loaded: 0.000030 seconds

 748: 22.525179, 20.037121 avg loss, 0.000407 rate, 12.279333 seconds, 23936 images, 1333.554173 hours left
Loaded: 0.000027 seconds

 749: 23.414860, 20.374895 avg loss, 0.000409 rate, 12.264825 seconds, 23968 images, 1337.264857 hours left
Loaded: 0.000030 seconds

 750: 22.984947, 20.635900 avg loss, 0.000411 rate, 12.165179 seconds, 24000 images, 1340.918254 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.169408 seconds - performance bottleneck on CPU or Disk HDD/SSD

 751: 27.694496, 21.341761 avg loss, 0.000414 rate, 17.135681 seconds, 24032 images, 1344.396761 hours left
Loaded: 0.000031 seconds

 752: 24.523590, 21.659943 avg loss, 0.000416 rate, 16.434803 seconds, 24064 images, 1354.975588 hours left
Loaded: 0.000029 seconds

 753: 19.295444, 21.423492 avg loss, 0.000418 rate, 15.347358 seconds, 24096 images, 1364.240499 hours left
Loaded: 0.000030 seconds

 754: 19.590664, 21.240210 avg loss, 0.000420 rate, 15.175829 seconds, 24128 images, 1371.903138 hours left
Loaded: 0.000027 seconds

 755: 12.143732, 20.330563 avg loss, 0.000422 rate, 14.188680 seconds, 24160 images, 1379.250995 hours left
Loaded: 0.000023 seconds

 756: 20.750784, 20.372585 avg loss, 0.000425 rate, 15.626200 seconds, 24192 images, 1385.154986 hours left
Loaded: 0.000025 seconds

 757: 20.858545, 20.421181 avg loss, 0.000427 rate, 15.705425 seconds, 24224 images, 1392.995425 hours left
Loaded: 0.000032 seconds

 758: 13.600779, 19.739140 avg loss, 0.000429 rate, 14.171665 seconds, 24256 images, 1400.867397 hours left
Loaded: 0.000026 seconds

 759: 21.638496, 19.929075 avg loss, 0.000431 rate, 15.904743 seconds, 24288 images, 1406.531492 hours left
Loaded: 0.000028 seconds

 760: 21.943024, 20.130470 avg loss, 0.000434 rate, 16.079539 seconds, 24320 images, 1414.544705 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.349561 seconds - performance bottleneck on CPU or Disk HDD/SSD

 761: 20.969744, 20.214397 avg loss, 0.000436 rate, 7.441095 seconds, 24352 images, 1422.720391 hours left
Loaded: 0.000033 seconds

 762: 17.168871, 19.909845 avg loss, 0.000438 rate, 6.756920 seconds, 24384 images, 1419.307908 hours left
Loaded: 0.000026 seconds

 763: 20.937439, 20.012606 avg loss, 0.000441 rate, 7.123143 seconds, 24416 images, 1414.494579 hours left
Loaded: 0.000028 seconds

 764: 22.295740, 20.240919 avg loss, 0.000443 rate, 7.052061 seconds, 24448 images, 1410.237731 hours left
Loaded: 0.000027 seconds

 765: 21.589911, 20.375818 avg loss, 0.000445 rate, 6.882790 seconds, 24480 images, 1405.924762 hours left
Loaded: 0.000027 seconds

 766: 21.652651, 20.503502 avg loss, 0.000448 rate, 7.056688 seconds, 24512 images, 1401.419929 hours left
Loaded: 0.000030 seconds

 767: 24.151192, 20.868271 avg loss, 0.000450 rate, 7.506410 seconds, 24544 images, 1397.201522 hours left
Loaded: 0.000029 seconds

 768: 19.813559, 20.762800 avg loss, 0.000452 rate, 6.991226 seconds, 24576 images, 1393.649563 hours left
Loaded: 0.000030 seconds

 769: 16.943781, 20.380898 avg loss, 0.000455 rate, 6.742360 seconds, 24608 images, 1389.417952 hours left
Loaded: 0.000038 seconds

 770: 20.722460, 20.415054 avg loss, 0.000457 rate, 7.093953 seconds, 24640 images, 1384.883177 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000032 seconds

 771: 23.922747, 20.765823 avg loss, 0.000459 rate, 14.575288 seconds, 24672 images, 1380.881802 hours left
Loaded: 0.000028 seconds

 772: 20.831106, 20.772352 avg loss, 0.000462 rate, 14.060612 seconds, 24704 images, 1387.305526 hours left
Loaded: 0.000027 seconds

 773: 20.027365, 20.697853 avg loss, 0.000464 rate, 13.994779 seconds, 24736 images, 1392.950539 hours left
Loaded: 0.000042 seconds

 774: 19.750046, 20.603073 avg loss, 0.000467 rate, 14.104732 seconds, 24768 images, 1398.447666 hours left
Loaded: 0.000033 seconds

 775: 15.894613, 20.132227 avg loss, 0.000469 rate, 13.864877 seconds, 24800 images, 1404.042432 hours left
Loaded: 0.000035 seconds

 776: 14.391275, 19.558132 avg loss, 0.000471 rate, 13.516806 seconds, 24832 images, 1409.248250 hours left
Loaded: 0.000029 seconds

 777: 15.434551, 19.145775 avg loss, 0.000474 rate, 13.831919 seconds, 24864 images, 1413.918809 hours left
Loaded: 0.000031 seconds

 778: 28.132187, 20.044416 avg loss, 0.000476 rate, 16.133078 seconds, 24896 images, 1418.980030 hours left
Loaded: 0.000027 seconds

 779: 24.182821, 20.458258 avg loss, 0.000479 rate, 15.637015 seconds, 24928 images, 1427.184881 hours left
Loaded: 0.000040 seconds

 780: 25.599844, 20.972416 avg loss, 0.000481 rate, 15.629588 seconds, 24960 images, 1434.619040 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.006837 seconds

 781: 14.108739, 20.286049 avg loss, 0.000484 rate, 9.290370 seconds, 24992 images, 1441.968524 hours left
Loaded: 0.000029 seconds

 782: 20.475651, 20.305010 avg loss, 0.000486 rate, 10.193586 seconds, 25024 images, 1440.454383 hours left
Loaded: 0.000029 seconds

 783: 14.191261, 19.693636 avg loss, 0.000489 rate, 9.368501 seconds, 25056 images, 1440.199666 hours left
Loaded: 0.000030 seconds

 784: 22.146772, 19.938950 avg loss, 0.000491 rate, 10.313315 seconds, 25088 images, 1438.802166 hours left
Loaded: 0.000029 seconds

 785: 21.205124, 20.065567 avg loss, 0.000494 rate, 9.882021 seconds, 25120 images, 1438.730113 hours left
Loaded: 0.000038 seconds

 786: 16.180542, 19.677065 avg loss, 0.000496 rate, 9.310606 seconds, 25152 images, 1438.060070 hours left
Loaded: 0.000037 seconds

 787: 17.769436, 19.486301 avg loss, 0.000499 rate, 9.552250 seconds, 25184 images, 1436.603535 hours left
Loaded: 0.000034 seconds

 788: 15.728921, 19.110563 avg loss, 0.000501 rate, 9.552711 seconds, 25216 images, 1435.496965 hours left
Loaded: 0.000029 seconds

 789: 25.609383, 19.760445 avg loss, 0.000504 rate, 10.556109 seconds, 25248 images, 1434.402068 hours left
Loaded: 0.000029 seconds

 790: 23.480656, 20.132465 avg loss, 0.000506 rate, 10.616243 seconds, 25280 images, 1434.710890 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.532560 seconds - performance bottleneck on CPU or Disk HDD/SSD

 791: 22.129854, 20.332205 avg loss, 0.000509 rate, 10.126044 seconds, 25312 images, 1435.100066 hours left
Loaded: 0.000033 seconds

 792: 20.672066, 20.366192 avg loss, 0.000511 rate, 9.665156 seconds, 25344 images, 1435.544080 hours left
Loaded: 0.000027 seconds

 793: 22.791466, 20.608719 avg loss, 0.000514 rate, 9.849858 seconds, 25376 images, 1434.604686 hours left
Loaded: 0.000026 seconds

 794: 16.720655, 20.219913 avg loss, 0.000517 rate, 10.112742 seconds, 25408 images, 1433.931031 hours left
Loaded: 0.000034 seconds

 795: 28.278635, 21.025785 avg loss, 0.000519 rate, 11.354578 seconds, 25440 images, 1433.628988 hours left
Loaded: 0.000031 seconds

 796: 21.726088, 21.095816 avg loss, 0.000522 rate, 10.393510 seconds, 25472 images, 1435.053703 hours left
Loaded: 0.000038 seconds

 797: 20.687326, 21.054966 avg loss, 0.000525 rate, 10.322564 seconds, 25504 images, 1435.130108 hours left
Loaded: 0.000038 seconds

 798: 21.082434, 21.057713 avg loss, 0.000527 rate, 10.489936 seconds, 25536 images, 1435.107253 hours left
Loaded: 0.000037 seconds

 799: 19.763666, 20.928308 avg loss, 0.000530 rate, 10.422458 seconds, 25568 images, 1435.316919 hours left
Loaded: 0.000030 seconds

 800: 20.384153, 20.873894 avg loss, 0.000532 rate, 10.591675 seconds, 25600 images, 1435.430795 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.043209 seconds

 801: 24.276876, 21.214191 avg loss, 0.000535 rate, 13.463938 seconds, 25632 images, 1435.778388 hours left
Loaded: 0.000034 seconds

 802: 14.633767, 20.556149 avg loss, 0.000538 rate, 12.352802 seconds, 25664 images, 1440.169251 hours left
Loaded: 0.000030 seconds

 803: 13.454405, 19.845974 avg loss, 0.000541 rate, 12.901159 seconds, 25696 images, 1442.913928 hours left
Loaded: 0.000029 seconds

 804: 21.172091, 19.978586 avg loss, 0.000543 rate, 13.512711 seconds, 25728 images, 1446.392263 hours left
Loaded: 0.000028 seconds

 805: 21.615993, 20.142326 avg loss, 0.000546 rate, 13.286778 seconds, 25760 images, 1450.684638 hours left
Loaded: 0.000023 seconds

 806: 19.980371, 20.126131 avg loss, 0.000549 rate, 13.314048 seconds, 25792 images, 1454.620445 hours left
Loaded: 0.000027 seconds

 807: 17.252872, 19.838806 avg loss, 0.000551 rate, 12.687178 seconds, 25824 images, 1458.554701 hours left
Loaded: 0.000031 seconds

 808: 20.004662, 19.855392 avg loss, 0.000554 rate, 13.628085 seconds, 25856 images, 1461.579467 hours left
Loaded: 0.000029 seconds

 809: 17.455435, 19.615396 avg loss, 0.000557 rate, 12.869808 seconds, 25888 images, 1465.879967 hours left
Loaded: 0.000027 seconds

 810: 21.204573, 19.774315 avg loss, 0.000560 rate, 13.593035 seconds, 25920 images, 1469.084909 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.525018 seconds - performance bottleneck on CPU or Disk HDD/SSD

 811: 25.477255, 20.344608 avg loss, 0.000562 rate, 8.308440 seconds, 25952 images, 1473.261622 hours left
Loaded: 0.000028 seconds

 812: 15.105633, 19.820711 avg loss, 0.000565 rate, 7.139161 seconds, 25984 images, 1470.790079 hours left
Loaded: 0.000026 seconds

 813: 20.170307, 19.855671 avg loss, 0.000568 rate, 8.108748 seconds, 26016 images, 1465.991545 hours left
Loaded: 0.000034 seconds

 814: 30.187456, 20.888849 avg loss, 0.000571 rate, 8.371456 seconds, 26048 images, 1462.586776 hours left
Loaded: 0.000026 seconds

 815: 19.221085, 20.722073 avg loss, 0.000574 rate, 7.397261 seconds, 26080 images, 1459.580689 hours left
Loaded: 0.000025 seconds

 816: 17.572760, 20.407141 avg loss, 0.000576 rate, 7.369054 seconds, 26112 images, 1455.252430 hours left
Loaded: 0.000034 seconds

 817: 18.425161, 20.208942 avg loss, 0.000579 rate, 7.406538 seconds, 26144 images, 1450.928282 hours left
Loaded: 0.000048 seconds

 818: 22.320356, 20.420084 avg loss, 0.000582 rate, 7.920190 seconds, 26176 images, 1446.699393 hours left
Loaded: 0.000034 seconds

 819: 19.969345, 20.375010 avg loss, 0.000585 rate, 7.770391 seconds, 26208 images, 1443.225746 hours left
Loaded: 0.000033 seconds

 820: 14.768103, 19.814320 avg loss, 0.000588 rate, 7.295868 seconds, 26240 images, 1439.578871 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 821: 22.626320, 20.095520 avg loss, 0.000591 rate, 9.181539 seconds, 26272 images, 1435.309804 hours left
Loaded: 0.000026 seconds

 822: 17.128471, 19.798815 avg loss, 0.000594 rate, 9.193204 seconds, 26304 images, 1433.700706 hours left
Loaded: 0.000034 seconds

 823: 22.246017, 20.043535 avg loss, 0.000596 rate, 9.618704 seconds, 26336 images, 1432.123865 hours left
Loaded: 0.000030 seconds

 824: 19.336699, 19.972851 avg loss, 0.000599 rate, 9.097548 seconds, 26368 images, 1431.153369 hours left
Loaded: 0.000033 seconds

 825: 13.944404, 19.370007 avg loss, 0.000602 rate, 8.442437 seconds, 26400 images, 1429.469186 hours left
Loaded: 0.000036 seconds

 826: 19.095444, 19.342550 avg loss, 0.000605 rate, 9.076836 seconds, 26432 images, 1426.892539 hours left
Loaded: 0.000030 seconds

 827: 17.137836, 19.122078 avg loss, 0.000608 rate, 8.524799 seconds, 26464 images, 1425.222175 hours left
Loaded: 0.000028 seconds

 828: 17.068628, 18.916733 avg loss, 0.000611 rate, 8.531495 seconds, 26496 images, 1422.802262 hours left
Loaded: 0.000029 seconds

 829: 22.409529, 19.266012 avg loss, 0.000614 rate, 9.045451 seconds, 26528 images, 1420.415832 hours left
Loaded: 0.000030 seconds

 830: 26.837778, 20.023190 avg loss, 0.000617 rate, 9.775785 seconds, 26560 images, 1418.766587 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.000030 seconds

 831: 14.871224, 19.507994 avg loss, 0.000620 rate, 9.126561 seconds, 26592 images, 1418.147495 hours left
Loaded: 0.000030 seconds

 832: 19.080765, 19.465271 avg loss, 0.000623 rate, 9.749100 seconds, 26624 images, 1416.633464 hours left
Loaded: 0.000029 seconds

 833: 24.108742, 19.929619 avg loss, 0.000626 rate, 10.321527 seconds, 26656 images, 1415.998609 hours left
Loaded: 0.000037 seconds

 834: 22.139301, 20.150587 avg loss, 0.000629 rate, 10.308764 seconds, 26688 images, 1416.164584 hours left
Loaded: 0.000034 seconds

 835: 14.007354, 19.536264 avg loss, 0.000632 rate, 9.758112 seconds, 26720 images, 1416.311168 hours left
Loaded: 0.000029 seconds

 836: 22.882574, 19.870895 avg loss, 0.000635 rate, 10.716659 seconds, 26752 images, 1415.691970 hours left
Loaded: 0.000040 seconds

 837: 21.358232, 20.019629 avg loss, 0.000638 rate, 10.459041 seconds, 26784 images, 1416.409351 hours left
Loaded: 0.000039 seconds

 838: 19.316862, 19.949352 avg loss, 0.000641 rate, 10.365457 seconds, 26816 images, 1416.761984 hours left
Loaded: 0.000040 seconds

 839: 24.069124, 20.361330 avg loss, 0.000644 rate, 10.988690 seconds, 26848 images, 1416.981169 hours left
Loaded: 0.000040 seconds

 840: 19.947041, 20.319901 avg loss, 0.000647 rate, 10.389562 seconds, 26880 images, 1418.063150 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 841: 15.347062, 19.822617 avg loss, 0.000650 rate, 13.773614 seconds, 26912 images, 1418.302724 hours left
Loaded: 0.000029 seconds

 842: 25.157955, 20.356150 avg loss, 0.000653 rate, 14.813275 seconds, 26944 images, 1423.236717 hours left
Loaded: 0.000025 seconds

 843: 24.887831, 20.809319 avg loss, 0.000657 rate, 15.044892 seconds, 26976 images, 1429.564325 hours left
Loaded: 0.000032 seconds

 844: 19.021679, 20.630554 avg loss, 0.000660 rate, 14.144078 seconds, 27008 images, 1436.150077 hours left
Loaded: 0.000029 seconds

 845: 29.235233, 21.491022 avg loss, 0.000663 rate, 16.879069 seconds, 27040 images, 1441.419672 hours left
Loaded: 0.000032 seconds

 846: 24.291006, 21.771021 avg loss, 0.000666 rate, 15.787541 seconds, 27072 images, 1450.432506 hours left
Loaded: 0.000036 seconds

 847: 23.454275, 21.939346 avg loss, 0.000669 rate, 15.437990 seconds, 27104 images, 1457.840208 hours left
Loaded: 0.000041 seconds

 848: 22.320463, 21.977459 avg loss, 0.000672 rate, 15.460120 seconds, 27136 images, 1464.688642 hours left
Loaded: 0.000034 seconds

 849: 23.529827, 22.132696 avg loss, 0.000675 rate, 15.325756 seconds, 27168 images, 1471.499270 hours left
Loaded: 0.000036 seconds

 850: 21.346373, 22.054064 avg loss, 0.000679 rate, 15.155152 seconds, 27200 images, 1478.055254 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.531711 seconds - performance bottleneck on CPU or Disk HDD/SSD

 851: 17.149239, 21.563581 avg loss, 0.000682 rate, 12.543709 seconds, 27232 images, 1484.308855 hours left
Loaded: 0.000030 seconds

 852: 21.078764, 21.515100 avg loss, 0.000685 rate, 12.802523 seconds, 27264 images, 1487.613337 hours left
Loaded: 0.000026 seconds

 853: 20.138277, 21.377419 avg loss, 0.000688 rate, 12.685892 seconds, 27296 images, 1490.506022 hours left
Loaded: 0.000029 seconds

 854: 19.705730, 21.210249 avg loss, 0.000691 rate, 12.838501 seconds, 27328 images, 1493.207865 hours left
Loaded: 0.000034 seconds

 855: 27.049492, 21.794174 avg loss, 0.000695 rate, 14.570797 seconds, 27360 images, 1496.094465 hours left
Loaded: 0.000029 seconds

 856: 17.409800, 21.355736 avg loss, 0.000698 rate, 12.941651 seconds, 27392 images, 1501.356429 hours left
Loaded: 0.000028 seconds

 857: 19.589226, 21.179085 avg loss, 0.000701 rate, 13.353188 seconds, 27424 images, 1504.304637 hours left
Loaded: 0.000031 seconds

 858: 16.074120, 20.668589 avg loss, 0.000705 rate, 12.630344 seconds, 27456 images, 1507.794495 hours left
Loaded: 0.000026 seconds

 859: 18.564577, 20.458187 avg loss, 0.000708 rate, 13.319666 seconds, 27488 images, 1510.246191 hours left
Loaded: 0.000032 seconds

 860: 16.397312, 20.052099 avg loss, 0.000711 rate, 12.826798 seconds, 27520 images, 1513.630033 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.363598 seconds - performance bottleneck on CPU or Disk HDD/SSD

 861: 23.146191, 20.361507 avg loss, 0.000714 rate, 6.337023 seconds, 27552 images, 1516.295961 hours left
Loaded: 0.000026 seconds

 862: 22.038692, 20.529226 avg loss, 0.000718 rate, 6.281081 seconds, 27584 images, 1510.432713 hours left
Loaded: 0.000028 seconds

 863: 23.227549, 20.799059 avg loss, 0.000721 rate, 6.355386 seconds, 27616 images, 1504.045842 hours left
Loaded: 0.000028 seconds

 864: 23.416603, 21.060814 avg loss, 0.000724 rate, 6.121914 seconds, 27648 images, 1497.825951 hours left
Loaded: 0.000035 seconds

 865: 12.467876, 20.201521 avg loss, 0.000728 rate, 5.492820 seconds, 27680 images, 1491.344212 hours left
Loaded: 0.000036 seconds

 866: 22.864429, 20.467812 avg loss, 0.000731 rate, 6.299447 seconds, 27712 images, 1484.054178 hours left
Loaded: 0.000030 seconds

 867: 17.504118, 20.171442 avg loss, 0.000735 rate, 5.946397 seconds, 27744 images, 1477.956526 hours left
Loaded: 0.000032 seconds

 868: 18.153227, 19.969620 avg loss, 0.000738 rate, 6.107189 seconds, 27776 images, 1471.429839 hours left
Loaded: 0.000037 seconds

 869: 26.060894, 20.578747 avg loss, 0.000741 rate, 6.678582 seconds, 27808 images, 1465.191563 hours left
Loaded: 0.000029 seconds

 870: 14.263100, 19.947182 avg loss, 0.000745 rate, 5.794225 seconds, 27840 images, 1459.808674 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000029 seconds

 871: 24.619976, 20.414461 avg loss, 0.000748 rate, 14.029501 seconds, 27872 images, 1453.252221 hours left
Loaded: 0.000034 seconds

 872: 19.995304, 20.372545 avg loss, 0.000752 rate, 13.124350 seconds, 27904 images, 1458.190712 hours left
Loaded: 0.000030 seconds

 873: 20.582811, 20.393572 avg loss, 0.000755 rate, 13.529637 seconds, 27936 images, 1461.823568 hours left
Loaded: 0.000038 seconds

 874: 23.341311, 20.688345 avg loss, 0.000759 rate, 13.501118 seconds, 27968 images, 1465.982533 hours left
Loaded: 0.000028 seconds

 875: 21.695425, 20.789053 avg loss, 0.000762 rate, 12.845451 seconds, 28000 images, 1470.060300 hours left
Loaded: 0.000029 seconds

 876: 26.092718, 21.319420 avg loss, 0.000766 rate, 13.759522 seconds, 28032 images, 1473.187274 hours left
Loaded: 0.000037 seconds

 877: 20.181011, 21.205580 avg loss, 0.000769 rate, 12.544415 seconds, 28064 images, 1477.551533 hours left
Loaded: 0.000036 seconds

 878: 14.148540, 20.499876 avg loss, 0.000773 rate, 11.497417 seconds, 28096 images, 1480.185744 hours left
Loaded: 0.000038 seconds

 879: 22.318392, 20.681728 avg loss, 0.000776 rate, 11.762682 seconds, 28128 images, 1481.340513 hours left
Loaded: 0.000034 seconds

 880: 24.378078, 21.051363 avg loss, 0.000780 rate, 12.300976 seconds, 28160 images, 1482.851848 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.611326 seconds - performance bottleneck on CPU or Disk HDD/SSD

 881: 23.278027, 21.274029 avg loss, 0.000783 rate, 12.614056 seconds, 28192 images, 1485.095094 hours left
Loaded: 0.000029 seconds

 882: 17.754652, 20.922091 avg loss, 0.000787 rate, 11.712154 seconds, 28224 images, 1488.598747 hours left
Loaded: 0.000035 seconds

 883: 22.853781, 21.115259 avg loss, 0.000790 rate, 12.613242 seconds, 28256 images, 1489.967266 hours left
Loaded: 0.000030 seconds

 884: 18.013569, 20.805090 avg loss, 0.000794 rate, 11.702110 seconds, 28288 images, 1492.572647 hours left
Loaded: 0.000026 seconds

 885: 15.364875, 20.261068 avg loss, 0.000797 rate, 11.107124 seconds, 28320 images, 1493.887422 hours left
Loaded: 0.000028 seconds

 886: 28.299772, 21.064939 avg loss, 0.000801 rate, 12.889686 seconds, 28352 images, 1494.363279 hours left
Loaded: 0.000026 seconds

 887: 13.408792, 20.299324 avg loss, 0.000805 rate, 10.796492 seconds, 28384 images, 1497.308221 hours left
Loaded: 0.000022 seconds

 888: 12.983047, 19.567696 avg loss, 0.000808 rate, 10.960411 seconds, 28416 images, 1497.318710 hours left
Loaded: 0.000034 seconds

 889: 26.624878, 20.273415 avg loss, 0.000812 rate, 12.981589 seconds, 28448 images, 1497.556546 hours left
Loaded: 0.000040 seconds

 890: 15.515303, 19.797604 avg loss, 0.000816 rate, 11.467987 seconds, 28480 images, 1500.596996 hours left
Resizing, random_coef = 1.40 

 384 x 384 
 try to allocate additional workspace_size = 42.47 MB 
 CUDA allocate done! 
Loaded: 0.243499 seconds - performance bottleneck on CPU or Disk HDD/SSD

 891: 16.787525, 19.496595 avg loss, 0.000819 rate, 4.706495 seconds, 28512 images, 1501.506430 hours left
Loaded: 0.000029 seconds

 892: 17.298046, 19.276741 avg loss, 0.000823 rate, 4.880829 seconds, 28544 images, 1493.360994 hours left
Loaded: 0.000032 seconds

 893: 21.583242, 19.507391 avg loss, 0.000827 rate, 5.113026 seconds, 28576 images, 1485.201053 hours left
Loaded: 0.000037 seconds

 894: 19.686739, 19.525326 avg loss, 0.000830 rate, 4.870373 seconds, 28608 images, 1477.444943 hours left
Loaded: 0.000037 seconds

 895: 22.531616, 19.825954 avg loss, 0.000834 rate, 4.853712 seconds, 28640 images, 1469.429634 hours left
Loaded: 0.000037 seconds

 896: 23.093975, 20.152756 avg loss, 0.000838 rate, 4.884029 seconds, 28672 images, 1461.471343 hours left
Loaded: 0.000031 seconds

 897: 23.302448, 20.467726 avg loss, 0.000842 rate, 4.806285 seconds, 28704 images, 1453.634694 hours left
Loaded: 0.000029 seconds

 898: 18.769735, 20.297926 avg loss, 0.000845 rate, 4.598743 seconds, 28736 images, 1445.768500 hours left
Loaded: 0.000036 seconds

 899: 22.528423, 20.520975 avg loss, 0.000849 rate, 4.769043 seconds, 28768 images, 1437.692926 hours left
Loaded: 0.000034 seconds

 900: 26.016195, 21.070498 avg loss, 0.000853 rate, 4.811124 seconds, 28800 images, 1429.934445 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 901: 20.241470, 20.987595 avg loss, 0.000857 rate, 12.963114 seconds, 28832 images, 1422.311931 hours left
Loaded: 0.000031 seconds

 902: 21.374355, 21.026270 avg loss, 0.000861 rate, 13.259597 seconds, 28864 images, 1426.078748 hours left
Loaded: 0.000032 seconds

 903: 18.813917, 20.805035 avg loss, 0.000864 rate, 12.647234 seconds, 28896 images, 1430.219319 hours left
Loaded: 0.000030 seconds

 904: 16.821779, 20.406710 avg loss, 0.000868 rate, 12.478773 seconds, 28928 images, 1433.468630 hours left
Loaded: 0.000029 seconds

 905: 26.064190, 20.972458 avg loss, 0.000872 rate, 13.550438 seconds, 28960 images, 1436.451626 hours left
Loaded: 0.000041 seconds

 906: 17.877480, 20.662960 avg loss, 0.000876 rate, 12.594331 seconds, 28992 images, 1440.891973 hours left
Loaded: 0.000039 seconds

 907: 22.982170, 20.894880 avg loss, 0.000880 rate, 13.301313 seconds, 29024 images, 1443.961048 hours left
Loaded: 0.000029 seconds

 908: 26.892506, 21.494642 avg loss, 0.000884 rate, 13.604111 seconds, 29056 images, 1447.980513 hours left
Loaded: 0.000029 seconds

 909: 14.480137, 20.793192 avg loss, 0.000888 rate, 12.009502 seconds, 29088 images, 1452.379943 hours left
Loaded: 0.000029 seconds

 910: 23.526937, 21.066566 avg loss, 0.000891 rate, 13.304121 seconds, 29120 images, 1454.522417 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.288571 seconds - performance bottleneck on CPU or Disk HDD/SSD

 911: 18.635155, 20.823425 avg loss, 0.000895 rate, 8.378002 seconds, 29152 images, 1458.440043 hours left
Loaded: 0.000031 seconds

 912: 19.711702, 20.712254 avg loss, 0.000899 rate, 8.373090 seconds, 29184 images, 1455.882669 hours left
Loaded: 0.000031 seconds

 913: 20.135372, 20.654566 avg loss, 0.000903 rate, 8.579298 seconds, 29216 images, 1452.943608 hours left
Loaded: 0.000025 seconds

 914: 27.803429, 21.369452 avg loss, 0.000907 rate, 9.058883 seconds, 29248 images, 1450.320077 hours left
Loaded: 0.000029 seconds

 915: 19.026121, 21.135118 avg loss, 0.000911 rate, 8.534713 seconds, 29280 images, 1448.388287 hours left
Loaded: 0.000030 seconds

 916: 30.869457, 22.108553 avg loss, 0.000915 rate, 9.737187 seconds, 29312 images, 1445.748388 hours left
Loaded: 0.000029 seconds

 917: 16.593523, 21.557051 avg loss, 0.000919 rate, 8.315611 seconds, 29344 images, 1444.803578 hours left
Loaded: 0.000026 seconds

 918: 15.412015, 20.942547 avg loss, 0.000923 rate, 8.043224 seconds, 29376 images, 1441.895424 hours left
Loaded: 0.000030 seconds

 919: 16.236729, 20.471966 avg loss, 0.000927 rate, 8.331968 seconds, 29408 images, 1438.638324 hours left
Loaded: 0.000031 seconds

 920: 25.364620, 20.961231 avg loss, 0.000931 rate, 9.738216 seconds, 29440 images, 1435.814475 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 921: 18.304729, 20.695581 avg loss, 0.000935 rate, 13.073875 seconds, 29472 images, 1434.970327 hours left
Loaded: 0.000032 seconds

 922: 26.531670, 21.279190 avg loss, 0.000939 rate, 14.136375 seconds, 29504 images, 1438.763546 hours left
Loaded: 0.000031 seconds

 923: 13.741760, 20.525448 avg loss, 0.000944 rate, 12.497619 seconds, 29536 images, 1443.993253 hours left
Loaded: 0.000033 seconds

 924: 24.301754, 20.903078 avg loss, 0.000948 rate, 14.663120 seconds, 29568 images, 1446.896498 hours left
Loaded: 0.000037 seconds

 925: 15.330237, 20.345795 avg loss, 0.000952 rate, 12.741079 seconds, 29600 images, 1452.775766 hours left
Loaded: 0.000040 seconds

 926: 14.772700, 19.788485 avg loss, 0.000956 rate, 12.725419 seconds, 29632 images, 1455.928975 hours left
Loaded: 0.000035 seconds

 927: 18.482588, 19.657894 avg loss, 0.000960 rate, 13.712908 seconds, 29664 images, 1459.028890 hours left
Loaded: 0.000035 seconds

 928: 15.363453, 19.228451 avg loss, 0.000964 rate, 12.762046 seconds, 29696 images, 1463.468103 hours left
Loaded: 0.000031 seconds

 929: 20.828131, 19.388418 avg loss, 0.000968 rate, 13.262401 seconds, 29728 images, 1466.543376 hours left
Loaded: 0.000027 seconds

 930: 21.940176, 19.643595 avg loss, 0.000972 rate, 13.228286 seconds, 29760 images, 1470.282195 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.693382 seconds - performance bottleneck on CPU or Disk HDD/SSD

 931: 17.587898, 19.438025 avg loss, 0.000977 rate, 12.673164 seconds, 29792 images, 1473.936242 hours left
Loaded: 0.000034 seconds

 932: 21.278494, 19.622072 avg loss, 0.000981 rate, 13.158291 seconds, 29824 images, 1477.745537 hours left
Loaded: 0.000046 seconds

 933: 19.305746, 19.590439 avg loss, 0.000985 rate, 12.748222 seconds, 29856 images, 1481.227755 hours left
Loaded: 0.000030 seconds

 934: 10.630334, 18.694427 avg loss, 0.000989 rate, 11.994001 seconds, 29888 images, 1484.106086 hours left
Loaded: 0.000030 seconds

 935: 21.126318, 18.937616 avg loss, 0.000994 rate, 13.530860 seconds, 29920 images, 1485.908956 hours left
Loaded: 0.000032 seconds

 936: 24.217514, 19.465607 avg loss, 0.000998 rate, 13.924546 seconds, 29952 images, 1489.826434 hours left
Loaded: 0.000031 seconds

 937: 27.121307, 20.231176 avg loss, 0.001002 rate, 14.512841 seconds, 29984 images, 1494.251012 hours left
Loaded: 0.000030 seconds

 938: 23.950064, 20.603065 avg loss, 0.001006 rate, 13.763855 seconds, 30016 images, 1499.447666 hours left
Loaded: 0.000030 seconds

 939: 17.557243, 20.298483 avg loss, 0.001011 rate, 12.944654 seconds, 30048 images, 1503.552965 hours left
Loaded: 0.000029 seconds

 940: 23.413300, 20.609964 avg loss, 0.001015 rate, 13.814077 seconds, 30080 images, 1506.480391 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.475780 seconds - performance bottleneck on CPU or Disk HDD/SSD

 941: 17.828802, 20.331848 avg loss, 0.001019 rate, 11.403904 seconds, 30112 images, 1510.584977 hours left
Loaded: 0.000027 seconds

 942: 22.704212, 20.569084 avg loss, 0.001024 rate, 12.099091 seconds, 30144 images, 1511.964149 hours left
Loaded: 0.000032 seconds

 943: 18.252272, 20.337402 avg loss, 0.001028 rate, 11.764930 seconds, 30176 images, 1513.633995 hours left
Loaded: 0.000040 seconds

 944: 22.980314, 20.601694 avg loss, 0.001032 rate, 12.298943 seconds, 30208 images, 1514.823415 hours left
Loaded: 0.000034 seconds

 945: 30.834810, 21.625006 avg loss, 0.001037 rate, 13.865096 seconds, 30240 images, 1516.741945 hours left
Loaded: 0.000040 seconds

 946: 17.800060, 21.242512 avg loss, 0.001041 rate, 11.662014 seconds, 30272 images, 1520.814526 hours left
Loaded: 0.000037 seconds

 947: 14.635858, 20.581846 avg loss, 0.001046 rate, 11.211588 seconds, 30304 images, 1521.789244 hours left
Loaded: 0.000036 seconds

 948: 13.837490, 19.907410 avg loss, 0.001050 rate, 11.194392 seconds, 30336 images, 1522.129145 hours left
Loaded: 0.000027 seconds

 949: 28.033707, 20.720039 avg loss, 0.001054 rate, 12.811204 seconds, 30368 images, 1522.441752 hours left
Loaded: 0.000028 seconds

 950: 22.925022, 20.940538 avg loss, 0.001059 rate, 12.105908 seconds, 30400 images, 1524.994746 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.439420 seconds - performance bottleneck on CPU or Disk HDD/SSD

 951: 30.395485, 21.886034 avg loss, 0.001063 rate, 7.199850 seconds, 30432 images, 1526.543478 hours left
Loaded: 0.000038 seconds

 952: 16.524876, 21.349918 avg loss, 0.001068 rate, 6.124628 seconds, 30464 images, 1521.878584 hours left
Loaded: 0.000032 seconds

 953: 21.243464, 21.339273 avg loss, 0.001072 rate, 6.011161 seconds, 30496 images, 1515.158602 hours left
Loaded: 0.000026 seconds

 954: 22.752901, 21.480637 avg loss, 0.001077 rate, 6.132613 seconds, 30528 images, 1508.348344 hours left
Loaded: 0.000028 seconds

 955: 19.928686, 21.325441 avg loss, 0.001081 rate, 5.952913 seconds, 30560 images, 1501.774693 hours left
Loaded: 0.000036 seconds

 956: 14.655037, 20.658401 avg loss, 0.001086 rate, 5.812864 seconds, 30592 images, 1495.017409 hours left
Loaded: 0.000030 seconds

 957: 22.842129, 20.876774 avg loss, 0.001090 rate, 6.440132 seconds, 30624 images, 1488.133359 hours left
Loaded: 0.000032 seconds

 958: 25.398670, 21.328964 avg loss, 0.001095 rate, 6.676129 seconds, 30656 images, 1482.188533 hours left
Loaded: 0.000036 seconds

 959: 20.304800, 21.226547 avg loss, 0.001100 rate, 6.168508 seconds, 30688 images, 1476.630614 hours left
Loaded: 0.000040 seconds

 960: 21.564594, 21.260351 avg loss, 0.001104 rate, 6.527600 seconds, 30720 images, 1470.423877 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.435524 seconds - performance bottleneck on CPU or Disk HDD/SSD

 961: 28.449677, 21.979284 avg loss, 0.001109 rate, 7.156851 seconds, 30752 images, 1464.777477 hours left
Loaded: 0.000030 seconds

 962: 24.262980, 22.207653 avg loss, 0.001113 rate, 6.456485 seconds, 30784 images, 1460.664959 hours left
Loaded: 0.000030 seconds

 963: 19.453991, 21.932287 avg loss, 0.001118 rate, 5.995265 seconds, 30816 images, 1455.017420 hours left
Loaded: 0.000031 seconds

 964: 15.544712, 21.293530 avg loss, 0.001123 rate, 5.857124 seconds, 30848 images, 1448.786347 hours left
Loaded: 0.000030 seconds

 965: 27.366404, 21.900818 avg loss, 0.001127 rate, 6.728173 seconds, 30880 images, 1442.425885 hours left
Loaded: 0.000038 seconds

 966: 24.087074, 22.119444 avg loss, 0.001132 rate, 6.649860 seconds, 30912 images, 1437.337687 hours left
Loaded: 0.000038 seconds

 967: 20.342585, 21.941757 avg loss, 0.001137 rate, 6.418184 seconds, 30944 images, 1432.191685 hours left
Loaded: 0.000038 seconds

 968: 17.882545, 21.535835 avg loss, 0.001141 rate, 6.347062 seconds, 30976 images, 1426.775653 hours left
Loaded: 0.000037 seconds

 969: 20.902571, 21.472509 avg loss, 0.001146 rate, 6.593609 seconds, 31008 images, 1421.315076 hours left
Loaded: 0.000035 seconds

 970: 23.063002, 21.631559 avg loss, 0.001151 rate, 6.579713 seconds, 31040 images, 1416.251191 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000030 seconds

 971: 14.633095, 20.931713 avg loss, 0.001156 rate, 12.777160 seconds, 31072 images, 1411.218640 hours left
Loaded: 0.000023 seconds

 972: 17.935135, 20.632055 avg loss, 0.001160 rate, 13.103296 seconds, 31104 images, 1414.835849 hours left
Loaded: 0.000040 seconds

 973: 22.934488, 20.862299 avg loss, 0.001165 rate, 13.762510 seconds, 31136 images, 1418.869379 hours left
Loaded: 0.000037 seconds

 974: 18.825626, 20.658632 avg loss, 0.001170 rate, 13.107134 seconds, 31168 images, 1423.777268 hours left
Loaded: 0.000023 seconds

 975: 23.007149, 20.893484 avg loss, 0.001175 rate, 13.865106 seconds, 31200 images, 1427.726656 hours left
Loaded: 0.000024 seconds

 976: 21.799021, 20.984037 avg loss, 0.001180 rate, 13.679685 seconds, 31232 images, 1432.688235 hours left
Loaded: 0.000037 seconds

 977: 31.742601, 22.059895 avg loss, 0.001184 rate, 15.016731 seconds, 31264 images, 1437.342875 hours left
Loaded: 0.000032 seconds

 978: 14.914025, 21.345308 avg loss, 0.001189 rate, 12.552138 seconds, 31296 images, 1443.806185 hours left
Loaded: 0.000030 seconds

 979: 25.825745, 21.793352 avg loss, 0.001194 rate, 14.666008 seconds, 31328 images, 1446.785040 hours left
Loaded: 0.000029 seconds

 980: 29.064491, 22.520466 avg loss, 0.001199 rate, 15.227066 seconds, 31360 images, 1452.667187 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.436312 seconds - performance bottleneck on CPU or Disk HDD/SSD

 981: 25.371073, 22.805527 avg loss, 0.001204 rate, 10.750014 seconds, 31392 images, 1459.268970 hours left
Loaded: 0.000030 seconds

 982: 26.813385, 23.206312 avg loss, 0.001209 rate, 10.818090 seconds, 31424 images, 1460.197912 hours left
Loaded: 0.000031 seconds

 983: 22.669762, 23.152657 avg loss, 0.001214 rate, 10.290208 seconds, 31456 images, 1460.606630 hours left
Loaded: 0.000031 seconds

 984: 26.764568, 23.513847 avg loss, 0.001219 rate, 10.430685 seconds, 31488 images, 1460.278771 hours left
Loaded: 0.000039 seconds

 985: 20.018961, 23.164358 avg loss, 0.001224 rate, 9.773406 seconds, 31520 images, 1460.149081 hours left
Loaded: 0.000040 seconds

 986: 19.897373, 22.837660 avg loss, 0.001229 rate, 9.385087 seconds, 31552 images, 1459.108667 hours left
Loaded: 0.000037 seconds

 987: 15.325817, 22.086475 avg loss, 0.001234 rate, 9.087950 seconds, 31584 images, 1457.539823 hours left
Loaded: 0.000031 seconds

 988: 21.328880, 22.010715 avg loss, 0.001239 rate, 9.315948 seconds, 31616 images, 1455.574351 hours left
Loaded: 0.000033 seconds

 989: 18.478413, 21.657486 avg loss, 0.001244 rate, 9.131710 seconds, 31648 images, 1453.944851 hours left
Loaded: 0.000035 seconds

 990: 19.243191, 21.416056 avg loss, 0.001249 rate, 9.177942 seconds, 31680 images, 1452.075987 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.004309 seconds

 991: 17.920311, 21.066481 avg loss, 0.001254 rate, 8.432354 seconds, 31712 images, 1450.289937 hours left
Loaded: 0.000030 seconds

 992: 16.671503, 20.626984 avg loss, 0.001259 rate, 8.534806 seconds, 31744 images, 1447.493132 hours left
Loaded: 0.000031 seconds

 993: 18.468353, 20.411121 avg loss, 0.001264 rate, 8.796625 seconds, 31776 images, 1444.860488 hours left
Loaded: 0.000031 seconds

 994: 21.304680, 20.500477 avg loss, 0.001269 rate, 8.958502 seconds, 31808 images, 1442.617442 hours left
Loaded: 0.000043 seconds

 995: 17.702246, 20.220654 avg loss, 0.001274 rate, 8.360824 seconds, 31840 images, 1440.621394 hours left
Loaded: 0.000028 seconds

 996: 19.609121, 20.159500 avg loss, 0.001279 rate, 8.665720 seconds, 31872 images, 1437.816011 hours left
Loaded: 0.000029 seconds

 997: 18.451019, 19.988651 avg loss, 0.001284 rate, 8.786110 seconds, 31904 images, 1435.461685 hours left
Loaded: 0.000034 seconds

 998: 22.397436, 20.229530 avg loss, 0.001290 rate, 9.363710 seconds, 31936 images, 1433.297920 hours left
Loaded: 0.000031 seconds

 999: 18.535135, 20.060091 avg loss, 0.001295 rate, 9.174160 seconds, 31968 images, 1431.957203 hours left
Loaded: 0.000028 seconds

 1000: 22.228460, 20.276928 avg loss, 0.001300 rate, 9.511372 seconds, 32000 images, 1430.366860 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.088049 seconds

 1001: 24.910854, 20.740320 avg loss, 0.001300 rate, 17.061863 seconds, 32032 images, 1429.260271 hours left
Loaded: 0.000030 seconds

 1002: 25.839275, 21.250216 avg loss, 0.001300 rate, 16.715763 seconds, 32064 images, 1438.763138 hours left
Loaded: 0.000037 seconds

 1003: 16.039639, 20.729158 avg loss, 0.001300 rate, 14.960590 seconds, 32096 images, 1447.568591 hours left
Loaded: 0.000031 seconds

 1004: 18.789402, 20.535183 avg loss, 0.001300 rate, 15.346776 seconds, 32128 images, 1453.850665 hours left
Loaded: 0.000035 seconds

 1005: 15.821966, 20.063862 avg loss, 0.001300 rate, 14.841369 seconds, 32160 images, 1460.605696 hours left
Loaded: 0.000032 seconds

 1006: 17.831602, 19.840635 avg loss, 0.001300 rate, 14.326487 seconds, 32192 images, 1466.591895 hours left
Loaded: 0.000023 seconds

 1007: 28.932325, 20.749804 avg loss, 0.001300 rate, 16.628623 seconds, 32224 images, 1471.803795 hours left
Loaded: 0.000027 seconds

 1008: 27.431864, 21.418009 avg loss, 0.001300 rate, 16.407566 seconds, 32256 images, 1480.157693 hours left
Loaded: 0.000030 seconds

 1009: 27.676027, 22.043810 avg loss, 0.001300 rate, 16.047771 seconds, 32288 images, 1488.121299 hours left
Loaded: 0.000026 seconds

 1010: 13.911646, 21.230593 avg loss, 0.001300 rate, 13.364597 seconds, 32320 images, 1495.506020 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.571376 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1011: 21.300655, 21.237598 avg loss, 0.001300 rate, 14.866395 seconds, 32352 images, 1499.094016 hours left
Loaded: 0.000029 seconds

 1012: 21.270140, 21.240852 avg loss, 0.001300 rate, 13.845313 seconds, 32384 images, 1505.522526 hours left
Loaded: 0.000025 seconds

 1013: 21.891514, 21.305918 avg loss, 0.001300 rate, 13.655868 seconds, 32416 images, 1509.677266 hours left
Loaded: 0.000026 seconds

 1014: 25.197306, 21.695057 avg loss, 0.001300 rate, 13.791187 seconds, 32448 images, 1513.527564 hours left
Loaded: 0.000033 seconds

 1015: 17.235933, 21.249146 avg loss, 0.001300 rate, 12.776040 seconds, 32480 images, 1517.527072 hours left
Loaded: 0.000040 seconds

 1016: 12.629765, 20.387207 avg loss, 0.001300 rate, 12.478771 seconds, 32512 images, 1520.078082 hours left
Loaded: 0.000026 seconds

 1017: 20.748774, 20.423365 avg loss, 0.001300 rate, 13.351145 seconds, 32544 images, 1522.191109 hours left
Loaded: 0.000029 seconds

 1018: 19.522480, 20.333277 avg loss, 0.001300 rate, 13.187955 seconds, 32576 images, 1525.493330 hours left
Loaded: 0.000027 seconds

 1019: 19.197716, 20.219721 avg loss, 0.001300 rate, 13.509663 seconds, 32608 images, 1528.536076 hours left
Loaded: 0.000031 seconds

 1020: 21.596458, 20.357395 avg loss, 0.001300 rate, 14.521407 seconds, 32640 images, 1531.994712 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.282788 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1021: 19.055021, 20.227158 avg loss, 0.001300 rate, 6.184077 seconds, 32672 images, 1536.822468 hours left
Loaded: 0.000030 seconds

 1022: 24.755611, 20.680002 avg loss, 0.001300 rate, 6.528775 seconds, 32704 images, 1530.426655 hours left
Loaded: 0.000029 seconds

 1023: 21.928181, 20.804821 avg loss, 0.001300 rate, 6.466923 seconds, 32736 images, 1524.180721 hours left
Loaded: 0.000030 seconds

 1024: 24.701288, 21.194468 avg loss, 0.001300 rate, 6.578856 seconds, 32768 images, 1517.911410 hours left
Loaded: 0.000026 seconds

 1025: 13.036371, 20.378658 avg loss, 0.001300 rate, 5.822108 seconds, 32800 images, 1511.860075 hours left
Loaded: 0.000037 seconds

 1026: 15.119521, 19.852745 avg loss, 0.001300 rate, 6.089846 seconds, 32832 images, 1504.819294 hours left
Loaded: 0.000031 seconds

 1027: 25.890869, 20.456558 avg loss, 0.001300 rate, 6.873221 seconds, 32864 images, 1498.220389 hours left
Loaded: 0.000031 seconds

 1028: 20.223839, 20.433287 avg loss, 0.001300 rate, 6.540142 seconds, 32896 images, 1492.774321 hours left
Loaded: 0.000039 seconds

 1029: 21.203991, 20.510357 avg loss, 0.001300 rate, 6.422268 seconds, 32928 images, 1486.920573 hours left
Loaded: 0.000035 seconds

 1030: 19.407578, 20.400080 avg loss, 0.001300 rate, 6.130899 seconds, 32960 images, 1480.961812 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 1031: 20.500200, 20.410091 avg loss, 0.001300 rate, 15.696848 seconds, 32992 images, 1474.658367 hours left
Loaded: 0.000028 seconds

 1032: 14.928331, 19.861916 avg loss, 0.001300 rate, 15.411001 seconds, 33024 images, 1481.689854 hours left
Loaded: 0.000030 seconds

 1033: 20.104418, 19.886166 avg loss, 0.001300 rate, 16.660735 seconds, 33056 images, 1488.254404 hours left
Loaded: 0.000031 seconds

 1034: 20.227470, 19.920296 avg loss, 0.001300 rate, 16.641562 seconds, 33088 images, 1496.487158 hours left
Loaded: 0.000030 seconds

 1035: 21.248405, 20.053106 avg loss, 0.001300 rate, 16.898964 seconds, 33120 images, 1504.610939 hours left
Loaded: 0.000037 seconds

 1036: 20.051250, 20.052921 avg loss, 0.001300 rate, 16.610355 seconds, 33152 images, 1513.010553 hours left
Loaded: 0.000035 seconds

 1037: 22.209667, 20.268597 avg loss, 0.001300 rate, 16.587180 seconds, 33184 images, 1520.925719 hours left
Loaded: 0.000027 seconds

 1038: 16.670918, 19.908829 avg loss, 0.001300 rate, 15.407538 seconds, 33216 images, 1528.729533 hours left
Loaded: 0.000025 seconds

 1039: 16.695345, 19.587481 avg loss, 0.001300 rate, 15.398397 seconds, 33248 images, 1534.818623 hours left
Loaded: 0.000026 seconds

 1040: 16.247974, 19.253531 avg loss, 0.001300 rate, 15.189353 seconds, 33280 images, 1540.834094 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.442174 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1041: 17.337173, 19.061895 avg loss, 0.001300 rate, 12.357610 seconds, 33312 images, 1546.499343 hours left
Loaded: 0.000026 seconds

 1042: 18.090746, 18.964781 avg loss, 0.001300 rate, 12.202906 seconds, 33344 images, 1548.792604 hours left
Loaded: 0.000031 seconds

 1043: 15.893503, 18.657654 avg loss, 0.001300 rate, 12.757151 seconds, 33376 images, 1550.234835 hours left
Loaded: 0.000030 seconds

 1044: 19.212187, 18.713108 avg loss, 0.001300 rate, 13.316518 seconds, 33408 images, 1552.431568 hours left
Loaded: 0.000027 seconds

 1045: 12.920323, 18.133829 avg loss, 0.001300 rate, 12.150063 seconds, 33440 images, 1555.382350 hours left
Loaded: 0.000030 seconds

 1046: 20.161261, 18.336573 avg loss, 0.001300 rate, 13.455444 seconds, 33472 images, 1556.685271 hours left
Loaded: 0.000026 seconds

 1047: 18.531929, 18.356108 avg loss, 0.001300 rate, 13.053211 seconds, 33504 images, 1559.786183 hours left
Loaded: 0.000029 seconds

 1048: 21.576529, 18.678150 avg loss, 0.001300 rate, 13.251247 seconds, 33536 images, 1562.297997 hours left
Loaded: 0.000024 seconds

 1049: 23.098291, 19.120165 avg loss, 0.001300 rate, 13.421581 seconds, 33568 images, 1565.059421 hours left
Loaded: 0.000029 seconds

 1050: 20.018768, 19.210026 avg loss, 0.001300 rate, 13.135435 seconds, 33600 images, 1568.029491 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.116770 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1051: 18.740747, 19.163097 avg loss, 0.001300 rate, 13.599391 seconds, 33632 images, 1570.572842 hours left
Loaded: 0.000021 seconds

 1052: 20.275860, 19.274374 avg loss, 0.001300 rate, 14.108321 seconds, 33664 images, 1573.896358 hours left
Loaded: 0.000027 seconds

 1053: 17.414587, 19.088396 avg loss, 0.001300 rate, 13.666275 seconds, 33696 images, 1577.730694 hours left
Loaded: 0.000027 seconds

 1054: 19.296732, 19.109230 avg loss, 0.001300 rate, 14.018129 seconds, 33728 images, 1580.913380 hours left
Loaded: 0.000027 seconds

 1055: 15.268087, 18.725117 avg loss, 0.001300 rate, 13.364715 seconds, 33760 images, 1584.552347 hours left
Loaded: 0.000029 seconds

 1056: 18.197399, 18.672344 avg loss, 0.001300 rate, 14.256581 seconds, 33792 images, 1587.248374 hours left
Loaded: 0.000027 seconds

 1057: 25.032980, 19.308407 avg loss, 0.001300 rate, 15.061657 seconds, 33824 images, 1591.154731 hours left
Loaded: 0.000034 seconds

 1058: 18.152864, 19.192852 avg loss, 0.001300 rate, 14.128740 seconds, 33856 images, 1596.138899 hours left
Loaded: 0.000027 seconds

 1059: 20.312540, 19.304821 avg loss, 0.001300 rate, 14.489708 seconds, 33888 images, 1599.778920 hours left
Loaded: 0.000034 seconds

 1060: 26.426790, 20.017017 avg loss, 0.001300 rate, 14.945009 seconds, 33920 images, 1603.883276 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.333660 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1061: 16.666834, 19.681999 avg loss, 0.001300 rate, 6.181657 seconds, 33952 images, 1608.578212 hours left
Loaded: 0.000028 seconds

 1062: 16.502062, 19.364006 avg loss, 0.001300 rate, 6.099145 seconds, 33984 images, 1601.531341 hours left
Loaded: 0.000038 seconds

 1063: 26.152956, 20.042900 avg loss, 0.001300 rate, 6.931135 seconds, 34016 images, 1593.977595 hours left
Loaded: 0.000040 seconds

 1064: 17.942753, 19.832886 avg loss, 0.001300 rate, 6.105168 seconds, 34048 images, 1587.653622 hours left
Loaded: 0.000030 seconds

 1065: 20.794643, 19.929062 avg loss, 0.001300 rate, 6.358424 seconds, 34080 images, 1580.246989 hours left
Loaded: 0.000030 seconds

 1066: 21.640598, 20.100216 avg loss, 0.001300 rate, 6.256701 seconds, 34112 images, 1573.265740 hours left
Loaded: 0.000039 seconds

 1067: 24.573439, 20.547539 avg loss, 0.001300 rate, 6.590903 seconds, 34144 images, 1566.213163 hours left
Loaded: 0.000037 seconds

 1068: 21.885593, 20.681345 avg loss, 0.001300 rate, 5.883482 seconds, 34176 images, 1559.694749 hours left
Loaded: 0.000028 seconds

 1069: 17.849440, 20.398155 avg loss, 0.001300 rate, 5.651413 seconds, 34208 images, 1552.260084 hours left
Loaded: 0.000027 seconds

 1070: 15.297468, 19.888086 avg loss, 0.001300 rate, 5.489569 seconds, 34240 images, 1544.577785 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.005178 seconds

 1071: 22.737381, 20.173016 avg loss, 0.001300 rate, 7.597447 seconds, 34272 images, 1536.747766 hours left
Loaded: 0.000031 seconds

 1072: 18.460470, 20.001760 avg loss, 0.001300 rate, 7.197331 seconds, 34304 images, 1531.927443 hours left
Loaded: 0.000027 seconds

 1073: 15.896351, 19.591219 avg loss, 0.001300 rate, 7.149598 seconds, 34336 images, 1526.593083 hours left
Loaded: 0.000030 seconds

 1074: 23.568506, 19.988947 avg loss, 0.001300 rate, 8.140950 seconds, 34368 images, 1521.245820 hours left
Loaded: 0.000030 seconds

 1075: 17.957752, 19.785828 avg loss, 0.001300 rate, 7.419111 seconds, 34400 images, 1517.327310 hours left
Loaded: 0.000041 seconds

 1076: 18.330059, 19.640251 avg loss, 0.001300 rate, 7.700275 seconds, 34432 images, 1512.446576 hours left
Loaded: 0.000025 seconds

 1077: 15.534549, 19.229681 avg loss, 0.001300 rate, 7.293324 seconds, 34464 images, 1508.004687 hours left
Loaded: 0.000028 seconds

 1078: 20.782957, 19.385008 avg loss, 0.001300 rate, 7.868416 seconds, 34496 images, 1503.042616 hours left
Loaded: 0.000030 seconds

 1079: 16.904202, 19.136927 avg loss, 0.001300 rate, 7.744320 seconds, 34528 images, 1498.927967 hours left
Loaded: 0.000033 seconds

 1080: 20.495523, 19.272787 avg loss, 0.001300 rate, 8.003893 seconds, 34560 images, 1494.682286 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.382444 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1081: 23.689362, 19.714445 avg loss, 0.001300 rate, 5.701642 seconds, 34592 images, 1490.839147 hours left
Loaded: 0.000038 seconds

 1082: 23.140310, 20.057032 avg loss, 0.001300 rate, 5.847551 seconds, 34624 images, 1484.371069 hours left
Loaded: 0.000037 seconds

 1083: 20.180515, 20.069380 avg loss, 0.001300 rate, 5.406176 seconds, 34656 images, 1477.639569 hours left
Loaded: 0.000027 seconds

 1084: 28.078987, 20.870340 avg loss, 0.001300 rate, 5.691273 seconds, 34688 images, 1470.363059 hours left
Loaded: 0.000028 seconds

 1085: 22.912567, 21.074562 avg loss, 0.001300 rate, 5.546537 seconds, 34720 images, 1463.554791 hours left
Loaded: 0.000028 seconds

 1086: 17.449455, 20.712051 avg loss, 0.001300 rate, 5.273046 seconds, 34752 images, 1456.613804 hours left
Loaded: 0.000027 seconds

 1087: 18.072212, 20.448067 avg loss, 0.001300 rate, 5.687153 seconds, 34784 images, 1449.362807 hours left
Loaded: 0.000030 seconds

 1088: 23.062237, 20.709484 avg loss, 0.001300 rate, 6.041045 seconds, 34816 images, 1442.758779 hours left
Loaded: 0.000030 seconds

 1089: 18.464769, 20.485012 avg loss, 0.001300 rate, 5.840374 seconds, 34848 images, 1436.711719 hours left
Loaded: 0.000029 seconds

 1090: 15.563397, 19.992851 avg loss, 0.001300 rate, 5.532337 seconds, 34880 images, 1430.446732 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.146167 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1091: 20.579081, 20.051474 avg loss, 0.001300 rate, 6.870236 seconds, 34912 images, 1423.817054 hours left
Loaded: 0.000031 seconds

 1092: 20.769867, 20.123314 avg loss, 0.001300 rate, 6.484447 seconds, 34944 images, 1419.312383 hours left
Loaded: 0.000031 seconds

 1093: 19.977707, 20.108753 avg loss, 0.001300 rate, 6.488324 seconds, 34976 images, 1414.114828 hours left
Loaded: 0.000034 seconds

 1094: 21.873140, 20.285192 avg loss, 0.001300 rate, 6.617364 seconds, 35008 images, 1408.974608 hours left
Loaded: 0.000029 seconds

 1095: 17.970951, 20.053768 avg loss, 0.001300 rate, 6.158711 seconds, 35040 images, 1404.064786 hours left
Loaded: 0.000027 seconds

 1096: 16.975052, 19.745897 avg loss, 0.001300 rate, 6.212465 seconds, 35072 images, 1398.567777 hours left
Loaded: 0.000036 seconds

 1097: 21.940369, 19.965343 avg loss, 0.001300 rate, 6.575273 seconds, 35104 images, 1393.200288 hours left
Loaded: 0.000029 seconds

 1098: 20.700718, 20.038881 avg loss, 0.001300 rate, 6.677731 seconds, 35136 images, 1388.389767 hours left
Loaded: 0.000036 seconds

 1099: 22.919388, 20.326931 avg loss, 0.001300 rate, 6.565491 seconds, 35168 images, 1383.769455 hours left
Loaded: 0.000040 seconds

 1100: 12.032456, 19.497484 avg loss, 0.001300 rate, 5.676814 seconds, 35200 images, 1379.039635 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000033 seconds

 1101: 16.753447, 19.223080 avg loss, 0.001300 rate, 14.347790 seconds, 35232 images, 1373.124309 hours left
Loaded: 0.000033 seconds

 1102: 25.330765, 19.833849 avg loss, 0.001300 rate, 15.822777 seconds, 35264 images, 1379.296667 hours left
Loaded: 0.000030 seconds

 1103: 15.440166, 19.394480 avg loss, 0.001300 rate, 14.212272 seconds, 35296 images, 1387.453381 hours left
Loaded: 0.000032 seconds

 1104: 16.075888, 19.062620 avg loss, 0.001300 rate, 14.085753 seconds, 35328 images, 1393.294362 hours left
Loaded: 0.000030 seconds

 1105: 20.080006, 19.164358 avg loss, 0.001300 rate, 14.538960 seconds, 35360 images, 1398.901391 hours left
Loaded: 0.000030 seconds

 1106: 17.778210, 19.025743 avg loss, 0.001300 rate, 13.646798 seconds, 35392 images, 1405.080999 hours left
Loaded: 0.000030 seconds

 1107: 14.727994, 18.595968 avg loss, 0.001300 rate, 13.570014 seconds, 35424 images, 1409.961158 hours left
Loaded: 0.000033 seconds

 1108: 18.450106, 18.581383 avg loss, 0.001300 rate, 13.945660 seconds, 35456 images, 1414.685964 hours left
Loaded: 0.000032 seconds

 1109: 14.088174, 18.132061 avg loss, 0.001300 rate, 13.673470 seconds, 35488 images, 1419.884583 hours left
Loaded: 0.000031 seconds

 1110: 15.976256, 17.916481 avg loss, 0.001300 rate, 13.393457 seconds, 35520 images, 1424.653595 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.443108 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1111: 18.806969, 18.005529 avg loss, 0.001300 rate, 8.764111 seconds, 35552 images, 1428.986445 hours left
Loaded: 0.000038 seconds

 1112: 19.224306, 18.127407 avg loss, 0.001300 rate, 8.893373 seconds, 35584 images, 1427.468772 hours left
Loaded: 0.000039 seconds

 1113: 18.041735, 18.118839 avg loss, 0.001300 rate, 8.737120 seconds, 35616 images, 1425.530939 hours left
Loaded: 0.000026 seconds

 1114: 23.945173, 18.701473 avg loss, 0.001300 rate, 9.286133 seconds, 35648 images, 1423.395709 hours left
Loaded: 0.000037 seconds

 1115: 22.774229, 19.108749 avg loss, 0.001300 rate, 9.326966 seconds, 35680 images, 1422.043370 hours left
Loaded: 0.000039 seconds

 1116: 11.493443, 18.347219 avg loss, 0.001300 rate, 8.172736 seconds, 35712 images, 1420.761187 hours left
Loaded: 0.000030 seconds

 1117: 21.680090, 18.680506 avg loss, 0.001300 rate, 9.294835 seconds, 35744 images, 1417.890680 hours left
Loaded: 0.000029 seconds

 1118: 21.744541, 18.986910 avg loss, 0.001300 rate, 9.240064 seconds, 35776 images, 1416.605391 hours left
Loaded: 0.000048 seconds

 1119: 14.753367, 18.563555 avg loss, 0.001300 rate, 8.394119 seconds, 35808 images, 1415.256951 hours left
Loaded: 0.000038 seconds

 1120: 19.730848, 18.680285 avg loss, 0.001300 rate, 9.204160 seconds, 35840 images, 1412.748526 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.024749 seconds

 1121: 22.781742, 19.090431 avg loss, 0.001300 rate, 10.416552 seconds, 35872 images, 1411.388810 hours left
Loaded: 0.000039 seconds

 1122: 14.428638, 18.624252 avg loss, 0.001300 rate, 9.387482 seconds, 35904 images, 1411.758732 hours left
Loaded: 0.000032 seconds

 1123: 17.167315, 18.478558 avg loss, 0.001300 rate, 9.618458 seconds, 35936 images, 1410.663162 hours left
Loaded: 0.000029 seconds

 1124: 25.436729, 19.174376 avg loss, 0.001300 rate, 10.400013 seconds, 35968 images, 1409.898912 hours left
Loaded: 0.000032 seconds

 1125: 21.565840, 19.413523 avg loss, 0.001300 rate, 10.111510 seconds, 36000 images, 1410.226412 hours left
Loaded: 0.000027 seconds

 1126: 20.492210, 19.521391 avg loss, 0.001300 rate, 9.943107 seconds, 36032 images, 1410.150416 hours left
Loaded: 0.000029 seconds

 1127: 20.376526, 19.606905 avg loss, 0.001300 rate, 10.206205 seconds, 36064 images, 1409.841544 hours left
Loaded: 0.000038 seconds

 1128: 24.752672, 20.121481 avg loss, 0.001300 rate, 10.670770 seconds, 36096 images, 1409.900690 hours left
Loaded: 0.000038 seconds

 1129: 26.129665, 20.722300 avg loss, 0.001300 rate, 10.357831 seconds, 36128 images, 1410.603649 hours left
Loaded: 0.000038 seconds

 1130: 25.412794, 21.191349 avg loss, 0.001300 rate, 10.114357 seconds, 36160 images, 1410.865458 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.451171 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1131: 19.138315, 20.986046 avg loss, 0.001300 rate, 7.907678 seconds, 36192 images, 1410.786887 hours left
Loaded: 0.000028 seconds

 1132: 23.453650, 21.232807 avg loss, 0.001300 rate, 8.180880 seconds, 36224 images, 1408.273893 hours left
Loaded: 0.000038 seconds

 1133: 15.501088, 20.659636 avg loss, 0.001300 rate, 7.426208 seconds, 36256 images, 1405.539177 hours left
Loaded: 0.000040 seconds

 1134: 25.724756, 21.166147 avg loss, 0.001300 rate, 8.247569 seconds, 36288 images, 1401.784971 hours left
Loaded: 0.000038 seconds

 1135: 23.449991, 21.394531 avg loss, 0.001300 rate, 8.081146 seconds, 36320 images, 1399.207623 hours left
Loaded: 0.000041 seconds

 1136: 18.231934, 21.078272 avg loss, 0.001300 rate, 7.953811 seconds, 36352 images, 1396.425172 hours left
Loaded: 0.000038 seconds

 1137: 17.754267, 20.745871 avg loss, 0.001300 rate, 7.759380 seconds, 36384 images, 1393.493898 hours left
Loaded: 0.000039 seconds

 1138: 18.562704, 20.527554 avg loss, 0.001300 rate, 7.738294 seconds, 36416 images, 1390.322212 hours left
Loaded: 0.000038 seconds

 1139: 17.450541, 20.219852 avg loss, 0.001300 rate, 7.910913 seconds, 36448 images, 1387.152975 hours left
Loaded: 0.000037 seconds

 1140: 18.545313, 20.052399 avg loss, 0.001300 rate, 8.183049 seconds, 36480 images, 1384.254847 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 1141: 20.085890, 20.055748 avg loss, 0.001300 rate, 14.511304 seconds, 36512 images, 1381.763161 hours left
Loaded: 0.000041 seconds

 1142: 13.582160, 19.408390 avg loss, 0.001300 rate, 13.342521 seconds, 36544 images, 1388.074331 hours left
Loaded: 0.000026 seconds

 1143: 20.599096, 19.527460 avg loss, 0.001300 rate, 14.596583 seconds, 36576 images, 1392.701143 hours left
Loaded: 0.000042 seconds

 1144: 20.962097, 19.670923 avg loss, 0.001300 rate, 14.383240 seconds, 36608 images, 1399.021143 hours left
Loaded: 0.000028 seconds

 1145: 21.577599, 19.861591 avg loss, 0.001300 rate, 14.290068 seconds, 36640 images, 1404.981996 hours left
Loaded: 0.000038 seconds

 1146: 23.553766, 20.230808 avg loss, 0.001300 rate, 14.698171 seconds, 36672 images, 1410.753942 hours left
Loaded: 0.000029 seconds

 1147: 18.767836, 20.084511 avg loss, 0.001300 rate, 13.982922 seconds, 36704 images, 1417.034220 hours left
Loaded: 0.000028 seconds

 1148: 24.396049, 20.515665 avg loss, 0.001300 rate, 13.900503 seconds, 36736 images, 1422.259526 hours left
Loaded: 0.000026 seconds

 1149: 16.799742, 20.144073 avg loss, 0.001300 rate, 13.094228 seconds, 36768 images, 1427.318216 hours left
Loaded: 0.000025 seconds

 1150: 21.448280, 20.274494 avg loss, 0.001300 rate, 14.084806 seconds, 36800 images, 1431.207904 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.432021 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1151: 18.504717, 20.097517 avg loss, 0.001300 rate, 10.704073 seconds, 36832 images, 1436.432672 hours left
Loaded: 0.000030 seconds

 1152: 19.235226, 20.011288 avg loss, 0.001300 rate, 11.061520 seconds, 36864 images, 1437.515018 hours left
Loaded: 0.000028 seconds

 1153: 20.837460, 20.093904 avg loss, 0.001300 rate, 11.276332 seconds, 36896 images, 1438.483111 hours left
Loaded: 0.000036 seconds

 1154: 14.402472, 19.524761 avg loss, 0.001300 rate, 9.775106 seconds, 36928 images, 1439.739453 hours left
Loaded: 0.000027 seconds

 1155: 14.418458, 19.014132 avg loss, 0.001300 rate, 10.344664 seconds, 36960 images, 1438.900899 hours left
Loaded: 0.000030 seconds

 1156: 18.618414, 18.974560 avg loss, 0.001300 rate, 11.294065 seconds, 36992 images, 1438.860709 hours left
Loaded: 0.000026 seconds

 1157: 22.414433, 19.318546 avg loss, 0.001300 rate, 11.707665 seconds, 37024 images, 1440.137778 hours left
Loaded: 0.000033 seconds

 1158: 18.525282, 19.239220 avg loss, 0.001300 rate, 11.094614 seconds, 37056 images, 1441.975730 hours left
Loaded: 0.000029 seconds

 1159: 19.023865, 19.217684 avg loss, 0.001300 rate, 11.207340 seconds, 37088 images, 1442.944952 hours left
Loaded: 0.000029 seconds

 1160: 25.608143, 19.856730 avg loss, 0.001300 rate, 11.682617 seconds, 37120 images, 1444.060791 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.395700 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1161: 21.075867, 19.978643 avg loss, 0.001300 rate, 5.569863 seconds, 37152 images, 1445.824676 hours left
Loaded: 0.000037 seconds

 1162: 22.890715, 20.269850 avg loss, 0.001300 rate, 5.522225 seconds, 37184 images, 1439.640993 hours left
Loaded: 0.000028 seconds

 1163: 20.362473, 20.279112 avg loss, 0.001300 rate, 5.415912 seconds, 37216 images, 1432.904249 hours left
Loaded: 0.000028 seconds

 1164: 18.672857, 20.118486 avg loss, 0.001300 rate, 5.254329 seconds, 37248 images, 1426.087383 hours left
Loaded: 0.000036 seconds

 1165: 12.182758, 19.324913 avg loss, 0.001300 rate, 4.951571 seconds, 37280 images, 1419.114547 hours left
Loaded: 0.000038 seconds

 1166: 21.378366, 19.530258 avg loss, 0.001300 rate, 5.538828 seconds, 37312 images, 1411.791501 hours left
Loaded: 0.000028 seconds

 1167: 20.152634, 19.592495 avg loss, 0.001300 rate, 5.490073 seconds, 37344 images, 1405.356221 hours left
Loaded: 0.000038 seconds

 1168: 20.065060, 19.639751 avg loss, 0.001300 rate, 5.462463 seconds, 37376 images, 1398.917641 hours left
Loaded: 0.000029 seconds

 1169: 21.671072, 19.842884 avg loss, 0.001300 rate, 5.598407 seconds, 37408 images, 1392.505147 hours left
Loaded: 0.000042 seconds

 1170: 20.601412, 19.918737 avg loss, 0.001300 rate, 5.541795 seconds, 37440 images, 1386.345309 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 1171: 13.595758, 19.286440 avg loss, 0.001300 rate, 6.364200 seconds, 37472 images, 1380.168551 hours left
Loaded: 0.000026 seconds

 1172: 21.061907, 19.463987 avg loss, 0.001300 rate, 6.938436 seconds, 37504 images, 1375.194215 hours left
Loaded: 0.000034 seconds

 1173: 20.548506, 19.572439 avg loss, 0.001300 rate, 6.780031 seconds, 37536 images, 1371.066087 hours left
Loaded: 0.000034 seconds

 1174: 12.589241, 18.874119 avg loss, 0.001300 rate, 6.593677 seconds, 37568 images, 1366.759519 hours left
Loaded: 0.000031 seconds

 1175: 28.782425, 19.864950 avg loss, 0.001300 rate, 8.126585 seconds, 37600 images, 1362.237523 hours left
Loaded: 0.000031 seconds

 1176: 20.045790, 19.883034 avg loss, 0.001300 rate, 7.475071 seconds, 37632 images, 1359.886891 hours left
Loaded: 0.000026 seconds

 1177: 25.568241, 20.451555 avg loss, 0.001300 rate, 8.005947 seconds, 37664 images, 1356.656086 hours left
Loaded: 0.000033 seconds

 1178: 22.220791, 20.628479 avg loss, 0.001300 rate, 7.715272 seconds, 37696 images, 1354.193889 hours left
Loaded: 0.000029 seconds

 1179: 22.687870, 20.834417 avg loss, 0.001300 rate, 7.716877 seconds, 37728 images, 1351.353134 hours left
Loaded: 0.000039 seconds

 1180: 16.857260, 20.436701 avg loss, 0.001300 rate, 6.975344 seconds, 37760 images, 1348.542985 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.349736 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1181: 15.612375, 19.954268 avg loss, 0.001300 rate, 6.219197 seconds, 37792 images, 1344.732425 hours left
Loaded: 0.000030 seconds

 1182: 18.855747, 19.844416 avg loss, 0.001300 rate, 6.493303 seconds, 37824 images, 1340.396205 hours left
Loaded: 0.000033 seconds

 1183: 20.476992, 19.907673 avg loss, 0.001300 rate, 6.400090 seconds, 37856 images, 1335.998474 hours left
Loaded: 0.000028 seconds

 1184: 23.782003, 20.295105 avg loss, 0.001300 rate, 6.520922 seconds, 37888 images, 1331.515420 hours left
Loaded: 0.000022 seconds

 1185: 14.865087, 19.752104 avg loss, 0.001300 rate, 5.689791 seconds, 37920 images, 1327.244764 hours left
Loaded: 0.000027 seconds

 1186: 30.334099, 20.810303 avg loss, 0.001300 rate, 6.467330 seconds, 37952 images, 1321.864031 hours left
Loaded: 0.000036 seconds

 1187: 22.785227, 21.007795 avg loss, 0.001300 rate, 6.018932 seconds, 37984 images, 1317.615518 hours left
Loaded: 0.000029 seconds

 1188: 21.120411, 21.019056 avg loss, 0.001300 rate, 6.147425 seconds, 38016 images, 1312.787566 hours left
Loaded: 0.000026 seconds

 1189: 23.277147, 21.244865 avg loss, 0.001300 rate, 6.333065 seconds, 38048 images, 1308.186085 hours left
Loaded: 0.000026 seconds

 1190: 21.721117, 21.292490 avg loss, 0.001300 rate, 6.094668 seconds, 38080 images, 1303.888075 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.023447 seconds

 1191: 26.769985, 21.840240 avg loss, 0.001300 rate, 11.554990 seconds, 38112 images, 1299.302378 hours left
Loaded: 0.000028 seconds

 1192: 12.018769, 20.858093 avg loss, 0.001300 rate, 9.949032 seconds, 38144 images, 1302.368307 hours left
Loaded: 0.000028 seconds

 1193: 24.380230, 21.210306 avg loss, 0.001300 rate, 11.289503 seconds, 38176 images, 1303.143651 hours left
Loaded: 0.000027 seconds

 1194: 23.884478, 21.477724 avg loss, 0.001300 rate, 11.411421 seconds, 38208 images, 1305.770399 hours left
Loaded: 0.000028 seconds

 1195: 23.936646, 21.723616 avg loss, 0.001300 rate, 11.150561 seconds, 38240 images, 1308.539942 hours left
Loaded: 0.000036 seconds

 1196: 18.145760, 21.365829 avg loss, 0.001300 rate, 10.559036 seconds, 38272 images, 1310.919959 hours left
Loaded: 0.000041 seconds

 1197: 15.314581, 20.760704 avg loss, 0.001300 rate, 10.231804 seconds, 38304 images, 1312.455735 hours left
Loaded: 0.000036 seconds

 1198: 18.252916, 20.509926 avg loss, 0.001300 rate, 10.904899 seconds, 38336 images, 1313.522278 hours left
Loaded: 0.000030 seconds

 1199: 23.918653, 20.850800 avg loss, 0.001300 rate, 11.092079 seconds, 38368 images, 1315.511668 hours left
Loaded: 0.000026 seconds

 1200: 19.248343, 20.690554 avg loss, 0.001300 rate, 10.521930 seconds, 38400 images, 1317.740734 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.497260 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1201: 26.183687, 21.239866 avg loss, 0.001300 rate, 8.781188 seconds, 38432 images, 1319.156707 hours left
Loaded: 0.000031 seconds

 1202: 23.847742, 21.500654 avg loss, 0.001300 rate, 8.312812 seconds, 38464 images, 1318.833821 hours left
Loaded: 0.000031 seconds

 1203: 15.222786, 20.872868 avg loss, 0.001300 rate, 7.707407 seconds, 38496 images, 1317.174902 hours left
Loaded: 0.000030 seconds

 1204: 19.004879, 20.686069 avg loss, 0.001300 rate, 8.018279 seconds, 38528 images, 1314.692890 hours left
Loaded: 0.000030 seconds

 1205: 17.919260, 20.409389 avg loss, 0.001300 rate, 8.010106 seconds, 38560 images, 1312.666835 hours left
Loaded: 0.000030 seconds

 1206: 14.794142, 19.847864 avg loss, 0.001300 rate, 7.570843 seconds, 38592 images, 1310.649682 hours left
Loaded: 0.000039 seconds

 1207: 22.965445, 20.159622 avg loss, 0.001300 rate, 8.571086 seconds, 38624 images, 1308.043453 hours left
Loaded: 0.000038 seconds

 1208: 21.316383, 20.275299 avg loss, 0.001300 rate, 8.393828 seconds, 38656 images, 1306.850540 hours left
Loaded: 0.000041 seconds

 1209: 20.956944, 20.343464 avg loss, 0.001300 rate, 8.595721 seconds, 38688 images, 1305.423687 hours left
Loaded: 0.000039 seconds

 1210: 16.691490, 19.978266 avg loss, 0.001300 rate, 8.196679 seconds, 38720 images, 1304.291092 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.080544 seconds

 1211: 20.831570, 20.063597 avg loss, 0.001300 rate, 10.625488 seconds, 38752 images, 1302.616361 hours left
Loaded: 0.000025 seconds

 1212: 23.927223, 20.449959 avg loss, 0.001300 rate, 11.179383 seconds, 38784 images, 1304.438557 hours left
Loaded: 0.000033 seconds

 1213: 21.272707, 20.532234 avg loss, 0.001300 rate, 10.825855 seconds, 38816 images, 1306.899044 hours left
Loaded: 0.000026 seconds

 1214: 21.693041, 20.648315 avg loss, 0.001300 rate, 10.790735 seconds, 38848 images, 1308.844583 hours left
Loaded: 0.000030 seconds

 1215: 23.530935, 20.936577 avg loss, 0.001300 rate, 11.046424 seconds, 38880 images, 1310.721916 hours left
Loaded: 0.000030 seconds

 1216: 11.183318, 19.961250 avg loss, 0.001300 rate, 9.197290 seconds, 38912 images, 1312.935069 hours left
Loaded: 0.000037 seconds

 1217: 19.420832, 19.907207 avg loss, 0.001300 rate, 10.355215 seconds, 38944 images, 1312.561494 hours left
Loaded: 0.000036 seconds

 1218: 15.787459, 19.495234 avg loss, 0.001300 rate, 9.848438 seconds, 38976 images, 1313.797563 hours left
Loaded: 0.000030 seconds

 1219: 26.739395, 20.219650 avg loss, 0.001300 rate, 11.565082 seconds, 39008 images, 1314.318393 hours left
Loaded: 0.000031 seconds

 1220: 22.781773, 20.475863 avg loss, 0.001300 rate, 10.748173 seconds, 39040 images, 1317.214781 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.049153 seconds

 1221: 21.461859, 20.574463 avg loss, 0.001300 rate, 11.745641 seconds, 39072 images, 1318.949212 hours left
Loaded: 0.000029 seconds

 1222: 17.158567, 20.232874 avg loss, 0.001300 rate, 11.022839 seconds, 39104 images, 1322.117770 hours left
Loaded: 0.000032 seconds

 1223: 24.750113, 20.684597 avg loss, 0.001300 rate, 12.068429 seconds, 39136 images, 1324.184039 hours left
Loaded: 0.000033 seconds

 1224: 18.771139, 20.493252 avg loss, 0.001300 rate, 10.978457 seconds, 39168 images, 1327.679728 hours left
Loaded: 0.000032 seconds

 1225: 27.092499, 21.153177 avg loss, 0.001300 rate, 12.163584 seconds, 39200 images, 1329.628768 hours left
Loaded: 0.000029 seconds

 1226: 21.745289, 21.212389 avg loss, 0.001300 rate, 11.305967 seconds, 39232 images, 1333.201909 hours left
Loaded: 0.000029 seconds

 1227: 13.730359, 20.464186 avg loss, 0.001300 rate, 10.103300 seconds, 39264 images, 1335.549876 hours left
Loaded: 0.000029 seconds

 1228: 21.402666, 20.558033 avg loss, 0.001300 rate, 11.156931 seconds, 39296 images, 1336.206389 hours left
Loaded: 0.000028 seconds

 1229: 12.602864, 19.762516 avg loss, 0.001300 rate, 10.016378 seconds, 39328 images, 1338.317555 hours left
Loaded: 0.000044 seconds

 1230: 27.823248, 20.568588 avg loss, 0.001300 rate, 11.433153 seconds, 39360 images, 1338.825783 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.440437 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1231: 17.460684, 20.257797 avg loss, 0.001300 rate, 9.401502 seconds, 39392 images, 1341.293794 hours left
Loaded: 0.000028 seconds

 1232: 22.375931, 20.469610 avg loss, 0.001300 rate, 9.778657 seconds, 39424 images, 1341.530243 hours left
Loaded: 0.000027 seconds

 1233: 17.146215, 20.137270 avg loss, 0.001300 rate, 9.070869 seconds, 39456 images, 1341.676577 hours left
Loaded: 0.000035 seconds

 1234: 16.271559, 19.750698 avg loss, 0.001300 rate, 9.159664 seconds, 39488 images, 1340.839822 hours left
Loaded: 0.000034 seconds

 1235: 23.400259, 20.115654 avg loss, 0.001300 rate, 10.272604 seconds, 39520 images, 1340.134565 hours left
Loaded: 0.000031 seconds

 1236: 20.067917, 20.110880 avg loss, 0.001300 rate, 10.587273 seconds, 39552 images, 1340.979813 hours left
Loaded: 0.000030 seconds

 1237: 26.267324, 20.726524 avg loss, 0.001300 rate, 10.550522 seconds, 39584 images, 1342.252973 hours left
Loaded: 0.000028 seconds

 1238: 13.697006, 20.023573 avg loss, 0.001300 rate, 9.421896 seconds, 39616 images, 1343.462401 hours left
Loaded: 0.000029 seconds

 1239: 18.260052, 19.847221 avg loss, 0.001300 rate, 10.244225 seconds, 39648 images, 1343.094481 hours left
Loaded: 0.000029 seconds

 1240: 16.217714, 19.484270 avg loss, 0.001300 rate, 10.124895 seconds, 39680 images, 1343.870651 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.052373 seconds

 1241: 20.546165, 19.590460 avg loss, 0.001300 rate, 14.570528 seconds, 39712 images, 1344.473541 hours left
Loaded: 0.000026 seconds

 1242: 11.996827, 18.831097 avg loss, 0.001300 rate, 13.702696 seconds, 39744 images, 1351.308303 hours left
Loaded: 0.000027 seconds

 1243: 19.981726, 18.946159 avg loss, 0.001300 rate, 14.503590 seconds, 39776 images, 1356.798548 hours left
Loaded: 0.000027 seconds

 1244: 15.170500, 18.568594 avg loss, 0.001300 rate, 13.830193 seconds, 39808 images, 1363.344554 hours left
Loaded: 0.000037 seconds

 1245: 19.994383, 18.711172 avg loss, 0.001300 rate, 14.744387 seconds, 39840 images, 1368.891177 hours left
Loaded: 0.000029 seconds

 1246: 18.462688, 18.686323 avg loss, 0.001300 rate, 14.388575 seconds, 39872 images, 1375.650133 hours left
Loaded: 0.000028 seconds

 1247: 22.936958, 19.111387 avg loss, 0.001300 rate, 14.980307 seconds, 39904 images, 1381.848001 hours left
Loaded: 0.000028 seconds

 1248: 17.869577, 18.987206 avg loss, 0.001300 rate, 13.683964 seconds, 39936 images, 1388.804472 hours left
Loaded: 0.000027 seconds

 1249: 27.211298, 19.809614 avg loss, 0.001300 rate, 15.405811 seconds, 39968 images, 1393.893553 hours left
Loaded: 0.000031 seconds

 1250: 18.850073, 19.713659 avg loss, 0.001300 rate, 14.139351 seconds, 40000 images, 1401.319575 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.250558 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1251: 15.975727, 19.339867 avg loss, 0.001300 rate, 7.714053 seconds, 40032 images, 1406.914966 hours left
Loaded: 0.000032 seconds

 1252: 17.002811, 19.106161 avg loss, 0.001300 rate, 7.964225 seconds, 40064 images, 1403.891175 hours left
Loaded: 0.000039 seconds

 1253: 25.582441, 19.753790 avg loss, 0.001300 rate, 8.713627 seconds, 40096 images, 1400.897109 hours left
Loaded: 0.000040 seconds

 1254: 11.042601, 18.882671 avg loss, 0.001300 rate, 7.242083 seconds, 40128 images, 1398.972239 hours left
Loaded: 0.000038 seconds

 1255: 17.606045, 18.755009 avg loss, 0.001300 rate, 7.705154 seconds, 40160 images, 1395.025866 hours left
Loaded: 0.000021 seconds

 1256: 25.789711, 19.458479 avg loss, 0.001300 rate, 8.168304 seconds, 40192 images, 1391.761116 hours left
Loaded: 0.000027 seconds

 1257: 20.654018, 19.578033 avg loss, 0.001300 rate, 7.808213 seconds, 40224 images, 1389.171258 hours left
Loaded: 0.000027 seconds

 1258: 20.000202, 19.620251 avg loss, 0.001300 rate, 7.763721 seconds, 40256 images, 1386.107915 hours left
Loaded: 0.000030 seconds

 1259: 28.728512, 20.531076 avg loss, 0.001300 rate, 9.037713 seconds, 40288 images, 1383.013485 hours left
Loaded: 0.000028 seconds

 1260: 29.340904, 21.412060 avg loss, 0.001300 rate, 9.136761 seconds, 40320 images, 1381.716729 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.026300 seconds

 1261: 19.641314, 21.234985 avg loss, 0.001300 rate, 10.296947 seconds, 40352 images, 1380.570272 hours left
Loaded: 0.000032 seconds

 1262: 21.720098, 21.283497 avg loss, 0.001300 rate, 10.462407 seconds, 40384 images, 1381.080605 hours left
Loaded: 0.000029 seconds

 1263: 16.738035, 20.828951 avg loss, 0.001300 rate, 9.863755 seconds, 40416 images, 1381.778834 hours left
Loaded: 0.000037 seconds

 1264: 21.067484, 20.852804 avg loss, 0.001300 rate, 10.416254 seconds, 40448 images, 1381.639851 hours left
Loaded: 0.000038 seconds

 1265: 16.476000, 20.415123 avg loss, 0.001300 rate, 9.759897 seconds, 40480 images, 1382.268432 hours left
Loaded: 0.000030 seconds

 1266: 15.076492, 19.881260 avg loss, 0.001300 rate, 9.577804 seconds, 40512 images, 1381.980487 hours left
Loaded: 0.000031 seconds

 1267: 21.281767, 20.021311 avg loss, 0.001300 rate, 10.214511 seconds, 40544 images, 1381.442864 hours left
Loaded: 0.000029 seconds

 1268: 23.567188, 20.375898 avg loss, 0.001300 rate, 10.957318 seconds, 40576 images, 1381.793550 hours left
Loaded: 0.000040 seconds

 1269: 22.392155, 20.577524 avg loss, 0.001300 rate, 10.486355 seconds, 40608 images, 1383.170806 hours left
Loaded: 0.000031 seconds

 1270: 18.290216, 20.348793 avg loss, 0.001300 rate, 9.935872 seconds, 40640 images, 1383.881149 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.396094 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1271: 21.462372, 20.460152 avg loss, 0.001300 rate, 6.434246 seconds, 40672 images, 1383.820963 hours left
Loaded: 0.000029 seconds

 1272: 19.770460, 20.391182 avg loss, 0.001300 rate, 6.070871 seconds, 40704 images, 1379.454722 hours left
Loaded: 0.000028 seconds

 1273: 12.057410, 19.557804 avg loss, 0.001300 rate, 5.561995 seconds, 40736 images, 1374.078974 hours left
Loaded: 0.000036 seconds

 1274: 20.159504, 19.617973 avg loss, 0.001300 rate, 6.277791 seconds, 40768 images, 1368.051286 hours left
Loaded: 0.000041 seconds

 1275: 26.755583, 20.331734 avg loss, 0.001300 rate, 6.769764 seconds, 40800 images, 1363.076492 hours left
Loaded: 0.000037 seconds

 1276: 17.739540, 20.072514 avg loss, 0.001300 rate, 5.930650 seconds, 40832 images, 1358.833673 hours left
Loaded: 0.000034 seconds

 1277: 16.014704, 19.666733 avg loss, 0.001300 rate, 5.923016 seconds, 40864 images, 1353.469629 hours left
Loaded: 0.000037 seconds

 1278: 13.736429, 19.073702 avg loss, 0.001300 rate, 5.703882 seconds, 40896 images, 1348.148619 hours left
Loaded: 0.000035 seconds

 1279: 16.532280, 18.819559 avg loss, 0.001300 rate, 5.999834 seconds, 40928 images, 1342.576929 hours left
Loaded: 0.000028 seconds

 1280: 18.041285, 18.741732 avg loss, 0.001300 rate, 6.004088 seconds, 40960 images, 1337.471340 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.000029 seconds

 1281: 24.280148, 19.295574 avg loss, 0.001300 rate, 10.741285 seconds, 40992 images, 1332.422679 hours left
Loaded: 0.000031 seconds

 1282: 15.020433, 18.868061 avg loss, 0.001300 rate, 9.799980 seconds, 41024 images, 1333.993657 hours left
Loaded: 0.000028 seconds

 1283: 12.062541, 18.187510 avg loss, 0.001300 rate, 9.284013 seconds, 41056 images, 1334.243573 hours left
Loaded: 0.000038 seconds

 1284: 20.280361, 18.396795 avg loss, 0.001300 rate, 10.220253 seconds, 41088 images, 1333.775460 hours left
Loaded: 0.000045 seconds

 1285: 20.777956, 18.634911 avg loss, 0.001300 rate, 10.242545 seconds, 41120 images, 1334.610310 hours left
Loaded: 0.000029 seconds

 1286: 17.086576, 18.480078 avg loss, 0.001300 rate, 10.218855 seconds, 41152 images, 1335.467707 hours left
Loaded: 0.000041 seconds

 1287: 28.643112, 19.496382 avg loss, 0.001300 rate, 11.896592 seconds, 41184 images, 1336.283627 hours left
Loaded: 0.000038 seconds

 1288: 23.868996, 19.933643 avg loss, 0.001300 rate, 11.218066 seconds, 41216 images, 1339.417899 hours left
Loaded: 0.000030 seconds

 1289: 22.627785, 20.203058 avg loss, 0.001300 rate, 10.730208 seconds, 41248 images, 1341.579877 hours left
Loaded: 0.000031 seconds

 1290: 19.269417, 20.109694 avg loss, 0.001300 rate, 9.755113 seconds, 41280 images, 1343.043683 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000029 seconds

 1291: 16.215239, 19.720247 avg loss, 0.001300 rate, 11.886815 seconds, 41312 images, 1343.140662 hours left
Loaded: 0.000029 seconds

 1292: 10.636481, 18.811871 avg loss, 0.001300 rate, 11.261753 seconds, 41344 images, 1346.192658 hours left
Loaded: 0.000029 seconds

 1293: 22.216400, 19.152323 avg loss, 0.001300 rate, 13.059836 seconds, 41376 images, 1348.347335 hours left
Loaded: 0.000039 seconds

 1294: 18.166164, 19.053707 avg loss, 0.001300 rate, 12.429214 seconds, 41408 images, 1352.973808 hours left
Loaded: 0.000035 seconds

 1295: 18.134121, 18.961748 avg loss, 0.001300 rate, 12.498931 seconds, 41440 images, 1356.679522 hours left
Loaded: 0.000031 seconds

 1296: 17.905365, 18.856110 avg loss, 0.001300 rate, 12.529706 seconds, 41472 images, 1360.444814 hours left
Loaded: 0.000035 seconds

 1297: 18.563583, 18.826857 avg loss, 0.001300 rate, 12.200485 seconds, 41504 images, 1364.215088 hours left
Loaded: 0.000031 seconds

 1298: 15.475494, 18.491720 avg loss, 0.001300 rate, 11.633127 seconds, 41536 images, 1367.491107 hours left
Loaded: 0.000043 seconds

 1299: 11.004484, 17.742996 avg loss, 0.001300 rate, 10.894139 seconds, 41568 images, 1369.947587 hours left
Loaded: 0.000039 seconds

 1300: 18.787876, 17.847485 avg loss, 0.001300 rate, 12.130037 seconds, 41600 images, 1371.354752 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.344650 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1301: 19.394032, 18.002140 avg loss, 0.001300 rate, 6.987176 seconds, 41632 images, 1374.461591 hours left
Loaded: 0.000029 seconds

 1302: 21.986238, 18.400551 avg loss, 0.001300 rate, 7.511441 seconds, 41664 images, 1370.883767 hours left
Loaded: 0.000030 seconds

 1303: 19.157539, 18.476250 avg loss, 0.001300 rate, 7.262097 seconds, 41696 images, 1367.590806 hours left
Loaded: 0.000028 seconds

 1304: 26.360376, 19.264662 avg loss, 0.001300 rate, 7.920558 seconds, 41728 images, 1363.984999 hours left
Loaded: 0.000033 seconds

 1305: 19.323910, 19.270586 avg loss, 0.001300 rate, 7.090962 seconds, 41760 images, 1361.328287 hours left
Loaded: 0.000028 seconds

 1306: 27.165979, 20.060125 avg loss, 0.001300 rate, 7.874874 seconds, 41792 images, 1357.547764 hours left
Loaded: 0.000031 seconds

 1307: 18.232737, 19.877386 avg loss, 0.001300 rate, 7.092741 seconds, 41824 images, 1354.892032 hours left
Loaded: 0.000038 seconds

 1308: 23.815926, 20.271240 avg loss, 0.001300 rate, 7.522236 seconds, 41856 images, 1351.178298 hours left
Loaded: 0.000034 seconds

 1309: 15.433876, 19.787504 avg loss, 0.001300 rate, 6.793122 seconds, 41888 images, 1348.097249 hours left
Loaded: 0.000028 seconds

 1310: 17.246393, 19.533394 avg loss, 0.001300 rate, 7.042181 seconds, 41920 images, 1344.035962 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.391383 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1311: 26.177759, 20.197830 avg loss, 0.001300 rate, 7.317644 seconds, 41952 images, 1340.360615 hours left
Loaded: 0.000029 seconds

 1312: 20.140596, 20.192106 avg loss, 0.001300 rate, 6.935966 seconds, 41984 images, 1337.646635 hours left
Loaded: 0.000028 seconds

 1313: 14.228572, 19.595753 avg loss, 0.001300 rate, 6.498274 seconds, 42016 images, 1333.887864 hours left
Loaded: 0.000030 seconds

 1314: 18.724592, 19.508636 avg loss, 0.001300 rate, 7.111209 seconds, 42048 images, 1329.559741 hours left
Loaded: 0.000030 seconds

 1315: 17.174866, 19.275259 avg loss, 0.001300 rate, 6.899514 seconds, 42080 images, 1326.124799 hours left
Loaded: 0.000032 seconds

 1316: 14.567250, 18.804459 avg loss, 0.001300 rate, 6.753125 seconds, 42112 images, 1322.430644 hours left
Loaded: 0.000030 seconds

 1317: 24.428556, 19.366869 avg loss, 0.001300 rate, 7.719165 seconds, 42144 images, 1318.570429 hours left
Loaded: 0.000030 seconds

 1318: 15.366082, 18.966791 avg loss, 0.001300 rate, 6.621907 seconds, 42176 images, 1316.088325 hours left
Loaded: 0.000027 seconds

 1319: 20.877237, 19.157835 avg loss, 0.001300 rate, 7.304288 seconds, 42208 images, 1312.109542 hours left
Loaded: 0.000027 seconds

 1320: 20.577850, 19.299837 avg loss, 0.001300 rate, 7.008282 seconds, 42240 images, 1309.116722 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.383927 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1321: 25.497446, 19.919598 avg loss, 0.001300 rate, 6.487473 seconds, 42272 images, 1305.743367 hours left
Loaded: 0.000034 seconds

 1322: 18.486940, 19.776333 avg loss, 0.001300 rate, 6.328395 seconds, 42304 images, 1302.213884 hours left
Loaded: 0.000031 seconds

 1323: 17.849829, 19.583683 avg loss, 0.001300 rate, 6.337925 seconds, 42336 images, 1297.966807 hours left
Loaded: 0.000030 seconds

 1324: 23.960297, 20.021345 avg loss, 0.001300 rate, 6.787493 seconds, 42368 images, 1293.775380 hours left
Loaded: 0.000040 seconds

 1325: 18.388077, 19.858019 avg loss, 0.001300 rate, 6.341875 seconds, 42400 images, 1290.249220 hours left
Loaded: 0.000039 seconds

 1326: 21.019789, 19.974195 avg loss, 0.001300 rate, 6.540999 seconds, 42432 images, 1286.140423 hours left
Loaded: 0.000030 seconds

 1327: 15.634451, 19.540220 avg loss, 0.001300 rate, 5.999632 seconds, 42464 images, 1282.348800 hours left
Loaded: 0.000030 seconds

 1328: 20.926710, 19.678869 avg loss, 0.001300 rate, 6.504465 seconds, 42496 images, 1277.844406 hours left
Loaded: 0.000041 seconds

 1329: 15.143666, 19.225349 avg loss, 0.001300 rate, 6.052473 seconds, 42528 images, 1274.085037 hours left
Loaded: 0.000029 seconds

 1330: 24.483179, 19.751133 avg loss, 0.001300 rate, 6.387033 seconds, 42560 images, 1269.736532 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 1331: 20.740582, 19.850079 avg loss, 0.001300 rate, 16.549365 seconds, 42592 images, 1265.895373 hours left
Loaded: 0.000032 seconds

 1332: 21.906149, 20.055685 avg loss, 0.001300 rate, 16.066479 seconds, 42624 images, 1276.183498 hours left
Loaded: 0.000029 seconds

 1333: 23.692421, 20.419359 avg loss, 0.001300 rate, 16.581536 seconds, 42656 images, 1285.699144 hours left
Loaded: 0.000031 seconds

 1334: 16.063093, 19.983732 avg loss, 0.001300 rate, 15.024081 seconds, 42688 images, 1295.833750 hours left
Loaded: 0.000029 seconds

 1335: 18.430157, 19.828375 avg loss, 0.001300 rate, 15.519075 seconds, 42720 images, 1303.707443 hours left
Loaded: 0.000031 seconds

 1336: 25.274662, 20.373003 avg loss, 0.001300 rate, 16.344918 seconds, 42752 images, 1312.188698 hours left
Loaded: 0.000026 seconds

 1337: 17.831690, 20.118872 avg loss, 0.001300 rate, 15.111496 seconds, 42784 images, 1321.730187 hours left
Loaded: 0.000032 seconds

 1338: 21.471846, 20.254169 avg loss, 0.001300 rate, 15.763761 seconds, 42816 images, 1329.465990 hours left
Loaded: 0.000028 seconds

 1339: 23.175591, 20.546312 avg loss, 0.001300 rate, 16.326449 seconds, 42848 images, 1338.028807 hours left
Loaded: 0.000031 seconds

 1340: 25.179569, 21.009638 avg loss, 0.001300 rate, 16.182286 seconds, 42880 images, 1347.286145 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.272554 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1341: 19.303904, 20.839064 avg loss, 0.001300 rate, 5.435491 seconds, 42912 images, 1356.250978 hours left
Loaded: 0.000029 seconds

 1342: 22.000719, 20.955229 avg loss, 0.001300 rate, 5.637709 seconds, 42944 images, 1350.602987 hours left
Loaded: 0.000038 seconds

 1343: 14.868939, 20.346600 avg loss, 0.001300 rate, 5.206078 seconds, 42976 images, 1344.913975 hours left
Loaded: 0.000038 seconds

 1344: 25.674061, 20.879345 avg loss, 0.001300 rate, 5.758320 seconds, 43008 images, 1338.683374 hours left
Loaded: 0.000038 seconds

 1345: 16.078590, 20.399269 avg loss, 0.001300 rate, 5.183608 seconds, 43040 images, 1333.280773 hours left
Loaded: 0.000038 seconds

 1346: 15.771152, 19.936457 avg loss, 0.001300 rate, 5.334016 seconds, 43072 images, 1327.135320 hours left
Loaded: 0.000038 seconds

 1347: 23.802046, 20.323015 avg loss, 0.001300 rate, 5.767797 seconds, 43104 images, 1321.259854 hours left
Loaded: 0.000026 seconds

 1348: 19.170609, 20.207775 avg loss, 0.001300 rate, 5.717642 seconds, 43136 images, 1316.044578 hours left
Loaded: 0.000030 seconds

 1349: 22.942812, 20.481279 avg loss, 0.001300 rate, 5.952563 seconds, 43168 images, 1310.811884 hours left
Loaded: 0.000030 seconds

 1350: 22.474298, 20.680582 avg loss, 0.001300 rate, 5.910284 seconds, 43200 images, 1305.957231 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 1351: 19.288460, 20.541370 avg loss, 0.001300 rate, 11.486919 seconds, 43232 images, 1301.092487 hours left
Loaded: 0.000029 seconds

 1352: 19.082203, 20.395454 avg loss, 0.001300 rate, 11.524358 seconds, 43264 images, 1304.008513 hours left
Loaded: 0.000036 seconds

 1353: 16.539436, 20.009853 avg loss, 0.001300 rate, 10.807851 seconds, 43296 images, 1306.947262 hours left
Loaded: 0.000027 seconds

 1354: 21.180965, 20.126965 avg loss, 0.001300 rate, 12.021161 seconds, 43328 images, 1308.863147 hours left
Loaded: 0.000029 seconds

 1355: 22.584349, 20.372704 avg loss, 0.001300 rate, 11.943783 seconds, 43360 images, 1312.442107 hours left
Loaded: 0.000030 seconds

 1356: 14.829085, 19.818342 avg loss, 0.001300 rate, 10.649979 seconds, 43392 images, 1315.877959 hours left
Loaded: 0.000039 seconds

 1357: 15.231106, 19.359619 avg loss, 0.001300 rate, 10.709165 seconds, 43424 images, 1317.485549 hours left
Loaded: 0.000034 seconds

 1358: 21.938107, 19.617468 avg loss, 0.001300 rate, 11.616148 seconds, 43456 images, 1319.159108 hours left
Loaded: 0.000024 seconds

 1359: 22.679422, 19.923664 avg loss, 0.001300 rate, 11.409479 seconds, 43488 images, 1322.073431 hours left
Loaded: 0.000030 seconds

 1360: 12.909097, 19.222208 avg loss, 0.001300 rate, 10.171203 seconds, 43520 images, 1324.672017 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.093152 seconds

 1361: 18.243301, 19.124317 avg loss, 0.001300 rate, 14.179272 seconds, 43552 images, 1325.527725 hours left
Loaded: 0.000031 seconds

 1362: 29.261923, 20.138077 avg loss, 0.001300 rate, 15.446137 seconds, 43584 images, 1332.061139 hours left
Loaded: 0.000029 seconds

 1363: 14.481656, 19.572435 avg loss, 0.001300 rate, 13.334166 seconds, 43616 images, 1340.156568 hours left
Loaded: 0.000039 seconds

 1364: 21.874678, 19.802660 avg loss, 0.001300 rate, 14.472160 seconds, 43648 images, 1345.242767 hours left
Loaded: 0.000035 seconds

 1365: 16.686964, 19.491091 avg loss, 0.001300 rate, 13.731676 seconds, 43680 images, 1351.855896 hours left
Loaded: 0.000029 seconds

 1366: 22.941187, 19.836100 avg loss, 0.001300 rate, 14.733140 seconds, 43712 images, 1357.376178 hours left
Loaded: 0.000028 seconds

 1367: 25.799990, 20.432489 avg loss, 0.001300 rate, 14.941233 seconds, 43744 images, 1364.229723 hours left
Loaded: 0.000037 seconds

 1368: 15.213825, 19.910624 avg loss, 0.001300 rate, 13.471418 seconds, 43776 images, 1371.303208 hours left
Loaded: 0.000037 seconds

 1369: 21.222446, 20.041805 avg loss, 0.001300 rate, 13.848490 seconds, 43808 images, 1376.268063 hours left
Loaded: 0.000026 seconds

 1370: 27.915850, 20.829210 avg loss, 0.001300 rate, 14.907776 seconds, 43840 images, 1381.706033 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.472680 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1371: 20.999786, 20.846268 avg loss, 0.001300 rate, 7.241730 seconds, 43872 images, 1388.558237 hours left
Loaded: 0.000028 seconds

 1372: 18.440825, 20.605724 avg loss, 0.001300 rate, 7.127193 seconds, 43904 images, 1385.368462 hours left
Loaded: 0.000029 seconds

 1373: 22.330906, 20.778242 avg loss, 0.001300 rate, 7.420679 seconds, 43936 images, 1381.396446 hours left
Loaded: 0.000029 seconds

 1374: 18.711620, 20.571581 avg loss, 0.001300 rate, 7.184881 seconds, 43968 images, 1377.871037 hours left
Loaded: 0.000029 seconds

 1375: 26.535938, 21.168016 avg loss, 0.001300 rate, 7.838597 seconds, 44000 images, 1374.053939 hours left
Loaded: 0.000032 seconds

 1376: 23.843676, 21.435583 avg loss, 0.001300 rate, 7.727835 seconds, 44032 images, 1371.181343 hours left
Loaded: 0.000031 seconds

 1377: 23.759275, 21.667952 avg loss, 0.001300 rate, 7.602713 seconds, 44064 images, 1368.183888 hours left
Loaded: 0.000030 seconds

 1378: 14.989199, 21.000076 avg loss, 0.001300 rate, 6.971685 seconds, 44096 images, 1365.042907 hours left
Loaded: 0.000036 seconds

 1379: 18.326834, 20.732752 avg loss, 0.001300 rate, 7.392664 seconds, 44128 images, 1361.058439 hours left
Loaded: 0.000031 seconds

 1380: 21.823723, 20.841848 avg loss, 0.001300 rate, 7.795417 seconds, 44160 images, 1357.697456 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.313727 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1381: 16.954988, 20.453163 avg loss, 0.001300 rate, 6.522124 seconds, 44192 images, 1354.928449 hours left
Loaded: 0.000030 seconds

 1382: 21.883511, 20.596197 avg loss, 0.001300 rate, 7.000719 seconds, 44224 images, 1350.856687 hours left
Loaded: 0.000028 seconds

 1383: 29.269350, 21.463512 avg loss, 0.001300 rate, 7.472878 seconds, 44256 images, 1347.054243 hours left
Loaded: 0.000039 seconds

 1384: 24.644939, 21.781654 avg loss, 0.001300 rate, 6.969823 seconds, 44288 images, 1343.944421 hours left
Loaded: 0.000030 seconds

 1385: 19.025007, 21.505989 avg loss, 0.001300 rate, 6.561449 seconds, 44320 images, 1340.168240 hours left
Loaded: 0.000032 seconds

 1386: 23.567274, 21.712118 avg loss, 0.001300 rate, 6.816862 seconds, 44352 images, 1335.863605 hours left
Loaded: 0.000036 seconds

 1387: 14.077663, 20.948673 avg loss, 0.001300 rate, 6.024571 seconds, 44384 images, 1331.956111 hours left
Loaded: 0.000039 seconds

 1388: 22.541868, 21.107992 avg loss, 0.001300 rate, 6.606805 seconds, 44416 images, 1326.989230 hours left
Loaded: 0.000038 seconds

 1389: 14.649834, 20.462177 avg loss, 0.001300 rate, 5.937752 seconds, 44448 images, 1322.879226 hours left
Loaded: 0.000031 seconds

 1390: 21.044355, 20.520395 avg loss, 0.001300 rate, 6.572955 seconds, 44480 images, 1317.882713 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 1391: 23.290287, 20.797384 avg loss, 0.001300 rate, 17.307778 seconds, 44512 images, 1313.816797 hours left
Loaded: 0.000034 seconds

 1392: 23.300579, 21.047703 avg loss, 0.001300 rate, 17.384109 seconds, 44544 images, 1324.674422 hours left
Loaded: 0.000029 seconds

 1393: 25.153252, 21.458258 avg loss, 0.001300 rate, 17.662218 seconds, 44576 images, 1335.529258 hours left
Loaded: 0.000031 seconds

 1394: 21.223488, 21.434780 avg loss, 0.001300 rate, 16.321259 seconds, 44608 images, 1346.661065 hours left
Loaded: 0.000029 seconds

 1395: 21.197161, 21.411018 avg loss, 0.001300 rate, 16.079989 seconds, 44640 images, 1355.822395 hours left
Loaded: 0.000031 seconds

 1396: 19.612885, 21.231205 avg loss, 0.001300 rate, 16.040841 seconds, 44672 images, 1364.557566 hours left
Loaded: 0.000028 seconds

 1397: 21.062479, 21.214333 avg loss, 0.001300 rate, 16.019804 seconds, 44704 images, 1373.151068 hours left
Loaded: 0.000030 seconds

 1398: 24.104120, 21.503311 avg loss, 0.001300 rate, 16.731191 seconds, 44736 images, 1381.629420 hours left
Loaded: 0.000029 seconds

 1399: 18.367922, 21.189772 avg loss, 0.001300 rate, 15.449858 seconds, 44768 images, 1391.009210 hours left
Loaded: 0.000036 seconds

 1400: 20.416857, 21.112480 avg loss, 0.001300 rate, 16.173550 seconds, 44800 images, 1398.518725 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.488382 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1401: 21.209837, 21.122215 avg loss, 0.001300 rate, 8.349739 seconds, 44832 images, 1406.956430 hours left
Loaded: 0.000029 seconds

 1402: 27.051792, 21.715174 avg loss, 0.001300 rate, 8.672612 seconds, 44864 images, 1405.139926 hours left
Loaded: 0.000037 seconds

 1403: 12.933184, 20.836975 avg loss, 0.001300 rate, 7.286310 seconds, 44896 images, 1403.112145 hours left
Loaded: 0.000030 seconds

 1404: 18.275513, 20.580830 avg loss, 0.001300 rate, 8.060459 seconds, 44928 images, 1399.182687 hours left
Loaded: 0.000030 seconds

 1405: 22.635286, 20.786276 avg loss, 0.001300 rate, 8.318971 seconds, 44960 images, 1396.365756 hours left
Loaded: 0.000033 seconds

 1406: 18.988821, 20.606531 avg loss, 0.001300 rate, 7.835252 seconds, 44992 images, 1393.935380 hours left
Loaded: 0.000037 seconds

 1407: 20.327742, 20.578651 avg loss, 0.001300 rate, 8.069826 seconds, 45024 images, 1390.858660 hours left
Loaded: 0.000038 seconds

 1408: 14.547895, 19.975576 avg loss, 0.001300 rate, 7.655542 seconds, 45056 images, 1388.137897 hours left
Loaded: 0.000038 seconds

 1409: 23.919516, 20.369970 avg loss, 0.001300 rate, 8.463322 seconds, 45088 images, 1384.869971 hours left
Loaded: 0.000037 seconds

 1410: 17.943560, 20.127329 avg loss, 0.001300 rate, 7.683431 seconds, 45120 images, 1382.754582 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 1411: 20.700794, 20.184675 avg loss, 0.001300 rate, 14.835084 seconds, 45152 images, 1379.579110 hours left
Loaded: 0.000029 seconds

 1412: 11.746017, 19.340809 avg loss, 0.001300 rate, 13.327465 seconds, 45184 images, 1386.350114 hours left
Loaded: 0.000038 seconds

 1413: 20.371811, 19.443909 avg loss, 0.001300 rate, 14.739277 seconds, 45216 images, 1390.963272 hours left
Loaded: 0.000028 seconds

 1414: 21.197699, 19.619287 avg loss, 0.001300 rate, 14.477094 seconds, 45248 images, 1397.487543 hours left
Loaded: 0.000029 seconds

 1415: 12.858006, 18.943159 avg loss, 0.001300 rate, 13.357658 seconds, 45280 images, 1403.583038 hours left
Loaded: 0.000029 seconds

 1416: 24.000761, 19.448919 avg loss, 0.001300 rate, 15.967933 seconds, 45312 images, 1408.065612 hours left
Loaded: 0.000029 seconds

 1417: 23.935398, 19.897568 avg loss, 0.001300 rate, 15.723278 seconds, 45344 images, 1416.122066 hours left
Loaded: 0.000029 seconds

 1418: 16.731342, 19.580946 avg loss, 0.001300 rate, 14.132712 seconds, 45376 images, 1423.758734 hours left
Loaded: 0.000030 seconds

 1419: 20.951336, 19.717985 avg loss, 0.001300 rate, 15.263607 seconds, 45408 images, 1429.113930 hours left
Loaded: 0.000029 seconds

 1420: 23.795856, 20.125772 avg loss, 0.001300 rate, 15.427394 seconds, 45440 images, 1435.983335 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.336370 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1421: 21.333452, 20.246540 avg loss, 0.001300 rate, 6.291500 seconds, 45472 images, 1443.011067 hours left
Loaded: 0.000043 seconds

 1422: 18.357519, 20.057638 avg loss, 0.001300 rate, 6.236008 seconds, 45504 images, 1437.769387 hours left
Loaded: 0.000028 seconds

 1423: 20.699194, 20.121794 avg loss, 0.001300 rate, 6.166934 seconds, 45536 images, 1432.036916 hours left
Loaded: 0.000036 seconds

 1424: 19.803530, 20.089968 avg loss, 0.001300 rate, 6.341138 seconds, 45568 images, 1426.265973 hours left
Loaded: 0.000030 seconds

 1425: 23.016659, 20.382637 avg loss, 0.001300 rate, 6.372915 seconds, 45600 images, 1420.794238 hours left
Loaded: 0.000029 seconds

 1426: 21.447929, 20.489166 avg loss, 0.001300 rate, 6.230235 seconds, 45632 images, 1415.421247 hours left
Loaded: 0.000028 seconds

 1427: 20.811260, 20.521376 avg loss, 0.001300 rate, 6.109813 seconds, 45664 images, 1409.904164 hours left
Loaded: 0.000029 seconds

 1428: 21.089239, 20.578161 avg loss, 0.001300 rate, 6.249919 seconds, 45696 images, 1404.275294 hours left
Loaded: 0.000024 seconds

 1429: 21.979528, 20.718298 avg loss, 0.001300 rate, 6.044547 seconds, 45728 images, 1398.896927 hours left
Loaded: 0.000029 seconds

 1430: 18.743637, 20.520832 avg loss, 0.001300 rate, 5.866095 seconds, 45760 images, 1393.287609 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 1431: 17.827595, 20.251509 avg loss, 0.001300 rate, 10.167941 seconds, 45792 images, 1387.486986 hours left
Loaded: 0.000027 seconds

 1432: 16.870754, 19.913433 avg loss, 0.001300 rate, 10.070699 seconds, 45824 images, 1387.708008 hours left
Loaded: 0.000026 seconds

 1433: 21.763971, 20.098488 avg loss, 0.001300 rate, 10.558188 seconds, 45856 images, 1387.791988 hours left
Loaded: 0.000025 seconds

 1434: 17.844761, 19.873116 avg loss, 0.001300 rate, 10.354540 seconds, 45888 images, 1388.550902 hours left
Loaded: 0.000035 seconds

 1435: 18.876781, 19.773481 avg loss, 0.001300 rate, 10.893956 seconds, 45920 images, 1389.019880 hours left
Loaded: 0.000031 seconds

 1436: 15.415572, 19.337690 avg loss, 0.001300 rate, 10.580657 seconds, 45952 images, 1390.231945 hours left
Loaded: 0.000029 seconds

 1437: 24.527205, 19.856642 avg loss, 0.001300 rate, 11.842185 seconds, 45984 images, 1390.997531 hours left
Loaded: 0.000026 seconds

 1438: 28.008429, 20.671820 avg loss, 0.001300 rate, 11.820871 seconds, 46016 images, 1393.504268 hours left
Loaded: 0.000030 seconds

 1439: 18.410324, 20.445671 avg loss, 0.001300 rate, 10.749232 seconds, 46048 images, 1395.956351 hours left
Loaded: 0.000041 seconds

 1440: 21.137482, 20.514853 avg loss, 0.001300 rate, 10.849904 seconds, 46080 images, 1396.898294 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.037761 seconds

 1441: 18.018459, 20.265213 avg loss, 0.001300 rate, 14.726306 seconds, 46112 images, 1397.970364 hours left
Loaded: 0.000033 seconds

 1442: 14.703654, 19.709057 avg loss, 0.001300 rate, 14.307303 seconds, 46144 images, 1404.457731 hours left
Loaded: 0.000027 seconds

 1443: 19.189987, 19.657150 avg loss, 0.001300 rate, 15.312659 seconds, 46176 images, 1410.247029 hours left
Loaded: 0.000029 seconds

 1444: 18.264730, 19.517908 avg loss, 0.001300 rate, 15.329204 seconds, 46208 images, 1417.372081 hours left
Loaded: 0.000028 seconds

 1445: 12.292042, 18.795322 avg loss, 0.001300 rate, 14.215315 seconds, 46240 images, 1424.448779 hours left
Loaded: 0.000028 seconds

 1446: 24.706583, 19.386448 avg loss, 0.001300 rate, 16.312670 seconds, 46272 images, 1429.910521 hours left
Loaded: 0.000028 seconds

 1447: 25.892107, 20.037014 avg loss, 0.001300 rate, 16.934907 seconds, 46304 images, 1438.225086 hours left
Loaded: 0.000031 seconds

 1448: 23.753613, 20.408674 avg loss, 0.001300 rate, 16.211626 seconds, 46336 images, 1447.319044 hours left
Loaded: 0.000028 seconds

 1449: 18.787615, 20.246569 avg loss, 0.001300 rate, 15.300804 seconds, 46368 images, 1455.319366 hours left
Loaded: 0.000030 seconds

 1450: 23.928860, 20.614798 avg loss, 0.001300 rate, 16.045903 seconds, 46400 images, 1461.977007 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.459900 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1451: 23.643700, 20.917688 avg loss, 0.001300 rate, 6.392198 seconds, 46432 images, 1469.600924 hours left
Loaded: 0.000037 seconds

 1452: 30.117128, 21.837633 avg loss, 0.001300 rate, 6.701012 seconds, 46464 images, 1464.403631 hours left
Loaded: 0.000033 seconds

 1453: 28.086994, 22.462570 avg loss, 0.001300 rate, 6.387187 seconds, 46496 images, 1459.048900 hours left
Loaded: 0.000029 seconds

 1454: 18.897041, 22.106018 avg loss, 0.001300 rate, 6.025494 seconds, 46528 images, 1453.312654 hours left
Loaded: 0.000030 seconds

 1455: 20.205954, 21.916012 avg loss, 0.001300 rate, 5.966481 seconds, 46560 images, 1447.132355 hours left
Loaded: 0.000032 seconds

 1456: 18.181915, 21.542603 avg loss, 0.001300 rate, 5.716283 seconds, 46592 images, 1440.932038 hours left
Loaded: 0.000049 seconds

 1457: 14.727142, 20.861057 avg loss, 0.001300 rate, 5.608038 seconds, 46624 images, 1434.446875 hours left
Loaded: 0.000036 seconds

 1458: 14.691003, 20.244051 avg loss, 0.001300 rate, 5.800634 seconds, 46656 images, 1427.876521 hours left
Loaded: 0.000037 seconds

 1459: 12.267454, 19.446392 avg loss, 0.001300 rate, 5.538944 seconds, 46688 images, 1421.638816 hours left
Loaded: 0.000030 seconds

 1460: 17.278688, 19.229622 avg loss, 0.001300 rate, 5.723739 seconds, 46720 images, 1415.100716 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000034 seconds

 1461: 13.071324, 18.613792 avg loss, 0.001300 rate, 12.850066 seconds, 46752 images, 1408.884136 hours left
Loaded: 0.000036 seconds

 1462: 14.008759, 18.153290 avg loss, 0.001300 rate, 13.023101 seconds, 46784 images, 1412.608367 hours left
Loaded: 0.000031 seconds

 1463: 24.879721, 18.825933 avg loss, 0.001300 rate, 15.247351 seconds, 46816 images, 1416.535187 hours left
Loaded: 0.000030 seconds

 1464: 21.099550, 19.053295 avg loss, 0.001300 rate, 13.633880 seconds, 46848 images, 1423.505982 hours left
Loaded: 0.000026 seconds

 1465: 19.638432, 19.111809 avg loss, 0.001300 rate, 13.245309 seconds, 46880 images, 1428.170415 hours left
Loaded: 0.000029 seconds

 1466: 18.692282, 19.069857 avg loss, 0.001300 rate, 13.257691 seconds, 46912 images, 1432.249516 hours left
Loaded: 0.000033 seconds

 1467: 23.498030, 19.512674 avg loss, 0.001300 rate, 14.066527 seconds, 46944 images, 1436.304958 hours left
Loaded: 0.000039 seconds

 1468: 25.683992, 20.129807 avg loss, 0.001300 rate, 15.087560 seconds, 46976 images, 1441.441027 hours left
Loaded: 0.000029 seconds

 1469: 15.212856, 19.638111 avg loss, 0.001300 rate, 13.253850 seconds, 47008 images, 1447.941060 hours left
Loaded: 0.000029 seconds

 1470: 14.855449, 19.159845 avg loss, 0.001300 rate, 12.648606 seconds, 47040 images, 1451.834153 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.497805 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1471: 16.956266, 18.939487 avg loss, 0.001300 rate, 12.067979 seconds, 47072 images, 1454.849291 hours left
Loaded: 0.000034 seconds

 1472: 24.277742, 19.473312 avg loss, 0.001300 rate, 12.869664 seconds, 47104 images, 1457.719396 hours left
Loaded: 0.000029 seconds

 1473: 18.436930, 19.369675 avg loss, 0.001300 rate, 12.360184 seconds, 47136 images, 1460.982047 hours left
Loaded: 0.000028 seconds

 1474: 19.700981, 19.402805 avg loss, 0.001300 rate, 12.276329 seconds, 47168 images, 1463.505795 hours left
Loaded: 0.000026 seconds

 1475: 20.552759, 19.517801 avg loss, 0.001300 rate, 12.412475 seconds, 47200 images, 1465.888031 hours left
Loaded: 0.000035 seconds

 1476: 21.318993, 19.697920 avg loss, 0.001300 rate, 12.716247 seconds, 47232 images, 1468.435133 hours left
Loaded: 0.000029 seconds

 1477: 20.462812, 19.774408 avg loss, 0.001300 rate, 12.608799 seconds, 47264 images, 1471.377823 hours left
Loaded: 0.000029 seconds

 1478: 21.692152, 19.966183 avg loss, 0.001300 rate, 13.325638 seconds, 47296 images, 1474.142100 hours left
Loaded: 0.000029 seconds

 1479: 12.660592, 19.235624 avg loss, 0.001300 rate, 12.246396 seconds, 47328 images, 1477.872362 hours left
Loaded: 0.000029 seconds

 1480: 21.129143, 19.424976 avg loss, 0.001300 rate, 13.478917 seconds, 47360 images, 1480.069273 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.072890 seconds

 1481: 23.303883, 19.812866 avg loss, 0.001300 rate, 16.416528 seconds, 47392 images, 1483.952659 hours left
Loaded: 0.000031 seconds

 1482: 18.039061, 19.635487 avg loss, 0.001300 rate, 15.305635 seconds, 47424 images, 1491.970183 hours left
Loaded: 0.000038 seconds

 1483: 18.870449, 19.558983 avg loss, 0.001300 rate, 15.681391 seconds, 47456 images, 1498.266612 hours left
Loaded: 0.000037 seconds

 1484: 20.734316, 19.676516 avg loss, 0.001300 rate, 15.983642 seconds, 47488 images, 1505.020901 hours left
Loaded: 0.000030 seconds

 1485: 24.324156, 20.141279 avg loss, 0.001300 rate, 16.586662 seconds, 47520 images, 1512.126574 hours left
Loaded: 0.000030 seconds

 1486: 16.700916, 19.797243 avg loss, 0.001300 rate, 14.887733 seconds, 47552 images, 1519.997011 hours left
Loaded: 0.000028 seconds

 1487: 19.750616, 19.792580 avg loss, 0.001300 rate, 15.516739 seconds, 47584 images, 1525.433726 hours left
Loaded: 0.000030 seconds

 1488: 18.968472, 19.710169 avg loss, 0.001300 rate, 15.643363 seconds, 47616 images, 1531.687925 hours left
Loaded: 0.000036 seconds

 1489: 23.618008, 20.100952 avg loss, 0.001300 rate, 16.298448 seconds, 47648 images, 1538.055075 hours left
Loaded: 0.000030 seconds

 1490: 19.454233, 20.036280 avg loss, 0.001300 rate, 15.342043 seconds, 47680 images, 1545.266547 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.595697 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1491: 22.423244, 20.274977 avg loss, 0.001300 rate, 13.604938 seconds, 47712 images, 1551.080143 hours left
Loaded: 0.000033 seconds

 1492: 18.079666, 20.055447 avg loss, 0.001300 rate, 13.219199 seconds, 47744 images, 1555.253368 hours left
Loaded: 0.000036 seconds

 1493: 27.742233, 20.824125 avg loss, 0.001300 rate, 14.620479 seconds, 47776 images, 1558.024466 hours left
Loaded: 0.000038 seconds

 1494: 20.573929, 20.799107 avg loss, 0.001300 rate, 13.496543 seconds, 47808 images, 1562.710179 hours left
Loaded: 0.000029 seconds

 1495: 18.437857, 20.562981 avg loss, 0.001300 rate, 13.124728 seconds, 47840 images, 1565.791077 hours left
Loaded: 0.000039 seconds

 1496: 25.353991, 21.042082 avg loss, 0.001300 rate, 14.526731 seconds, 47872 images, 1568.325734 hours left
Loaded: 0.000048 seconds

 1497: 23.946512, 21.332525 avg loss, 0.001300 rate, 14.267769 seconds, 47904 images, 1572.778369 hours left
Loaded: 0.000039 seconds

 1498: 17.282724, 20.927546 avg loss, 0.001300 rate, 13.147328 seconds, 47936 images, 1576.827499 hours left
Loaded: 0.000041 seconds

 1499: 27.565794, 21.591370 avg loss, 0.001300 rate, 14.438709 seconds, 47968 images, 1579.283021 hours left
Loaded: 0.000028 seconds

 1500: 21.917957, 21.624029 avg loss, 0.001300 rate, 13.803337 seconds, 48000 images, 1583.503956 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.455295 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1501: 21.408731, 21.602499 avg loss, 0.001300 rate, 7.055568 seconds, 48032 images, 1586.801928 hours left
Loaded: 0.000026 seconds

 1502: 19.654543, 21.407703 avg loss, 0.001300 rate, 7.038615 seconds, 48064 images, 1581.344791 hours left
Loaded: 0.000023 seconds

 1503: 20.577154, 21.324648 avg loss, 0.001300 rate, 7.218950 seconds, 48096 images, 1575.287655 hours left
Loaded: 0.000027 seconds

 1504: 24.668026, 21.658985 avg loss, 0.001300 rate, 7.562732 seconds, 48128 images, 1569.541030 hours left
Loaded: 0.000027 seconds

 1505: 17.608362, 21.253923 avg loss, 0.001300 rate, 6.988032 seconds, 48160 images, 1564.328370 hours left
Loaded: 0.000034 seconds

 1506: 14.656611, 20.594193 avg loss, 0.001300 rate, 6.634470 seconds, 48192 images, 1558.371227 hours left
Loaded: 0.000041 seconds

 1507: 21.453598, 20.680134 avg loss, 0.001300 rate, 7.342293 seconds, 48224 images, 1551.983575 hours left
Loaded: 0.000036 seconds

 1508: 21.926052, 20.804726 avg loss, 0.001300 rate, 7.320202 seconds, 48256 images, 1546.640900 hours left
Loaded: 0.000037 seconds

 1509: 17.165670, 20.440821 avg loss, 0.001300 rate, 6.913194 seconds, 48288 images, 1541.321004 hours left
Loaded: 0.000028 seconds

 1510: 19.546692, 20.351408 avg loss, 0.001300 rate, 7.092059 seconds, 48320 images, 1535.490140 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.316700 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1511: 18.579601, 20.174227 avg loss, 0.001300 rate, 5.615172 seconds, 48352 images, 1529.965474 hours left
Loaded: 0.000028 seconds

 1512: 16.401140, 19.796919 avg loss, 0.001300 rate, 5.517837 seconds, 48384 images, 1522.887886 hours left
Loaded: 0.000030 seconds

 1513: 20.856129, 19.902840 avg loss, 0.001300 rate, 5.753254 seconds, 48416 images, 1515.307209 hours left
Loaded: 0.000028 seconds

 1514: 18.152599, 19.727816 avg loss, 0.001300 rate, 5.517216 seconds, 48448 images, 1508.128633 hours left
Loaded: 0.000030 seconds

 1515: 15.565305, 19.311565 avg loss, 0.001300 rate, 5.307302 seconds, 48480 images, 1500.694657 hours left
Loaded: 0.000029 seconds

 1516: 20.458090, 19.426218 avg loss, 0.001300 rate, 5.697818 seconds, 48512 images, 1493.044068 hours left
Loaded: 0.000028 seconds

 1517: 24.288630, 19.912458 avg loss, 0.001300 rate, 5.931458 seconds, 48544 images, 1486.011236 hours left
Loaded: 0.000030 seconds

 1518: 17.784431, 19.699656 avg loss, 0.001300 rate, 5.363873 seconds, 48576 images, 1479.372554 hours left
Loaded: 0.000026 seconds

 1519: 12.211862, 18.950876 avg loss, 0.001300 rate, 5.046515 seconds, 48608 images, 1472.013537 hours left
Loaded: 0.000034 seconds

 1520: 13.668580, 18.422647 avg loss, 0.001300 rate, 5.175273 seconds, 48640 images, 1464.288214 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.000030 seconds

 1521: 20.583031, 18.638685 avg loss, 0.001300 rate, 10.218324 seconds, 48672 images, 1456.818606 hours left
Loaded: 0.000029 seconds

 1522: 20.582012, 18.833017 avg loss, 0.001300 rate, 10.408293 seconds, 48704 images, 1456.413610 hours left
Loaded: 0.000029 seconds

 1523: 21.078819, 19.057598 avg loss, 0.001300 rate, 10.549385 seconds, 48736 images, 1456.275944 hours left
Loaded: 0.000030 seconds

 1524: 18.020239, 18.953861 avg loss, 0.001300 rate, 10.114513 seconds, 48768 images, 1456.335184 hours left
Loaded: 0.000029 seconds

 1525: 25.452568, 19.603731 avg loss, 0.001300 rate, 10.492878 seconds, 48800 images, 1455.791052 hours left
Loaded: 0.000029 seconds

 1526: 20.391289, 19.682487 avg loss, 0.001300 rate, 10.046376 seconds, 48832 images, 1455.776762 hours left
Loaded: 0.000029 seconds

 1527: 23.318005, 20.046040 avg loss, 0.001300 rate, 10.353170 seconds, 48864 images, 1455.143715 hours left
Loaded: 0.000036 seconds

 1528: 22.363903, 20.277826 avg loss, 0.001300 rate, 10.369103 seconds, 48896 images, 1454.942198 hours left
Loaded: 0.000037 seconds

 1529: 18.123493, 20.062393 avg loss, 0.001300 rate, 9.835924 seconds, 48928 images, 1454.764762 hours left
Loaded: 0.000041 seconds

 1530: 17.480997, 19.804253 avg loss, 0.001300 rate, 9.552769 seconds, 48960 images, 1453.850069 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.233508 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1531: 19.913382, 19.815166 avg loss, 0.001300 rate, 6.318737 seconds, 48992 images, 1452.552041 hours left
Loaded: 0.000027 seconds

 1532: 17.748642, 19.608515 avg loss, 0.001300 rate, 6.237928 seconds, 49024 images, 1447.108109 hours left
Loaded: 0.000029 seconds

 1533: 23.669645, 20.014627 avg loss, 0.001300 rate, 6.585075 seconds, 49056 images, 1441.282986 hours left
Loaded: 0.000039 seconds

 1534: 22.165340, 20.229698 avg loss, 0.001300 rate, 6.448893 seconds, 49088 images, 1435.997252 hours left
Loaded: 0.000041 seconds

 1535: 25.257414, 20.732470 avg loss, 0.001300 rate, 6.657935 seconds, 49120 images, 1430.575619 hours left
Loaded: 0.000038 seconds

 1536: 12.611593, 19.920382 avg loss, 0.001300 rate, 5.773002 seconds, 49152 images, 1425.497924 hours left
Loaded: 0.000030 seconds

 1537: 21.063776, 20.034721 avg loss, 0.001300 rate, 6.544424 seconds, 49184 images, 1419.244455 hours left
Loaded: 0.000035 seconds

 1538: 22.628317, 20.294081 avg loss, 0.001300 rate, 6.775476 seconds, 49216 images, 1414.122691 hours left
Loaded: 0.000038 seconds

 1539: 21.778934, 20.442566 avg loss, 0.001300 rate, 6.586994 seconds, 49248 images, 1409.372372 hours left
Loaded: 0.000038 seconds

 1540: 20.860029, 20.484312 avg loss, 0.001300 rate, 6.597449 seconds, 49280 images, 1404.408307 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 1541: 13.689073, 19.804789 avg loss, 0.001300 rate, 14.292029 seconds, 49312 images, 1399.508355 hours left
Loaded: 0.000028 seconds

 1542: 18.343033, 19.658613 avg loss, 0.001300 rate, 15.287364 seconds, 49344 images, 1405.322033 hours left
Loaded: 0.000027 seconds

 1543: 20.900764, 19.782829 avg loss, 0.001300 rate, 15.411763 seconds, 49376 images, 1412.457076 hours left
Loaded: 0.000026 seconds

 1544: 21.143930, 19.918940 avg loss, 0.001300 rate, 15.858677 seconds, 49408 images, 1419.693129 hours left
Loaded: 0.000027 seconds

 1545: 11.429624, 19.070007 avg loss, 0.001300 rate, 14.473012 seconds, 49440 images, 1427.476197 hours left
Loaded: 0.000030 seconds

 1546: 21.964478, 19.359455 avg loss, 0.001300 rate, 16.598952 seconds, 49472 images, 1433.260880 hours left
Loaded: 0.000023 seconds

 1547: 17.210199, 19.144529 avg loss, 0.001300 rate, 15.434462 seconds, 49504 images, 1441.934198 hours left
Loaded: 0.000031 seconds

 1548: 19.901775, 19.220253 avg loss, 0.001300 rate, 16.406274 seconds, 49536 images, 1448.906767 hours left
Loaded: 0.000030 seconds

 1549: 24.174131, 19.715641 avg loss, 0.001300 rate, 17.357746 seconds, 49568 images, 1457.156487 hours left
Loaded: 0.000028 seconds

 1550: 22.590799, 20.003157 avg loss, 0.001300 rate, 16.369700 seconds, 49600 images, 1466.642378 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.350768 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1551: 17.554598, 19.758301 avg loss, 0.001300 rate, 8.047250 seconds, 49632 images, 1474.663955 hours left
Loaded: 0.000029 seconds

 1552: 19.381756, 19.720646 avg loss, 0.001300 rate, 8.344103 seconds, 49664 images, 1471.556726 hours left
Loaded: 0.000029 seconds

 1553: 25.378265, 20.286407 avg loss, 0.001300 rate, 8.659442 seconds, 49696 images, 1468.405861 hours left
Loaded: 0.000038 seconds

 1554: 22.403027, 20.498070 avg loss, 0.001300 rate, 8.296023 seconds, 49728 images, 1465.723531 hours left
Loaded: 0.000037 seconds

 1555: 21.096685, 20.557932 avg loss, 0.001300 rate, 7.944726 seconds, 49760 images, 1462.564327 hours left
Loaded: 0.000037 seconds

 1556: 22.099337, 20.712072 avg loss, 0.001300 rate, 8.218313 seconds, 49792 images, 1458.949807 hours left
Loaded: 0.000037 seconds

 1557: 13.188141, 19.959679 avg loss, 0.001300 rate, 7.447164 seconds, 49824 images, 1455.750590 hours left
Loaded: 0.000037 seconds

 1558: 15.740705, 19.537781 avg loss, 0.001300 rate, 7.555193 seconds, 49856 images, 1451.514566 hours left
Loaded: 0.000033 seconds

 1559: 17.572630, 19.341267 avg loss, 0.001300 rate, 8.098167 seconds, 49888 images, 1447.470604 hours left
Loaded: 0.000030 seconds

 1560: 29.450954, 20.352236 avg loss, 0.001300 rate, 9.103655 seconds, 49920 images, 1444.219591 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.302833 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1561: 16.206259, 19.937637 avg loss, 0.001300 rate, 5.973171 seconds, 49952 images, 1442.394610 hours left
Loaded: 0.000038 seconds

 1562: 15.836341, 19.527508 avg loss, 0.001300 rate, 5.938438 seconds, 49984 images, 1436.668852 hours left
Loaded: 0.000038 seconds

 1563: 25.654591, 20.140217 avg loss, 0.001300 rate, 6.533939 seconds, 50016 images, 1430.532542 hours left
Loaded: 0.000039 seconds

 1564: 16.221350, 19.748329 avg loss, 0.001300 rate, 6.009935 seconds, 50048 images, 1425.282905 hours left
Loaded: 0.000038 seconds

 1565: 24.381401, 20.211636 avg loss, 0.001300 rate, 6.514012 seconds, 50080 images, 1419.359512 hours left
Loaded: 0.000038 seconds

 1566: 20.827454, 20.273218 avg loss, 0.001300 rate, 6.222160 seconds, 50112 images, 1414.193951 hours left
Loaded: 0.000030 seconds

 1567: 25.744293, 20.820326 avg loss, 0.001300 rate, 6.507750 seconds, 50144 images, 1408.675541 hours left
Loaded: 0.000032 seconds

 1568: 19.192879, 20.657581 avg loss, 0.001300 rate, 6.175285 seconds, 50176 images, 1403.608094 hours left
Loaded: 0.000039 seconds

 1569: 15.464142, 20.138237 avg loss, 0.001300 rate, 5.866783 seconds, 50208 images, 1398.130536 hours left
Loaded: 0.000040 seconds

 1570: 11.208654, 19.245279 avg loss, 0.001300 rate, 5.610111 seconds, 50240 images, 1392.280187 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.287384 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1571: 19.325994, 19.253351 avg loss, 0.001300 rate, 5.573932 seconds, 50272 images, 1386.132612 hours left
Loaded: 0.000031 seconds

 1572: 24.235859, 19.751602 avg loss, 0.001300 rate, 6.013412 seconds, 50304 images, 1380.394580 hours left
Loaded: 0.000030 seconds

 1573: 26.915913, 20.468033 avg loss, 0.001300 rate, 6.323554 seconds, 50336 images, 1374.924746 hours left
Loaded: 0.000030 seconds

 1574: 18.635136, 20.284742 avg loss, 0.001300 rate, 5.679520 seconds, 50368 images, 1369.939418 hours left
Loaded: 0.000028 seconds

 1575: 17.193691, 19.975637 avg loss, 0.001300 rate, 5.348035 seconds, 50400 images, 1364.111357 hours left
Loaded: 0.000036 seconds

 1576: 23.376081, 20.315681 avg loss, 0.001300 rate, 6.107810 seconds, 50432 images, 1357.882151 hours left
Loaded: 0.000030 seconds

 1577: 23.217070, 20.605820 avg loss, 0.001300 rate, 6.230716 seconds, 50464 images, 1352.768207 hours left
Loaded: 0.000038 seconds

 1578: 21.854996, 20.730738 avg loss, 0.001300 rate, 5.859304 seconds, 50496 images, 1347.875711 hours left
Loaded: 0.000031 seconds

 1579: 16.996515, 20.357315 avg loss, 0.001300 rate, 5.662851 seconds, 50528 images, 1342.517396 hours left
Loaded: 0.000037 seconds

 1580: 19.919455, 20.313530 avg loss, 0.001300 rate, 5.818246 seconds, 50560 images, 1336.940377 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.021046 seconds

 1581: 16.164114, 19.898588 avg loss, 0.001300 rate, 6.179026 seconds, 50592 images, 1331.634480 hours left
Loaded: 0.000027 seconds

 1582: 20.432432, 19.951973 avg loss, 0.001300 rate, 6.599708 seconds, 50624 images, 1326.910741 hours left
Loaded: 0.000038 seconds

 1583: 26.382719, 20.595047 avg loss, 0.001300 rate, 7.079835 seconds, 50656 images, 1322.788109 hours left
Loaded: 0.000041 seconds

 1584: 14.580538, 19.993595 avg loss, 0.001300 rate, 6.028272 seconds, 50688 images, 1319.372102 hours left
Loaded: 0.000037 seconds

 1585: 21.849142, 20.179150 avg loss, 0.001300 rate, 6.580549 seconds, 50720 images, 1314.532899 hours left
Loaded: 0.000038 seconds

 1586: 12.174020, 19.378637 avg loss, 0.001300 rate, 5.964964 seconds, 50752 images, 1310.507454 hours left
Loaded: 0.000039 seconds

 1587: 18.548660, 19.295639 avg loss, 0.001300 rate, 6.493859 seconds, 50784 images, 1305.669125 hours left
Loaded: 0.000031 seconds

 1588: 22.722084, 19.638283 avg loss, 0.001300 rate, 6.746587 seconds, 50816 images, 1301.612141 hours left
Loaded: 0.000038 seconds

 1589: 19.544968, 19.628952 avg loss, 0.001300 rate, 6.280250 seconds, 50848 images, 1297.945947 hours left
Loaded: 0.000034 seconds

 1590: 16.119808, 19.278038 avg loss, 0.001300 rate, 5.983249 seconds, 50880 images, 1293.670128 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 1591: 14.712377, 18.821472 avg loss, 0.001300 rate, 6.593843 seconds, 50912 images, 1289.025440 hours left
Loaded: 0.000030 seconds

 1592: 18.061598, 18.745485 avg loss, 0.001300 rate, 6.877248 seconds, 50944 images, 1285.273367 hours left
Loaded: 0.000032 seconds

 1593: 22.150417, 19.085979 avg loss, 0.001300 rate, 7.080678 seconds, 50976 images, 1281.951560 hours left
Loaded: 0.000030 seconds

 1594: 22.841978, 19.461578 avg loss, 0.001300 rate, 7.202270 seconds, 51008 images, 1278.944878 hours left
Loaded: 0.000031 seconds

 1595: 21.760403, 19.691462 avg loss, 0.001300 rate, 7.166442 seconds, 51040 images, 1276.136750 hours left
Loaded: 0.000029 seconds

 1596: 25.922997, 20.314615 avg loss, 0.001300 rate, 7.448330 seconds, 51072 images, 1273.307032 hours left
Loaded: 0.000037 seconds

 1597: 19.184038, 20.201557 avg loss, 0.001300 rate, 6.884917 seconds, 51104 images, 1270.896241 hours left
Loaded: 0.000040 seconds

 1598: 17.205593, 19.901960 avg loss, 0.001300 rate, 6.717651 seconds, 51136 images, 1267.728749 hours left
Loaded: 0.000033 seconds

 1599: 26.767052, 20.588470 avg loss, 0.001300 rate, 7.269289 seconds, 51168 images, 1264.361122 hours left
Loaded: 0.000033 seconds

 1600: 15.833999, 20.113024 avg loss, 0.001300 rate, 6.605211 seconds, 51200 images, 1261.791613 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 1601: 21.967785, 20.298500 avg loss, 0.001300 rate, 13.904104 seconds, 51232 images, 1258.327477 hours left
Loaded: 0.000031 seconds

 1602: 19.443724, 20.213022 avg loss, 0.001300 rate, 13.010584 seconds, 51264 images, 1265.012987 hours left
Loaded: 0.000033 seconds

 1603: 17.163815, 19.908102 avg loss, 0.001300 rate, 13.177115 seconds, 51296 images, 1270.393341 hours left
Loaded: 0.000028 seconds

 1604: 18.587244, 19.776016 avg loss, 0.001300 rate, 13.383733 seconds, 51328 images, 1275.950643 hours left
Loaded: 0.000028 seconds

 1605: 19.912285, 19.789642 avg loss, 0.001300 rate, 13.624231 seconds, 51360 images, 1281.738664 hours left
Loaded: 0.000032 seconds

 1606: 22.315432, 20.042221 avg loss, 0.001300 rate, 14.053108 seconds, 51392 images, 1287.802054 hours left
Loaded: 0.000029 seconds

 1607: 19.724859, 20.010485 avg loss, 0.001300 rate, 13.357170 seconds, 51424 images, 1294.399123 hours left
Loaded: 0.000028 seconds

 1608: 18.431767, 19.852613 avg loss, 0.001300 rate, 13.178265 seconds, 51456 images, 1299.965738 hours left
Loaded: 0.000028 seconds

 1609: 17.659819, 19.633333 avg loss, 0.001300 rate, 13.213868 seconds, 51488 images, 1305.228719 hours left
Loaded: 0.000030 seconds

 1610: 22.752813, 19.945282 avg loss, 0.001300 rate, 14.121796 seconds, 51520 images, 1310.488371 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.314046 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1611: 17.414017, 19.692156 avg loss, 0.001300 rate, 6.775630 seconds, 51552 images, 1316.953606 hours left
Loaded: 0.000027 seconds

 1612: 12.309942, 18.953934 avg loss, 0.001300 rate, 6.426567 seconds, 51584 images, 1313.608974 hours left
Loaded: 0.000029 seconds

 1613: 18.746059, 18.933146 avg loss, 0.001300 rate, 6.858052 seconds, 51616 images, 1309.378871 hours left
Loaded: 0.000028 seconds

 1614: 18.013344, 18.841166 avg loss, 0.001300 rate, 6.888002 seconds, 51648 images, 1305.789005 hours left
Loaded: 0.000028 seconds

 1615: 16.938465, 18.650896 avg loss, 0.001300 rate, 6.812934 seconds, 51680 images, 1302.276519 hours left
Loaded: 0.000029 seconds

 1616: 22.291666, 19.014973 avg loss, 0.001300 rate, 7.383381 seconds, 51712 images, 1298.695113 hours left
Loaded: 0.000029 seconds

 1617: 24.550589, 19.568535 avg loss, 0.001300 rate, 7.596712 seconds, 51744 images, 1295.940023 hours left
Loaded: 0.000028 seconds

 1618: 17.791960, 19.390877 avg loss, 0.001300 rate, 7.037029 seconds, 51776 images, 1293.508093 hours left
Loaded: 0.000030 seconds

 1619: 16.008495, 19.052639 avg loss, 0.001300 rate, 6.895030 seconds, 51808 images, 1290.324861 hours left
Loaded: 0.000028 seconds

 1620: 19.697205, 19.117096 avg loss, 0.001300 rate, 7.124339 seconds, 51840 images, 1286.976665 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000036 seconds

 1621: 21.425714, 19.347958 avg loss, 0.001300 rate, 14.921379 seconds, 51872 images, 1283.979700 hours left
Loaded: 0.000029 seconds

 1622: 19.929630, 19.406124 avg loss, 0.001300 rate, 14.320077 seconds, 51904 images, 1291.817640 hours left
Loaded: 0.000029 seconds

 1623: 22.680313, 19.733543 avg loss, 0.001300 rate, 14.728570 seconds, 51936 images, 1298.743883 hours left
Loaded: 0.000028 seconds

 1624: 21.175602, 19.877748 avg loss, 0.001300 rate, 14.873918 seconds, 51968 images, 1306.166899 hours left
Loaded: 0.000028 seconds

 1625: 27.618622, 20.651836 avg loss, 0.001300 rate, 16.532851 seconds, 52000 images, 1313.717061 hours left
Loaded: 0.000028 seconds

 1626: 21.258507, 20.712503 avg loss, 0.001300 rate, 15.132941 seconds, 52032 images, 1323.490585 hours left
Loaded: 0.000030 seconds

 1627: 10.957673, 19.737020 avg loss, 0.001300 rate, 13.145576 seconds, 52064 images, 1331.226373 hours left
Loaded: 0.000029 seconds

 1628: 20.138819, 19.777201 avg loss, 0.001300 rate, 15.232360 seconds, 52096 images, 1336.130775 hours left
Loaded: 0.000033 seconds

 1629: 24.280457, 20.227526 avg loss, 0.001300 rate, 15.956403 seconds, 52128 images, 1343.877849 hours left
Loaded: 0.000029 seconds

 1630: 20.735643, 20.278337 avg loss, 0.001300 rate, 15.105534 seconds, 52160 images, 1352.550759 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.321478 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1631: 20.811195, 20.331623 avg loss, 0.001300 rate, 5.761249 seconds, 52192 images, 1359.957799 hours left
Loaded: 0.000040 seconds

 1632: 19.018246, 20.200285 avg loss, 0.001300 rate, 5.885566 seconds, 52224 images, 1354.787357 hours left
Loaded: 0.000039 seconds

 1633: 13.829329, 19.563189 avg loss, 0.001300 rate, 5.077433 seconds, 52256 images, 1349.395441 hours left
Loaded: 0.000039 seconds

 1634: 14.949261, 19.101795 avg loss, 0.001300 rate, 5.186742 seconds, 52288 images, 1342.937563 hours left
Loaded: 0.000036 seconds

 1635: 15.661473, 18.757763 avg loss, 0.001300 rate, 5.236796 seconds, 52320 images, 1336.695725 hours left
Loaded: 0.000038 seconds

 1636: 22.104939, 19.092480 avg loss, 0.001300 rate, 5.699669 seconds, 52352 images, 1330.585647 hours left
Loaded: 0.000036 seconds

 1637: 25.886827, 19.771915 avg loss, 0.001300 rate, 5.757849 seconds, 52384 images, 1325.178077 hours left
Loaded: 0.000037 seconds

 1638: 18.935114, 19.688236 avg loss, 0.001300 rate, 5.226635 seconds, 52416 images, 1319.905184 hours left
Loaded: 0.000037 seconds

 1639: 17.114164, 19.430828 avg loss, 0.001300 rate, 5.386443 seconds, 52448 images, 1313.948890 hours left
Loaded: 0.000030 seconds

 1640: 22.505386, 19.738283 avg loss, 0.001300 rate, 5.856300 seconds, 52480 images, 1308.273594 hours left
Resizing, random_coef = 1.40 

 384 x 384 
 try to allocate additional workspace_size = 42.47 MB 
 CUDA allocate done! 
Loaded: 0.326476 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1641: 20.420759, 19.806530 avg loss, 0.001300 rate, 5.070618 seconds, 52512 images, 1303.306118 hours left
Loaded: 0.000040 seconds

 1642: 29.599722, 20.785849 avg loss, 0.001300 rate, 5.314771 seconds, 52544 images, 1297.751927 hours left
Loaded: 0.000038 seconds

 1643: 15.723553, 20.279619 avg loss, 0.001300 rate, 4.675868 seconds, 52576 images, 1292.139243 hours left
Loaded: 0.000030 seconds

 1644: 19.645920, 20.216249 avg loss, 0.001300 rate, 4.729581 seconds, 52608 images, 1285.697331 hours left
Loaded: 0.000032 seconds

 1645: 17.931286, 19.987753 avg loss, 0.001300 rate, 4.765056 seconds, 52640 images, 1279.394247 hours left
Loaded: 0.000038 seconds

 1646: 19.144789, 19.903456 avg loss, 0.001300 rate, 4.923701 seconds, 52672 images, 1273.203340 hours left
Loaded: 0.000037 seconds

 1647: 22.615170, 20.174627 avg loss, 0.001300 rate, 5.066258 seconds, 52704 images, 1267.294173 hours left
Loaded: 0.000037 seconds

 1648: 16.783422, 19.835506 avg loss, 0.001300 rate, 4.771772 seconds, 52736 images, 1261.641629 hours left
Loaded: 0.000038 seconds

 1649: 24.330540, 20.285009 avg loss, 0.001300 rate, 5.172601 seconds, 52768 images, 1255.637523 hours left
Loaded: 0.000031 seconds

 1650: 19.608534, 20.217361 avg loss, 0.001300 rate, 4.912245 seconds, 52800 images, 1250.248874 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.027437 seconds

 1651: 19.488153, 20.144440 avg loss, 0.001300 rate, 5.731570 seconds, 52832 images, 1244.553312 hours left
Loaded: 0.000031 seconds

 1652: 19.774504, 20.107447 avg loss, 0.001300 rate, 5.682735 seconds, 52864 images, 1240.088002 hours left
Loaded: 0.000040 seconds

 1653: 15.909560, 19.687658 avg loss, 0.001300 rate, 5.469599 seconds, 52896 images, 1235.561694 hours left
Loaded: 0.000032 seconds

 1654: 25.430075, 20.261900 avg loss, 0.001300 rate, 6.206194 seconds, 52928 images, 1230.785293 hours left
Loaded: 0.000029 seconds

 1655: 23.517954, 20.587505 avg loss, 0.001300 rate, 6.165263 seconds, 52960 images, 1227.077318 hours left
Loaded: 0.000030 seconds

 1656: 26.345158, 21.163271 avg loss, 0.001300 rate, 6.353308 seconds, 52992 images, 1223.349684 hours left
Loaded: 0.000031 seconds

 1657: 16.447449, 20.691689 avg loss, 0.001300 rate, 5.578722 seconds, 53024 images, 1219.919879 hours left
Loaded: 0.000035 seconds

 1658: 20.422842, 20.664804 avg loss, 0.001300 rate, 5.813516 seconds, 53056 images, 1215.451033 hours left
Loaded: 0.000038 seconds

 1659: 20.995985, 20.697922 avg loss, 0.001300 rate, 5.960096 seconds, 53088 images, 1211.352211 hours left
Loaded: 0.000030 seconds

 1660: 18.957102, 20.523840 avg loss, 0.001300 rate, 5.856783 seconds, 53120 images, 1207.497479 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000032 seconds

 1661: 27.255360, 21.196993 avg loss, 0.001300 rate, 14.109054 seconds, 53152 images, 1203.538107 hours left
Loaded: 0.000029 seconds

 1662: 12.945096, 20.371803 avg loss, 0.001300 rate, 11.741470 seconds, 53184 images, 1211.053191 hours left
Loaded: 0.000028 seconds

 1663: 27.135506, 21.048174 avg loss, 0.001300 rate, 14.305673 seconds, 53216 images, 1215.212411 hours left
Loaded: 0.000029 seconds

 1664: 24.046440, 21.348000 avg loss, 0.001300 rate, 13.712493 seconds, 53248 images, 1222.883116 hours left
Loaded: 0.000030 seconds

 1665: 22.887865, 21.501986 avg loss, 0.001300 rate, 13.270949 seconds, 53280 images, 1229.655133 hours left
Loaded: 0.000032 seconds

 1666: 22.607531, 21.612539 avg loss, 0.001300 rate, 13.539778 seconds, 53312 images, 1235.747564 hours left
Loaded: 0.000029 seconds

 1667: 23.370907, 21.788376 avg loss, 0.001300 rate, 13.637814 seconds, 53344 images, 1242.151540 hours left
Loaded: 0.000028 seconds

 1668: 19.140453, 21.523584 avg loss, 0.001300 rate, 12.077746 seconds, 53376 images, 1248.627277 hours left
Loaded: 0.000029 seconds

 1669: 16.946283, 21.065855 avg loss, 0.001300 rate, 11.850830 seconds, 53408 images, 1252.876518 hours left
Loaded: 0.000028 seconds

 1670: 22.808073, 21.240076 avg loss, 0.001300 rate, 12.815836 seconds, 53440 images, 1256.768811 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.268637 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1671: 15.571893, 20.673258 avg loss, 0.001300 rate, 6.855348 seconds, 53472 images, 1261.959297 hours left
Loaded: 0.000033 seconds

 1672: 17.711826, 20.377115 avg loss, 0.001300 rate, 7.120249 seconds, 53504 images, 1259.210967 hours left
Loaded: 0.000039 seconds

 1673: 23.638107, 20.703215 avg loss, 0.001300 rate, 7.505013 seconds, 53536 images, 1256.484991 hours left
Loaded: 0.000040 seconds

 1674: 14.513447, 20.084238 avg loss, 0.001300 rate, 6.687392 seconds, 53568 images, 1254.319383 hours left
Loaded: 0.000038 seconds

 1675: 23.106340, 20.386448 avg loss, 0.001300 rate, 7.457143 seconds, 53600 images, 1251.042495 hours left
Loaded: 0.000037 seconds

 1676: 24.456463, 20.793449 avg loss, 0.001300 rate, 7.640218 seconds, 53632 images, 1248.864940 hours left
Loaded: 0.000038 seconds

 1677: 21.318394, 20.845943 avg loss, 0.001300 rate, 7.261265 seconds, 53664 images, 1246.962810 hours left
Loaded: 0.000029 seconds

 1678: 19.270655, 20.688416 avg loss, 0.001300 rate, 7.055816 seconds, 53696 images, 1244.554599 hours left
Loaded: 0.000031 seconds

 1679: 19.545031, 20.574078 avg loss, 0.001300 rate, 7.160984 seconds, 53728 images, 1241.885763 hours left
Loaded: 0.000029 seconds

 1680: 20.951077, 20.611778 avg loss, 0.001300 rate, 7.258370 seconds, 53760 images, 1239.389320 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 1681: 14.585453, 20.009146 avg loss, 0.001300 rate, 8.568704 seconds, 53792 images, 1237.052759 hours left
Loaded: 0.000031 seconds

 1682: 18.692303, 19.877460 avg loss, 0.001300 rate, 8.927198 seconds, 53824 images, 1236.555150 hours left
Loaded: 0.000029 seconds

 1683: 20.413830, 19.931097 avg loss, 0.001300 rate, 9.249560 seconds, 53856 images, 1236.559230 hours left
Loaded: 0.000039 seconds

 1684: 20.759541, 20.013941 avg loss, 0.001300 rate, 9.174140 seconds, 53888 images, 1237.009907 hours left
Loaded: 0.000031 seconds

 1685: 17.123301, 19.724876 avg loss, 0.001300 rate, 8.860132 seconds, 53920 images, 1237.351562 hours left
Loaded: 0.000027 seconds

 1686: 21.951710, 19.947559 avg loss, 0.001300 rate, 9.817742 seconds, 53952 images, 1237.254677 hours left
Loaded: 0.000033 seconds

 1687: 20.874020, 20.040205 avg loss, 0.001300 rate, 9.638289 seconds, 53984 images, 1238.485591 hours left
Loaded: 0.000040 seconds

 1688: 21.688969, 20.205082 avg loss, 0.001300 rate, 9.362876 seconds, 54016 images, 1239.455528 hours left
Loaded: 0.000032 seconds

 1689: 19.303631, 20.114937 avg loss, 0.001300 rate, 9.617361 seconds, 54048 images, 1240.034140 hours left
Loaded: 0.000029 seconds

 1690: 18.668242, 19.970268 avg loss, 0.001300 rate, 9.268160 seconds, 54080 images, 1240.959538 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.414231 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1691: 18.492132, 19.822454 avg loss, 0.001300 rate, 8.530442 seconds, 54112 images, 1241.391803 hours left
Loaded: 0.000028 seconds

 1692: 21.312124, 19.971422 avg loss, 0.001300 rate, 8.708464 seconds, 54144 images, 1241.371464 hours left
Loaded: 0.000029 seconds

 1693: 14.406722, 19.414951 avg loss, 0.001300 rate, 7.974491 seconds, 54176 images, 1241.024056 hours left
Loaded: 0.000040 seconds

 1694: 22.896606, 19.763117 avg loss, 0.001300 rate, 9.033760 seconds, 54208 images, 1239.663124 hours left
Loaded: 0.000037 seconds

 1695: 20.059433, 19.792747 avg loss, 0.001300 rate, 8.574481 seconds, 54240 images, 1239.783487 hours left
Loaded: 0.000041 seconds

 1696: 26.476809, 20.461153 avg loss, 0.001300 rate, 9.477331 seconds, 54272 images, 1239.266255 hours left
Loaded: 0.000041 seconds

 1697: 16.635168, 20.078554 avg loss, 0.001300 rate, 7.565409 seconds, 54304 images, 1240.005137 hours left
Loaded: 0.000026 seconds

 1698: 17.716305, 19.842329 avg loss, 0.001300 rate, 7.710668 seconds, 54336 images, 1238.087511 hours left
Loaded: 0.000034 seconds

 1699: 15.302001, 19.388296 avg loss, 0.001300 rate, 7.424538 seconds, 54368 images, 1236.390286 hours left
Loaded: 0.000023 seconds

 1700: 15.554127, 19.004879 avg loss, 0.001300 rate, 7.167874 seconds, 54400 images, 1234.313573 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.499454 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1701: 19.699768, 19.074368 avg loss, 0.001300 rate, 8.129686 seconds, 54432 images, 1231.901968 hours left
Loaded: 0.000030 seconds

 1702: 17.704445, 18.937376 avg loss, 0.001300 rate, 8.028090 seconds, 54464 images, 1231.539091 hours left
Loaded: 0.000028 seconds

 1703: 21.468937, 19.190533 avg loss, 0.001300 rate, 8.250050 seconds, 54496 images, 1230.347074 hours left
Loaded: 0.000039 seconds

 1704: 21.922920, 19.463772 avg loss, 0.001300 rate, 8.037093 seconds, 54528 images, 1229.474490 hours left
Loaded: 0.000026 seconds

 1705: 21.608656, 19.678261 avg loss, 0.001300 rate, 7.995962 seconds, 54560 images, 1228.315561 hours left
Loaded: 0.000030 seconds

 1706: 18.472719, 19.557707 avg loss, 0.001300 rate, 7.567096 seconds, 54592 images, 1227.111191 hours left
Loaded: 0.000035 seconds

 1707: 21.907433, 19.792679 avg loss, 0.001300 rate, 7.941440 seconds, 54624 images, 1225.324639 hours left
Loaded: 0.000026 seconds

 1708: 18.823862, 19.695797 avg loss, 0.001300 rate, 7.600257 seconds, 54656 images, 1224.074606 hours left
Loaded: 0.000027 seconds

 1709: 18.550312, 19.581249 avg loss, 0.001300 rate, 7.802775 seconds, 54688 images, 1222.364330 hours left
Loaded: 0.000034 seconds

 1710: 23.825403, 20.005665 avg loss, 0.001300 rate, 8.286850 seconds, 54720 images, 1220.951720 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.249408 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1711: 19.611279, 19.966227 avg loss, 0.001300 rate, 5.856637 seconds, 54752 images, 1220.223923 hours left
Loaded: 0.000030 seconds

 1712: 17.793514, 19.748955 avg loss, 0.001300 rate, 5.596259 seconds, 54784 images, 1216.481776 hours left
Loaded: 0.000041 seconds

 1713: 22.961321, 20.070190 avg loss, 0.001300 rate, 5.900796 seconds, 54816 images, 1212.070754 hours left
Loaded: 0.000030 seconds

 1714: 22.544338, 20.317606 avg loss, 0.001300 rate, 5.789829 seconds, 54848 images, 1208.125783 hours left
Loaded: 0.000029 seconds

 1715: 19.927820, 20.278627 avg loss, 0.001300 rate, 5.889034 seconds, 54880 images, 1204.066484 hours left
Loaded: 0.000025 seconds

 1716: 20.683121, 20.319077 avg loss, 0.001300 rate, 5.607266 seconds, 54912 images, 1200.185213 hours left
Loaded: 0.000026 seconds

 1717: 17.898310, 20.077000 avg loss, 0.001300 rate, 5.577162 seconds, 54944 images, 1195.952336 hours left
Loaded: 0.000035 seconds

 1718: 18.666531, 19.935953 avg loss, 0.001300 rate, 5.543969 seconds, 54976 images, 1191.720065 hours left
Loaded: 0.000029 seconds

 1719: 23.600010, 20.302359 avg loss, 0.001300 rate, 5.773597 seconds, 55008 images, 1187.484126 hours left
Loaded: 0.000029 seconds

 1720: 16.499247, 19.922047 avg loss, 0.001300 rate, 5.430295 seconds, 55040 images, 1183.608672 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.008231 seconds

 1721: 24.673462, 20.397188 avg loss, 0.001300 rate, 10.446968 seconds, 55072 images, 1179.296312 hours left
Loaded: 0.000028 seconds

 1722: 22.697378, 20.627207 avg loss, 0.001300 rate, 10.032886 seconds, 55104 images, 1181.989012 hours left
Loaded: 0.000028 seconds

 1723: 21.231930, 20.687679 avg loss, 0.001300 rate, 9.981305 seconds, 55136 images, 1184.069680 hours left
Loaded: 0.000027 seconds

 1724: 19.557158, 20.574627 avg loss, 0.001300 rate, 9.695096 seconds, 55168 images, 1186.058050 hours left
Loaded: 0.000035 seconds

 1725: 17.312164, 20.248381 avg loss, 0.001300 rate, 9.600000 seconds, 55200 images, 1187.629967 hours left
Loaded: 0.000029 seconds

 1726: 16.136400, 19.837183 avg loss, 0.001300 rate, 9.276569 seconds, 55232 images, 1189.054395 hours left
Loaded: 0.000027 seconds

 1727: 11.330139, 18.986479 avg loss, 0.001300 rate, 8.982803 seconds, 55264 images, 1190.016436 hours left
Loaded: 0.000035 seconds

 1728: 19.988979, 19.086729 avg loss, 0.001300 rate, 9.960771 seconds, 55296 images, 1190.561822 hours left
Loaded: 0.000034 seconds

 1729: 13.211423, 18.499199 avg loss, 0.001300 rate, 9.006215 seconds, 55328 images, 1192.456691 hours left
Loaded: 0.000036 seconds

 1730: 16.058033, 18.255083 avg loss, 0.001300 rate, 9.534913 seconds, 55360 images, 1193.010070 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.325764 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1731: 18.498301, 18.279406 avg loss, 0.001300 rate, 5.355940 seconds, 55392 images, 1194.290387 hours left
Loaded: 0.000037 seconds

 1732: 20.820717, 18.533537 avg loss, 0.001300 rate, 5.442703 seconds, 55424 images, 1190.219323 hours left
Loaded: 0.000027 seconds

 1733: 19.868879, 18.667070 avg loss, 0.001300 rate, 5.525611 seconds, 55456 images, 1185.857876 hours left
Loaded: 0.000030 seconds

 1734: 20.435787, 18.843943 avg loss, 0.001300 rate, 5.572661 seconds, 55488 images, 1181.654881 hours left
Loaded: 0.000027 seconds

 1735: 22.367760, 19.196325 avg loss, 0.001300 rate, 5.701480 seconds, 55520 images, 1177.559090 hours left
Loaded: 0.000032 seconds

 1736: 20.992477, 19.375940 avg loss, 0.001300 rate, 5.737121 seconds, 55552 images, 1173.682726 hours left
Loaded: 0.000025 seconds

 1737: 21.458569, 19.584204 avg loss, 0.001300 rate, 5.632642 seconds, 55584 images, 1169.894489 hours left
Loaded: 0.000038 seconds

 1738: 21.164127, 19.742197 avg loss, 0.001300 rate, 5.588702 seconds, 55616 images, 1165.999350 hours left
Loaded: 0.000041 seconds

 1739: 20.042717, 19.772249 avg loss, 0.001300 rate, 5.500095 seconds, 55648 images, 1162.082290 hours left
Loaded: 0.000039 seconds

 1740: 12.507635, 19.045788 avg loss, 0.001300 rate, 5.184438 seconds, 55680 images, 1158.081629 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.041398 seconds

 1741: 16.862064, 18.827415 avg loss, 0.001300 rate, 9.490446 seconds, 55712 images, 1153.683632 hours left
Loaded: 0.000028 seconds

 1742: 23.520487, 19.296722 avg loss, 0.001300 rate, 10.398007 seconds, 55744 images, 1155.352622 hours left
Loaded: 0.000038 seconds

 1743: 23.755924, 19.742643 avg loss, 0.001300 rate, 10.968486 seconds, 55776 images, 1158.204951 hours left
Loaded: 0.000029 seconds

 1744: 21.379511, 19.906330 avg loss, 0.001300 rate, 10.654122 seconds, 55808 images, 1161.819105 hours left
Loaded: 0.000030 seconds

 1745: 23.377380, 20.253435 avg loss, 0.001300 rate, 11.069297 seconds, 55840 images, 1164.961544 hours left
Loaded: 0.000030 seconds

 1746: 24.383034, 20.666395 avg loss, 0.001300 rate, 10.938981 seconds, 55872 images, 1168.647726 hours left
Loaded: 0.000029 seconds

 1747: 21.994438, 20.799200 avg loss, 0.001300 rate, 10.910515 seconds, 55904 images, 1172.116472 hours left
Loaded: 0.000040 seconds

 1748: 21.416719, 20.860952 avg loss, 0.001300 rate, 10.689581 seconds, 55936 images, 1175.511060 hours left
Loaded: 0.000028 seconds

 1749: 14.484792, 20.223337 avg loss, 0.001300 rate, 9.762177 seconds, 55968 images, 1178.565602 hours left
Loaded: 0.000030 seconds

 1750: 18.719156, 20.072920 avg loss, 0.001300 rate, 10.440193 seconds, 56000 images, 1180.304708 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.492911 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1751: 21.082727, 20.173901 avg loss, 0.001300 rate, 10.823486 seconds, 56032 images, 1182.965734 hours left
Loaded: 0.000038 seconds

 1752: 17.935812, 19.950092 avg loss, 0.001300 rate, 10.411330 seconds, 56064 images, 1186.813984 hours left
Loaded: 0.000040 seconds

 1753: 23.139246, 20.269009 avg loss, 0.001300 rate, 11.022330 seconds, 56096 images, 1189.369883 hours left
Loaded: 0.000041 seconds

 1754: 18.321741, 20.074282 avg loss, 0.001300 rate, 10.309942 seconds, 56128 images, 1192.746682 hours left
Loaded: 0.000039 seconds

 1755: 22.235292, 20.290382 avg loss, 0.001300 rate, 10.960421 seconds, 56160 images, 1195.102738 hours left
Loaded: 0.000030 seconds

 1756: 23.610769, 20.622421 avg loss, 0.001300 rate, 10.292029 seconds, 56192 images, 1198.336374 hours left
Loaded: 0.000026 seconds

 1757: 20.173485, 20.577528 avg loss, 0.001300 rate, 10.366919 seconds, 56224 images, 1200.611642 hours left
Loaded: 0.000035 seconds

 1758: 17.559525, 20.275728 avg loss, 0.001300 rate, 9.726981 seconds, 56256 images, 1202.967874 hours left
Loaded: 0.000034 seconds

 1759: 17.585171, 20.006672 avg loss, 0.001300 rate, 10.194730 seconds, 56288 images, 1204.413961 hours left
Loaded: 0.000029 seconds

 1760: 19.437965, 19.949800 avg loss, 0.001300 rate, 10.521392 seconds, 56320 images, 1206.493576 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000031 seconds

 1761: 22.892555, 20.244076 avg loss, 0.001300 rate, 16.706135 seconds, 56352 images, 1209.004914 hours left
Loaded: 0.000023 seconds

 1762: 15.301960, 19.749865 avg loss, 0.001300 rate, 14.823958 seconds, 56384 images, 1220.059369 hours left
Loaded: 0.000027 seconds

 1763: 19.764170, 19.751295 avg loss, 0.001300 rate, 16.970493 seconds, 56416 images, 1228.395695 hours left
Loaded: 0.000030 seconds

 1764: 14.232155, 19.199381 avg loss, 0.001300 rate, 14.924780 seconds, 56448 images, 1239.622380 hours left
Loaded: 0.000029 seconds

 1765: 13.337010, 18.613144 avg loss, 0.001300 rate, 15.279202 seconds, 56480 images, 1247.902668 hours left
Loaded: 0.000037 seconds

 1766: 23.116154, 19.063444 avg loss, 0.001300 rate, 17.718975 seconds, 56512 images, 1256.591120 hours left
Loaded: 0.000028 seconds

 1767: 22.965841, 19.453684 avg loss, 0.001300 rate, 16.823383 seconds, 56544 images, 1268.572650 hours left
Loaded: 0.000029 seconds

 1768: 26.172861, 20.125601 avg loss, 0.001300 rate, 17.873059 seconds, 56576 images, 1279.193575 hours left
Loaded: 0.000033 seconds

 1769: 27.420067, 20.855047 avg loss, 0.001300 rate, 18.438608 seconds, 56608 images, 1291.162435 hours left
Loaded: 0.000032 seconds

 1770: 17.227322, 20.492275 avg loss, 0.001300 rate, 15.598870 seconds, 56640 images, 1303.795051 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.668343 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1771: 23.185316, 20.761580 avg loss, 0.001300 rate, 16.061494 seconds, 56672 images, 1312.367224 hours left
Loaded: 0.000029 seconds

 1772: 15.625375, 20.247959 avg loss, 0.001300 rate, 13.993691 seconds, 56704 images, 1322.420384 hours left
Loaded: 0.000039 seconds

 1773: 15.848266, 19.807989 avg loss, 0.001300 rate, 13.754122 seconds, 56736 images, 1328.582472 hours left
Loaded: 0.000028 seconds

 1774: 22.586111, 20.085802 avg loss, 0.001300 rate, 14.940286 seconds, 56768 images, 1334.351025 hours left
Loaded: 0.000027 seconds

 1775: 22.749241, 20.352146 avg loss, 0.001300 rate, 15.128816 seconds, 56800 images, 1341.705091 hours left
Loaded: 0.000028 seconds

 1776: 23.602280, 20.677160 avg loss, 0.001300 rate, 15.189899 seconds, 56832 images, 1349.246752 hours left
Loaded: 0.000028 seconds

 1777: 15.435717, 20.153015 avg loss, 0.001300 rate, 13.519181 seconds, 56864 images, 1356.797578 hours left
Loaded: 0.000023 seconds

 1778: 11.428118, 19.280525 avg loss, 0.001300 rate, 13.626675 seconds, 56896 images, 1361.958338 hours left
Loaded: 0.000040 seconds

 1779: 14.087012, 18.761173 avg loss, 0.001300 rate, 14.178123 seconds, 56928 images, 1367.216365 hours left
Loaded: 0.000037 seconds

 1780: 11.961813, 18.081238 avg loss, 0.001300 rate, 13.695182 seconds, 56960 images, 1373.185737 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.346817 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1781: 22.814398, 18.554554 avg loss, 0.001300 rate, 6.390965 seconds, 56992 images, 1378.426336 hours left
Loaded: 0.000029 seconds

 1782: 21.826122, 18.881710 avg loss, 0.001300 rate, 6.276688 seconds, 57024 images, 1373.976141 hours left
Loaded: 0.000026 seconds

 1783: 20.874170, 19.080956 avg loss, 0.001300 rate, 5.993503 seconds, 57056 images, 1368.931702 hours left
Loaded: 0.000029 seconds

 1784: 16.433943, 18.816254 avg loss, 0.001300 rate, 5.807798 seconds, 57088 images, 1363.545383 hours left
Loaded: 0.000040 seconds

 1785: 19.315054, 18.866135 avg loss, 0.001300 rate, 5.724356 seconds, 57120 images, 1357.955654 hours left
Loaded: 0.000028 seconds

 1786: 19.886187, 18.968140 avg loss, 0.001300 rate, 5.588548 seconds, 57152 images, 1352.306228 hours left
Loaded: 0.000028 seconds

 1787: 24.710430, 19.542368 avg loss, 0.001300 rate, 5.901165 seconds, 57184 images, 1346.525125 hours left
Loaded: 0.000029 seconds

 1788: 20.699654, 19.658096 avg loss, 0.001300 rate, 5.566225 seconds, 57216 images, 1341.234891 hours left
Loaded: 0.000028 seconds

 1789: 19.334059, 19.625692 avg loss, 0.001300 rate, 5.448007 seconds, 57248 images, 1335.533548 hours left
Loaded: 0.000031 seconds

 1790: 16.112810, 19.274405 avg loss, 0.001300 rate, 5.207912 seconds, 57280 images, 1329.725433 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.004001 seconds

 1791: 17.654549, 19.112419 avg loss, 0.001300 rate, 6.984004 seconds, 57312 images, 1323.642797 hours left
Loaded: 0.000030 seconds

 1792: 27.774609, 19.978638 avg loss, 0.001300 rate, 7.864286 seconds, 57344 images, 1320.086886 hours left
Loaded: 0.000030 seconds

 1793: 15.899307, 19.570705 avg loss, 0.001300 rate, 6.857807 seconds, 57376 images, 1317.780468 hours left
Loaded: 0.000039 seconds

 1794: 19.969809, 19.610615 avg loss, 0.001300 rate, 7.197571 seconds, 57408 images, 1314.102818 hours left
Loaded: 0.000038 seconds

 1795: 18.477320, 19.497286 avg loss, 0.001300 rate, 7.112504 seconds, 57440 images, 1310.932613 hours left
Loaded: 0.000038 seconds

 1796: 23.220272, 19.869585 avg loss, 0.001300 rate, 7.543978 seconds, 57472 images, 1307.676245 hours left
Loaded: 0.000029 seconds

 1797: 32.902180, 21.172844 avg loss, 0.001300 rate, 8.550969 seconds, 57504 images, 1305.050138 hours left
Loaded: 0.000034 seconds

 1798: 21.052614, 21.160822 avg loss, 0.001300 rate, 7.441232 seconds, 57536 images, 1303.845230 hours left
Loaded: 0.000030 seconds

 1799: 21.236912, 21.168430 avg loss, 0.001300 rate, 7.400043 seconds, 57568 images, 1301.115053 hours left
Loaded: 0.000037 seconds

 1800: 15.412783, 20.592865 avg loss, 0.001300 rate, 6.904596 seconds, 57600 images, 1298.355092 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.144267 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1801: 27.410599, 21.274639 avg loss, 0.001300 rate, 9.060197 seconds, 57632 images, 1294.936394 hours left
Loaded: 0.000029 seconds

 1802: 15.438034, 20.690979 avg loss, 0.001300 rate, 7.952326 seconds, 57664 images, 1294.737757 hours left
Loaded: 0.000037 seconds

 1803: 15.088674, 20.130749 avg loss, 0.001300 rate, 7.813033 seconds, 57696 images, 1292.806569 hours left
Loaded: 0.000039 seconds

 1804: 24.075611, 20.525234 avg loss, 0.001300 rate, 8.854901 seconds, 57728 images, 1290.701725 hours left
Loaded: 0.000031 seconds

 1805: 22.880287, 20.760740 avg loss, 0.001300 rate, 8.123194 seconds, 57760 images, 1290.061173 hours left
Loaded: 0.000027 seconds

 1806: 18.468538, 20.531521 avg loss, 0.001300 rate, 7.789942 seconds, 57792 images, 1288.413383 hours left
Loaded: 0.000027 seconds

 1807: 19.691898, 20.447559 avg loss, 0.001300 rate, 7.720103 seconds, 57824 images, 1286.320403 hours left
Loaded: 0.000026 seconds

 1808: 21.171545, 20.519958 avg loss, 0.001300 rate, 8.044949 seconds, 57856 images, 1284.151584 hours left
Loaded: 0.000035 seconds

 1809: 19.582685, 20.426231 avg loss, 0.001300 rate, 7.669273 seconds, 57888 images, 1282.454425 hours left
Loaded: 0.000034 seconds

 1810: 25.528515, 20.936460 avg loss, 0.001300 rate, 8.157000 seconds, 57920 images, 1280.253823 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.000041 seconds

 1811: 16.834404, 20.526255 avg loss, 0.001300 rate, 10.224010 seconds, 57952 images, 1278.750828 hours left
Loaded: 0.000035 seconds

 1812: 13.036689, 19.777298 avg loss, 0.001300 rate, 9.676256 seconds, 57984 images, 1280.126170 hours left
Loaded: 0.000037 seconds

 1813: 11.238931, 18.923462 avg loss, 0.001300 rate, 9.503508 seconds, 58016 images, 1280.728949 hours left
Loaded: 0.000035 seconds

 1814: 20.687433, 19.099859 avg loss, 0.001300 rate, 10.861817 seconds, 58048 images, 1281.086379 hours left
Loaded: 0.000026 seconds

 1815: 18.618967, 19.051769 avg loss, 0.001300 rate, 10.611045 seconds, 58080 images, 1283.321787 hours left
Loaded: 0.000025 seconds

 1816: 20.204910, 19.167084 avg loss, 0.001300 rate, 10.727614 seconds, 58112 images, 1285.187420 hours left
Loaded: 0.000035 seconds

 1817: 22.827524, 19.533127 avg loss, 0.001300 rate, 10.994669 seconds, 58144 images, 1287.195842 hours left
Loaded: 0.000025 seconds

 1818: 16.989733, 19.278788 avg loss, 0.001300 rate, 10.410787 seconds, 58176 images, 1289.554095 hours left
Loaded: 0.000034 seconds

 1819: 15.076584, 18.858566 avg loss, 0.001300 rate, 10.030881 seconds, 58208 images, 1291.079928 hours left
Loaded: 0.000036 seconds

 1820: 25.257925, 19.498503 avg loss, 0.001300 rate, 11.507425 seconds, 58240 images, 1292.064216 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.405628 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1821: 17.540634, 19.302715 avg loss, 0.001300 rate, 8.786588 seconds, 58272 images, 1295.083975 hours left
Loaded: 0.000035 seconds

 1822: 24.997669, 19.872211 avg loss, 0.001300 rate, 9.561282 seconds, 58304 images, 1294.866386 hours left
Loaded: 0.000028 seconds

 1823: 22.104847, 20.095474 avg loss, 0.001300 rate, 9.151753 seconds, 58336 images, 1295.162230 hours left
Loaded: 0.000028 seconds

 1824: 15.603239, 19.646252 avg loss, 0.001300 rate, 8.450280 seconds, 58368 images, 1294.887794 hours left
Loaded: 0.000039 seconds

 1825: 19.781214, 19.659748 avg loss, 0.001300 rate, 8.966114 seconds, 58400 images, 1293.644389 hours left
Loaded: 0.000032 seconds

 1826: 21.942968, 19.888069 avg loss, 0.001300 rate, 9.386831 seconds, 58432 images, 1293.127948 hours left
Loaded: 0.000051 seconds

 1827: 27.841314, 20.683393 avg loss, 0.001300 rate, 9.863289 seconds, 58464 images, 1293.199415 hours left
Loaded: 0.000032 seconds

 1828: 18.790867, 20.494141 avg loss, 0.001300 rate, 9.070799 seconds, 58496 images, 1293.930163 hours left
Loaded: 0.000030 seconds

 1829: 17.151382, 20.159864 avg loss, 0.001300 rate, 9.078779 seconds, 58528 images, 1293.555789 hours left
Loaded: 0.000038 seconds

 1830: 22.963116, 20.440189 avg loss, 0.001300 rate, 9.652326 seconds, 58560 images, 1293.196186 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.338255 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1831: 18.902994, 20.286470 avg loss, 0.001300 rate, 5.759621 seconds, 58592 images, 1293.634639 hours left
Loaded: 0.000033 seconds

 1832: 23.639914, 20.621815 avg loss, 0.001300 rate, 6.085927 seconds, 58624 images, 1289.145035 hours left
Loaded: 0.000030 seconds

 1833: 24.335817, 20.993216 avg loss, 0.001300 rate, 6.231637 seconds, 58656 images, 1284.683804 hours left
Loaded: 0.000030 seconds

 1834: 24.278963, 21.321791 avg loss, 0.001300 rate, 6.233756 seconds, 58688 images, 1280.468998 hours left
Loaded: 0.000030 seconds

 1835: 22.925451, 21.482157 avg loss, 0.001300 rate, 6.095513 seconds, 58720 images, 1276.299258 hours left
Loaded: 0.000031 seconds

 1836: 19.281902, 21.262131 avg loss, 0.001300 rate, 5.813847 seconds, 58752 images, 1271.979707 hours left
Loaded: 0.000039 seconds

 1837: 20.261761, 21.162094 avg loss, 0.001300 rate, 5.754245 seconds, 58784 images, 1267.313179 hours left
Loaded: 0.000032 seconds

 1838: 21.371746, 21.183060 avg loss, 0.001300 rate, 5.841817 seconds, 58816 images, 1262.610750 hours left
Loaded: 0.000042 seconds

 1839: 13.799910, 20.444744 avg loss, 0.001300 rate, 5.423408 seconds, 58848 images, 1258.076622 hours left
Loaded: 0.000032 seconds

 1840: 22.253841, 20.625654 avg loss, 0.001300 rate, 5.978817 seconds, 58880 images, 1253.008265 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000029 seconds

 1841: 17.894922, 20.352581 avg loss, 0.001300 rate, 15.829938 seconds, 58912 images, 1248.759899 hours left
Loaded: 0.000030 seconds

 1842: 14.780781, 19.795401 avg loss, 0.001300 rate, 15.625813 seconds, 58944 images, 1258.199412 hours left
Loaded: 0.000031 seconds

 1843: 17.151728, 19.531033 avg loss, 0.001300 rate, 15.809586 seconds, 58976 images, 1267.261742 hours left
Loaded: 0.000028 seconds

 1844: 18.082867, 19.386215 avg loss, 0.001300 rate, 15.500308 seconds, 59008 images, 1276.487961 hours left
Loaded: 0.000031 seconds

 1845: 18.392782, 19.286873 avg loss, 0.001300 rate, 15.292969 seconds, 59040 images, 1285.193471 hours left
Loaded: 0.000036 seconds

 1846: 17.152721, 19.073458 avg loss, 0.001300 rate, 15.129280 seconds, 59072 images, 1293.524702 hours left
Loaded: 0.000032 seconds

 1847: 19.441303, 19.110243 avg loss, 0.001300 rate, 15.601980 seconds, 59104 images, 1301.545839 hours left
Loaded: 0.000038 seconds

 1848: 19.835039, 19.182722 avg loss, 0.001300 rate, 16.792863 seconds, 59136 images, 1310.141477 hours left
Loaded: 0.000027 seconds

 1849: 18.962669, 19.160717 avg loss, 0.001300 rate, 16.545148 seconds, 59168 images, 1320.300670 hours left
Loaded: 0.000033 seconds

 1850: 18.806818, 19.125328 avg loss, 0.001300 rate, 16.419278 seconds, 59200 images, 1330.015088 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.458109 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1851: 25.305124, 19.743307 avg loss, 0.001300 rate, 12.214502 seconds, 59232 images, 1339.457976 hours left
Loaded: 0.000026 seconds

 1852: 20.108309, 19.779808 avg loss, 0.001300 rate, 10.744098 seconds, 59264 images, 1343.616703 hours left
Loaded: 0.000022 seconds

 1853: 22.426577, 20.044485 avg loss, 0.001300 rate, 10.977904 seconds, 59296 images, 1345.062593 hours left
Loaded: 0.000026 seconds

 1854: 22.406322, 20.280668 avg loss, 0.001300 rate, 11.140897 seconds, 59328 images, 1346.817839 hours left
Loaded: 0.000027 seconds

 1855: 18.222857, 20.074886 avg loss, 0.001300 rate, 10.299082 seconds, 59360 images, 1348.781275 hours left
Loaded: 0.000026 seconds

 1856: 16.016392, 19.669037 avg loss, 0.001300 rate, 9.965781 seconds, 59392 images, 1349.559028 hours left
Loaded: 0.000027 seconds

 1857: 20.098700, 19.712004 avg loss, 0.001300 rate, 10.699590 seconds, 59424 images, 1349.867311 hours left
Loaded: 0.000034 seconds

 1858: 18.902796, 19.631083 avg loss, 0.001300 rate, 10.544582 seconds, 59456 images, 1351.188898 hours left
Loaded: 0.000039 seconds

 1859: 21.773979, 19.845371 avg loss, 0.001300 rate, 11.402763 seconds, 59488 images, 1352.282545 hours left
Loaded: 0.000030 seconds

 1860: 19.283436, 19.789177 avg loss, 0.001300 rate, 11.083294 seconds, 59520 images, 1354.553912 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.280614 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1861: 19.321674, 19.742426 avg loss, 0.001300 rate, 10.420102 seconds, 59552 images, 1356.360021 hours left
Loaded: 0.000032 seconds

 1862: 17.249527, 19.493135 avg loss, 0.001300 rate, 9.972884 seconds, 59584 images, 1357.618085 hours left
Loaded: 0.000031 seconds

 1863: 23.210529, 19.864876 avg loss, 0.001300 rate, 10.307722 seconds, 59616 images, 1357.855458 hours left
Loaded: 0.000037 seconds

 1864: 14.752871, 19.353676 avg loss, 0.001300 rate, 9.274044 seconds, 59648 images, 1358.554215 hours left
Loaded: 0.000028 seconds

 1865: 18.343346, 19.252644 avg loss, 0.001300 rate, 9.799233 seconds, 59680 images, 1357.814215 hours left
Loaded: 0.000037 seconds

 1866: 22.637413, 19.591120 avg loss, 0.001300 rate, 10.829100 seconds, 59712 images, 1357.809015 hours left
Loaded: 0.000030 seconds

 1867: 23.627176, 19.994726 avg loss, 0.001300 rate, 10.747393 seconds, 59744 images, 1359.230317 hours left
Loaded: 0.000032 seconds

 1868: 22.019150, 20.197168 avg loss, 0.001300 rate, 10.581477 seconds, 59776 images, 1360.524194 hours left
Loaded: 0.000029 seconds

 1869: 15.336884, 19.711140 avg loss, 0.001300 rate, 10.169708 seconds, 59808 images, 1361.575296 hours left
Loaded: 0.000030 seconds

 1870: 27.654549, 20.505480 avg loss, 0.001300 rate, 11.435256 seconds, 59840 images, 1362.045520 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.401518 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1871: 19.242079, 20.379139 avg loss, 0.001300 rate, 8.366687 seconds, 59872 images, 1364.263904 hours left
Loaded: 0.000031 seconds

 1872: 21.418270, 20.483051 avg loss, 0.001300 rate, 8.758549 seconds, 59904 images, 1362.765960 hours left
Loaded: 0.000037 seconds

 1873: 20.449675, 20.479713 avg loss, 0.001300 rate, 8.271314 seconds, 59936 images, 1361.269627 hours left
Loaded: 0.000039 seconds

 1874: 16.968740, 20.128616 avg loss, 0.001300 rate, 8.286556 seconds, 59968 images, 1359.113385 hours left
Loaded: 0.000037 seconds

 1875: 22.704786, 20.386234 avg loss, 0.001300 rate, 8.881524 seconds, 60000 images, 1356.999796 hours left
Loaded: 0.000038 seconds

 1876: 15.547339, 19.902346 avg loss, 0.001300 rate, 7.980752 seconds, 60032 images, 1355.731390 hours left
Loaded: 0.000037 seconds

 1877: 13.262690, 19.238380 avg loss, 0.001300 rate, 7.582073 seconds, 60064 images, 1353.228015 hours left
Loaded: 0.000029 seconds

 1878: 25.707663, 19.885309 avg loss, 0.001300 rate, 9.112505 seconds, 60096 images, 1350.197454 hours left
Loaded: 0.000026 seconds

 1879: 19.885391, 19.885317 avg loss, 0.001300 rate, 8.249973 seconds, 60128 images, 1349.316909 hours left
Loaded: 0.000030 seconds

 1880: 21.010468, 19.997831 avg loss, 0.001300 rate, 8.557975 seconds, 60160 images, 1347.250482 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.294498 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1881: 14.262205, 19.424269 avg loss, 0.001300 rate, 6.015000 seconds, 60192 images, 1345.631304 hours left
Loaded: 0.000038 seconds

 1882: 22.891966, 19.771038 avg loss, 0.001300 rate, 6.679740 seconds, 60224 images, 1340.913993 hours left
Loaded: 0.000040 seconds

 1883: 17.511614, 19.545095 avg loss, 0.001300 rate, 6.087691 seconds, 60256 images, 1336.756693 hours left
Loaded: 0.000039 seconds

 1884: 16.925770, 19.283163 avg loss, 0.001300 rate, 6.136616 seconds, 60288 images, 1331.820935 hours left
Loaded: 0.000040 seconds

 1885: 17.177879, 19.072636 avg loss, 0.001300 rate, 6.092498 seconds, 60320 images, 1327.002279 hours left
Loaded: 0.000039 seconds

 1886: 11.839192, 18.349291 avg loss, 0.001300 rate, 5.999959 seconds, 60352 images, 1322.170687 hours left
Loaded: 0.000031 seconds

 1887: 21.147753, 18.629137 avg loss, 0.001300 rate, 6.626507 seconds, 60384 images, 1317.259224 hours left
Loaded: 0.000038 seconds

 1888: 21.366396, 18.902863 avg loss, 0.001300 rate, 6.748973 seconds, 60416 images, 1313.264641 hours left
Loaded: 0.000031 seconds

 1889: 21.755722, 19.188148 avg loss, 0.001300 rate, 6.664205 seconds, 60448 images, 1309.479612 hours left
Loaded: 0.000031 seconds

 1890: 19.134455, 19.182779 avg loss, 0.001300 rate, 6.458025 seconds, 60480 images, 1305.615000 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 1891: 17.634296, 19.027931 avg loss, 0.001300 rate, 7.925336 seconds, 60512 images, 1301.503451 hours left
Loaded: 0.000028 seconds

 1892: 19.741596, 19.099298 avg loss, 0.001300 rate, 8.225979 seconds, 60544 images, 1299.465252 hours left
Loaded: 0.000030 seconds

 1893: 17.222208, 18.911589 avg loss, 0.001300 rate, 7.934657 seconds, 60576 images, 1297.863816 hours left
Loaded: 0.000029 seconds

 1894: 22.712828, 19.291712 avg loss, 0.001300 rate, 8.484985 seconds, 60608 images, 1295.874886 hours left
Loaded: 0.000027 seconds

 1895: 20.562706, 19.418812 avg loss, 0.001300 rate, 8.291729 seconds, 60640 images, 1294.668037 hours left
Loaded: 0.000035 seconds

 1896: 17.924789, 19.269409 avg loss, 0.001300 rate, 7.896702 seconds, 60672 images, 1293.205566 hours left
Loaded: 0.000029 seconds

 1897: 14.986673, 18.841135 avg loss, 0.001300 rate, 7.585220 seconds, 60704 images, 1291.210591 hours left
Loaded: 0.000029 seconds

 1898: 23.864840, 19.343506 avg loss, 0.001300 rate, 8.663531 seconds, 60736 images, 1288.804131 hours left
Loaded: 0.000029 seconds

 1899: 15.326329, 18.941788 avg loss, 0.001300 rate, 7.804952 seconds, 60768 images, 1287.915182 hours left
Loaded: 0.000029 seconds

 1900: 23.517698, 19.399380 avg loss, 0.001300 rate, 8.605088 seconds, 60800 images, 1285.845965 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.024738 seconds

 1901: 22.751207, 19.734562 avg loss, 0.001300 rate, 12.560187 seconds, 60832 images, 1284.905617 hours left
Loaded: 0.000027 seconds

 1902: 19.697521, 19.730858 avg loss, 0.001300 rate, 12.827334 seconds, 60864 images, 1289.486660 hours left
Loaded: 0.000031 seconds

 1903: 22.371510, 19.994923 avg loss, 0.001300 rate, 13.627374 seconds, 60896 images, 1294.357632 hours left
Loaded: 0.000025 seconds

 1904: 17.964403, 19.791870 avg loss, 0.001300 rate, 12.685052 seconds, 60928 images, 1300.287912 hours left
Loaded: 0.000039 seconds

 1905: 24.512463, 20.263929 avg loss, 0.001300 rate, 13.667195 seconds, 60960 images, 1304.853738 hours left
Loaded: 0.000038 seconds

 1906: 16.921547, 19.929691 avg loss, 0.001300 rate, 12.235516 seconds, 60992 images, 1310.734144 hours left
Loaded: 0.000026 seconds

 1907: 18.981894, 19.834911 avg loss, 0.001300 rate, 12.847017 seconds, 61024 images, 1314.572853 hours left
Loaded: 0.000033 seconds

 1908: 24.077805, 20.259201 avg loss, 0.001300 rate, 13.608998 seconds, 61056 images, 1319.220044 hours left
Loaded: 0.000051 seconds

 1909: 15.832356, 19.816517 avg loss, 0.001300 rate, 11.851986 seconds, 61088 images, 1324.876062 hours left
Loaded: 0.000038 seconds

 1910: 13.806866, 19.215551 avg loss, 0.001300 rate, 11.949953 seconds, 61120 images, 1328.042091 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.056452 seconds

 1911: 21.191437, 19.413139 avg loss, 0.001300 rate, 17.023835 seconds, 61152 images, 1331.312088 hours left
Loaded: 0.000030 seconds

 1912: 24.942877, 19.966114 avg loss, 0.001300 rate, 17.747411 seconds, 61184 images, 1341.654657 hours left
Loaded: 0.000042 seconds

 1913: 21.853167, 20.154819 avg loss, 0.001300 rate, 16.805369 seconds, 61216 images, 1352.817738 hours left
Loaded: 0.000039 seconds

 1914: 24.935951, 20.632933 avg loss, 0.001300 rate, 16.617784 seconds, 61248 images, 1362.564460 hours left
Loaded: 0.000036 seconds

 1915: 23.246256, 20.894264 avg loss, 0.001300 rate, 16.682273 seconds, 61280 images, 1371.953867 hours left
Loaded: 0.000029 seconds

 1916: 22.960720, 21.100910 avg loss, 0.001300 rate, 16.189885 seconds, 61312 images, 1381.338645 hours left
Loaded: 0.000028 seconds

 1917: 19.018303, 20.892649 avg loss, 0.001300 rate, 15.588810 seconds, 61344 images, 1389.947584 hours left
Loaded: 0.000033 seconds

 1918: 27.459444, 21.549328 avg loss, 0.001300 rate, 17.347498 seconds, 61376 images, 1397.637926 hours left
Loaded: 0.000030 seconds

 1919: 20.486050, 21.443001 avg loss, 0.001300 rate, 16.487682 seconds, 61408 images, 1407.687025 hours left
Loaded: 0.000029 seconds

 1920: 13.771583, 20.675859 avg loss, 0.001300 rate, 14.988147 seconds, 61440 images, 1416.444778 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.384488 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1921: 22.510876, 20.859362 avg loss, 0.001300 rate, 7.570487 seconds, 61472 images, 1423.038136 hours left
Loaded: 0.000030 seconds

 1922: 11.984834, 19.971909 avg loss, 0.001300 rate, 6.750894 seconds, 61504 images, 1419.824944 hours left
Loaded: 0.000037 seconds

 1923: 21.262177, 20.100935 avg loss, 0.001300 rate, 7.405611 seconds, 61536 images, 1414.976324 hours left
Loaded: 0.000035 seconds

 1924: 18.120060, 19.902847 avg loss, 0.001300 rate, 7.236943 seconds, 61568 images, 1411.082924 hours left
Loaded: 0.000028 seconds

 1925: 17.324436, 19.645006 avg loss, 0.001300 rate, 7.216267 seconds, 61600 images, 1406.994839 hours left
Loaded: 0.000034 seconds

 1926: 18.776777, 19.558184 avg loss, 0.001300 rate, 7.230776 seconds, 61632 images, 1402.918972 hours left
Loaded: 0.000030 seconds

 1927: 17.503202, 19.352686 avg loss, 0.001300 rate, 7.129448 seconds, 61664 images, 1398.903946 hours left
Loaded: 0.000030 seconds

 1928: 12.689821, 18.686399 avg loss, 0.001300 rate, 6.734761 seconds, 61696 images, 1394.788722 hours left
Loaded: 0.000040 seconds

 1929: 22.793917, 19.097151 avg loss, 0.001300 rate, 7.563356 seconds, 61728 images, 1390.168009 hours left
Loaded: 0.000030 seconds

 1930: 19.484852, 19.135921 avg loss, 0.001300 rate, 7.433653 seconds, 61760 images, 1386.741038 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.366732 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1931: 17.960003, 19.018330 avg loss, 0.001300 rate, 5.635498 seconds, 61792 images, 1383.168674 hours left
Loaded: 0.000031 seconds

 1932: 24.639248, 19.580421 avg loss, 0.001300 rate, 5.874182 seconds, 61824 images, 1377.649573 hours left
Loaded: 0.000028 seconds

 1933: 12.883760, 18.910755 avg loss, 0.001300 rate, 5.076060 seconds, 61856 images, 1372.008354 hours left
Loaded: 0.000029 seconds

 1934: 11.434492, 18.163128 avg loss, 0.001300 rate, 5.090595 seconds, 61888 images, 1365.318200 hours left
Loaded: 0.000038 seconds

 1935: 27.395473, 19.086363 avg loss, 0.001300 rate, 6.323970 seconds, 61920 images, 1358.715065 hours left
Loaded: 0.000031 seconds

 1936: 11.414916, 18.319218 avg loss, 0.001300 rate, 5.202273 seconds, 61952 images, 1353.886065 hours left
Loaded: 0.000030 seconds

 1937: 16.292395, 18.116535 avg loss, 0.001300 rate, 5.490579 seconds, 61984 images, 1347.551887 hours left
Loaded: 0.000039 seconds

 1938: 21.545477, 18.459429 avg loss, 0.001300 rate, 5.891317 seconds, 62016 images, 1341.680311 hours left
Loaded: 0.000030 seconds

 1939: 14.844698, 18.097956 avg loss, 0.001300 rate, 5.508077 seconds, 62048 images, 1336.422427 hours left
Loaded: 0.000030 seconds

 1940: 19.936106, 18.281771 avg loss, 0.001300 rate, 5.761873 seconds, 62080 images, 1330.686348 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 1941: 17.802460, 18.233839 avg loss, 0.001300 rate, 6.169952 seconds, 62112 images, 1325.359094 hours left
Loaded: 0.000040 seconds

 1942: 18.634470, 18.273903 avg loss, 0.001300 rate, 6.282392 seconds, 62144 images, 1320.650238 hours left
Loaded: 0.000030 seconds

 1943: 18.634604, 18.309973 avg loss, 0.001300 rate, 6.396585 seconds, 62176 images, 1316.144184 hours left
Loaded: 0.000033 seconds

 1944: 16.321131, 18.111088 avg loss, 0.001300 rate, 6.099988 seconds, 62208 images, 1311.841321 hours left
Loaded: 0.000031 seconds

 1945: 20.837370, 18.383717 avg loss, 0.001300 rate, 6.265096 seconds, 62240 images, 1307.170704 hours left
Loaded: 0.000029 seconds

 1946: 18.336212, 18.378965 avg loss, 0.001300 rate, 5.973400 seconds, 62272 images, 1302.775427 hours left
Loaded: 0.000032 seconds

 1947: 18.726137, 18.413683 avg loss, 0.001300 rate, 6.064364 seconds, 62304 images, 1298.020119 hours left
Loaded: 0.000027 seconds

 1948: 18.524261, 18.424742 avg loss, 0.001300 rate, 6.299735 seconds, 62336 images, 1293.438326 hours left
Loaded: 0.000029 seconds

 1949: 16.834612, 18.265728 avg loss, 0.001300 rate, 6.153429 seconds, 62368 images, 1289.228285 hours left
Loaded: 0.000029 seconds

 1950: 23.564659, 18.795622 avg loss, 0.001300 rate, 6.735623 seconds, 62400 images, 1284.857718 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 1951: 26.101831, 19.526243 avg loss, 0.001300 rate, 14.514493 seconds, 62432 images, 1281.337097 hours left
Loaded: 0.000031 seconds

 1952: 15.810078, 19.154627 avg loss, 0.001300 rate, 12.853033 seconds, 62464 images, 1288.624294 hours left
Loaded: 0.000037 seconds

 1953: 17.272257, 18.966391 avg loss, 0.001300 rate, 13.200133 seconds, 62496 images, 1293.537702 hours left
Loaded: 0.000037 seconds

 1954: 18.247089, 18.894461 avg loss, 0.001300 rate, 13.388037 seconds, 62528 images, 1298.882631 hours left
Loaded: 0.000037 seconds

 1955: 18.365067, 18.841522 avg loss, 0.001300 rate, 13.934558 seconds, 62560 images, 1304.434293 hours left
Loaded: 0.000033 seconds

 1956: 17.267502, 18.684120 avg loss, 0.001300 rate, 13.310143 seconds, 62592 images, 1310.687261 hours left
Loaded: 0.000032 seconds

 1957: 20.779381, 18.893646 avg loss, 0.001300 rate, 13.964039 seconds, 62624 images, 1316.012924 hours left
Loaded: 0.000031 seconds

 1958: 24.013781, 19.405659 avg loss, 0.001300 rate, 14.207898 seconds, 62656 images, 1322.190838 hours left
Loaded: 0.000032 seconds

 1959: 17.704700, 19.235563 avg loss, 0.001300 rate, 13.006538 seconds, 62688 images, 1328.644636 hours left
Loaded: 0.000029 seconds

 1960: 19.102983, 19.222305 avg loss, 0.001300 rate, 13.373475 seconds, 62720 images, 1333.370171 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.033340 seconds

 1961: 24.299810, 19.730057 avg loss, 0.001300 rate, 14.609330 seconds, 62752 images, 1338.556556 hours left
Loaded: 0.000027 seconds

 1962: 11.063662, 18.863417 avg loss, 0.001300 rate, 13.212253 seconds, 62784 images, 1345.448619 hours left
Loaded: 0.000030 seconds

 1963: 30.589575, 20.036032 avg loss, 0.001300 rate, 16.924693 seconds, 62816 images, 1350.290880 hours left
Loaded: 0.000026 seconds

 1964: 20.031199, 20.035549 avg loss, 0.001300 rate, 14.168017 seconds, 62848 images, 1360.225761 hours left
Loaded: 0.000028 seconds

 1965: 23.260401, 20.358034 avg loss, 0.001300 rate, 14.483733 seconds, 62880 images, 1366.243737 hours left
Loaded: 0.000026 seconds

 1966: 15.504196, 19.872650 avg loss, 0.001300 rate, 13.187653 seconds, 62912 images, 1372.638706 hours left
Loaded: 0.000027 seconds

 1967: 14.927904, 19.378176 avg loss, 0.001300 rate, 13.197163 seconds, 62944 images, 1377.174849 hours left
Loaded: 0.000027 seconds

 1968: 22.745375, 19.714895 avg loss, 0.001300 rate, 14.291700 seconds, 62976 images, 1381.678765 hours left
Loaded: 0.000032 seconds

 1969: 19.571075, 19.700514 avg loss, 0.001300 rate, 14.253578 seconds, 63008 images, 1387.653332 hours left
Loaded: 0.000030 seconds

 1970: 25.611452, 20.291607 avg loss, 0.001300 rate, 15.523158 seconds, 63040 images, 1393.515329 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.593442 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1971: 20.240437, 20.286489 avg loss, 0.001300 rate, 13.899892 seconds, 63072 images, 1401.076787 hours left
Loaded: 0.000032 seconds

 1972: 23.729910, 20.630831 avg loss, 0.001300 rate, 14.432249 seconds, 63104 images, 1407.136442 hours left
Loaded: 0.000028 seconds

 1973: 17.204859, 20.288233 avg loss, 0.001300 rate, 13.044679 seconds, 63136 images, 1413.050914 hours left
Loaded: 0.000030 seconds

 1974: 19.137772, 20.173187 avg loss, 0.001300 rate, 13.482068 seconds, 63168 images, 1416.984693 hours left
Loaded: 0.000028 seconds

 1975: 15.043189, 19.660187 avg loss, 0.001300 rate, 12.913850 seconds, 63200 images, 1421.484795 hours left
Loaded: 0.000029 seconds

 1976: 18.834158, 19.577583 avg loss, 0.001300 rate, 13.367289 seconds, 63232 images, 1425.152993 hours left
Loaded: 0.000028 seconds

 1977: 16.338438, 19.253670 avg loss, 0.001300 rate, 13.059482 seconds, 63264 images, 1429.412392 hours left
Loaded: 0.000028 seconds

 1978: 25.727716, 19.901075 avg loss, 0.001300 rate, 14.962177 seconds, 63296 images, 1433.202910 hours left
Loaded: 0.000037 seconds

 1979: 17.734591, 19.684427 avg loss, 0.001300 rate, 13.472559 seconds, 63328 images, 1439.590306 hours left
Loaded: 0.000028 seconds

 1980: 24.538067, 20.169792 avg loss, 0.001300 rate, 14.448373 seconds, 63360 images, 1443.851006 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.388418 seconds - performance bottleneck on CPU or Disk HDD/SSD

 1981: 18.558252, 20.008638 avg loss, 0.001300 rate, 7.234453 seconds, 63392 images, 1449.420333 hours left
Loaded: 0.000029 seconds

 1982: 23.025284, 20.310303 avg loss, 0.001300 rate, 7.677703 seconds, 63424 images, 1445.482105 hours left
Loaded: 0.000031 seconds

 1983: 26.372196, 20.916492 avg loss, 0.001300 rate, 7.848003 seconds, 63456 images, 1441.659207 hours left
Loaded: 0.000029 seconds

 1984: 18.936251, 20.718468 avg loss, 0.001300 rate, 6.918689 seconds, 63488 images, 1438.110345 hours left
Loaded: 0.000028 seconds

 1985: 18.632170, 20.509838 avg loss, 0.001300 rate, 7.181602 seconds, 63520 images, 1433.310064 hours left
Loaded: 0.000029 seconds

 1986: 17.441622, 20.203016 avg loss, 0.001300 rate, 7.029498 seconds, 63552 images, 1428.921838 hours left
Loaded: 0.000029 seconds

 1987: 20.166977, 20.199413 avg loss, 0.001300 rate, 7.110710 seconds, 63584 images, 1424.366847 hours left
Loaded: 0.000035 seconds

 1988: 18.421839, 20.021656 avg loss, 0.001300 rate, 7.060709 seconds, 63616 images, 1419.969846 hours left
Loaded: 0.000029 seconds

 1989: 22.295897, 20.249081 avg loss, 0.001300 rate, 7.489577 seconds, 63648 images, 1415.547563 hours left
Loaded: 0.000031 seconds

 1990: 22.656759, 20.489849 avg loss, 0.001300 rate, 7.285861 seconds, 63680 images, 1411.763352 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 1991: 16.213202, 20.062183 avg loss, 0.001300 rate, 11.886055 seconds, 63712 images, 1407.734870 hours left
Loaded: 0.000030 seconds

 1992: 15.833994, 19.639364 avg loss, 0.001300 rate, 12.007410 seconds, 63744 images, 1410.116751 hours left
Loaded: 0.000029 seconds

 1993: 15.782263, 19.253654 avg loss, 0.001300 rate, 12.029646 seconds, 63776 images, 1412.642835 hours left
Loaded: 0.000033 seconds

 1994: 21.530924, 19.481380 avg loss, 0.001300 rate, 13.211043 seconds, 63808 images, 1415.174412 hours left
Loaded: 0.000030 seconds

 1995: 18.035662, 19.336809 avg loss, 0.001300 rate, 12.779778 seconds, 63840 images, 1419.316574 hours left
Loaded: 0.000030 seconds

 1996: 21.700573, 19.573185 avg loss, 0.001300 rate, 13.216212 seconds, 63872 images, 1422.820085 hours left
Loaded: 0.000025 seconds

 1997: 20.150282, 19.630894 avg loss, 0.001300 rate, 12.828786 seconds, 63904 images, 1426.892870 hours left
Loaded: 0.000030 seconds

 1998: 20.314091, 19.699213 avg loss, 0.001300 rate, 12.909801 seconds, 63936 images, 1430.388402 hours left
Loaded: 0.000041 seconds

 1999: 22.134352, 19.942726 avg loss, 0.001300 rate, 13.003156 seconds, 63968 images, 1433.961133 hours left
Loaded: 0.000031 seconds

 2000: 17.901882, 19.738642 avg loss, 0.001300 rate, 12.383242 seconds, 64000 images, 1437.627388 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 2001: 23.293568, 20.094135 avg loss, 0.001300 rate, 13.196047 seconds, 64032 images, 1440.398523 hours left
Loaded: 0.000021 seconds

 2002: 12.328270, 19.317549 avg loss, 0.001300 rate, 12.336379 seconds, 64064 images, 1444.267410 hours left
Loaded: 0.000029 seconds

 2003: 17.644348, 19.150229 avg loss, 0.001300 rate, 13.439322 seconds, 64096 images, 1446.907168 hours left
Loaded: 0.000025 seconds

 2004: 20.122084, 19.247414 avg loss, 0.001300 rate, 13.686149 seconds, 64128 images, 1451.047766 hours left
Loaded: 0.000027 seconds

 2005: 21.434645, 19.466137 avg loss, 0.001300 rate, 13.731000 seconds, 64160 images, 1455.488700 hours left
Loaded: 0.000030 seconds

 2006: 21.855915, 19.705114 avg loss, 0.001300 rate, 13.953405 seconds, 64192 images, 1459.947294 hours left
Loaded: 0.000029 seconds

 2007: 20.929018, 19.827505 avg loss, 0.001300 rate, 13.775908 seconds, 64224 images, 1464.669234 hours left
Loaded: 0.000029 seconds

 2008: 26.361839, 20.480938 avg loss, 0.001300 rate, 14.978498 seconds, 64256 images, 1469.098134 hours left
Loaded: 0.000035 seconds

 2009: 17.184875, 20.151331 avg loss, 0.001300 rate, 13.086009 seconds, 64288 images, 1475.147933 hours left
Loaded: 0.000030 seconds

 2010: 17.332651, 19.869463 avg loss, 0.001300 rate, 13.166941 seconds, 64320 images, 1478.516676 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.272753 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2011: 17.964754, 19.678991 avg loss, 0.001300 rate, 7.083856 seconds, 64352 images, 1481.963767 hours left
Loaded: 0.000031 seconds

 2012: 21.376955, 19.848787 avg loss, 0.001300 rate, 7.530576 seconds, 64384 images, 1477.330779 hours left
Loaded: 0.000031 seconds

 2013: 21.795174, 20.043427 avg loss, 0.001300 rate, 7.522357 seconds, 64416 images, 1472.985031 hours left
Loaded: 0.000029 seconds

 2014: 20.585629, 20.097647 avg loss, 0.001300 rate, 7.215130 seconds, 64448 images, 1468.671341 hours left
Loaded: 0.000029 seconds

 2015: 20.724205, 20.160303 avg loss, 0.001300 rate, 7.303356 seconds, 64480 images, 1463.975350 hours left
Loaded: 0.000024 seconds

 2016: 28.084114, 20.952684 avg loss, 0.001300 rate, 7.999816 seconds, 64512 images, 1459.448464 hours left
Loaded: 0.000038 seconds

 2017: 14.093586, 20.266775 avg loss, 0.001300 rate, 6.627354 seconds, 64544 images, 1455.931193 hours left
Loaded: 0.000028 seconds

 2018: 18.217646, 20.061863 avg loss, 0.001300 rate, 7.112554 seconds, 64576 images, 1450.548678 hours left
Loaded: 0.000030 seconds

 2019: 25.799339, 20.635611 avg loss, 0.001300 rate, 7.632734 seconds, 64608 images, 1445.891798 hours left
Loaded: 0.000028 seconds

 2020: 19.599039, 20.531954 avg loss, 0.001300 rate, 7.257240 seconds, 64640 images, 1442.001747 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 2021: 16.876320, 20.166389 avg loss, 0.001300 rate, 11.489588 seconds, 64672 images, 1437.630639 hours left
Loaded: 0.000030 seconds

 2022: 16.118755, 19.761625 avg loss, 0.001300 rate, 11.117913 seconds, 64704 images, 1439.163601 hours left
Loaded: 0.000027 seconds

 2023: 27.211449, 20.506607 avg loss, 0.001300 rate, 12.557278 seconds, 64736 images, 1440.166562 hours left
Loaded: 0.000030 seconds

 2024: 19.779579, 20.433905 avg loss, 0.001300 rate, 11.365991 seconds, 64768 images, 1443.152487 hours left
Loaded: 0.000030 seconds

 2025: 23.672564, 20.757771 avg loss, 0.001300 rate, 12.022771 seconds, 64800 images, 1444.459000 hours left
Loaded: 0.000029 seconds

 2026: 15.951567, 20.277149 avg loss, 0.001300 rate, 10.801811 seconds, 64832 images, 1446.661827 hours left
Loaded: 0.000029 seconds

 2027: 17.694008, 20.018835 avg loss, 0.001300 rate, 11.219739 seconds, 64864 images, 1447.151990 hours left
Loaded: 0.000030 seconds

 2028: 21.787228, 20.195675 avg loss, 0.001300 rate, 11.481179 seconds, 64896 images, 1448.215904 hours left
Loaded: 0.000027 seconds

 2029: 18.059881, 19.982096 avg loss, 0.001300 rate, 10.537508 seconds, 64928 images, 1449.631150 hours left
Loaded: 0.000035 seconds

 2030: 15.941524, 19.578039 avg loss, 0.001300 rate, 10.329415 seconds, 64960 images, 1449.725561 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.429301 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2031: 24.818552, 20.102091 avg loss, 0.001300 rate, 6.992095 seconds, 64992 images, 1449.530877 hours left
Loaded: 0.000031 seconds

 2032: 21.097336, 20.201614 avg loss, 0.001300 rate, 6.870958 seconds, 65024 images, 1445.311516 hours left
Loaded: 0.000031 seconds

 2033: 24.804413, 20.661894 avg loss, 0.001300 rate, 6.934606 seconds, 65056 images, 1440.372215 hours left
Loaded: 0.000037 seconds

 2034: 24.915623, 21.087267 avg loss, 0.001300 rate, 6.979798 seconds, 65088 images, 1435.570416 hours left
Loaded: 0.000037 seconds

 2035: 16.242254, 20.602766 avg loss, 0.001300 rate, 6.035572 seconds, 65120 images, 1430.879199 hours left
Loaded: 0.000040 seconds

 2036: 18.211515, 20.363642 avg loss, 0.001300 rate, 6.215419 seconds, 65152 images, 1424.927475 hours left
Loaded: 0.000038 seconds

 2037: 19.644276, 20.291706 avg loss, 0.001300 rate, 6.613753 seconds, 65184 images, 1419.284275 hours left
Loaded: 0.000042 seconds

 2038: 26.984844, 20.961020 avg loss, 0.001300 rate, 6.961587 seconds, 65216 images, 1414.249041 hours left
Loaded: 0.000029 seconds

 2039: 16.432894, 20.508207 avg loss, 0.001300 rate, 6.079643 seconds, 65248 images, 1409.745753 hours left
Loaded: 0.000031 seconds

 2040: 23.936920, 20.851078 avg loss, 0.001300 rate, 6.631818 seconds, 65280 images, 1404.066307 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.396590 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2041: 23.271967, 21.093166 avg loss, 0.001300 rate, 5.874653 seconds, 65312 images, 1399.208190 hours left
Loaded: 0.000032 seconds

 2042: 25.758020, 21.559652 avg loss, 0.001300 rate, 6.103357 seconds, 65344 images, 1393.899336 hours left
Loaded: 0.000038 seconds

 2043: 17.280798, 21.131767 avg loss, 0.001300 rate, 5.474309 seconds, 65376 images, 1388.411143 hours left
Loaded: 0.000032 seconds

 2044: 17.389912, 20.757582 avg loss, 0.001300 rate, 5.677264 seconds, 65408 images, 1382.106841 hours left
Loaded: 0.000031 seconds

 2045: 22.413094, 20.923134 avg loss, 0.001300 rate, 5.752725 seconds, 65440 images, 1376.146569 hours left
Loaded: 0.000030 seconds

 2046: 27.675041, 21.598324 avg loss, 0.001300 rate, 6.027933 seconds, 65472 images, 1370.350367 hours left
Loaded: 0.000041 seconds

 2047: 26.057606, 22.044252 avg loss, 0.001300 rate, 5.763459 seconds, 65504 images, 1364.993160 hours left
Loaded: 0.000029 seconds

 2048: 13.479312, 21.187757 avg loss, 0.001300 rate, 5.097668 seconds, 65536 images, 1359.323335 hours left
Loaded: 0.000032 seconds

 2049: 15.757236, 20.644705 avg loss, 0.001300 rate, 5.244555 seconds, 65568 images, 1352.788329 hours left
Loaded: 0.000035 seconds

 2050: 16.089212, 20.189156 avg loss, 0.001300 rate, 5.319788 seconds, 65600 images, 1346.522039 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 2051: 15.771738, 19.747414 avg loss, 0.001300 rate, 15.093651 seconds, 65632 images, 1340.422570 hours left
Loaded: 0.000028 seconds

 2052: 22.668768, 20.039549 avg loss, 0.001300 rate, 17.181091 seconds, 65664 images, 1347.916770 hours left
Loaded: 0.000029 seconds

 2053: 16.834627, 19.719057 avg loss, 0.001300 rate, 15.853366 seconds, 65696 images, 1358.226211 hours left
Loaded: 0.000028 seconds

 2054: 18.588842, 19.606035 avg loss, 0.001300 rate, 16.406984 seconds, 65728 images, 1366.594177 hours left
Loaded: 0.000030 seconds

 2055: 18.967855, 19.542217 avg loss, 0.001300 rate, 16.589983 seconds, 65760 images, 1375.644943 hours left
Loaded: 0.000031 seconds

 2056: 17.054560, 19.293451 avg loss, 0.001300 rate, 16.244873 seconds, 65792 images, 1384.858532 hours left
Loaded: 0.000028 seconds

 2057: 23.468414, 19.710947 avg loss, 0.001300 rate, 17.709803 seconds, 65824 images, 1393.502113 hours left
Loaded: 0.000047 seconds

 2058: 19.803209, 19.720173 avg loss, 0.001300 rate, 16.566333 seconds, 65856 images, 1404.087498 hours left
Loaded: 0.000032 seconds

 2059: 20.468132, 19.794970 avg loss, 0.001300 rate, 17.121613 seconds, 65888 images, 1412.983802 hours left
Loaded: 0.000028 seconds

 2060: 21.616198, 19.977093 avg loss, 0.001300 rate, 17.115008 seconds, 65920 images, 1422.559894 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.342323 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2061: 14.729414, 19.452324 avg loss, 0.001300 rate, 10.118657 seconds, 65952 images, 1432.031033 hours left
Loaded: 0.000021 seconds

 2062: 21.447163, 19.651808 avg loss, 0.001300 rate, 11.137543 seconds, 65984 images, 1432.194515 hours left
Loaded: 0.000025 seconds

 2063: 15.614235, 19.248051 avg loss, 0.001300 rate, 10.161407 seconds, 66016 images, 1433.293097 hours left
Loaded: 0.000039 seconds

 2064: 25.620785, 19.885324 avg loss, 0.001300 rate, 12.556075 seconds, 66048 images, 1433.029161 hours left
Loaded: 0.000034 seconds

 2065: 22.705622, 20.167355 avg loss, 0.001300 rate, 11.091911 seconds, 66080 images, 1436.083393 hours left
Loaded: 0.000027 seconds

 2066: 17.239479, 19.874567 avg loss, 0.001300 rate, 10.375820 seconds, 66112 images, 1437.079832 hours left
Loaded: 0.000027 seconds

 2067: 15.919686, 19.479078 avg loss, 0.001300 rate, 10.349035 seconds, 66144 images, 1437.074811 hours left
Loaded: 0.000034 seconds

 2068: 27.340004, 20.265171 avg loss, 0.001300 rate, 11.787829 seconds, 66176 images, 1437.032725 hours left
Loaded: 0.000027 seconds

 2069: 19.455256, 20.184179 avg loss, 0.001300 rate, 10.918581 seconds, 66208 images, 1438.983099 hours left
Loaded: 0.000026 seconds

 2070: 19.384855, 20.104246 avg loss, 0.001300 rate, 10.889366 seconds, 66240 images, 1439.710427 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.468949 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2071: 31.472525, 21.241074 avg loss, 0.001300 rate, 7.664623 seconds, 66272 images, 1440.390000 hours left
Loaded: 0.000023 seconds

 2072: 15.591942, 20.676161 avg loss, 0.001300 rate, 6.071267 seconds, 66304 images, 1437.247248 hours left
Loaded: 0.000030 seconds

 2073: 10.709303, 19.679476 avg loss, 0.001300 rate, 5.651299 seconds, 66336 images, 1431.280625 hours left
Loaded: 0.000039 seconds

 2074: 22.822109, 19.993740 avg loss, 0.001300 rate, 6.742277 seconds, 66368 images, 1424.792206 hours left
Loaded: 0.000038 seconds

 2075: 17.650434, 19.759409 avg loss, 0.001300 rate, 6.570124 seconds, 66400 images, 1419.879147 hours left
Loaded: 0.000037 seconds

 2076: 24.555094, 20.238977 avg loss, 0.001300 rate, 6.966620 seconds, 66432 images, 1414.776848 hours left
Loaded: 0.000029 seconds

 2077: 26.581657, 20.873245 avg loss, 0.001300 rate, 7.286403 seconds, 66464 images, 1410.274508 hours left
Loaded: 0.000029 seconds

 2078: 20.322672, 20.818188 avg loss, 0.001300 rate, 6.407681 seconds, 66496 images, 1406.259901 hours left
Loaded: 0.000029 seconds

 2079: 19.272982, 20.663668 avg loss, 0.001300 rate, 6.200887 seconds, 66528 images, 1401.068825 hours left
Loaded: 0.000031 seconds

 2080: 15.861804, 20.183481 avg loss, 0.001300 rate, 6.037127 seconds, 66560 images, 1395.643335 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 2081: 14.018906, 19.567024 avg loss, 0.001300 rate, 14.177485 seconds, 66592 images, 1390.045361 hours left
Loaded: 0.000031 seconds

 2082: 20.622589, 19.672581 avg loss, 0.001300 rate, 15.834334 seconds, 66624 images, 1395.773643 hours left
Loaded: 0.000028 seconds

 2083: 16.132776, 19.318600 avg loss, 0.001300 rate, 14.459091 seconds, 66656 images, 1403.738510 hours left
Loaded: 0.000029 seconds

 2084: 23.118589, 19.698599 avg loss, 0.001300 rate, 16.258523 seconds, 66688 images, 1409.719668 hours left
Loaded: 0.000030 seconds

 2085: 21.404299, 19.869169 avg loss, 0.001300 rate, 15.720736 seconds, 66720 images, 1418.132270 hours left
Loaded: 0.000029 seconds

 2086: 18.676884, 19.749941 avg loss, 0.001300 rate, 14.945535 seconds, 66752 images, 1425.716144 hours left
Loaded: 0.000030 seconds

 2087: 20.487265, 19.823673 avg loss, 0.001300 rate, 15.147563 seconds, 66784 images, 1432.150879 hours left
Loaded: 0.000034 seconds

 2088: 19.325346, 19.773840 avg loss, 0.001300 rate, 15.048478 seconds, 66816 images, 1438.800932 hours left
Loaded: 0.000030 seconds

 2089: 23.881145, 20.184570 avg loss, 0.001300 rate, 16.096340 seconds, 66848 images, 1445.247265 hours left
Loaded: 0.000038 seconds

 2090: 23.591490, 20.525263 avg loss, 0.001300 rate, 15.838224 seconds, 66880 images, 1453.079828 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.438852 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2091: 23.270584, 20.799795 avg loss, 0.001300 rate, 8.140191 seconds, 66912 images, 1460.476678 hours left
Loaded: 0.000043 seconds

 2092: 23.968042, 21.116619 avg loss, 0.001300 rate, 8.123165 seconds, 66944 images, 1457.749359 hours left
Loaded: 0.000033 seconds

 2093: 15.648345, 20.569792 avg loss, 0.001300 rate, 7.302659 seconds, 66976 images, 1454.418188 hours left
Loaded: 0.000035 seconds

 2094: 14.213766, 19.934189 avg loss, 0.001300 rate, 7.172259 seconds, 67008 images, 1449.984332 hours left
Loaded: 0.000034 seconds

 2095: 20.999479, 20.040718 avg loss, 0.001300 rate, 7.979681 seconds, 67040 images, 1445.414263 hours left
Loaded: 0.000031 seconds

 2096: 22.328156, 20.269463 avg loss, 0.001300 rate, 8.277866 seconds, 67072 images, 1442.007717 hours left
Loaded: 0.000028 seconds

 2097: 18.193914, 20.061909 avg loss, 0.001300 rate, 8.166852 seconds, 67104 images, 1439.048033 hours left
Loaded: 0.000039 seconds

 2098: 21.601692, 20.215887 avg loss, 0.001300 rate, 8.474992 seconds, 67136 images, 1435.964226 hours left
Loaded: 0.000038 seconds

 2099: 23.637711, 20.558069 avg loss, 0.001300 rate, 8.710314 seconds, 67168 images, 1433.337855 hours left
Loaded: 0.000043 seconds

 2100: 16.661057, 20.168367 avg loss, 0.001300 rate, 7.405118 seconds, 67200 images, 1431.063511 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.413905 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2101: 16.171335, 19.768663 avg loss, 0.001300 rate, 5.869617 seconds, 67232 images, 1427.004921 hours left
Loaded: 0.000033 seconds

 2102: 24.635744, 20.255371 avg loss, 0.001300 rate, 6.414250 seconds, 67264 images, 1421.434053 hours left
Loaded: 0.000035 seconds

 2103: 21.054649, 20.335299 avg loss, 0.001300 rate, 6.285841 seconds, 67296 images, 1416.099906 hours left
Loaded: 0.000022 seconds

 2104: 18.409252, 20.142694 avg loss, 0.001300 rate, 6.010907 seconds, 67328 images, 1410.641314 hours left
Loaded: 0.000029 seconds

 2105: 20.135426, 20.141968 avg loss, 0.001300 rate, 6.125304 seconds, 67360 images, 1404.856642 hours left
Loaded: 0.000035 seconds

 2106: 18.556719, 19.983442 avg loss, 0.001300 rate, 6.101593 seconds, 67392 images, 1399.288184 hours left
Loaded: 0.000034 seconds

 2107: 18.219658, 19.807064 avg loss, 0.001300 rate, 6.032054 seconds, 67424 images, 1393.742578 hours left
Loaded: 0.000028 seconds

 2108: 20.201441, 19.846502 avg loss, 0.001300 rate, 6.180835 seconds, 67456 images, 1388.156137 hours left
Loaded: 0.000044 seconds

 2109: 21.738243, 20.035677 avg loss, 0.001300 rate, 6.765156 seconds, 67488 images, 1382.831516 hours left
Loaded: 0.000053 seconds

 2110: 18.713549, 19.903463 avg loss, 0.001300 rate, 6.072946 seconds, 67520 images, 1378.369089 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.376604 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2111: 20.862368, 19.999353 avg loss, 0.001300 rate, 5.994011 seconds, 67552 images, 1372.992972 hours left
Loaded: 0.000038 seconds

 2112: 23.216322, 20.321051 avg loss, 0.001300 rate, 6.134675 seconds, 67584 images, 1368.082624 hours left
Loaded: 0.000030 seconds

 2113: 20.172935, 20.306240 avg loss, 0.001300 rate, 5.769206 seconds, 67616 images, 1362.894775 hours left
Loaded: 0.000029 seconds

 2114: 15.541080, 19.829723 avg loss, 0.001300 rate, 5.450812 seconds, 67648 images, 1357.252821 hours left
Loaded: 0.000026 seconds

 2115: 16.344753, 19.481226 avg loss, 0.001300 rate, 5.534849 seconds, 67680 images, 1351.226481 hours left
Loaded: 0.000033 seconds

 2116: 17.380640, 19.271168 avg loss, 0.001300 rate, 5.715921 seconds, 67712 images, 1345.376727 hours left
Loaded: 0.000037 seconds

 2117: 16.209616, 18.965012 avg loss, 0.001300 rate, 5.633423 seconds, 67744 images, 1339.836138 hours left
Loaded: 0.000039 seconds

 2118: 21.711426, 19.239653 avg loss, 0.001300 rate, 6.205151 seconds, 67776 images, 1334.236738 hours left
Loaded: 0.000038 seconds

 2119: 14.660914, 18.781778 avg loss, 0.001300 rate, 5.265993 seconds, 67808 images, 1329.484813 hours left
Loaded: 0.000028 seconds

 2120: 18.959558, 18.799557 avg loss, 0.001300 rate, 5.402670 seconds, 67840 images, 1323.480239 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 2121: 18.483889, 18.767990 avg loss, 0.001300 rate, 7.847105 seconds, 67872 images, 1317.724884 hours left
Loaded: 0.000030 seconds

 2122: 17.794792, 18.670670 avg loss, 0.001300 rate, 8.062475 seconds, 67904 images, 1315.411109 hours left
Loaded: 0.000029 seconds

 2123: 24.127245, 19.216328 avg loss, 0.001300 rate, 8.715010 seconds, 67936 images, 1313.418609 hours left
Loaded: 0.000030 seconds

 2124: 22.621429, 19.556837 avg loss, 0.001300 rate, 8.910754 seconds, 67968 images, 1312.349367 hours left
Loaded: 0.000032 seconds

 2125: 17.339767, 19.335131 avg loss, 0.001300 rate, 8.096476 seconds, 68000 images, 1311.561780 hours left
Loaded: 0.000029 seconds

 2126: 18.147007, 19.216318 avg loss, 0.001300 rate, 8.362786 seconds, 68032 images, 1309.654779 hours left
Loaded: 0.000033 seconds

 2127: 14.804722, 18.775158 avg loss, 0.001300 rate, 7.669317 seconds, 68064 images, 1308.135494 hours left
Loaded: 0.000029 seconds

 2128: 21.363409, 19.033983 avg loss, 0.001300 rate, 8.467027 seconds, 68096 images, 1305.671367 hours left
Loaded: 0.000030 seconds

 2129: 11.117047, 18.242290 avg loss, 0.001300 rate, 7.650455 seconds, 68128 images, 1304.336177 hours left
Loaded: 0.000029 seconds

 2130: 22.209188, 18.638981 avg loss, 0.001300 rate, 8.312752 seconds, 68160 images, 1301.883884 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.510788 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2131: 24.105528, 19.185635 avg loss, 0.001300 rate, 7.403695 seconds, 68192 images, 1300.372949 hours left
Loaded: 0.000028 seconds

 2132: 24.020182, 19.669090 avg loss, 0.001300 rate, 7.325173 seconds, 68224 images, 1298.325713 hours left
Loaded: 0.000027 seconds

 2133: 20.126415, 19.714823 avg loss, 0.001300 rate, 7.120401 seconds, 68256 images, 1295.483149 hours left
Loaded: 0.000021 seconds

 2134: 20.039989, 19.747339 avg loss, 0.001300 rate, 7.171011 seconds, 68288 images, 1292.385514 hours left
Loaded: 0.000025 seconds

 2135: 20.649817, 19.837587 avg loss, 0.001300 rate, 7.098243 seconds, 68320 images, 1289.388888 hours left
Loaded: 0.000036 seconds

 2136: 17.901766, 19.644005 avg loss, 0.001300 rate, 6.806176 seconds, 68352 images, 1286.321480 hours left
Loaded: 0.000039 seconds

 2137: 12.615230, 18.941128 avg loss, 0.001300 rate, 6.510618 seconds, 68384 images, 1282.880418 hours left
Loaded: 0.000036 seconds

 2138: 19.606327, 19.007648 avg loss, 0.001300 rate, 7.199276 seconds, 68416 images, 1279.064599 hours left
Loaded: 0.000033 seconds

 2139: 20.884398, 19.195324 avg loss, 0.001300 rate, 7.239642 seconds, 68448 images, 1276.240253 hours left
Loaded: 0.000035 seconds

 2140: 15.681124, 18.843904 avg loss, 0.001300 rate, 6.898210 seconds, 68480 images, 1273.500005 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000027 seconds

 2141: 21.677298, 19.127243 avg loss, 0.001300 rate, 15.187844 seconds, 68512 images, 1270.314486 hours left
Loaded: 0.000033 seconds

 2142: 26.499960, 19.864515 avg loss, 0.001300 rate, 15.155541 seconds, 68544 images, 1278.636391 hours left
Loaded: 0.000028 seconds

 2143: 25.220669, 20.400131 avg loss, 0.001300 rate, 14.994426 seconds, 68576 images, 1286.830323 hours left
Loaded: 0.000029 seconds

 2144: 20.561142, 20.416233 avg loss, 0.001300 rate, 14.059645 seconds, 68608 images, 1294.719231 hours left
Loaded: 0.000027 seconds

 2145: 14.611541, 19.835764 avg loss, 0.001300 rate, 12.928946 seconds, 68640 images, 1301.235170 hours left
Loaded: 0.000031 seconds

 2146: 18.440166, 19.696205 avg loss, 0.001300 rate, 14.198996 seconds, 68672 images, 1306.120662 hours left
Loaded: 0.000031 seconds

 2147: 17.875793, 19.514164 avg loss, 0.001300 rate, 13.827491 seconds, 68704 images, 1312.715420 hours left
Loaded: 0.000026 seconds

 2148: 14.484391, 19.011187 avg loss, 0.001300 rate, 12.868533 seconds, 68736 images, 1318.729921 hours left
Loaded: 0.000031 seconds

 2149: 15.210966, 18.631165 avg loss, 0.001300 rate, 13.134582 seconds, 68768 images, 1323.356725 hours left
Loaded: 0.000030 seconds

 2150: 24.607452, 19.228794 avg loss, 0.001300 rate, 14.935033 seconds, 68800 images, 1328.305527 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.370563 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2151: 22.133989, 19.519314 avg loss, 0.001300 rate, 6.027399 seconds, 68832 images, 1335.697175 hours left
Loaded: 0.000030 seconds

 2152: 20.019131, 19.569296 avg loss, 0.001300 rate, 5.817891 seconds, 68864 images, 1331.196934 hours left
Loaded: 0.000031 seconds

 2153: 18.043596, 19.416725 avg loss, 0.001300 rate, 5.482393 seconds, 68896 images, 1325.938729 hours left
Loaded: 0.000030 seconds

 2154: 25.145582, 19.989611 avg loss, 0.001300 rate, 6.107858 seconds, 68928 images, 1320.268660 hours left
Loaded: 0.000038 seconds

 2155: 24.270237, 20.417673 avg loss, 0.001300 rate, 5.648290 seconds, 68960 images, 1315.521103 hours left
Loaded: 0.000028 seconds

 2156: 18.669415, 20.242847 avg loss, 0.001300 rate, 5.277244 seconds, 68992 images, 1310.184838 hours left
Loaded: 0.000022 seconds

 2157: 19.827179, 20.201281 avg loss, 0.001300 rate, 5.352718 seconds, 69024 images, 1304.388271 hours left
Loaded: 0.000033 seconds

 2158: 23.246456, 20.505798 avg loss, 0.001300 rate, 6.047730 seconds, 69056 images, 1298.754123 hours left
Loaded: 0.000029 seconds

 2159: 18.991760, 20.354395 avg loss, 0.001300 rate, 5.333957 seconds, 69088 images, 1294.138413 hours left
Loaded: 0.000027 seconds

 2160: 17.770357, 20.095991 avg loss, 0.001300 rate, 5.293013 seconds, 69120 images, 1288.580775 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 2161: 22.047180, 20.291111 avg loss, 0.001300 rate, 12.360231 seconds, 69152 images, 1283.022016 hours left
Loaded: 0.000027 seconds

 2162: 16.409437, 19.902943 avg loss, 0.001300 rate, 11.803533 seconds, 69184 images, 1287.301804 hours left
Loaded: 0.000035 seconds

 2163: 19.823866, 19.895035 avg loss, 0.001300 rate, 12.236106 seconds, 69216 images, 1290.768140 hours left
Loaded: 0.000039 seconds

 2164: 15.161543, 19.421686 avg loss, 0.001300 rate, 11.648205 seconds, 69248 images, 1294.798589 hours left
Loaded: 0.000035 seconds

 2165: 18.217400, 19.301258 avg loss, 0.001300 rate, 12.134084 seconds, 69280 images, 1297.974891 hours left
Loaded: 0.000030 seconds

 2166: 14.916254, 18.862759 avg loss, 0.001300 rate, 11.902691 seconds, 69312 images, 1301.791978 hours left
Loaded: 0.000029 seconds

 2167: 25.164251, 19.492908 avg loss, 0.001300 rate, 13.455758 seconds, 69344 images, 1305.250544 hours left
Loaded: 0.000028 seconds

 2168: 24.380077, 19.981625 avg loss, 0.001300 rate, 13.555024 seconds, 69376 images, 1310.824336 hours left
Loaded: 0.000034 seconds

 2169: 20.945496, 20.078012 avg loss, 0.001300 rate, 12.801693 seconds, 69408 images, 1316.479762 hours left
Loaded: 0.000027 seconds

 2170: 22.367758, 20.306988 avg loss, 0.001300 rate, 13.151449 seconds, 69440 images, 1321.035804 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.102353 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2171: 27.381357, 21.014425 avg loss, 0.001300 rate, 18.791448 seconds, 69472 images, 1326.030390 hours left
Loaded: 0.000030 seconds

 2172: 20.235893, 20.936573 avg loss, 0.001300 rate, 16.132276 seconds, 69504 images, 1338.923792 hours left
Loaded: 0.000024 seconds

 2173: 11.772449, 20.020161 avg loss, 0.001300 rate, 14.459763 seconds, 69536 images, 1347.865623 hours left
Loaded: 0.000028 seconds

 2174: 22.337542, 20.251900 avg loss, 0.001300 rate, 16.782424 seconds, 69568 images, 1354.402820 hours left
Loaded: 0.000029 seconds

 2175: 22.770121, 20.503721 avg loss, 0.001300 rate, 16.505234 seconds, 69600 images, 1364.089740 hours left
Loaded: 0.000027 seconds

 2176: 21.159128, 20.569262 avg loss, 0.001300 rate, 15.822954 seconds, 69632 images, 1373.296036 hours left
Loaded: 0.000029 seconds

 2177: 17.774622, 20.289797 avg loss, 0.001300 rate, 16.211618 seconds, 69664 images, 1381.465785 hours left
Loaded: 0.000034 seconds

 2178: 15.652122, 19.826029 avg loss, 0.001300 rate, 15.726953 seconds, 69696 images, 1390.091798 hours left
Loaded: 0.000028 seconds

 2179: 31.089165, 20.952343 avg loss, 0.001300 rate, 18.603558 seconds, 69728 images, 1397.960627 hours left
Loaded: 0.000028 seconds

 2180: 25.001051, 21.357214 avg loss, 0.001300 rate, 17.396518 seconds, 69760 images, 1409.732582 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.418562 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2181: 23.786600, 21.600153 avg loss, 0.001300 rate, 11.248189 seconds, 69792 images, 1419.715954 hours left
Loaded: 0.000027 seconds

 2182: 21.875340, 21.627672 avg loss, 0.001300 rate, 11.147042 seconds, 69824 images, 1421.668151 hours left
Loaded: 0.000026 seconds

 2183: 25.037893, 21.968695 avg loss, 0.001300 rate, 12.274525 seconds, 69856 images, 1422.881440 hours left
Loaded: 0.000031 seconds

 2184: 17.557884, 21.527615 avg loss, 0.001300 rate, 11.142736 seconds, 69888 images, 1425.643243 hours left
Loaded: 0.000045 seconds

 2185: 22.274878, 21.602341 avg loss, 0.001300 rate, 11.461836 seconds, 69920 images, 1426.810767 hours left
Loaded: 0.000039 seconds

 2186: 24.342825, 21.876389 avg loss, 0.001300 rate, 11.325094 seconds, 69952 images, 1428.408303 hours left
Loaded: 0.000035 seconds

 2187: 23.026121, 21.991362 avg loss, 0.001300 rate, 11.070634 seconds, 69984 images, 1429.800545 hours left
Loaded: 0.000027 seconds

 2188: 21.821508, 21.974377 avg loss, 0.001300 rate, 10.808454 seconds, 70016 images, 1430.826601 hours left
Loaded: 0.000026 seconds

 2189: 16.644699, 21.441408 avg loss, 0.001300 rate, 10.589785 seconds, 70048 images, 1431.479447 hours left
Loaded: 0.000040 seconds

 2190: 18.954487, 21.192717 avg loss, 0.001300 rate, 10.465703 seconds, 70080 images, 1431.823052 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.071151 seconds

 2191: 17.204563, 20.793901 avg loss, 0.001300 rate, 12.103696 seconds, 70112 images, 1431.991456 hours left
Loaded: 0.000029 seconds

 2192: 21.312443, 20.845757 avg loss, 0.001300 rate, 13.496010 seconds, 70144 images, 1434.523876 hours left
Loaded: 0.000024 seconds

 2193: 17.859999, 20.547180 avg loss, 0.001300 rate, 12.431522 seconds, 70176 images, 1438.859718 hours left
Loaded: 0.000031 seconds

 2194: 19.484758, 20.440937 avg loss, 0.001300 rate, 12.745541 seconds, 70208 images, 1441.678708 hours left
Loaded: 0.000030 seconds

 2195: 24.219242, 20.818768 avg loss, 0.001300 rate, 13.184299 seconds, 70240 images, 1444.904144 hours left
Loaded: 0.000031 seconds

 2196: 21.229256, 20.859816 avg loss, 0.001300 rate, 12.569393 seconds, 70272 images, 1448.704608 hours left
Loaded: 0.000027 seconds

 2197: 26.953100, 21.469145 avg loss, 0.001300 rate, 12.917584 seconds, 70304 images, 1451.615892 hours left
Loaded: 0.000026 seconds

 2198: 15.979068, 20.920137 avg loss, 0.001300 rate, 11.558979 seconds, 70336 images, 1454.979979 hours left
Loaded: 0.000038 seconds

 2199: 22.043476, 21.032471 avg loss, 0.001300 rate, 12.372660 seconds, 70368 images, 1456.429846 hours left
Loaded: 0.000034 seconds

 2200: 15.880768, 20.517300 avg loss, 0.001300 rate, 11.463720 seconds, 70400 images, 1458.991470 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.207642 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2201: 14.124874, 19.878057 avg loss, 0.001300 rate, 5.139338 seconds, 70432 images, 1460.269313 hours left
Loaded: 0.000028 seconds

 2202: 21.063850, 19.996637 avg loss, 0.001300 rate, 5.547798 seconds, 70464 images, 1453.067741 hours left
Loaded: 0.000024 seconds

 2203: 13.060181, 19.302992 avg loss, 0.001300 rate, 5.001699 seconds, 70496 images, 1446.216160 hours left
Loaded: 0.000023 seconds

 2204: 26.015240, 19.974216 avg loss, 0.001300 rate, 5.945956 seconds, 70528 images, 1438.677185 hours left
Loaded: 0.000029 seconds

 2205: 17.396751, 19.716471 avg loss, 0.001300 rate, 5.813429 seconds, 70560 images, 1432.520586 hours left
Loaded: 0.000031 seconds

 2206: 18.559484, 19.600773 avg loss, 0.001300 rate, 5.591268 seconds, 70592 images, 1426.242108 hours left
Loaded: 0.000038 seconds

 2207: 18.448503, 19.485546 avg loss, 0.001300 rate, 5.657768 seconds, 70624 images, 1419.718897 hours left
Loaded: 0.000039 seconds

 2208: 19.597393, 19.496731 avg loss, 0.001300 rate, 5.923265 seconds, 70656 images, 1413.352959 hours left
Loaded: 0.000030 seconds

 2209: 15.190906, 19.066149 avg loss, 0.001300 rate, 5.329651 seconds, 70688 images, 1407.418153 hours left
Loaded: 0.000027 seconds

 2210: 20.026203, 19.162155 avg loss, 0.001300 rate, 5.560270 seconds, 70720 images, 1400.721017 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 2211: 29.595364, 20.205477 avg loss, 0.001300 rate, 11.692369 seconds, 70752 images, 1394.410043 hours left
Loaded: 0.000040 seconds

 2212: 23.171461, 20.502075 avg loss, 0.001300 rate, 10.582187 seconds, 70784 images, 1396.649822 hours left
Loaded: 0.000030 seconds

 2213: 19.440315, 20.395899 avg loss, 0.001300 rate, 9.978708 seconds, 70816 images, 1397.330550 hours left
Loaded: 0.000029 seconds

 2214: 24.277109, 20.784019 avg loss, 0.001300 rate, 10.354666 seconds, 70848 images, 1397.169134 hours left
Loaded: 0.000028 seconds

 2215: 18.544497, 20.560066 avg loss, 0.001300 rate, 9.799256 seconds, 70880 images, 1397.529676 hours left
Loaded: 0.000038 seconds

 2216: 18.001728, 20.304232 avg loss, 0.001300 rate, 9.833385 seconds, 70912 images, 1397.117824 hours left
Loaded: 0.000035 seconds

 2217: 17.893612, 20.063169 avg loss, 0.001300 rate, 9.968427 seconds, 70944 images, 1396.757319 hours left
Loaded: 0.000026 seconds

 2218: 23.006563, 20.357510 avg loss, 0.001300 rate, 10.841401 seconds, 70976 images, 1396.587302 hours left
Loaded: 0.000037 seconds

 2219: 16.135149, 19.935274 avg loss, 0.001300 rate, 9.816920 seconds, 71008 images, 1397.627242 hours left
Loaded: 0.000038 seconds

 2220: 23.425198, 20.284267 avg loss, 0.001300 rate, 10.794796 seconds, 71040 images, 1397.238770 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.364782 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2221: 24.975306, 20.753372 avg loss, 0.001300 rate, 6.248394 seconds, 71072 images, 1398.207646 hours left
Loaded: 0.000031 seconds

 2222: 22.383747, 20.916410 avg loss, 0.001300 rate, 6.195957 seconds, 71104 images, 1393.378935 hours left
Loaded: 0.000033 seconds

 2223: 16.858189, 20.510588 avg loss, 0.001300 rate, 5.641815 seconds, 71136 images, 1388.021060 hours left
Loaded: 0.000039 seconds

 2224: 18.957771, 20.355307 avg loss, 0.001300 rate, 5.677256 seconds, 71168 images, 1381.949761 hours left
Loaded: 0.000039 seconds

 2225: 21.828114, 20.502588 avg loss, 0.001300 rate, 6.072423 seconds, 71200 images, 1375.988221 hours left
Loaded: 0.000030 seconds

 2226: 25.563900, 21.008720 avg loss, 0.001300 rate, 6.353076 seconds, 71232 images, 1370.633230 hours left
Loaded: 0.000040 seconds

 2227: 19.534340, 20.861282 avg loss, 0.001300 rate, 5.574471 seconds, 71264 images, 1365.720211 hours left
Loaded: 0.000028 seconds

 2228: 22.603245, 21.035479 avg loss, 0.001300 rate, 5.977185 seconds, 71296 images, 1359.778655 hours left
Loaded: 0.000029 seconds

 2229: 23.317982, 21.263729 avg loss, 0.001300 rate, 6.074870 seconds, 71328 images, 1354.453875 hours left
Loaded: 0.000034 seconds

 2230: 18.763235, 21.013680 avg loss, 0.001300 rate, 5.674843 seconds, 71360 images, 1349.317545 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.000023 seconds

 2231: 16.008377, 20.513149 avg loss, 0.001300 rate, 10.380094 seconds, 71392 images, 1343.678886 hours left
Loaded: 0.000026 seconds

 2232: 21.257933, 20.587627 avg loss, 0.001300 rate, 11.336046 seconds, 71424 images, 1344.609028 hours left
Loaded: 0.000028 seconds

 2233: 26.460482, 21.174913 avg loss, 0.001300 rate, 11.925470 seconds, 71456 images, 1346.852955 hours left
Loaded: 0.000028 seconds

 2234: 24.790319, 21.536453 avg loss, 0.001300 rate, 11.528608 seconds, 71488 images, 1349.890221 hours left
Loaded: 0.000027 seconds

 2235: 17.346865, 21.117495 avg loss, 0.001300 rate, 10.563629 seconds, 71520 images, 1352.347796 hours left
Loaded: 0.000040 seconds

 2236: 11.544752, 20.160221 avg loss, 0.001300 rate, 9.911507 seconds, 71552 images, 1353.445164 hours left
Loaded: 0.000034 seconds

 2237: 14.158266, 19.560026 avg loss, 0.001300 rate, 10.058403 seconds, 71584 images, 1353.628965 hours left
Loaded: 0.000028 seconds

 2238: 16.176792, 19.221703 avg loss, 0.001300 rate, 11.465438 seconds, 71616 images, 1354.014208 hours left
Loaded: 0.000028 seconds

 2239: 25.985420, 19.898075 avg loss, 0.001300 rate, 12.388832 seconds, 71648 images, 1356.342987 hours left
Loaded: 0.000030 seconds

 2240: 20.155643, 19.923832 avg loss, 0.001300 rate, 11.831888 seconds, 71680 images, 1359.926477 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.134536 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2241: 20.707382, 20.002188 avg loss, 0.001300 rate, 13.066846 seconds, 71712 images, 1362.703257 hours left
Loaded: 0.000037 seconds

 2242: 24.689543, 20.470922 avg loss, 0.001300 rate, 13.867715 seconds, 71744 images, 1367.347646 hours left
Loaded: 0.000036 seconds

 2243: 16.305416, 20.054371 avg loss, 0.001300 rate, 12.157231 seconds, 71776 images, 1372.867846 hours left
Loaded: 0.000030 seconds

 2244: 19.685501, 20.017485 avg loss, 0.001300 rate, 12.677417 seconds, 71808 images, 1375.965414 hours left
Loaded: 0.000029 seconds

 2245: 24.506247, 20.466360 avg loss, 0.001300 rate, 13.432002 seconds, 71840 images, 1379.751924 hours left
Loaded: 0.000030 seconds

 2246: 21.614843, 20.581209 avg loss, 0.001300 rate, 13.173711 seconds, 71872 images, 1384.544909 hours left
Loaded: 0.000036 seconds

 2247: 24.434944, 20.966583 avg loss, 0.001300 rate, 13.300681 seconds, 71904 images, 1388.932443 hours left
Loaded: 0.000044 seconds

 2248: 16.550554, 20.524981 avg loss, 0.001300 rate, 11.361163 seconds, 71936 images, 1393.451805 hours left
Loaded: 0.000027 seconds

 2249: 10.714996, 19.543982 avg loss, 0.001300 rate, 11.153493 seconds, 71968 images, 1395.241589 hours left
Loaded: 0.000030 seconds

 2250: 24.493828, 20.038967 avg loss, 0.001300 rate, 13.135749 seconds, 72000 images, 1396.725998 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.153596 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2251: 16.570566, 19.692127 avg loss, 0.001300 rate, 5.516275 seconds, 72032 images, 1400.939035 hours left
Loaded: 0.000032 seconds

 2252: 19.434359, 19.666351 avg loss, 0.001300 rate, 5.616515 seconds, 72064 images, 1394.776902 hours left
Loaded: 0.000029 seconds

 2253: 17.808546, 19.480572 avg loss, 0.001300 rate, 5.729074 seconds, 72096 images, 1388.602571 hours left
Loaded: 0.000027 seconds

 2254: 30.520958, 20.584610 avg loss, 0.001300 rate, 6.534059 seconds, 72128 images, 1382.645750 hours left
Loaded: 0.000030 seconds

 2255: 25.391237, 21.065273 avg loss, 0.001300 rate, 6.049766 seconds, 72160 images, 1377.862588 hours left
Loaded: 0.000037 seconds

 2256: 18.325438, 20.791290 avg loss, 0.001300 rate, 5.797774 seconds, 72192 images, 1372.456976 hours left
Loaded: 0.000041 seconds

 2257: 19.073566, 20.619518 avg loss, 0.001300 rate, 5.764455 seconds, 72224 images, 1366.756669 hours left
Loaded: 0.000036 seconds

 2258: 28.355526, 21.393120 avg loss, 0.001300 rate, 6.452326 seconds, 72256 images, 1361.067225 hours left
Loaded: 0.000030 seconds

 2259: 16.604918, 20.914299 avg loss, 0.001300 rate, 5.411751 seconds, 72288 images, 1356.386671 hours left
Loaded: 0.000024 seconds

 2260: 20.563251, 20.879194 avg loss, 0.001300 rate, 5.751997 seconds, 72320 images, 1350.312738 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.068496 seconds

 2261: 21.588202, 20.950094 avg loss, 0.001300 rate, 6.448110 seconds, 72352 images, 1344.770420 hours left
Loaded: 0.000026 seconds

 2262: 26.751383, 21.530224 avg loss, 0.001300 rate, 6.691666 seconds, 72384 images, 1340.341693 hours left
Loaded: 0.000039 seconds

 2263: 20.027262, 21.379929 avg loss, 0.001300 rate, 6.204868 seconds, 72416 images, 1336.199552 hours left
Loaded: 0.000028 seconds

 2264: 24.180149, 21.659950 avg loss, 0.001300 rate, 6.589337 seconds, 72448 images, 1331.425108 hours left
Loaded: 0.000028 seconds

 2265: 16.047880, 21.098743 avg loss, 0.001300 rate, 6.183623 seconds, 72480 images, 1327.230476 hours left
Loaded: 0.000031 seconds

 2266: 21.730684, 21.161938 avg loss, 0.001300 rate, 6.803990 seconds, 72512 images, 1322.516274 hours left
Loaded: 0.000032 seconds

 2267: 24.965622, 21.542307 avg loss, 0.001300 rate, 7.222795 seconds, 72544 images, 1318.707777 hours left
Loaded: 0.000030 seconds

 2268: 13.539999, 20.742077 avg loss, 0.001300 rate, 6.185223 seconds, 72576 images, 1315.516965 hours left
Loaded: 0.000042 seconds

 2269: 25.546303, 21.222500 avg loss, 0.001300 rate, 7.232758 seconds, 72608 images, 1310.922060 hours left
Loaded: 0.000041 seconds

 2270: 16.729208, 20.773170 avg loss, 0.001300 rate, 6.261283 seconds, 72640 images, 1307.822867 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.033822 seconds

 2271: 22.458670, 20.941721 avg loss, 0.001300 rate, 7.648147 seconds, 72672 images, 1303.410150 hours left
Loaded: 0.000032 seconds

 2272: 20.571739, 20.904722 avg loss, 0.001300 rate, 7.550385 seconds, 72704 images, 1301.007673 hours left
Loaded: 0.000030 seconds

 2273: 24.714930, 21.285744 avg loss, 0.001300 rate, 8.025485 seconds, 72736 images, 1298.447136 hours left
Loaded: 0.000030 seconds

 2274: 22.255650, 21.382734 avg loss, 0.001300 rate, 7.546593 seconds, 72768 images, 1296.569700 hours left
Loaded: 0.000028 seconds

 2275: 21.243647, 21.368826 avg loss, 0.001300 rate, 7.255168 seconds, 72800 images, 1294.048249 hours left
Loaded: 0.000029 seconds

 2276: 19.805458, 21.212490 avg loss, 0.001300 rate, 7.193750 seconds, 72832 images, 1291.148670 hours left
Loaded: 0.000031 seconds

 2277: 18.647493, 20.955990 avg loss, 0.001300 rate, 7.174416 seconds, 72864 images, 1288.193067 hours left
Loaded: 0.000032 seconds

 2278: 21.541891, 21.014580 avg loss, 0.001300 rate, 7.226239 seconds, 72896 images, 1285.240246 hours left
Loaded: 0.000038 seconds

 2279: 8.755363, 19.788658 avg loss, 0.001300 rate, 6.149327 seconds, 72928 images, 1282.388654 hours left
Loaded: 0.000039 seconds

 2280: 13.885994, 19.198391 avg loss, 0.001300 rate, 6.937131 seconds, 72960 images, 1278.075178 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.054932 seconds

 2281: 16.880779, 18.966629 avg loss, 0.001300 rate, 8.044023 seconds, 72992 images, 1274.895098 hours left
Loaded: 0.000026 seconds

 2282: 17.990034, 18.868969 avg loss, 0.001300 rate, 8.087677 seconds, 73024 images, 1273.354644 hours left
Loaded: 0.000030 seconds

 2283: 16.296850, 18.611757 avg loss, 0.001300 rate, 7.780831 seconds, 73056 images, 1271.813997 hours left
Loaded: 0.000029 seconds

 2284: 26.242208, 19.374802 avg loss, 0.001300 rate, 9.153414 seconds, 73088 images, 1269.864085 hours left
Loaded: 0.000042 seconds

 2285: 23.950918, 19.832413 avg loss, 0.001300 rate, 8.731831 seconds, 73120 images, 1269.833227 hours left
Loaded: 0.000029 seconds

 2286: 19.136162, 19.762787 avg loss, 0.001300 rate, 8.276595 seconds, 73152 images, 1269.219213 hours left
Loaded: 0.000030 seconds

 2287: 21.257772, 19.912285 avg loss, 0.001300 rate, 8.734131 seconds, 73184 images, 1267.981284 hours left
Loaded: 0.000038 seconds

 2288: 21.623215, 20.083378 avg loss, 0.001300 rate, 8.684554 seconds, 73216 images, 1267.388908 hours left
Loaded: 0.000031 seconds

 2289: 18.144745, 19.889515 avg loss, 0.001300 rate, 8.250658 seconds, 73248 images, 1266.733832 hours left
Loaded: 0.000036 seconds

 2290: 20.922569, 19.992821 avg loss, 0.001300 rate, 8.505034 seconds, 73280 images, 1265.484797 hours left
Resizing, random_coef = 1.40 

 544 x 544 
 try to allocate additional workspace_size = 85.23 MB 
 CUDA allocate done! 
Loaded: 0.027901 seconds

 2291: 16.696428, 19.663181 avg loss, 0.001300 rate, 9.176525 seconds, 73312 images, 1264.600271 hours left
Loaded: 0.000031 seconds

 2292: 23.155973, 20.012461 avg loss, 0.001300 rate, 10.027363 seconds, 73344 images, 1264.692413 hours left
Loaded: 0.000028 seconds

 2293: 17.909019, 19.802116 avg loss, 0.001300 rate, 9.246153 seconds, 73376 images, 1265.922525 hours left
Loaded: 0.000040 seconds

 2294: 21.742748, 19.996180 avg loss, 0.001300 rate, 9.540858 seconds, 73408 images, 1266.059179 hours left
Loaded: 0.000037 seconds

 2295: 27.863146, 20.782877 avg loss, 0.001300 rate, 10.284568 seconds, 73440 images, 1266.602303 hours left
Loaded: 0.000036 seconds

 2296: 20.679649, 20.772554 avg loss, 0.001300 rate, 9.415270 seconds, 73472 images, 1268.169186 hours left
Loaded: 0.000038 seconds

 2297: 17.156153, 20.410913 avg loss, 0.001300 rate, 9.014243 seconds, 73504 images, 1268.517349 hours left
Loaded: 0.000037 seconds

 2298: 20.660381, 20.435860 avg loss, 0.001300 rate, 9.343196 seconds, 73536 images, 1268.307027 hours left
Loaded: 0.000030 seconds

 2299: 15.106065, 19.902880 avg loss, 0.001300 rate, 8.796074 seconds, 73568 images, 1268.554019 hours left
Loaded: 0.000029 seconds

 2300: 23.945967, 20.307188 avg loss, 0.001300 rate, 9.151160 seconds, 73600 images, 1268.041347 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.387280 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2301: 19.315834, 20.208054 avg loss, 0.001300 rate, 8.067537 seconds, 73632 images, 1268.025173 hours left
Loaded: 0.000029 seconds

 2302: 16.863390, 19.873587 avg loss, 0.001300 rate, 7.812251 seconds, 73664 images, 1267.045438 hours left
Loaded: 0.000040 seconds

 2303: 21.227171, 20.008945 avg loss, 0.001300 rate, 8.483560 seconds, 73696 images, 1265.186281 hours left
Loaded: 0.000030 seconds

 2304: 17.180346, 19.726086 avg loss, 0.001300 rate, 7.919048 seconds, 73728 images, 1264.274722 hours left
Loaded: 0.000031 seconds

 2305: 24.863962, 20.239874 avg loss, 0.001300 rate, 8.877683 seconds, 73760 images, 1262.591025 hours left
Loaded: 0.000032 seconds

 2306: 22.300726, 20.445959 avg loss, 0.001300 rate, 8.606144 seconds, 73792 images, 1262.250773 hours left
Loaded: 0.000041 seconds

 2307: 18.438795, 20.245243 avg loss, 0.001300 rate, 8.131018 seconds, 73824 images, 1261.538126 hours left
Loaded: 0.000037 seconds

 2308: 19.350277, 20.155746 avg loss, 0.001300 rate, 8.371021 seconds, 73856 images, 1260.175081 hours left
Loaded: 0.000038 seconds

 2309: 22.193142, 20.359486 avg loss, 0.001300 rate, 8.737211 seconds, 73888 images, 1259.157771 hours left
Loaded: 0.000030 seconds

 2310: 17.039194, 20.027456 avg loss, 0.001300 rate, 7.977827 seconds, 73920 images, 1258.657371 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.281549 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2311: 17.082932, 19.733004 avg loss, 0.001300 rate, 5.561749 seconds, 73952 images, 1257.111056 hours left
Loaded: 0.000030 seconds

 2312: 22.721830, 20.031887 avg loss, 0.001300 rate, 6.074799 seconds, 73984 images, 1252.626268 hours left
Loaded: 0.000038 seconds

 2313: 22.434828, 20.272181 avg loss, 0.001300 rate, 5.960142 seconds, 74016 images, 1248.506704 hours left
Loaded: 0.000040 seconds

 2314: 12.865906, 19.531553 avg loss, 0.001300 rate, 5.227850 seconds, 74048 images, 1244.269660 hours left
Loaded: 0.000037 seconds

 2315: 20.993364, 19.677734 avg loss, 0.001300 rate, 5.898806 seconds, 74080 images, 1239.061591 hours left
Loaded: 0.000040 seconds

 2316: 28.726040, 20.582565 avg loss, 0.001300 rate, 6.590997 seconds, 74112 images, 1234.834085 hours left
Loaded: 0.000031 seconds

 2317: 20.422688, 20.566578 avg loss, 0.001300 rate, 5.793348 seconds, 74144 images, 1231.606727 hours left
Loaded: 0.000038 seconds

 2318: 19.519405, 20.461861 avg loss, 0.001300 rate, 5.764868 seconds, 74176 images, 1227.307791 hours left
Loaded: 0.000041 seconds

 2319: 23.109657, 20.726641 avg loss, 0.001300 rate, 6.076440 seconds, 74208 images, 1223.012427 hours left
Loaded: 0.000030 seconds

 2320: 26.516037, 21.305580 avg loss, 0.001300 rate, 6.237284 seconds, 74240 images, 1219.191170 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000028 seconds

 2321: 22.518740, 21.426895 avg loss, 0.001300 rate, 13.157192 seconds, 74272 images, 1215.630674 hours left
Loaded: 0.000029 seconds

 2322: 14.691752, 20.753382 avg loss, 0.001300 rate, 11.616516 seconds, 74304 images, 1221.681744 hours left
Loaded: 0.000028 seconds

 2323: 16.161324, 20.294176 avg loss, 0.001300 rate, 12.004525 seconds, 74336 images, 1225.540237 hours left
Loaded: 0.000031 seconds

 2324: 20.807705, 20.345530 avg loss, 0.001300 rate, 12.970980 seconds, 74368 images, 1229.897049 hours left
Loaded: 0.000029 seconds

 2325: 19.244047, 20.235382 avg loss, 0.001300 rate, 12.567199 seconds, 74400 images, 1235.547667 hours left
Loaded: 0.000029 seconds

 2326: 18.283619, 20.040205 avg loss, 0.001300 rate, 12.574248 seconds, 74432 images, 1240.582978 hours left
Loaded: 0.000029 seconds

 2327: 15.391876, 19.575373 avg loss, 0.001300 rate, 12.247687 seconds, 74464 images, 1245.577656 hours left
Loaded: 0.000031 seconds

 2328: 17.816973, 19.399532 avg loss, 0.001300 rate, 12.407273 seconds, 74496 images, 1250.070453 hours left
Loaded: 0.000029 seconds

 2329: 26.745117, 20.134090 avg loss, 0.001300 rate, 14.455581 seconds, 74528 images, 1254.739128 hours left
Loaded: 0.000029 seconds

 2330: 12.691381, 19.389820 avg loss, 0.001300 rate, 11.699573 seconds, 74560 images, 1262.195544 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.412822 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2331: 22.394741, 19.690311 avg loss, 0.001300 rate, 7.488089 seconds, 74592 images, 1265.763577 hours left
Loaded: 0.000028 seconds

 2332: 17.656950, 19.486975 avg loss, 0.001300 rate, 7.174860 seconds, 74624 images, 1264.039256 hours left
Loaded: 0.000026 seconds

 2333: 21.957546, 19.734032 avg loss, 0.001300 rate, 7.617902 seconds, 74656 images, 1261.327486 hours left
Loaded: 0.000029 seconds

 2334: 18.030806, 19.563709 avg loss, 0.001300 rate, 7.228414 seconds, 74688 images, 1259.255893 hours left
Loaded: 0.000029 seconds

 2335: 24.525707, 20.059910 avg loss, 0.001300 rate, 7.901061 seconds, 74720 images, 1256.666026 hours left
Loaded: 0.000032 seconds

 2336: 21.636501, 20.217569 avg loss, 0.001300 rate, 7.340283 seconds, 74752 images, 1255.032843 hours left
Loaded: 0.000029 seconds

 2337: 17.542025, 19.950014 avg loss, 0.001300 rate, 7.151644 seconds, 74784 images, 1252.639973 hours left
Loaded: 0.000030 seconds

 2338: 18.058121, 19.760824 avg loss, 0.001300 rate, 7.195080 seconds, 74816 images, 1250.009973 hours left
Loaded: 0.000030 seconds

 2339: 21.590124, 19.943754 avg loss, 0.001300 rate, 7.656296 seconds, 74848 images, 1247.466360 hours left
Loaded: 0.000038 seconds

 2340: 21.215239, 20.070902 avg loss, 0.001300 rate, 7.456645 seconds, 74880 images, 1245.586385 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.437639 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2341: 21.832966, 20.247108 avg loss, 0.001300 rate, 5.855270 seconds, 74912 images, 1243.448939 hours left
Loaded: 0.000029 seconds

 2342: 19.442259, 20.166624 avg loss, 0.001300 rate, 5.815745 seconds, 74944 images, 1239.722433 hours left
Loaded: 0.000031 seconds

 2343: 22.985052, 20.448467 avg loss, 0.001300 rate, 5.880821 seconds, 74976 images, 1235.372929 hours left
Loaded: 0.000033 seconds

 2344: 16.437277, 20.047348 avg loss, 0.001300 rate, 5.366665 seconds, 75008 images, 1231.156957 hours left
Loaded: 0.000030 seconds

 2345: 16.037951, 19.646408 avg loss, 0.001300 rate, 5.477543 seconds, 75040 images, 1226.271658 hours left
Loaded: 0.000030 seconds

 2346: 15.090907, 19.190859 avg loss, 0.001300 rate, 5.434300 seconds, 75072 images, 1221.588622 hours left
Loaded: 0.000031 seconds

 2347: 14.466098, 18.718382 avg loss, 0.001300 rate, 5.409135 seconds, 75104 images, 1216.892563 hours left
Loaded: 0.000038 seconds

 2348: 21.792587, 19.025803 avg loss, 0.001300 rate, 5.799806 seconds, 75136 images, 1212.208630 hours left
Loaded: 0.000039 seconds

 2349: 19.327194, 19.055943 avg loss, 0.001300 rate, 5.837709 seconds, 75168 images, 1208.112124 hours left
Loaded: 0.000039 seconds

 2350: 22.715418, 19.421890 avg loss, 0.001300 rate, 6.070886 seconds, 75200 images, 1204.109016 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.000351 seconds

 2351: 19.774881, 19.457190 avg loss, 0.001300 rate, 7.591035 seconds, 75232 images, 1200.468581 hours left
Loaded: 0.000029 seconds

 2352: 20.732117, 19.584682 avg loss, 0.001300 rate, 7.297891 seconds, 75264 images, 1198.968468 hours left
Loaded: 0.000030 seconds

 2353: 15.330770, 19.159290 avg loss, 0.001300 rate, 6.777368 seconds, 75296 images, 1197.077253 hours left
Loaded: 0.000029 seconds

 2354: 20.732971, 19.316658 avg loss, 0.001300 rate, 7.211423 seconds, 75328 images, 1194.484661 hours left
Loaded: 0.000038 seconds

 2355: 24.413815, 19.826374 avg loss, 0.001300 rate, 7.863101 seconds, 75360 images, 1192.518595 hours left
Loaded: 0.000039 seconds

 2356: 24.892513, 20.332989 avg loss, 0.001300 rate, 7.755383 seconds, 75392 images, 1191.473931 hours left
Loaded: 0.000038 seconds

 2357: 19.310760, 20.230766 avg loss, 0.001300 rate, 7.346138 seconds, 75424 images, 1190.290641 hours left
Loaded: 0.000039 seconds

 2358: 19.228476, 20.130537 avg loss, 0.001300 rate, 7.175807 seconds, 75456 images, 1188.552878 hours left
Loaded: 0.000032 seconds

 2359: 19.502369, 20.067720 avg loss, 0.001300 rate, 7.224424 seconds, 75488 images, 1186.596780 hours left
Loaded: 0.000028 seconds

 2360: 15.204079, 19.581356 avg loss, 0.001300 rate, 6.685802 seconds, 75520 images, 1184.727486 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.300864 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2361: 19.313263, 19.554546 avg loss, 0.001300 rate, 5.894497 seconds, 75552 images, 1182.131555 hours left
Loaded: 0.000034 seconds

 2362: 17.831575, 19.382250 avg loss, 0.001300 rate, 5.933103 seconds, 75584 images, 1178.882894 hours left
Loaded: 0.000038 seconds

 2363: 21.857563, 19.629782 avg loss, 0.001300 rate, 6.118986 seconds, 75616 images, 1175.303860 hours left
Loaded: 0.000038 seconds

 2364: 23.140802, 19.980885 avg loss, 0.001300 rate, 6.197024 seconds, 75648 images, 1172.017813 hours left
Loaded: 0.000030 seconds

 2365: 23.773104, 20.360107 avg loss, 0.001300 rate, 6.322273 seconds, 75680 images, 1168.872592 hours left
Loaded: 0.000038 seconds

 2366: 12.623770, 19.586473 avg loss, 0.001300 rate, 5.293517 seconds, 75712 images, 1165.932104 hours left
Loaded: 0.000039 seconds

 2367: 16.795580, 19.307384 avg loss, 0.001300 rate, 5.826723 seconds, 75744 images, 1161.597517 hours left
Loaded: 0.000035 seconds

 2368: 20.099844, 19.386631 avg loss, 0.001300 rate, 5.858404 seconds, 75776 images, 1158.044075 hours left
Loaded: 0.000031 seconds

 2369: 19.176855, 19.365654 avg loss, 0.001300 rate, 5.884425 seconds, 75808 images, 1154.569969 hours left
Loaded: 0.000038 seconds

 2370: 18.595984, 19.288687 avg loss, 0.001300 rate, 5.873234 seconds, 75840 images, 1151.166589 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.000030 seconds

 2371: 24.001926, 19.760010 avg loss, 0.001300 rate, 11.656228 seconds, 75872 images, 1147.781749 hours left
Loaded: 0.000029 seconds

 2372: 23.086836, 20.092693 avg loss, 0.001300 rate, 11.098835 seconds, 75904 images, 1152.432612 hours left
Loaded: 0.000030 seconds

 2373: 19.811771, 20.064602 avg loss, 0.001300 rate, 10.586729 seconds, 75936 images, 1156.265674 hours left
Loaded: 0.000038 seconds

 2374: 22.968655, 20.355007 avg loss, 0.001300 rate, 11.348122 seconds, 75968 images, 1159.351783 hours left
Loaded: 0.000025 seconds

 2375: 18.577320, 20.177238 avg loss, 0.001300 rate, 10.560226 seconds, 76000 images, 1163.460539 hours left
Loaded: 0.000030 seconds

 2376: 20.184137, 20.177929 avg loss, 0.001300 rate, 10.270035 seconds, 76032 images, 1166.437961 hours left
Loaded: 0.000029 seconds

 2377: 11.611428, 19.321280 avg loss, 0.001300 rate, 9.269895 seconds, 76064 images, 1168.984056 hours left
Loaded: 0.000025 seconds

 2378: 26.411480, 20.030300 avg loss, 0.001300 rate, 11.360347 seconds, 76096 images, 1170.120790 hours left
Loaded: 0.000029 seconds

 2379: 19.279299, 19.955200 avg loss, 0.001300 rate, 10.451854 seconds, 76128 images, 1174.138627 hours left
Loaded: 0.000029 seconds

 2380: 22.544516, 20.214132 avg loss, 0.001300 rate, 10.847236 seconds, 76160 images, 1176.859205 hours left
Resizing, random_coef = 1.40 

 672 x 672 
 try to allocate additional workspace_size = 130.06 MB 
 CUDA allocate done! 
Loaded: 0.000031 seconds

 2381: 18.839039, 20.076622 avg loss, 0.001300 rate, 12.932774 seconds, 76192 images, 1180.099627 hours left
Loaded: 0.000033 seconds

 2382: 20.932449, 20.162205 avg loss, 0.001300 rate, 14.084370 seconds, 76224 images, 1186.193298 hours left
Loaded: 0.000027 seconds

 2383: 18.611826, 20.007168 avg loss, 0.001300 rate, 13.801446 seconds, 76256 images, 1193.819418 hours left
Loaded: 0.000041 seconds

 2384: 22.267548, 20.233206 avg loss, 0.001300 rate, 14.195263 seconds, 76288 images, 1200.977761 hours left
Loaded: 0.000028 seconds

 2385: 19.921942, 20.202080 avg loss, 0.001300 rate, 13.573346 seconds, 76320 images, 1208.609408 hours left
Loaded: 0.000027 seconds

 2386: 24.149012, 20.596773 avg loss, 0.001300 rate, 14.300819 seconds, 76352 images, 1215.304164 hours left
Loaded: 0.000036 seconds

 2387: 21.336113, 20.670708 avg loss, 0.001300 rate, 13.805997 seconds, 76384 images, 1222.938502 hours left
Loaded: 0.000037 seconds

 2388: 27.809469, 21.384584 avg loss, 0.001300 rate, 14.835345 seconds, 76416 images, 1229.811809 hours left
Loaded: 0.000027 seconds

 2389: 19.445295, 21.190655 avg loss, 0.001300 rate, 13.257497 seconds, 76448 images, 1238.040598 hours left
Loaded: 0.000031 seconds

 2390: 19.439100, 21.015499 avg loss, 0.001300 rate, 13.168499 seconds, 76480 images, 1244.003869 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.048217 seconds

 2391: 11.581091, 20.072058 avg loss, 0.001300 rate, 9.838492 seconds, 76512 images, 1249.784334 hours left
Loaded: 0.000024 seconds

 2392: 20.760433, 20.140896 avg loss, 0.001300 rate, 10.954435 seconds, 76544 images, 1250.966113 hours left
Loaded: 0.000039 seconds

 2393: 12.944037, 19.421209 avg loss, 0.001300 rate, 10.028034 seconds, 76576 images, 1253.613421 hours left
Loaded: 0.000027 seconds

 2394: 24.533524, 19.932442 avg loss, 0.001300 rate, 11.492359 seconds, 76608 images, 1254.952445 hours left
Loaded: 0.000030 seconds

 2395: 22.033445, 20.142542 avg loss, 0.001300 rate, 11.105219 seconds, 76640 images, 1258.304118 hours left
Loaded: 0.000036 seconds

 2396: 24.066648, 20.534952 avg loss, 0.001300 rate, 11.349667 seconds, 76672 images, 1261.086589 hours left
Loaded: 0.000027 seconds

 2397: 19.586508, 20.440107 avg loss, 0.001300 rate, 10.971374 seconds, 76704 images, 1264.179437 hours left
Loaded: 0.000029 seconds

 2398: 20.530807, 20.449177 avg loss, 0.001300 rate, 11.080033 seconds, 76736 images, 1266.717900 hours left
Loaded: 0.000037 seconds

 2399: 17.202930, 20.124552 avg loss, 0.001300 rate, 10.896283 seconds, 76768 images, 1269.381293 hours left
Loaded: 0.000026 seconds

 2400: 16.509510, 19.763048 avg loss, 0.001300 rate, 10.539837 seconds, 76800 images, 1271.763792 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.049365 seconds

 2401: 22.461391, 20.032883 avg loss, 0.001300 rate, 13.149945 seconds, 76832 images, 1273.629239 hours left
Loaded: 0.000029 seconds

 2402: 22.122377, 20.241833 avg loss, 0.001300 rate, 13.110904 seconds, 76864 images, 1279.155635 hours left
Loaded: 0.000028 seconds

 2403: 20.444584, 20.262108 avg loss, 0.001300 rate, 12.967041 seconds, 76896 images, 1284.504452 hours left
Loaded: 0.000029 seconds

 2404: 14.141774, 19.650074 avg loss, 0.001300 rate, 11.555707 seconds, 76928 images, 1289.600692 hours left
Loaded: 0.000038 seconds

 2405: 15.276403, 19.212708 avg loss, 0.001300 rate, 12.018395 seconds, 76960 images, 1292.693215 hours left
Loaded: 0.000029 seconds

 2406: 18.607271, 19.152164 avg loss, 0.001300 rate, 12.573486 seconds, 76992 images, 1296.394965 hours left
Loaded: 0.000025 seconds

 2407: 20.476511, 19.284599 avg loss, 0.001300 rate, 12.957289 seconds, 77024 images, 1300.827675 hours left
Loaded: 0.000022 seconds

 2408: 26.368464, 19.992985 avg loss, 0.001300 rate, 13.631726 seconds, 77056 images, 1305.747044 hours left
Loaded: 0.000034 seconds

 2409: 15.945477, 19.588234 avg loss, 0.001300 rate, 11.869142 seconds, 77088 images, 1311.550322 hours left
Loaded: 0.000026 seconds

 2410: 14.927567, 19.122168 avg loss, 0.001300 rate, 11.559351 seconds, 77120 images, 1314.856859 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.411598 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2411: 12.915066, 18.501457 avg loss, 0.001300 rate, 10.489436 seconds, 77152 images, 1317.701666 hours left
Loaded: 0.000030 seconds

 2412: 24.015015, 19.052813 avg loss, 0.001300 rate, 11.796167 seconds, 77184 images, 1319.607120 hours left
Loaded: 0.000023 seconds

 2413: 15.341740, 18.681705 avg loss, 0.001300 rate, 10.428572 seconds, 77216 images, 1322.732019 hours left
Loaded: 0.000029 seconds

 2414: 20.513538, 18.864889 avg loss, 0.001300 rate, 11.499462 seconds, 77248 images, 1323.933456 hours left
Loaded: 0.000027 seconds

 2415: 27.945911, 19.772991 avg loss, 0.001300 rate, 12.104141 seconds, 77280 images, 1326.604510 hours left
Loaded: 0.000040 seconds

 2416: 11.737877, 18.969481 avg loss, 0.001300 rate, 9.883351 seconds, 77312 images, 1330.085435 hours left
Loaded: 0.000035 seconds

 2417: 18.120815, 18.884613 avg loss, 0.001300 rate, 10.753519 seconds, 77344 images, 1330.458923 hours left
Loaded: 0.000034 seconds

 2418: 20.571846, 19.053337 avg loss, 0.001300 rate, 10.928268 seconds, 77376 images, 1332.032576 hours left
Loaded: 0.000034 seconds

 2419: 19.309000, 19.078903 avg loss, 0.001300 rate, 11.088443 seconds, 77408 images, 1333.832236 hours left
Loaded: 0.000029 seconds

 2420: 20.996143, 19.270628 avg loss, 0.001300 rate, 11.286182 seconds, 77440 images, 1335.835481 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.027767 seconds

 2421: 22.968851, 19.640450 avg loss, 0.001300 rate, 14.698529 seconds, 77472 images, 1338.092238 hours left
Loaded: 0.000034 seconds

 2422: 16.097113, 19.286116 avg loss, 0.001300 rate, 13.895059 seconds, 77504 images, 1345.085936 hours left
Loaded: 0.000027 seconds

 2423: 15.607659, 18.918270 avg loss, 0.001300 rate, 13.803846 seconds, 77536 images, 1350.859659 hours left
Loaded: 0.000027 seconds

 2424: 21.108658, 19.137308 avg loss, 0.001300 rate, 14.788142 seconds, 77568 images, 1356.449385 hours left
Loaded: 0.000028 seconds

 2425: 18.101864, 19.033764 avg loss, 0.001300 rate, 13.822256 seconds, 77600 images, 1363.344993 hours left
Loaded: 0.000027 seconds

 2426: 19.244209, 19.054808 avg loss, 0.001300 rate, 14.065127 seconds, 77632 images, 1368.835261 hours left
Loaded: 0.000030 seconds

 2427: 22.306971, 19.380024 avg loss, 0.001300 rate, 15.264260 seconds, 77664 images, 1374.606608 hours left
Loaded: 0.000032 seconds

 2428: 25.058989, 19.947920 avg loss, 0.001300 rate, 15.395824 seconds, 77696 images, 1381.979251 hours left
Loaded: 0.000033 seconds

 2429: 18.624084, 19.815536 avg loss, 0.001300 rate, 13.843815 seconds, 77728 images, 1389.460150 hours left
Loaded: 0.000036 seconds

 2430: 12.981370, 19.132120 avg loss, 0.001300 rate, 13.072177 seconds, 77760 images, 1394.718948 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.345652 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2431: 23.702293, 19.589138 avg loss, 0.001300 rate, 5.849569 seconds, 77792 images, 1398.857542 hours left
Loaded: 0.000035 seconds

 2432: 21.883211, 19.818546 avg loss, 0.001300 rate, 5.647296 seconds, 77824 images, 1393.440222 hours left
Loaded: 0.000035 seconds

 2433: 20.354885, 19.872181 avg loss, 0.001300 rate, 5.569187 seconds, 77856 images, 1387.319039 hours left
Loaded: 0.000037 seconds

 2434: 19.325796, 19.817543 avg loss, 0.001300 rate, 5.372344 seconds, 77888 images, 1381.150986 hours left
Loaded: 0.000038 seconds

 2435: 22.958151, 20.131603 avg loss, 0.001300 rate, 5.790659 seconds, 77920 images, 1374.772266 hours left
Loaded: 0.000028 seconds

 2436: 20.856258, 20.204069 avg loss, 0.001300 rate, 5.523658 seconds, 77952 images, 1369.036065 hours left
Loaded: 0.000029 seconds

 2437: 19.889936, 20.172655 avg loss, 0.001300 rate, 5.399582 seconds, 77984 images, 1362.987799 hours left
Loaded: 0.000036 seconds

 2438: 25.117828, 20.667171 avg loss, 0.001300 rate, 5.721627 seconds, 78016 images, 1356.828339 hours left
Loaded: 0.000036 seconds

 2439: 12.988832, 19.899338 avg loss, 0.001300 rate, 4.996377 seconds, 78048 images, 1351.176021 hours left
Loaded: 0.000036 seconds

 2440: 22.415575, 20.150961 avg loss, 0.001300 rate, 5.507711 seconds, 78080 images, 1344.576824 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.014067 seconds

 2441: 22.762255, 20.412090 avg loss, 0.001300 rate, 7.905960 seconds, 78112 images, 1338.751036 hours left
Loaded: 0.000031 seconds

 2442: 21.313709, 20.502253 avg loss, 0.001300 rate, 7.852629 seconds, 78144 images, 1336.320874 hours left
Loaded: 0.000030 seconds

 2443: 15.847263, 20.036755 avg loss, 0.001300 rate, 7.318769 seconds, 78176 images, 1333.821789 hours left
Loaded: 0.000026 seconds

 2444: 19.310627, 19.964142 avg loss, 0.001300 rate, 7.698251 seconds, 78208 images, 1330.609081 hours left
Loaded: 0.000037 seconds

 2445: 18.389925, 19.806721 avg loss, 0.001300 rate, 7.562350 seconds, 78240 images, 1327.953483 hours left
Loaded: 0.000028 seconds

 2446: 19.379803, 19.764029 avg loss, 0.001300 rate, 7.691408 seconds, 78272 images, 1325.136418 hours left
Loaded: 0.000028 seconds

 2447: 20.665459, 19.854172 avg loss, 0.001300 rate, 7.838890 seconds, 78304 images, 1322.526039 hours left
Loaded: 0.000026 seconds

 2448: 19.494396, 19.818193 avg loss, 0.001300 rate, 7.628821 seconds, 78336 images, 1320.145779 hours left
Loaded: 0.000028 seconds

 2449: 27.012047, 20.537579 avg loss, 0.001300 rate, 8.460138 seconds, 78368 images, 1317.498674 hours left
Loaded: 0.000024 seconds

 2450: 13.313334, 19.815155 avg loss, 0.001300 rate, 7.121068 seconds, 78400 images, 1316.028130 hours left
Resizing, random_coef = 1.40 

 576 x 576 
 try to allocate additional workspace_size = 95.55 MB 
 CUDA allocate done! 
Loaded: 0.036992 seconds

 2451: 22.186985, 20.052338 avg loss, 0.001300 rate, 10.385716 seconds, 78432 images, 1312.719705 hours left
Loaded: 0.000031 seconds

 2452: 21.317877, 20.178892 avg loss, 0.001300 rate, 9.848372 seconds, 78464 images, 1314.012020 hours left
Loaded: 0.000029 seconds

 2453: 14.486332, 19.609636 avg loss, 0.001300 rate, 9.196468 seconds, 78496 images, 1314.496850 hours left
Loaded: 0.000028 seconds

 2454: 21.768429, 19.825516 avg loss, 0.001300 rate, 9.692118 seconds, 78528 images, 1314.074915 hours left
Loaded: 0.000026 seconds

 2455: 18.098873, 19.652851 avg loss, 0.001300 rate, 9.384328 seconds, 78560 images, 1314.342884 hours left
Loaded: 0.000029 seconds

 2456: 18.220888, 19.509655 avg loss, 0.001300 rate, 9.553646 seconds, 78592 images, 1314.182329 hours left
Loaded: 0.000032 seconds

 2457: 20.191015, 19.577791 avg loss, 0.001300 rate, 9.859553 seconds, 78624 images, 1314.257603 hours left
Loaded: 0.000028 seconds

 2458: 16.833456, 19.303358 avg loss, 0.001300 rate, 9.286642 seconds, 78656 images, 1314.755310 hours left
Loaded: 0.000027 seconds

 2459: 23.861752, 19.759197 avg loss, 0.001300 rate, 10.052974 seconds, 78688 images, 1314.455413 hours left
Loaded: 0.000030 seconds

 2460: 19.138266, 19.697104 avg loss, 0.001300 rate, 9.424679 seconds, 78720 images, 1315.218668 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.018916 seconds

 2461: 22.954475, 20.022840 avg loss, 0.001300 rate, 10.897725 seconds, 78752 images, 1315.105055 hours left
Loaded: 0.000025 seconds

 2462: 19.541168, 19.974674 avg loss, 0.001300 rate, 10.548940 seconds, 78784 images, 1317.056553 hours left
Loaded: 0.000035 seconds

 2463: 19.755610, 19.952768 avg loss, 0.001300 rate, 10.505496 seconds, 78816 images, 1318.479847 hours left
Loaded: 0.000036 seconds

 2464: 23.449467, 20.302439 avg loss, 0.001300 rate, 10.980650 seconds, 78848 images, 1319.828791 hours left
Loaded: 0.000034 seconds

 2465: 11.891002, 19.461294 avg loss, 0.001300 rate, 9.443578 seconds, 78880 images, 1321.821564 hours left
Loaded: 0.000027 seconds

 2466: 21.584795, 19.673645 avg loss, 0.001300 rate, 10.981687 seconds, 78912 images, 1321.667941 hours left
Loaded: 0.000029 seconds

 2467: 21.405350, 19.846815 avg loss, 0.001300 rate, 10.970870 seconds, 78944 images, 1323.643684 hours left
Loaded: 0.000035 seconds

 2468: 16.590717, 19.521206 avg loss, 0.001300 rate, 10.157541 seconds, 78976 images, 1325.584675 hours left
Loaded: 0.000025 seconds

 2469: 24.260324, 19.995117 avg loss, 0.001300 rate, 10.991314 seconds, 79008 images, 1326.381057 hours left
Loaded: 0.000024 seconds

 2470: 25.527363, 20.548342 avg loss, 0.001300 rate, 11.035543 seconds, 79040 images, 1328.322889 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000026 seconds

 2471: 13.290362, 19.822544 avg loss, 0.001300 rate, 12.825087 seconds, 79072 images, 1330.306458 hours left
Loaded: 0.000027 seconds

 2472: 19.534822, 19.793772 avg loss, 0.001300 rate, 13.977023 seconds, 79104 images, 1334.745847 hours left
Loaded: 0.000027 seconds

 2473: 25.210072, 20.335402 avg loss, 0.001300 rate, 14.808623 seconds, 79136 images, 1340.734407 hours left
Loaded: 0.000028 seconds

 2474: 23.617922, 20.663654 avg loss, 0.001300 rate, 14.599969 seconds, 79168 images, 1347.813484 hours left
Loaded: 0.000033 seconds

 2475: 12.115161, 19.808805 avg loss, 0.001300 rate, 12.511872 seconds, 79200 images, 1354.533078 hours left
Loaded: 0.000037 seconds

 2476: 16.376028, 19.465528 avg loss, 0.001300 rate, 13.440234 seconds, 79232 images, 1358.296764 hours left
Loaded: 0.000034 seconds

 2477: 17.383003, 19.257277 avg loss, 0.001300 rate, 14.048767 seconds, 79264 images, 1363.307098 hours left
Loaded: 0.000027 seconds

 2478: 22.160545, 19.547604 avg loss, 0.001300 rate, 14.781514 seconds, 79296 images, 1369.109113 hours left
Loaded: 0.000026 seconds

 2479: 12.714564, 18.864300 avg loss, 0.001300 rate, 13.253828 seconds, 79328 images, 1375.866748 hours left
Loaded: 0.000028 seconds

 2480: 19.132977, 18.891167 avg loss, 0.001300 rate, 14.468563 seconds, 79360 images, 1380.443364 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000038 seconds

 2481: 12.229527, 18.225002 avg loss, 0.001300 rate, 13.492330 seconds, 79392 images, 1386.654631 hours left
Loaded: 0.000028 seconds

 2482: 19.727634, 18.375265 avg loss, 0.001300 rate, 15.759081 seconds, 79424 images, 1391.453252 hours left
Loaded: 0.000026 seconds

 2483: 21.162357, 18.653975 avg loss, 0.001300 rate, 16.003851 seconds, 79456 images, 1399.339621 hours left
Loaded: 0.000028 seconds

 2484: 21.005327, 18.889111 avg loss, 0.001300 rate, 15.934808 seconds, 79488 images, 1407.485689 hours left
Loaded: 0.000029 seconds

 2485: 24.423090, 19.442509 avg loss, 0.001300 rate, 16.478515 seconds, 79520 images, 1415.454744 hours left
Loaded: 0.000029 seconds

 2486: 22.051548, 19.703413 avg loss, 0.001300 rate, 16.230350 seconds, 79552 images, 1424.096216 hours left
Loaded: 0.000028 seconds

 2487: 28.093861, 20.542458 avg loss, 0.001300 rate, 17.084338 seconds, 79584 images, 1432.307921 hours left
Loaded: 0.000027 seconds

 2488: 20.262321, 20.514444 avg loss, 0.001300 rate, 15.399385 seconds, 79616 images, 1441.618844 hours left
Loaded: 0.000027 seconds

 2489: 22.161083, 20.679108 avg loss, 0.001300 rate, 15.984226 seconds, 79648 images, 1448.505700 hours left
Loaded: 0.000030 seconds

 2490: 21.476265, 20.758823 avg loss, 0.001300 rate, 15.545250 seconds, 79680 images, 1456.132694 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.459688 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2491: 24.383339, 21.121275 avg loss, 0.001300 rate, 12.345452 seconds, 79712 images, 1463.076115 hours left
Loaded: 0.000029 seconds

 2492: 15.396688, 20.548817 avg loss, 0.001300 rate, 11.052789 seconds, 79744 images, 1466.159464 hours left
Loaded: 0.000022 seconds

 2493: 15.075796, 20.001514 avg loss, 0.001300 rate, 11.117087 seconds, 79776 images, 1466.787860 hours left
Loaded: 0.000026 seconds

 2494: 17.307745, 19.732138 avg loss, 0.001300 rate, 11.239185 seconds, 79808 images, 1467.498876 hours left
Loaded: 0.000025 seconds

 2495: 13.654448, 19.124369 avg loss, 0.001300 rate, 10.800129 seconds, 79840 images, 1468.371661 hours left
Loaded: 0.000035 seconds

 2496: 20.199383, 19.231871 avg loss, 0.001300 rate, 11.787722 seconds, 79872 images, 1468.628320 hours left
Loaded: 0.000027 seconds

 2497: 19.267115, 19.235395 avg loss, 0.001300 rate, 11.559934 seconds, 79904 images, 1470.248578 hours left
Loaded: 0.000026 seconds

 2498: 20.365189, 19.348375 avg loss, 0.001300 rate, 11.552400 seconds, 79936 images, 1471.537480 hours left
Loaded: 0.000026 seconds

 2499: 18.308746, 19.244411 avg loss, 0.001300 rate, 11.590844 seconds, 79968 images, 1472.803038 hours left
Loaded: 0.000026 seconds

 2500: 20.240471, 19.344017 avg loss, 0.001300 rate, 11.701823 seconds, 80000 images, 1474.109089 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.384608 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2501: 17.161860, 19.125801 avg loss, 0.001300 rate, 10.503060 seconds, 80032 images, 1475.555568 hours left
Loaded: 0.000027 seconds

 2502: 29.963406, 20.209562 avg loss, 0.001300 rate, 12.098986 seconds, 80064 images, 1475.861269 hours left
Loaded: 0.000029 seconds

 2503: 20.424219, 20.231028 avg loss, 0.001300 rate, 10.925549 seconds, 80096 images, 1477.839569 hours left
Loaded: 0.000027 seconds

 2504: 24.749943, 20.682919 avg loss, 0.001300 rate, 11.449371 seconds, 80128 images, 1478.174811 hours left
Loaded: 0.000027 seconds

 2505: 22.229877, 20.837614 avg loss, 0.001300 rate, 11.115773 seconds, 80160 images, 1479.231283 hours left
Loaded: 0.000040 seconds

 2506: 19.302076, 20.684061 avg loss, 0.001300 rate, 10.531382 seconds, 80192 images, 1479.815700 hours left
Loaded: 0.000034 seconds

 2507: 17.533175, 20.368973 avg loss, 0.001300 rate, 10.488359 seconds, 80224 images, 1479.585847 hours left
Loaded: 0.000036 seconds

 2508: 23.032024, 20.635279 avg loss, 0.001300 rate, 11.290513 seconds, 80256 images, 1479.298741 hours left
Loaded: 0.000029 seconds

 2509: 25.986103, 21.170361 avg loss, 0.001300 rate, 11.732345 seconds, 80288 images, 1480.124107 hours left
Loaded: 0.000030 seconds

 2510: 19.875086, 21.040833 avg loss, 0.001300 rate, 10.788493 seconds, 80320 images, 1481.552369 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.283885 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2511: 21.788353, 21.115585 avg loss, 0.001300 rate, 5.802898 seconds, 80352 images, 1481.660682 hours left
Loaded: 0.000028 seconds

 2512: 22.099091, 21.213936 avg loss, 0.001300 rate, 5.674818 seconds, 80384 images, 1475.263951 hours left
Loaded: 0.000027 seconds

 2513: 19.423679, 21.034910 avg loss, 0.001300 rate, 5.508546 seconds, 80416 images, 1468.361338 hours left
Loaded: 0.000024 seconds

 2514: 22.486134, 21.180033 avg loss, 0.001300 rate, 5.666970 seconds, 80448 images, 1461.297731 hours left
Loaded: 0.000034 seconds

 2515: 20.841629, 21.146193 avg loss, 0.001300 rate, 5.508889 seconds, 80480 images, 1454.523888 hours left
Loaded: 0.000035 seconds

 2516: 17.091198, 20.740692 avg loss, 0.001300 rate, 5.234338 seconds, 80512 images, 1447.599107 hours left
Loaded: 0.000027 seconds

 2517: 16.464571, 20.313080 avg loss, 0.001300 rate, 5.202394 seconds, 80544 images, 1440.363777 hours left
Loaded: 0.000027 seconds

 2518: 23.384239, 20.620195 avg loss, 0.001300 rate, 5.595959 seconds, 80576 images, 1433.156587 hours left
Loaded: 0.000034 seconds

 2519: 19.651613, 20.523336 avg loss, 0.001300 rate, 5.443360 seconds, 80608 images, 1426.565866 hours left
Loaded: 0.000030 seconds

 2520: 16.057625, 20.076765 avg loss, 0.001300 rate, 5.311039 seconds, 80640 images, 1419.829960 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000032 seconds

 2521: 17.936857, 19.862774 avg loss, 0.001300 rate, 13.803926 seconds, 80672 images, 1412.978355 hours left
Loaded: 0.000027 seconds

 2522: 21.231192, 19.999615 avg loss, 0.001300 rate, 14.360261 seconds, 80704 images, 1417.943255 hours left
Loaded: 0.000031 seconds

 2523: 20.587410, 20.058393 avg loss, 0.001300 rate, 14.208976 seconds, 80736 images, 1423.628022 hours left
Loaded: 0.000022 seconds

 2524: 10.379312, 19.090485 avg loss, 0.001300 rate, 12.568775 seconds, 80768 images, 1429.046639 hours left
Loaded: 0.000028 seconds

 2525: 23.646233, 19.546059 avg loss, 0.001300 rate, 15.224801 seconds, 80800 images, 1432.142184 hours left
Loaded: 0.000029 seconds

 2526: 15.869632, 19.178415 avg loss, 0.001300 rate, 13.772886 seconds, 80832 images, 1438.880730 hours left
Loaded: 0.000026 seconds

 2527: 29.229452, 20.183519 avg loss, 0.001300 rate, 15.706071 seconds, 80864 images, 1443.543473 hours left
Loaded: 0.000026 seconds

 2528: 18.033741, 19.968542 avg loss, 0.001300 rate, 14.253628 seconds, 80896 images, 1450.833641 hours left
Loaded: 0.000027 seconds

 2529: 14.335597, 19.405247 avg loss, 0.001300 rate, 12.973263 seconds, 80928 images, 1456.041762 hours left
Loaded: 0.000034 seconds

 2530: 15.084856, 18.973207 avg loss, 0.001300 rate, 13.413618 seconds, 80960 images, 1459.426694 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.328629 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2531: 24.367891, 19.512676 avg loss, 0.001300 rate, 5.806694 seconds, 80992 images, 1463.386874 hours left
Loaded: 0.000029 seconds

 2532: 18.079523, 19.369362 avg loss, 0.001300 rate, 5.512177 seconds, 81024 images, 1457.239686 hours left
Loaded: 0.000029 seconds

 2533: 22.028740, 19.635300 avg loss, 0.001300 rate, 5.601717 seconds, 81056 images, 1450.292044 hours left
Loaded: 0.000035 seconds

 2534: 16.316950, 19.303465 avg loss, 0.001300 rate, 5.171150 seconds, 81088 images, 1443.537703 hours left
Loaded: 0.000033 seconds

 2535: 28.126047, 20.185722 avg loss, 0.001300 rate, 5.837789 seconds, 81120 images, 1436.255323 hours left
Loaded: 0.000036 seconds

 2536: 15.748204, 19.741970 avg loss, 0.001300 rate, 5.100989 seconds, 81152 images, 1429.967868 hours left
Loaded: 0.000036 seconds

 2537: 16.194031, 19.387177 avg loss, 0.001300 rate, 5.061621 seconds, 81184 images, 1422.724110 hours left
Loaded: 0.000028 seconds

 2538: 16.318853, 19.080345 avg loss, 0.001300 rate, 5.127310 seconds, 81216 images, 1415.498318 hours left
Loaded: 0.000027 seconds

 2539: 21.162354, 19.288546 avg loss, 0.001300 rate, 5.357634 seconds, 81248 images, 1408.435624 hours left
Loaded: 0.000026 seconds

 2540: 19.727552, 19.332447 avg loss, 0.001300 rate, 5.237209 seconds, 81280 images, 1401.762131 hours left
Resizing, random_coef = 1.40 

 448 x 448 
 try to allocate additional workspace_size = 57.80 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 2541: 20.259407, 19.425142 avg loss, 0.001300 rate, 5.801621 seconds, 81312 images, 1394.988782 hours left
Loaded: 0.000026 seconds

 2542: 15.812569, 19.063885 avg loss, 0.001300 rate, 5.569075 seconds, 81344 images, 1389.063854 hours left
Loaded: 0.000021 seconds

 2543: 16.450495, 18.802546 avg loss, 0.001300 rate, 5.555839 seconds, 81376 images, 1382.876501 hours left
Loaded: 0.000027 seconds

 2544: 22.503839, 19.172674 avg loss, 0.001300 rate, 5.964343 seconds, 81408 images, 1376.732692 hours left
Loaded: 0.000035 seconds

 2545: 11.683453, 18.423752 avg loss, 0.001300 rate, 5.327479 seconds, 81440 images, 1371.215359 hours left
Loaded: 0.000037 seconds

 2546: 21.751245, 18.756500 avg loss, 0.001300 rate, 5.998289 seconds, 81472 images, 1364.872279 hours left
Loaded: 0.000034 seconds

 2547: 17.111919, 18.592043 avg loss, 0.001300 rate, 6.029140 seconds, 81504 images, 1359.520487 hours left
Loaded: 0.000033 seconds

 2548: 22.461071, 18.978947 avg loss, 0.001300 rate, 6.241208 seconds, 81536 images, 1354.264865 hours left
Loaded: 0.000037 seconds

 2549: 22.426649, 19.323717 avg loss, 0.001300 rate, 6.301419 seconds, 81568 images, 1349.355113 hours left
Loaded: 0.000034 seconds

 2550: 24.250443, 19.816389 avg loss, 0.001300 rate, 6.485644 seconds, 81600 images, 1344.577731 hours left
Resizing, random_coef = 1.40 

 704 x 704 
 try to allocate additional workspace_size = 142.74 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 2551: 24.769928, 20.311743 avg loss, 0.001300 rate, 14.980617 seconds, 81632 images, 1340.102920 hours left
Loaded: 0.000027 seconds

 2552: 21.674587, 20.448027 avg loss, 0.001300 rate, 14.406256 seconds, 81664 images, 1347.423002 hours left
Loaded: 0.000025 seconds

 2553: 28.309347, 21.234159 avg loss, 0.001300 rate, 15.916082 seconds, 81696 images, 1353.875397 hours left
Loaded: 0.000031 seconds

 2554: 18.466665, 20.957411 avg loss, 0.001300 rate, 13.974697 seconds, 81728 images, 1362.351594 hours left
Loaded: 0.000036 seconds

 2555: 10.893661, 19.951036 avg loss, 0.001300 rate, 12.453712 seconds, 81760 images, 1368.057701 hours left
Loaded: 0.000027 seconds

 2556: 18.335869, 19.789520 avg loss, 0.001300 rate, 14.084479 seconds, 81792 images, 1371.602918 hours left
Loaded: 0.000033 seconds

 2557: 19.228106, 19.733379 avg loss, 0.001300 rate, 14.017389 seconds, 81824 images, 1377.368277 hours left
Loaded: 0.000023 seconds

 2558: 13.450206, 19.105062 avg loss, 0.001300 rate, 13.115151 seconds, 81856 images, 1382.983155 hours left
Loaded: 0.000033 seconds

 2559: 21.765591, 19.371115 avg loss, 0.001300 rate, 14.793448 seconds, 81888 images, 1387.293880 hours left
Loaded: 0.000027 seconds

 2560: 16.599909, 19.093994 avg loss, 0.001300 rate, 13.859383 seconds, 81920 images, 1393.882843 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.408156 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2561: 22.540506, 19.438644 avg loss, 0.001300 rate, 11.187100 seconds, 81952 images, 1399.113901 hours left
Loaded: 0.000029 seconds

 2562: 18.606653, 19.355446 avg loss, 0.001300 rate, 10.690449 seconds, 81984 images, 1401.160914 hours left
Loaded: 0.000027 seconds

 2563: 23.162477, 19.736149 avg loss, 0.001300 rate, 11.310220 seconds, 82016 images, 1401.935971 hours left
Loaded: 0.000038 seconds

 2564: 23.780489, 20.140583 avg loss, 0.001300 rate, 11.566460 seconds, 82048 images, 1403.560486 hours left
Loaded: 0.000020 seconds

 2565: 24.220934, 20.548618 avg loss, 0.001300 rate, 11.221834 seconds, 82080 images, 1405.523161 hours left
Loaded: 0.000027 seconds

 2566: 20.007210, 20.494478 avg loss, 0.001300 rate, 10.727712 seconds, 82112 images, 1406.989480 hours left
Loaded: 0.000026 seconds

 2567: 17.723379, 20.217369 avg loss, 0.001300 rate, 10.077604 seconds, 82144 images, 1407.757671 hours left
Loaded: 0.000025 seconds

 2568: 18.662283, 20.061861 avg loss, 0.001300 rate, 10.321874 seconds, 82176 images, 1407.618951 hours left
Loaded: 0.000025 seconds

 2569: 16.202761, 19.675951 avg loss, 0.001300 rate, 9.935516 seconds, 82208 images, 1407.819450 hours left
Loaded: 0.000036 seconds

 2570: 21.084770, 19.816833 avg loss, 0.001300 rate, 10.464033 seconds, 82240 images, 1407.483529 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.062258 seconds

 2571: 26.763083, 20.511459 avg loss, 0.001300 rate, 12.784336 seconds, 82272 images, 1407.881967 hours left
Loaded: 0.000027 seconds

 2572: 24.001957, 20.860510 avg loss, 0.001300 rate, 12.598796 seconds, 82304 images, 1411.571748 hours left
Loaded: 0.000027 seconds

 2573: 23.958801, 21.170340 avg loss, 0.001300 rate, 12.371397 seconds, 82336 images, 1414.881896 hours left
Loaded: 0.000027 seconds

 2574: 20.273062, 21.080612 avg loss, 0.001300 rate, 11.731319 seconds, 82368 images, 1417.844383 hours left
Loaded: 0.000037 seconds

 2575: 18.296272, 20.802177 avg loss, 0.001300 rate, 11.503752 seconds, 82400 images, 1419.891903 hours left
Loaded: 0.000034 seconds

 2576: 26.805332, 21.402493 avg loss, 0.001300 rate, 12.440232 seconds, 82432 images, 1421.604175 hours left
Loaded: 0.000020 seconds

 2577: 24.397739, 21.702017 avg loss, 0.001300 rate, 12.117456 seconds, 82464 images, 1424.594554 hours left
Loaded: 0.000026 seconds

 2578: 24.524744, 21.984289 avg loss, 0.001300 rate, 12.411975 seconds, 82496 images, 1427.108537 hours left
Loaded: 0.000027 seconds

 2579: 19.769899, 21.762850 avg loss, 0.001300 rate, 11.878677 seconds, 82528 images, 1430.004709 hours left
Loaded: 0.000028 seconds

 2580: 24.222912, 22.008856 avg loss, 0.001300 rate, 11.802646 seconds, 82560 images, 1432.134275 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.332319 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2581: 24.702147, 22.278185 avg loss, 0.001300 rate, 7.041749 seconds, 82592 images, 1434.137353 hours left
Loaded: 0.000024 seconds

 2582: 22.798479, 22.330214 avg loss, 0.001300 rate, 7.106342 seconds, 82624 images, 1429.995125 hours left
Loaded: 0.000023 seconds

 2583: 16.900894, 21.787281 avg loss, 0.001300 rate, 6.510653 seconds, 82656 images, 1425.524044 hours left
Loaded: 0.000027 seconds

 2584: 19.672209, 21.575773 avg loss, 0.001300 rate, 6.696378 seconds, 82688 images, 1420.273749 hours left
Loaded: 0.000028 seconds

 2585: 29.907917, 22.408987 avg loss, 0.001300 rate, 7.677425 seconds, 82720 images, 1415.332822 hours left
Loaded: 0.000022 seconds

 2586: 26.878563, 22.855946 avg loss, 0.001300 rate, 7.277588 seconds, 82752 images, 1411.798170 hours left
Loaded: 0.000026 seconds

 2587: 26.160873, 23.186438 avg loss, 0.001300 rate, 7.472268 seconds, 82784 images, 1407.745823 hours left
Loaded: 0.000027 seconds

 2588: 18.357868, 22.703581 avg loss, 0.001300 rate, 6.749264 seconds, 82816 images, 1404.003244 hours left
Loaded: 0.000026 seconds

 2589: 22.187744, 22.651997 avg loss, 0.001300 rate, 7.126664 seconds, 82848 images, 1399.298093 hours left
Loaded: 0.000039 seconds

 2590: 18.795025, 22.266300 avg loss, 0.001300 rate, 6.906676 seconds, 82880 images, 1395.161949 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000022 seconds

 2591: 21.521442, 22.191814 avg loss, 0.001300 rate, 12.003178 seconds, 82912 images, 1390.762904 hours left
Loaded: 0.000027 seconds

 2592: 19.805887, 21.953222 avg loss, 0.001300 rate, 12.110944 seconds, 82944 images, 1393.456680 hours left
Loaded: 0.000027 seconds

 2593: 21.846802, 21.942581 avg loss, 0.001300 rate, 12.660526 seconds, 82976 images, 1396.272541 hours left
Loaded: 0.000032 seconds

 2594: 19.287683, 21.677092 avg loss, 0.001300 rate, 11.921254 seconds, 83008 images, 1399.820322 hours left
Loaded: 0.000026 seconds

 2595: 21.683897, 21.677773 avg loss, 0.001300 rate, 12.459970 seconds, 83040 images, 1402.310132 hours left
Loaded: 0.000021 seconds

 2596: 24.603111, 21.970306 avg loss, 0.001300 rate, 13.025344 seconds, 83072 images, 1405.520083 hours left
Loaded: 0.000033 seconds

 2597: 23.865788, 22.159855 avg loss, 0.001300 rate, 12.750826 seconds, 83104 images, 1409.479842 hours left
Loaded: 0.000030 seconds

 2598: 22.901878, 22.234056 avg loss, 0.001300 rate, 12.475065 seconds, 83136 images, 1413.020307 hours left
Loaded: 0.000026 seconds

 2599: 20.491529, 22.059803 avg loss, 0.001300 rate, 12.161834 seconds, 83168 images, 1416.143934 hours left
Loaded: 0.000028 seconds

 2600: 23.928661, 22.246689 avg loss, 0.001300 rate, 12.650434 seconds, 83200 images, 1418.803069 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.286579 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2601: 15.798538, 21.601873 avg loss, 0.001300 rate, 7.201409 seconds, 83232 images, 1422.111343 hours left
Loaded: 0.000025 seconds

 2602: 30.838400, 22.525526 avg loss, 0.001300 rate, 8.990439 seconds, 83264 images, 1418.246525 hours left
Loaded: 0.000027 seconds

 2603: 19.822485, 22.255222 avg loss, 0.001300 rate, 7.522163 seconds, 83296 images, 1416.498332 hours left
Loaded: 0.000027 seconds

 2604: 17.885681, 21.818268 avg loss, 0.001300 rate, 7.456121 seconds, 83328 images, 1412.736905 hours left
Loaded: 0.000026 seconds

 2605: 20.858402, 21.722281 avg loss, 0.001300 rate, 7.893961 seconds, 83360 images, 1408.921732 hours left
Loaded: 0.000027 seconds

 2606: 16.522953, 21.202347 avg loss, 0.001300 rate, 7.436851 seconds, 83392 images, 1405.750240 hours left
Loaded: 0.000038 seconds

 2607: 14.633821, 20.545494 avg loss, 0.001300 rate, 7.147791 seconds, 83424 images, 1401.978242 hours left
Loaded: 0.000024 seconds

 2608: 20.301908, 20.521135 avg loss, 0.001300 rate, 7.431600 seconds, 83456 images, 1397.844176 hours left
Loaded: 0.000025 seconds

 2609: 18.545155, 20.323538 avg loss, 0.001300 rate, 7.409560 seconds, 83488 images, 1394.143929 hours left
Loaded: 0.000035 seconds

 2610: 27.346933, 21.025877 avg loss, 0.001300 rate, 8.076728 seconds, 83520 images, 1390.450182 hours left
Resizing, random_coef = 1.40 

 736 x 736 
 try to allocate additional workspace_size = 156.01 MB 
 CUDA allocate done! 
Loaded: 0.000023 seconds

 2611: 14.256834, 20.348972 avg loss, 0.001300 rate, 13.610585 seconds, 83552 images, 1387.716079 hours left
Loaded: 0.000025 seconds

 2612: 16.344994, 19.948574 avg loss, 0.001300 rate, 14.076048 seconds, 83584 images, 1392.662741 hours left
Loaded: 0.000025 seconds

 2613: 16.000202, 19.553738 avg loss, 0.001300 rate, 14.202867 seconds, 83616 images, 1398.203646 hours left
Loaded: 0.000027 seconds

 2614: 17.121883, 19.310553 avg loss, 0.001300 rate, 14.691904 seconds, 83648 images, 1403.864499 hours left
Loaded: 0.000026 seconds

 2615: 19.290302, 19.308527 avg loss, 0.001300 rate, 15.395911 seconds, 83680 images, 1410.145052 hours left
Loaded: 0.000027 seconds

 2616: 17.220560, 19.099730 avg loss, 0.001300 rate, 14.992225 seconds, 83712 images, 1417.336419 hours left
Loaded: 0.000033 seconds

 2617: 23.330460, 19.522802 avg loss, 0.001300 rate, 16.492949 seconds, 83744 images, 1423.897524 hours left
Loaded: 0.000026 seconds

 2618: 16.510820, 19.221603 avg loss, 0.001300 rate, 15.183335 seconds, 83776 images, 1432.468491 hours left
Loaded: 0.000035 seconds

 2619: 16.313951, 18.930838 avg loss, 0.001300 rate, 14.742316 seconds, 83808 images, 1439.142491 hours left
Loaded: 0.000027 seconds

 2620: 19.501001, 18.987854 avg loss, 0.001300 rate, 15.593092 seconds, 83840 images, 1445.139791 hours left
Resizing, random_coef = 1.40 

 608 x 608 
 try to allocate additional workspace_size = 106.46 MB 
 CUDA allocate done! 
Loaded: 0.526221 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2621: 30.585934, 20.147661 avg loss, 0.001300 rate, 12.250940 seconds, 83872 images, 1452.253689 hours left
Loaded: 0.000028 seconds

 2622: 23.823906, 20.515285 avg loss, 0.001300 rate, 11.319749 seconds, 83904 images, 1455.401943 hours left
Loaded: 0.000026 seconds

 2623: 18.466549, 20.310411 avg loss, 0.001300 rate, 10.566096 seconds, 83936 images, 1456.503126 hours left
Loaded: 0.000028 seconds

 2624: 23.960222, 20.675392 avg loss, 0.001300 rate, 11.160974 seconds, 83968 images, 1456.550967 hours left
Loaded: 0.000026 seconds

 2625: 23.038784, 20.911732 avg loss, 0.001300 rate, 11.162768 seconds, 84000 images, 1457.421012 hours left
Loaded: 0.000028 seconds

 2626: 17.242092, 20.544767 avg loss, 0.001300 rate, 10.459332 seconds, 84032 images, 1458.284804 hours left
Loaded: 0.000037 seconds

 2627: 22.120693, 20.702360 avg loss, 0.001300 rate, 11.051357 seconds, 84064 images, 1458.167087 hours left
Loaded: 0.000028 seconds

 2628: 22.100044, 20.842129 avg loss, 0.001300 rate, 11.009918 seconds, 84096 images, 1458.869292 hours left
Loaded: 0.000027 seconds

 2629: 22.167290, 20.974646 avg loss, 0.001300 rate, 11.179252 seconds, 84128 images, 1459.507122 hours left
Loaded: 0.000027 seconds

 2630: 16.004498, 20.477631 avg loss, 0.001300 rate, 10.200920 seconds, 84160 images, 1460.372725 hours left
Resizing, random_coef = 1.40 

 640 x 640 
 try to allocate additional workspace_size = 117.96 MB 
 CUDA allocate done! 
Loaded: 0.000025 seconds

 2631: 14.760768, 19.905945 avg loss, 0.001300 rate, 11.034750 seconds, 84192 images, 1459.876637 hours left
Loaded: 0.000036 seconds

 2632: 21.134171, 20.028767 avg loss, 0.001300 rate, 12.293215 seconds, 84224 images, 1460.538640 hours left
Loaded: 0.000033 seconds

 2633: 17.528162, 19.778706 avg loss, 0.001300 rate, 11.738415 seconds, 84256 images, 1462.934422 hours left
Loaded: 0.000027 seconds

 2634: 23.091223, 20.109957 avg loss, 0.001300 rate, 12.407316 seconds, 84288 images, 1464.538939 hours left
Loaded: 0.000036 seconds

 2635: 22.683819, 20.367344 avg loss, 0.001300 rate, 12.425589 seconds, 84320 images, 1467.052435 hours left
Loaded: 0.000027 seconds

 2636: 24.701881, 20.800798 avg loss, 0.001300 rate, 12.629987 seconds, 84352 images, 1469.566044 hours left
Loaded: 0.000026 seconds

 2637: 19.013504, 20.622068 avg loss, 0.001300 rate, 12.346749 seconds, 84384 images, 1472.337144 hours left
Loaded: 0.000024 seconds

 2638: 21.250219, 20.684883 avg loss, 0.001300 rate, 12.630004 seconds, 84416 images, 1474.688792 hours left
Loaded: 0.000031 seconds

 2639: 25.503845, 21.166779 avg loss, 0.001300 rate, 12.679577 seconds, 84448 images, 1477.408614 hours left
Loaded: 0.000020 seconds

 2640: 21.191359, 21.169237 avg loss, 0.001300 rate, 12.251283 seconds, 84480 images, 1480.169769 hours left
Resizing, random_coef = 1.40 

 480 x 480 
 try to allocate additional workspace_size = 66.36 MB 
 CUDA allocate done! 
Loaded: 0.298275 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2641: 20.790182, 21.131332 avg loss, 0.001300 rate, 7.153949 seconds, 84512 images, 1482.310953 hours left
Loaded: 0.000026 seconds

 2642: 28.146261, 21.832825 avg loss, 0.001300 rate, 7.660506 seconds, 84544 images, 1477.793847 hours left
Loaded: 0.000026 seconds

 2643: 23.646299, 22.014172 avg loss, 0.001300 rate, 7.266861 seconds, 84576 images, 1473.609978 hours left
Loaded: 0.000026 seconds

 2644: 21.251871, 21.937943 avg loss, 0.001300 rate, 6.923728 seconds, 84608 images, 1468.923530 hours left
Loaded: 0.000026 seconds

 2645: 16.869644, 21.431112 avg loss, 0.001300 rate, 6.670464 seconds, 84640 images, 1463.809398 hours left
Loaded: 0.000032 seconds

 2646: 26.202673, 21.908268 avg loss, 0.001300 rate, 7.200597 seconds, 84672 images, 1458.396141 hours left
Loaded: 0.000034 seconds

 2647: 15.265372, 21.243979 avg loss, 0.001300 rate, 6.576134 seconds, 84704 images, 1453.770140 hours left
Loaded: 0.000033 seconds

 2648: 22.217222, 21.341303 avg loss, 0.001300 rate, 6.972546 seconds, 84736 images, 1448.326796 hours left
Loaded: 0.000033 seconds

 2649: 24.114365, 21.618608 avg loss, 0.001300 rate, 7.011797 seconds, 84768 images, 1443.486074 hours left
Loaded: 0.000033 seconds

 2650: 18.991331, 21.355881 avg loss, 0.001300 rate, 6.549158 seconds, 84800 images, 1438.748019 hours left
Resizing, random_coef = 1.40 

 512 x 512 
 try to allocate additional workspace_size = 75.50 MB 
 CUDA allocate done! 
Loaded: 0.000024 seconds

 2651: 26.318146, 21.852108 avg loss, 0.001300 rate, 8.444874 seconds, 84832 images, 1433.417535 hours left
Loaded: 0.000027 seconds

 2652: 26.811869, 22.348083 avg loss, 0.001300 rate, 8.217951 seconds, 84864 images, 1430.761937 hours left
Loaded: 0.000027 seconds

 2653: 24.353537, 22.548630 avg loss, 0.001300 rate, 7.968202 seconds, 84896 images, 1427.819063 hours left
Loaded: 0.000036 seconds

 2654: 19.459173, 22.239685 avg loss, 0.001300 rate, 7.328695 seconds, 84928 images, 1424.560214 hours left
Loaded: 0.000026 seconds

 2655: 20.553947, 22.071112 avg loss, 0.001300 rate, 7.457612 seconds, 84960 images, 1420.449566 hours left
Loaded: 0.000048 seconds

 2656: 19.180246, 21.782024 avg loss, 0.001300 rate, 7.328431 seconds, 84992 images, 1416.558270 hours left
Loaded: 0.000027 seconds

 2657: 17.565540, 21.360376 avg loss, 0.001300 rate, 7.270680 seconds, 85024 images, 1412.527253 hours left
Loaded: 0.000026 seconds

 2658: 17.170500, 20.941389 avg loss, 0.001300 rate, 7.133578 seconds, 85056 images, 1408.456633 hours left
Loaded: 0.000035 seconds

 2659: 18.512592, 20.698509 avg loss, 0.001300 rate, 7.406233 seconds, 85088 images, 1404.237100 hours left
Loaded: 0.000033 seconds

 2660: 17.132627, 20.341921 avg loss, 0.001300 rate, 7.346876 seconds, 85120 images, 1400.436806 hours left
Resizing, random_coef = 1.40 

 416 x 416 
 try to allocate additional workspace_size = 49.84 MB 
 CUDA allocate done! 
Loaded: 0.290668 seconds - performance bottleneck on CPU or Disk HDD/SSD

 2661: 18.030230, 20.110752 avg loss, 0.001300 rate, 5.174015 seconds, 85152 images, 1396.592409 hours left
Loaded: 0.000034 seconds

 2662: 15.858722, 19.685549 avg loss, 0.001300 rate, 5.232915 seconds, 85184 images, 1390.183530 hours left
Loaded: 0.000028 seconds

 2663: 16.910742, 19.408068 avg loss, 0.001300 rate, 5.130756 seconds, 85216 images, 1383.518264 hours left
Loaded: 0.000026 seconds

 2664: 17.594208, 19.226681 avg loss, 0.001300 rate, 5.155979 seconds, 85248 images, 1376.778355 hours left
Loaded: 0.000030 seconds

 2665: 21.870211, 19.491034 avg loss, 0.001300 rate, 5.283053 seconds, 85280 images, 1370.140707 hours left
Loaded: 0.000035 seconds

 2666: 20.158367, 19.557766 avg loss, 0.001300 rate, 5.227773 seconds, 85312 images, 1363.745155 hours left
Loaded: 0.000034 seconds

 2667: 15.427773, 19.144766 avg loss, 0.001300 rate, 5.038298 seconds, 85344 images, 1357.337106 hours left
Loaded: 0.000036 seconds

 2668: 13.391771, 18.569466 avg loss, 0.001300 rate, 4.868220 seconds, 85376 images, 1350.731101 hours left
Loaded: 0.000035 seconds

 2669: 19.647104, 18.677229 avg loss, 0.001300 rate, 5.262381 seconds, 85408 images, 1343.955951 hours left
Loaded: 0.000033 seconds

 2670: 23.853096, 19.194817 avg loss, 0.001300 rate, 5.429338 seconds, 85440 images, 1337.7936jax@getafix:~/projects/yolov4$ 
jax@getafix:~/projects/yolov4$ vi logs.txt 

yolov4
net.optimized_memory = 0
mini_batch = 1, batch = 32, time_steps = 1, train = 1
nms_kind: greedynms (1), beta = 0.600000
nms_kind: greedynms (1), beta = 0.600000
nms_kind: greedynms (1), beta = 0.600000

 seen 64, trained: 0 K-images (0 Kilo-batches_64)
Learning Rate: 0.0013, Momentum: 0.949, Decay: 0.0005
Resizing, random_coef = 1.40

 736 x 736
 try to allocate additional workspace_size = 156.01 MB
 CUDA allocate done!
Loaded: 0.000024 seconds

 1: 4173.809082, 4173.809082 avg loss, 0.000000 rate, 12.090222 seconds, 32 images, -1.000000 hours left
Loaded: 0.000027 seconds

 2: 4149.802734, 4171.408203 avg loss, 0.000000 rate, 11.797990 seconds, 64 images, 1680.877665 hours left
Loaded: 0.000022 seconds

 3: 4226.664062, 4176.933594 avg loss, 0.000000 rate, 12.455998 seconds, 96 images, 1680.471355 hours left
Loaded: 0.000029 seconds

 4: 4132.355469, 4172.475586 avg loss, 0.000000 rate, 12.052404 seconds, 128 images, 1680.983876 hours left
Loaded: 0.000024 seconds

 5: 4216.416504, 4176.869629 avg loss, 0.000000 rate, 12.681887 seconds, 160 images, 1680.930145 hours left
"logs.txt" [noeol] 9354L, 397526C                                                                  
```
