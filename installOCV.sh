#!/bin/bash -e
myRepo=$(pwd)
CMAKE_CONFIG_GENERATOR="Visual Studio 15 2017 Win64"

if [  ! -d "$myRepo/Build"  ]; then
	mkdir Build
fi 
if [  ! -d "$myRepo/Build/opencv"  ]; then
	mkdir Build/opencv
fi 
if [  ! -d "$myRepo/Install"  ]; then
	mkdir Install
fi 
if [  ! -d "$myRepo/Install/opencv"  ]; then
	mkdir Install/opencv
fi
if [  ! -d "$myRepo/Build/opencv_contrib"  ]; then
	mkdir Build/opencv_contrib
fi 

if [  ! -d "$myRepo/opencv"  ]; then
    echo "cloning opencv"
    git clone https://github.com/opencv/opencv.git
	cd opencv
	git reset --hard c9ad5779f2803dcc91a9938142209128d30b22d1
    cd ..
fi

if [  ! -d "$myRepo/opencv_contrib"  ]; then
    echo "cloning opencv_contrib"
    git clone https://github.com/opencv/opencv_contrib.git
	cd opencv_contrib
	git reset --hard 25221244732dcf44c1450d0f93edc2529a61c0e1
	cd ..
fi

RepoSource=opencv
pushd Build/$RepoSource
CMAKE_OPTIONS='-DBUILD_PERF_TESTS:BOOL=OFF -DBUILD_TESTS:BOOL=OFF -DBUILD_DOCS:BOOL=OFF -DWITH_CUDA:BOOL=OFF -DBUILD_PYTHON:BOOL=OFF -DBUILD_JAVA:BOOL=OFF -DBUILD_PYTHON3:BOOL=OFF -DBUILD_PYTHON2:BOOL=OFF -DBUILD_EXAMPLES:BOOL=OFF -DINSTALL_CREATE_DISTRIB=ON'
cmake -G"$CMAKE_CONFIG_GENERATOR" $CMAKE_OPTIONS -DOPENCV_EXTRA_MODULES_PATH="$myRepo"/opencv_contrib/modules -DCMAKE_INSTALL_PREFIX="$myRepo"/install/"$RepoSource" "$myRepo/$RepoSource"
echo "************************* $Source_DIR -->debug"
cmake --build .  --config debug
echo "************************* $Source_DIR -->release"
cmake --build .  --config release
cmake --build .  --target install --config release
cmake --build .  --target install --config debug
popd