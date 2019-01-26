cmake_minimum_required(VERSION 2.4)

project(openmit-idl)

set(CMAKE_VERBOSE_MAKEFILE on)

set(BASIC_CXXFLAGS "-std=c++11 -g -O3 -Wall")
set(PIC_FLAGS "-fPIC")
set(BASIC_CPPDEFINES "-DNDEBUG -DHAVE_NETINET_IN_H")
set(BASIC_CPPDEFINES "-DNDEBUG")

set(CMAKE_CXX_FLAGS "${BASIC_CXXFLAGS} ${PIC_FLAGS} ${BASIC_CPPDEFINES}")

include_directories(
  $ENV{THRIFT_HOME}/include 
  $ENV{PROTOBUF_HOME}/include 
)

link_directories(
  $ENV{THRIFT_HOME}/lib 
  $ENV{PROTOBUF_HOME}/lib
)

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib) 

set(link_libs
  libthrift.a
  libprotoc.a
  libprotobuf.a
)

aux_source_directory(openmi/pb srcs_pbcpp)

set(srcs "")
list(APPEND srcs ${srcs_pbcpp})

set(libname openmit_idl)

add_library(${libname} SHARED ${srcs})
target_link_libraries(${libname} ${link_libs})

add_library(${libname}_static STATIC ${srcs})
target_link_libraries(${libname}_static ${link_libs})
set_target_properties(${libname}_static PROPERTIES OUTPUT_NAME ${libname})
