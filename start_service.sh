killall -9 tensorflow_model_server
sleep 1
killall -9 tensorflow_model_server
sleep 1
killall -9 tensorflow_model_server
sleep 5
op_path=/search/odin/hzsun/cuda_codes/serving
qa_model_path=/search/odin/hzsun/tf-serving-model-bak/qa-select-base-combined04-ckpt80
mrc_model_path=/search/odin/hzsun/tf-serving-model-bak/mrc-base-mrc02-ckpt60
custom_ops=${op_path}/kernel_fo_conv.so:${op_path}/kernel_fo_pooling.so
cmd=bazel-bin/tensorflow_serving/model_servers/tensorflow_model_server
for i in 1 2 3 4 5 6 7 
do 
    gpuid=$[${i}%8] 
    qa_portid=$[${i}+8500] 
    mrc_portid=$[${i}+8600] 
    CUDA_VISIBLE_DEVICES=${gpuid} nohup ${cmd} --port=$[${qa_portid}-1000] --rest_api_port=${qa_portid} \
    --model_name=qa --model_base_path=${qa_model_path} --custom_ops=${custom_ops} \
    --per_process_gpu_memory_fraction=0.333 --tensorflow_session_parallelism=5 1>stdout.log 2>stderr.log & 
    CUDA_VISIBLE_DEVICES=${gpuid} nohup ${cmd} --port=$[${mrc_portid}-1000] --rest_api_port=${mrc_portid} \
    --model_name=mrc --model_base_path=${mrc_model_path} --custom_ops=${custom_ops} \
    --per_process_gpu_memory_fraction=0.333 --tensorflow_session_parallelism=5 1>stdout.log 2>stderr.log & 
done 

CUDA_VISIBLE_DEVICES=0 nohup ${cmd} --port=7600 --rest_api_port=8600 \
    --model_name=mrc --model_base_path=${mrc_model_path} --custom_ops=${custom_ops} \
    --per_process_gpu_memory_fraction=0.333 --tensorflow_session_parallelism=5 1>stdout.log 2>stderr.log & 
CUDA_VISIBLE_DEVICES=0  ${cmd} --port=7500 --rest_api_port=8500 \
    --model_name=qa --model_base_path=${qa_model_path} --custom_ops=${custom_ops} \
    --per_process_gpu_memory_fraction=0.333 --tensorflow_session_parallelism=5

