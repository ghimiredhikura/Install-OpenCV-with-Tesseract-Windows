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

echo "Installing leptonica"
myRepo=$(pwd)
CMAKE_CONFIG_GENERATOR="Visual Studio 15 2017 Win64"
RepoSource=leptonica
MAJGitRepo $RepoSource https://github.com/DanBloomberg/leptonica.git
cd $RepoSource
git reset --hard f3d7ee868b4864cdca7ea57349d49f3d2b4a63ec
cd ..

pushd Build/$RepoSource
cmake -G"$CMAKE_CONFIG_GENERATOR" -DCMAKE_INSTALL_PREFIX="$myRepo"/Install/leptonica "$myRepo/$RepoSource"
echo "************************* $Source_DIR -->debug"
cmake --build .  --config release
cmake --build .  --target install --config release
popd