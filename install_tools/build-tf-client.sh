#! /usr/bin/env bash

source ./workspace-env.sh
source ./unset-tf-env-gpu.sh
source ./set-tf-env-cpu.sh

INFO "begin ..."

cd ${TF_SERVING_DIR}; \
#bazel clean \
bazel build \
 -c opt  \
 --linkopt=-rdynamic \
 --copt=-mavx \
 --copt="-fPIC" \
 --copt=-msse4.2 \
 --verbose_failures \
//tensorflow_serving/client:libtf_serving_api.so

