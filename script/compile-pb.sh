#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"/..

deps_base_path=$HOME/.openmit_deps

while getopts "c:" opt; do
  case "$opt" in 
    c) deps_base_path=$OPTARG;;
    \?) echo "Invalid option: -$OPTARG";;
  esac
done

PROTOBUF_HOME=$deps_base_path
protoc=$PROTOBUF_HOME/bin/protoc 
if [ ! -f $protoc ]; then 
  echo "[WARNING] proto not exist in $protoc"
  exit 1
fi
export LD_LIBRARY_PATH=$PROTOBUF_HOME/lib
export DYLD_LIBRARY_PATH=$PROTOBUF_HOME/lib

pb_dir=$SCRIPT_DIR/openmi/pb

cpp_out=$pb_dir
java_out=$pb_dir/java
python_out=$pb_dir/python

mkdir -p $cpp_out || true
mkdir -p $java_out || true
mkdir -p $python_out || true

# compile proto recursive
function compile_proto_recursive() {
  if [ $# -lt 1 ]; then
    echo "You need to specify 'dir' args."
    exit 1
  fi
  for elem in `ls $1`
  do 
    dir_or_file=$1/$elem 
    postfix=".proto"
    if [ -d $dir_or_file ]; then
      compile_proto_recursive $dir_or_file
      continue
    fi
    
    if [[ "${dir_or_file:0-6}" == "$postfix" ]]; then 
      $protoc -I=$1 --cpp_out=$cpp_out --java_out=$java_out --python_out=$python_out $dir_or_file
    fi
  done
}

compile_proto_recursive $SCRIPT_DIR/proto

echo "======== ${BASH_SOURCE[0]} ========"
