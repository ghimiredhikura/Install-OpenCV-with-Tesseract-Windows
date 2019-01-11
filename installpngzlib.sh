#!/bin/bash
myRepo=$(pwd)
CMAKE_CONFIG_GENERATOR="Visual Studio 15 2017 Win64"
RepoSource=zlib
mkdir Build/$RepoSource
pushd Build/$RepoSource
cmake . -G"Visual Studio 15 2017 Win64" \
-DCMAKE_INSTALL_PREFIX:PATH="$myRepo"/install/zlib -DINSTALL_BIN_DIR:PATH="$myRepo"/install/zlib/bin \
-DINSTALL_INC_DIR:PATH="$myRepo"/install/zlib/include -DINSTALL_LIB_DIR:PATH="$myRepo"/install/zlib/lib "$myRepo"/"$RepoSource"
cmake --build . --config release
cmake --build . --target install --config release
cmake --build . --config debug
cmake --build . --target install --config debug
popd
RepoSource=lpng
mkdir Build/$RepoSource
pushd Build/$RepoSource
cp "$myRepo"/"$RepoSource"/scripts/pnglibconf.h.prebuilt "$myRepo"/"$RepoSource"/pnglibconf.h
cmake . -G"Visual Studio 15 2017 Win64" \
-DZLIB_INCLUDE_DIR:PATH="$myRepo"/install/zlib/include -DZLIB_LIBRARY_DEBUG:FILE="$myRepo"/install/zlib/lib/zlibstaticd.lib \
-Dld-version-script:BOOL=OFF -DPNG_TESTS:BOOL=OFF -DAWK:STRING= \
-DZLIB_LIBRARY_RELEASE:FILE="$myRepo"/install/zlib/lib/zlibstatic.lib -DCMAKE_INSTALL_PREFIX="$myRepo"/Install/"$RepoSource" \
"$myRepo"/"$RepoSource"
cmake --build . --config release
cmake --build . --target install --config release
cmake --build . --config debug
cmake --build . --target install --config debug
popd