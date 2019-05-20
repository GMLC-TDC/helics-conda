#!/usr/bin/env bash

set -ev # exit on first error, print each command

if [ ${TRAVIS_OS_NAME} == "osx" ]; then
    echo ""
    echo "Removing homebrew from Travis CI to avoid conflicts."
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall > ~/uninstall_homebrew
    chmod +x ~/uninstall_homebrew
    ~/uninstall_homebrew -fq
    rm ~/uninstall_homebrew
fi

if [[ "$TRAVIS_OS_NAME" != "windows" ]]; then
    export MINICONDA=$HOME/miniconda
else
    export MINICONDA=/c/miniconda
fi

if [ ${PYTHON_ARCH} == "32" ]; then
  set CONDA_FORCE_32BIT=1
fi

hash -r
conda update -q conda
conda info -a

conda create -n helics-build-environment python=$PYTHON_VERSION
source activate helics-build-environment
conda list

