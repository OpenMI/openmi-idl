namespace cpp   openmi.thrift
namespace py    openmi.thrift
namespace java  org.openmi.thrift 

// service
service Collector {

  void Start(1:string session_name),

  void Report(1:string session_name, 2:list<double> metrics),

  bool Stop(1:string session_name),

  void Finish(1:string session_name),

  list<string> PrintCurrent(1:string session_name),

  list<string> PrintHistory(1:string session_name),
  
  void Stat(1:string session_name),

  list<string> ListSessions(),

  void DropSession(1:string session_name), 

  void SetWorkerNum(1:string session_name, 2:i32 worker_num),
}
