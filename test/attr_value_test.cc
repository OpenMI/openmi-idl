#include "openmi/pb/attr_value.pb.h"
using namespace openmi;

int main(int argc, char** argv) {
  proto::AttrValue av;
  av.set_i(10);
  switch (av.value_case()) {
    case proto::AttrValue::kI:
      std::cout << "kI. value: " << av.i() << std::endl; break;
    case proto::AttrValue::VALUE_NOT_SET:
      std::cout << "VALUE not set"; break;
  }
  return 0;
}
