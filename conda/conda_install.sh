#!/usr/bin/env bash

set -ev # exit on first error, print each command

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
# conda info -a

if [[ "$TRAVIS_OS_NAME" != "windows" ]]; then
    source activate base
else
    source activate base
fi

