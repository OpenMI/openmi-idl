namespace cpp     openmi.thrift
namespace py      openmi.thrift 
namespace java    org.openmi.thrift

enum ResErrCode {
  SUCCESS = 0,
  FAILED = 1,
  EXCEPTION = 2,
}

struct KVPair {
  1: string key;
  2: string value;
}

struct Item {
  1: i64 item_id;
  2: list<KVPair> item_kv;
}

struct RequestData {
  1: i64 global_id;
  2: list<string> models;
  3: list<KVPair> req_data;
  4: list<KVPair> user_data;
  5: list<Item> item_dtaa;
}

struct PredictValue {
  1: i16 error_no;
  2: i64 item_id;
  3: string item_type;
  4: list<double> predict;
}

enum CompressType {
  NONE = 1,
  SNAPPY = 2,
}

enum RawInstType {
  NN_INSTANCE = 1,
}

struct Request {
  1: string global_id;
  2: list<string> models;
  3: binary raw_inst;   // binary of multiple instance or rawinstance
  4: map<string, string> bizData;
  5: optional CompressType compress_type = CompressType.NONE;
  6: optional RawInstType raw_inst_type = RawInstType.NN_INSTANCE;
}

struct Response {
  1: ResErrCode error_no;
  2: string global_id;
  3: list<PredictValue> items;
  4: map<string, string> bizData;
  5: string err_msg;
}

// service
service Predictor {
  Response Predict(1: Request req),
}

service PredictorProxy {
  Response Predict(1: Request req),
}
