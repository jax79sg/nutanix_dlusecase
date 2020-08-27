#!/bin/bash
sudo docker run --gpus all -v $(pwd)/myconfig:/darknet/myconfig -v $(pwd)/mydata:/darknet/mydata -v $(pwd)/myweights:/darknet/myweights yolov4 /darknet/darknet detector test /darknet/myconfig/coco.data /darknet/myconfig/yolov4.cfg /darknet/myweights/yolov4.weights /darknet/data/dog.jpg
