#!/bin/bash
sudo docker run --gpus all -d --name testTraining2gpu -v $(pwd)/myconfig:/darknet/myconfig -v $(pwd)/mydata:/darknet/mydata -v $(pwd)/myweights:/darknet/myweights yolov4  /darknet/darknet detector train -dont_show /darknet/myconfig/coco.data /darknet/myconfig/yolov4.cfg /darknet/myweights/backup/yolov4_last.weights -gpus 0,1

