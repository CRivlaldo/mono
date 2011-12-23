#!/bin/bash

readonly MONO_TRUNK_IOS=$(pwd)

source common.sh

readonly PACKAGE_NAME=runtime-build
readonly INSTALL_PATH=${MONO_TRUNK_IOS}/mono-runtime-install

ONLY_MAKE=0


CustomConfigureStep() {
  Banner "Configuring ${PACKAGE_NAME}"
  set +e
  if [ -f ${PACKAGE_NAME}/Makefile ]
  then
    cd ${PACKAGE_NAME}
  fi
  if [ ${ONLY_MAKE} = 0 ]; then
    make distclean
  fi
  cd ${MONO_TRUNK_IOS}
  if [ ${ONLY_MAKE} = 0 ]; then
    set -e
    cp config-ios-runtime.cache config-ios-runtime.cache.temp
    Remove ${PACKAGE_NAME}
    MakeDir ${PACKAGE_NAME}
  fi
  cd ${PACKAGE_NAME}
  if [ ${ONLY_MAKE} = 0 ]; then
    CONFIG_OPTS="--build=i386-apple-darwin --host=arm-apple-darwin --disable-shared --cache-file=../config-ios-runtime.cache.temp"
    CC=${IOSCC} CXX=${IOSCXX} CPP=${IOSCPP} AR=${IOSAR} RANLIB=${IOSRANLIB} PKG_CONFIG_PATH=${IOS_SDK_USR_LIB}/pkgconfig LD="${IOSLD}" \
    PKG_CONFIG_LIBDIR=${IOS_SDK_USR_LIB} PATH=${IOS_BIN_PATH}:${PATH} LIBS="-lc" \
    CFLAGS="-g -O2 -isysroot /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.0.sdk -DIPHONEOS" CPPFLAGS="-isysroot /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.0.sdk" ../../configure \
      ${CONFIG_OPTS} \
      --exec-prefix=${INSTALL_PATH} \
      --libdir=${INSTALL_PATH}/lib \
      --prefix=${INSTALL_PATH} \
      --oldincludedir=${INSTALL_PATH}/include \
      --disable-mcs-build \
      --with-tls=pthread \
      --without-sigaltstack \
      --without-mmap \
      --with-gc=included \
      --with-sgen=no \
      --with-tls=pthread \
      --with-shared-mono=no \
      --with-static_mono=yes \
      --enable-nls=no
    rm ../config-ios-runtime.cache.temp
  fi
}

# old flags
    # --exec-prefix=${INSTALL_PATH} \
    # --libdir=${INSTALL_PATH}/lib \
    # --prefix=${INSTALL_PATH} \
    # --oldincludedir=${INSTALL_PATH}/include \
    # --disable-mcs-build \
    # --with-glib=embedded \
    # --with-tls=pthread \
    # --enable-threads=posix \
    # --without-sigaltstack \
    # --without-mmap \
    # --with-gc=included \
    # --with-sgen=no \
    # --enable-nls=no \
    # --with-shared-mono=no

CustomInstallStep() {
  make install

}

CustomPackageInstall() {
  CustomConfigureStep
  DefaultBuildStep
  CustomInstallStep
}

CustomPackageInstall
exit 0
