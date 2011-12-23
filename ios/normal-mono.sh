#!/bin/bash

readonly MONO_TRUNK_IOS=$(pwd)

readonly PACKAGE_NAME=mono-normal-build

source common.sh


CustomConfigureStep() {
  Banner "Configuring ${PACKAGE_NAME}"
  set +e
  if [ -f ${PACKAGE_NAME}/Makefile ]
  then
    cd ${PACKAGE_NAME}
    make distclean
  fi
  cd ${MONO_TRUNK_IOS}
  set -e
  Remove ${PACKAGE_NAME}
  MakeDir ${PACKAGE_NAME}
  cd ${PACKAGE_NAME}
  ../../configure \
    --prefix=${MONO_TRUNK_IOS}/normal-mono \
    --disable-parallel-mark \
    --enable-nls=no \
    --with-tls=pthread \
    --with-sgen=no
}

CustomPackageInstall() {
  CustomConfigureStep
  DefaultBuildStep
  DefaultInstallStep
}


CustomPackageInstall
exit 0
