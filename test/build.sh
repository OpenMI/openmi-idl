#!/bin/bash

g++ -std=c++11 -I.. -I../.. -L../lib -lopenmi_idl attr_value_test.cc -o xx
