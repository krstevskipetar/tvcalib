FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /workspace
EXPOSE 8888

RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
       python3.9 python3.9-distutils python3.9-venv python3.9-dev curl git \
    && curl -sS https://bootstrap.pypa.io/get-pip.py | python3.9 \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1 \
    && rm -rf /var/lib/apt/lists/*

RUN apt update && apt upgrade && apt install tmux ffmpeg neovim nano python-is-python3

RUN python3 -m pip install --no-cache-dir \
    torch==1.11.0+cu113 torchvision==0.12.0+cu113 \
    -f https://download.pytorch.org/whl/torch_stable.html

RUN python3 --version && nvcc --version \
    && python3 -c "import torch; print(torch.version.cuda, torch.cuda.is_available())"
