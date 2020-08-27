FROM nvidia/cuda:10.0-devel-ubuntu18.04
RUN apt update && \
    apt install -y build-essential axel zip unzip cmake git wget ffmpeg libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
RUN wget https://github.com/opencv/opencv/archive/4.4.0.zip
RUN unzip 4.4.0.zip
RUN cd opencv-4.4.0 && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j$(nproc) && \
    make install
COPY checkcv.py /
RUN python checkcv.py    

RUN git clone https://github.com/roboflow-ai/darknet
RUN cd darknet && \
    mkdir build-release && \
    cd build-release && \
    cmake .. && \
    make -j$(nproc) && \
    make install
RUN cd /darknet && \
    mkdir -p myconfig && \
    mkdir -p mydata && \
    mkdir -p myweights
    
WORKDIR /darknet   
