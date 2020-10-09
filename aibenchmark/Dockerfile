FROM nvcr.io/nvidia/tensorflow:20.03-tf2-py3
RUN apt update && \
    apt install -y python3-pip 
RUN pip3 install --upgrade pip
RUN pip3 install ai-benchmark
ADD . /benchmark/
WORKDIR /benchmark
ENTRYPOINT ["/bin/bash","-l","-c"]
