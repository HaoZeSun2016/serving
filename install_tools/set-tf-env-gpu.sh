#! /usr/bin/env bash

source ./workspace-env.sh

## File System
export TF_NEED_S3=0
export TF_NEED_GCP=0
export TF_NEED_HDFS=0

## compute

### cuda 
export TF_NEED_CUDA=1
export CUDA_TOOLKIT_PATH="/usr/local/cuda-9.0/"
export TF_CUDA_VERSION=9.0 #$($CUDA_TOOLKIT_PATH/bin/nvcc --version | sed -n 's/^.*release \(.*\),.*/\1/p')

### p100

## TODO diff GPU diff config

export P4_COMPUTE_CAPABILITIES="6.0"
export P40_COMPUTE_CAPABILITIES="6.1"
export P100_COMPUTE_CAPABILITIES="6.1"
export V100_COMPUTE_CAPABILITIES="7.0"

export TF_CUDA_COMPUTE_CAPABILITIES=${P40_COMPUTE_CAPABILITIES}

### cudnn
export CUDNN_INSTALL_PATH="/usr/local/cuda-9.0/"
export TF_CUDNN_VERSION=7 #$(sed -n 's/^#define CUDNN_MAJOR\s*\(.*\).*/\1/p' $CUDNN_INSTALL_PATH/include/cudnn.h)

### opencl
export TF_NEED_OPENCL=0
export TF_NEED_OPENCL_SYCL=0

## MPI
export TF_NEED_MPI=0
export TF_NEED_VERBS=0
export TF_NEED_GDR=0

## clang
export TF_CUDA_CLANG=0

## blas
export TF_NEED_MKL=0


## tensorrt
#export TF_NEED_TENSORRT=1
#export TENSORRT_INSTALL_PATH="${TOP_SRC_DIR}/3rd-party/TensorRT-4.0.0.3/lib"
#export TF_TENSORRT_VERSION="4.1.0"

## infer no need nccl
## nccl
export TF_NEED_NCCL=1
export NCCL_INSTALL_PATH="/usr/local/nccl-2.3.5/lib"
export NCCL_HDR_PATH="/usr/local/nccl-2.3.5/include"
export TF_NCCL_VERSION=2


## other
export TF_NEED_JEMALLOC=1
export TF_ENABLE_XLA=1
export GCC_HOST_COMPILER_PATH="/usr/bin/gcc"
export PYTHON_BIN_PATH="/usr/bin/python"
export PYTHON_INCLUDE_PATH="/usr/include/python2.7/"
export CC_OPT_FLAGS="-march=native"
export PYTHON_LIB_PATH="/usr/lib/python2.7/site-packages/"

