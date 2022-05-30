#!/bin/bash
set -e
mkdir -p dextool-shared-rel
cmake -G Ninja -S . -B dextool-shared-rel -DCMAKE_BUILD_TYPE=Debug -DCMAKE_DEBUG_POSTFIX=d -DBUILD_SHARED_LIBS=ON #-DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build dextool-shared-rel -j 16
