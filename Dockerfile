FROM nvcr.io/nvidia/ai-workbench/python-cuda120:1.0.3

ENV DEBIAN_FRONTEND=noninteractive
ARG USERNAME=user
ARG WORKDIR=/workspace

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get -y install libgl1-mesa-glx tzdata
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

WORKDIR /workspace

COPY . .

RUN pip3 install pip --upgrade && pip3 install -r requirements.txt -f https://download.pytorch.org/whl/torch_stable.html

RUN apt-get -y install g++ make

RUN apt-get -y install wget

RUN git clone https://github.com/NVIDIA-AI-IOT/torch2trt \
    && cd torch2trt \
    && git checkout 19a317659e15d1307009803e7a15f264672df19d \
    && wget https://github.com/NVIDIA-AI-IOT/torch2trt/commit/19a317659e15d1307009803e7a15f264672df19d.patch \
    && python3 setup.py install

RUN apt-get update -y && apt-get install -y libturbojpeg ffmpeg
RUN pip install -U git+https://github.com/lilohuang/PyTurboJPEG.git