#! /usr/bin/env bash
set -e
CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TOP_SRC_DIR="${CWD}/.."

TEST_DATA_DIR="${TOP_SRC_DIR}/serving-1.12.0/tensorflow_serving/servables/tensorflow/testdata"

cd ${TOP_SRC_DIR}/serving-1.12.0/bazel-bin/tensorflow_serving/model_servers;
./tensorflow_model_server                                             \
    --enable_custom_ops=true                                          \
    --custom_ops_config_file="${TEST_DATA_DIR}/custom_ops_config.cfg" \
    --rest_api_port=8501                                              \
    --model_name=half_plus_three                                      \
    --model_base_path=${TEST_DATA_DIR}/saved_model_half_plus_three/ 

