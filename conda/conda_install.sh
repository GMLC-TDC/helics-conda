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


if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then

    if [[ ${using_homebrew} == "yes" ]]; then
      sudo \
        installer \
        -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg \
        -target /
    else
      export MACOSX_DEPLOYMENT_TARGET="10.9"
      export CONDA_BUILD_SYSROOT="$(xcode-select -p)/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${MACOSX_DEPLOYMENT_TARGET}.sdk"

      if [[ ! -d ${CONDA_BUILD_SYSROOT} || "$OSX_FORCE_SDK_DOWNLOAD" == "1" ]]; then
        echo "downloading ${macosx_deployment_target} sdk"
        curl -L -O https://github.com/phracker/MacOSX-SDKs/releases/download/10.13/MacOSX${MACOSX_DEPLOYMENT_TARGET}.sdk.tar.xz
        tar -xf MacOSX${MACOSX_DEPLOYMENT_TARGET}.sdk.tar.xz -C "$(dirname "$CONDA_BUILD_SYSROOT")"
        # set minimum sdk version to our target
        plutil -replace MinimumSDKVersion -string ${MACOSX_DEPLOYMENT_TARGET} $(xcode-select -p)/Platforms/MacOSX.platform/Info.plist
        plutil -replace DTSDKName -string macosx${MACOSX_DEPLOYMENT_TARGET}internal $(xcode-select -p)/Platforms/MacOSX.platform/Info.plist
      fi

      if [ -d "${CONDA_BUILD_SYSROOT}" ]; then
        echo "Found CONDA_BUILD_SYSROOT: ${CONDA_BUILD_SYSROOT}"
      else
        echo "Missing CONDA_BUILD_SYSROOT: ${CONDA_BUILD_SYSROOT}"
        exit 1
      fi
    fi

fi
