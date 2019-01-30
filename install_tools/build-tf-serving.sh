#! /usr/bin/env bash

source ./workspace-env.sh
source ./unset-tf-env-gpu.sh
source ./set-tf-env-gpu.sh

## tensorrt
INFO "TOP_SRC_DIR ${TOP_SRC_DIR}"

INFO "begin ..."

cd ${TF_SERVING_DIR}; \
#bazel clean \
bazel build \
 -c opt  \
 --linkopt=-rdynamic \
 --copt=-mavx \
 --config=cuda \
 --copt="-fPIC" \
 --copt=-msse4.2 \
 --verbose_failures \
//tensorflow_serving/model_servers:tensorflow_model_server

#--config=cuda \
#--crosstool_top=@local_config_cuda//crosstool:toolchain \
