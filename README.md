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
 130 conv    128       1 x 1/
 .
 .
 .
 
```

# Validation instructions
Record the output of 
