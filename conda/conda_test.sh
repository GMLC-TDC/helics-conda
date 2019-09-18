#!/usr/bin/env bash

set -e # exit on first error

source activate helics-build-environment

python -c "import helics as h; h.helicsGetVersion()"
