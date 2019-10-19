namespace cpp   openmi.thrift
namespace py    openmi.thrift
namespace java  org.openmi.thrift

# Define service for commincation between ps and worker
struct ModelInfo {
  1: string model_name,
  2: string group_name,
  3: i64 model_index,
}

service Ps
{
  # Key op 
  list<binary> Pull(1:list<string> names, 2:list<binary> reqs, 3:string val_type, 4:i64 log_id),

  oneway void Push(1:list<string> names, 2:list<binary> reqs, 3:string val_type, 4:i32 epoch=0, 5:i64 log_id),
  
  # Model op in ps side. format: PROTO/PBTXT, val_type: WEIGHTS/PARAMS/GRADS
  list<string> Create(1:string name, 2:list<binary> pb_defs, 3:bool pb_binary=false), 
  
  void Drop(1:string name),
  
  void Dump(1:list<string> names, 2:string path, 3:string val_type='WEIGHTS', 4:string format='PROTO', 5:bool dump_zero=false),
  
  void DumpAll(1:string val_type='WEIGHTS', 2:string format='PROTO', 3:bool dump_zero=false),
  
  list<binary> GetUpdated(1:list<string> names),
  
  void Load(1:string name, 2:string path),
  
  list<ModelInfo> ListModels(), 

  binary ModelDef(1:string name, 2:bool pb_binary=false), 

  void Move(1:string from_name, 2:string to_name, 3:string backup_name),
  
  void RestoreModels(),
  
  void SetStreamingUpdate(1:list<string> names, 2:bool streaming_update),
  
  string ServingType(),
  
  list<string> Stat(1:list<string> names),

  # Number of ps node
  i32 ShardNum(),

  # Mode: offline | online | nearline
  string Mode(),

  list<string> ExecShell(1:list<string> cmds),
}
