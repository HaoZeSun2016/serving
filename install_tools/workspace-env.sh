#!/usr/bin/env bash
CURRENT_DIR=$(cd `dirname ${BASH_SOURCE[0]}` && pwd)
TOP_SRC_DIR=$(cd "${CURRENT_DIR}/.." && pwd)
source ${CURRENT_DIR}/util.sh

INFO $TOP_SRC_DIR

### tf serving dir
TF_SERVING_DIR=${TOP_SRC_DIR}/

### rpmbuild
#RPMBUILD_SOURCES_DIR="/root/rpmbuild/SOURCES/"

unset CC
unset CXX
export CC=gcc
export CXX=g++

source ~/.bashrc
#export LD_LIBRARY_PATH=/usr/gcc-trunk/lib64/:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=/usr/local/nccl-2.3.5/lib64/:${LD_LIBRARY_PATH}
#export LD_LIBRARY_PATH=/usr/local/cudnn-7.0.4.a/lib64/:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64/:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=/usr/lib64/:${LD_LIBARARY_PATH}
export LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64/stubs:${LD_LIBRARY_PATH}
# libnetwork
#export LD_LIBRARY_PATH=/usr/local/libnetwork/lib64/:${LD_LIBRARY_PATH}
