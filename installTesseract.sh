#!/bin/bash
function MAJGitRepo
{
if [  ! -d "$myRepo/$1"  ]; then
  echo "clonning ${1}"
  git clone $2
  mkdir Build/$1
else
  echo "update $1"
  cd $1
  git pull --rebase
  cd ..
fi
}
echo "Installing tesseract"
myRepo=$(pwd)
CMAKE_CONFIG_GENERATOR="Visual Studio 15 2017 Win64"

RepoSource=tesseract
MAJGitRepo $RepoSource https://github.com/tesseract-ocr/tesseract.git
cd $RepoSource
git reset --hard 51316994ccae0b48692d547030f26c0969308214
cd ..

pushd Build/$RepoSource
cmake -G"$CMAKE_CONFIG_GENERATOR"  -DBUILD_TRAINING_TOOLS:BOOL=OFF -DCMAKE_INSTALL_PREFIX="$myRepo"/Install/tesseract -DLeptonica_DIR:PATH="$myRepo"/Install/leptonica/cmake -DPKG_CONFIG_EXECUTABLE:BOOL=OFF "$myRepo"/"$RepoSource"
echo "************************* $Source_DIR -->release"
cmake --build . --config release
cmake --build .  --target install --config release
popd

RepoSource=opencv
pushd Build/$RepoSource
CMAKE_OPTIONS='-DBUILD_PERF_TESTS:BOOL=OFF -DBUILD_TESTS:BOOL=OFF -DBUILD_DOCS:BOOL=OFF -DWITH_CUDA:BOOL=OFF'
cmake -G"$CMAKE_CONFIG_GENERATOR"  \
-DTesseract_INCLUDE_DIR:PATH="${myRepo}"/Install/tesseract/include -DTesseract_LIBRARY="${myRepo}"/Install/tesseract/lib/tesseract40.lib -DLept_LIBRARY="${myRepo}"/Install/leptonica/lib/leptonica-1.74.4.lib \
$CMAKE_OPTIONS -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
-DINSTALL_CREATE_DISTRIB=ON -DCMAKE_INSTALL_PREFIX="$myRepo"/install/"$RepoSource"  "$myRepo/$RepoSource"
echo "************************* $Source_DIR -->devenv debug"
cmake --build .  --config debug
echo "************************* $Source_DIR -->devenv release"
cmake --build .  --config release
cmake --build .  --target install --config release
cmake --build .  --target install --config debug
popd