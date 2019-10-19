#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)
PROJECT_DIR=$SCRIPT_DIR/..

thrift_out_dir=$PROJECT_DIR/openmi
mkdir -p $thrift_out_dir || echo "$thrift_out_dir exists!"

deps_base_path=$HOME/.openmi_deps

while getopts "c:" opt; do
  case "$opt" in 
    c) deps_base_path=$OPTARG;;
    \?) echo "Invalid option: -$OPTARG";;
  esac
done

os_name=`uname | tr "A-Z" "a-z"` 
if [[ "$os_name" == "linux" ]]; then
  export LD_LIBRARY_PATH=$deps_base_path/lib64:$LD_LIBRARY_PATH
fi

thrift=$deps_base_path/bin/thrift
echo "thrift: $thrift"

function compile_thrift() {
  target=$1
  if [ -d $target ]; then
    for file in `ls $target`
    do 
      if [ ${file:0-7} == ".thrift" ]; then
        $thrift -r --gen cpp --gen py --gen java -o $thrift_out_dir $target/$file
      fi
    done
  fi
}

compile_thrift $PROJECT_DIR/thrift
