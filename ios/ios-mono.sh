#!/bin/bash

# nacl-mono.sh
#
# usage:  nacl-mono.sh
#
# this script builds a compiler for 32-bit NaCl code
# (installed in ./compiler folder)
#

ONLY_MAKE=0

source common.sh
# source ios-common.sh

readonly MONO_TRUNK_IOS=$(pwd)

readonly PACKAGE_NAME=ios-mono-build

readonly INSTALL_PATH=${IOS_SDK_USR}



CustomConfigureStep() {
  if [ ${ONLY_MAKE} = 0 ]; then
    Banner "Configuring ${PACKAGE_NAME}"
    set +e
    if [ -f ${PACKAGE_NAME}/Makefile ]
    then
      cd ${PACKAGE_NAME}
     make distclean
    fi
  fi
  cd ${MONO_TRUNK_IOS}
  if [ ${ONLY_MAKE} = 0 ]; then
    set -e
    Remove ${PACKAGE_NAME}
    MakeDir ${PACKAGE_NAME}
  fi
  cd ${PACKAGE_NAME}
  if [ ${ONLY_MAKE} = 0 ]; then
    cp ../ios-mono-config-cache ../ios-mono-config-cache.temp
    ../../configure \
      --target=arm-apple-darwin \
      --prefix=${INSTALL_PATH} \
      --exec-prefix=${INSTALL_PATH} \
      --with-tls=pthread \
      --disable-mono-debugger \
      --with-sigaltstack=no \
      --with-sgen=no \
      --with-gc=included \
      --enable-nls=no \
      --cache-file=../ios-mono-config-cache.temp  

    rm ../ios-mono-config-cache.temp
  fi
}

CustomPackageInstall() {
  CustomConfigureStep
  DefaultBuildStep
  DefaultInstallStep
}

CustomPackageInstall
exit 0
