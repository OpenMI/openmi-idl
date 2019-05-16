#!/bin/bash 

set -o pipefail
set -o errexit

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
PROJECT_DIR=$SCRIPT_DIR

deps_base_path=$HOME/.openmi_deps

while getopts "b:" opt; do
  case "$opt" in 
    b) deps_base_path=$OPTARG;;
    \?) echo "Invalid option: -$OPTARG";;
  esac
done

# Compile IDL
sh $SCRIPT_DIR/script/compile-proto.sh -c $deps_base_path

export PROTOBUF_HOME=$deps_base_path

mkdir -p $PROJECT_DIR/build || echo "$PROJECT_DIR/build exists!"
cd $PROJECT_DIR/build

cmake -DCMAKE_C_COMPILER=`which gcc` -DCMAKE_CXX_COMPILER=`which g++` $PROJECT_DIR

make -j8

echo "======== ${BASH_SOURCE[0]} ========"
