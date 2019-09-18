#!/usr/bin/env bash

set -ev # exit on first error, print each command

source activate helics-build-environment

python -c "import helics as h; h.helicsGetVersion()"
