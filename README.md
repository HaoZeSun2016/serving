1.  配置python2.x cuda cudnn nccl2.x tensorRT等环境 ~/.bashrcz中增加CC=/usr/bin/gcc
2.  修改install_tools中的配置 注意增加python-devel PYTHON_INCLUDE_PATH NCCL_HDR_PATH等环境变量
3.  从bazelbuild的release下载对应的最低bazel.xxx.sh版本进行安装
4.  注意bazel编译中的-rdynamic 和 -fPIC选项
5.  修改main.cc
6.  编译serving
7.  编译custom_ops注意相比于python_load 要去掉-ltensorflow_framework选项使之不依赖于python版本的tensorflow而依赖于serving

8. 使用serving参考start_service.sh其中rest和grpc不能使用同一端口

2019.3

9. 参考https://github.com/tensorflow/serving/issues/680 增加了cpu端的client服务包编译，用bazel编译成.so库
   install_tools中配置好gcc路径 编译build-tf-client
   会在tensorflow_serving/client下生成一个.so文件
   nm -Ca *.so可以看到函数和类入口名，对照example/resnet_client.cc中的函数即可
   使用时load相应的*.so

# TensorFlow Serving

[![Ubuntu Build Status](https://storage.googleapis.com/tensorflow-serving-kokoro-build-badges/ubuntu.svg)](https://storage.googleapis.com/tensorflow-serving-kokoro-build-badges/ubuntu.html)
![Docker CPU Nightly Build Status](https://storage.googleapis.com/tensorflow-serving-kokoro-build-badges/docker-cpu-nightly.svg)
![Docker GPU Nightly Build Status](https://storage.googleapis.com/tensorflow-serving-kokoro-build-badges/docker-gpu-nightly.svg)

TensorFlow Serving is an open-source software library for serving
machine learning models. It deals with the *inference* aspect of machine
learning, taking models after *training* and managing their lifetimes, providing
clients with versioned access via a high-performance, reference-counted lookup
table.

Multiple models, or indeed multiple versions of the same model, can be served
simultaneously. This flexibility facilitates canarying new versions,
non-atomically migrating clients to new models or versions, and A/B testing
experimental models.

The primary use-case is high-performance production serving, but the same
serving infrastructure can also be used in bulk-processing (e.g. map-reduce)
jobs to pre-compute inference results or analyze model performance. In both
scenarios, GPUs can substantially increase inference throughput. TensorFlow
Serving comes with a scheduler that groups individual inference requests into
batches for joint execution on a GPU, with configurable latency controls.

TensorFlow Serving has out-of-the-box support for TensorFlow models (naturally),
but at its core it manages arbitrary versioned items (*servables*) with
pass-through to their native APIs. In addition to trained TensorFlow models,
servables can include other assets needed for inference such as embeddings,
vocabularies and feature transformation configs, or even non-TensorFlow-based
machine learning models.

The architecture is highly modular. You can use some parts individually (e.g.
batch scheduling) or use all the parts together. There are numerous plug-in
points; perhaps the most useful ways to extend the system are:
(a) [creating a new type of servable](tensorflow_serving/g3doc/custom_servable.md);
(b) [creating a custom source of servable versions](tensorflow_serving/g3doc/custom_source.md).

**If you'd like to contribute to TensorFlow Serving, be sure to review the
[contribution guidelines](CONTRIBUTING.md).**

**We use [GitHub issues](https://github.com/tensorflow/serving/issues) for
tracking requests and bugs.**

# Download and Setup

See [install instructions](tensorflow_serving/g3doc/setup.md).

## Tutorials

* [Basic tutorial](tensorflow_serving/g3doc/serving_basic.md)
* [Advanced tutorial](tensorflow_serving/g3doc/serving_advanced.md)

## For more information

* [Serving architecture overview](tensorflow_serving/g3doc/overview.md)
* [TensorFlow website](http://tensorflow.org)
