FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && \
    apt install --no-install-recommends -y \
    wget curl git make nano build-essential

# Python3
RUN apt install -y --no-install-recommends \
    python3-distutils python3.9 python3.9-dev python3-pip && \
    wget -O ~/get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    python3.9 ~/get-pip.py

RUN ln -sf /usr/bin/python3.9 /usr/local/bin/python3 && \
    ln -sf /usr/bin/python3.9 /usr/local/bin/python && \
    python -m pip --no-cache-dir install --upgrade setuptools

# Notebook
RUN pip install jupyter jupyterlab notebook jupyter-contrib-nbextensions

RUN apt install libsndfile-dev

WORKDIR /app
COPY requirements.txt /app/

RUN pip install -r requirements.txt && \
    rm /app/requirements.txt
