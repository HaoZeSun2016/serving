// by Haoze Sun 2019.3.6
// a demo for qa-select using tf serving.

#include <iostream>
#include <vector>
#include <unordered_map>
#include <string>
#include "grpcpp/create_channel.h"
#include "grpcpp/security/credentials.h"
#include "google/protobuf/map.h"
#include "tensorflow/core/framework/tensor.h"
#include "tensorflow/core/platform/types.h"
#include "tensorflow/core/util/command_line_flags.h"
#include "tensorflow_serving/apis/prediction_service.grpc.pb.h"

using grpc::Channel;
using grpc::ClientContext;
using grpc::Status;

using tensorflow::serving::PredictRequest;
using tensorflow::serving::PredictResponse;
using tensorflow::serving::PredictionService;

typedef google::protobuf::Map<tensorflow::string, tensorflow::TensorProto> TFFDict;
typedef std::unordered_map<std::string, tensorflow::TensorProto> FFDict;  // feed & fetch dict

// override of c++ types into tensorflow protobuf type
// 1. string/boolean/int32/float32
// 2. data in row major
// github.com/tensorflow/tensorflow/blob/master/tensorflow/core/framework/tensor.proto
// github.com/tensorflow/tensorflow/blob/master/tensorflow/core/framework/tensor_shape.proto
tensorflow::TensorProto transFormat(const char * arr, int & arr_size) {
    tensorflow::TensorProto proto;
    proto.set_dtype(tensorflow::DataType::DT_STRING);
    proto.add_string_val(arr, arr_size);
    proto.mutable_tensor_shape()->add_dim()->set_size(1);
    return proto;
}

tensorflow::TensorProto transFormat(const std::string * arr, int & arr_size, std::vector<int> & shapes) {
    tensorflow::TensorProto proto;
    proto.set_dtype(tensorflow::DataType::DT_STRING);
    for (int i = 0; i < arr_size; ++i) {
        proto.add_string_val(arr[i]);
    }
    for (int i = 0; i < shapes.size(); ++i) {
        proto.mutable_tensor_shape()->add_dim()->set_size(shapes[i]);
    }
    return proto;
}

tensorflow::TensorProto transFormat(const bool * arr, int & arr_size, std::vector<int> & shapes) {
    tensorflow::TensorProto proto;
    proto.set_dtype(tensorflow::DataType::DT_BOOL);
    for (int i = 0; i < arr_size; ++i) {
        proto.add_bool_val(arr[i]);
    }
    for (int i = 0; i < shapes.size(); ++i) {
        proto.mutable_tensor_shape()->add_dim()->set_size(shapes[i]);
    }
    return proto;
}

tensorflow::TensorProto transFormat(const int * arr, int & arr_size, std::vector<int> & shapes) {
    tensorflow::TensorProto proto;
    proto.set_dtype(tensorflow::DataType::DT_INT32);
    for (int i = 0; i < arr_size; ++i) {
        proto.add_int_val(arr[i]);
    }
    for (int i = 0; i < shapes.size(); ++i) {
        proto.mutable_tensor_shape()->add_dim()->set_size(shapes[i]);
    }
    return proto;
}

tensorflow::TensorProto transFormat(const float * arr, int & arr_size, std::vector<int> & shapes) {
    tensorflow::TensorProto proto;
    proto.set_dtype(tensorflow::DataType::DT_FLOAT);
    for (int i = 0; i < arr_size; ++i) {
        ;
        proto.add_float_val(arr[i]);
    }
    for (int i = 0; i < shapes.size(); ++i) {
        proto.mutable_tensor_shape()->add_dim()->set_size(shapes[i]);
    }
    return proto;
}


class ServingClient {
public:
    ServingClient(std::string port, std::string model_name, std::string model_signature_name);

    bool callPredict(FFDict& feed_dict, FFDict& fetch_dict);

private:
    std::unique_ptr<PredictionService::Stub> stub_;
    tensorflow::string model_name_;
    tensorflow::string model_signature_name_;
};

ServingClient::ServingClient(std::string port, std::string model_name, std::string model_signature_name) {
    // setup grpc connection
    std::shared_ptr<Channel> channel = grpc::CreateChannel(port, grpc::InsecureChannelCredentials());
    // setup service
    this->stub_ = PredictionService::NewStub(channel);
    this->model_name_ = model_name;
    this->model_signature_name_ = model_signature_name;
}

bool ServingClient::callPredict(FFDict& feed_dict, FFDict& fetch_dict) {
    PredictRequest predictRequest;
    PredictResponse response;
    ClientContext context;

    predictRequest.mutable_model_spec()->set_name(this->model_name_);
    predictRequest.mutable_model_spec()->set_signature_name(this->model_signature_name_);  // "serving_default"  as default
    TFFDict & inputs = *predictRequest.mutable_inputs();
    // loop through and copy from feed dict
    for (FFDict::iterator it = feed_dict.begin(); it != feed_dict.end(); it++) {
        inputs[it->first] = it->second;
    }

    Status status = this->stub_->Predict(&context, predictRequest, &response);
    if (status.ok()) {
        // copy results form response
        TFFDict & outputs = *response.mutable_outputs();
        for (TFFDict::iterator it = outputs.begin(); it != outputs.end(); it++) {
            fetch_dict[std::string(it->first)] = it->second;
        }
        return true;
    }
    else {
        return false;
    }
}