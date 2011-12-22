set -o nounset
set -o errexit

# scripts that source this file must be run from within packages tree
readonly SAVE_PWD=$(pwd)

readonly IOS_SDK_BASE=/Developer/Platforms/iPhoneOS.platform/Developer/usr

readonly IOS_BIN_PATH=${IOS_SDK_BASE}/bin
export IOSCC=${IOS_BIN_PATH}/arm-apple-darwin10-llvm-gcc-4.2
export IOSCXX=${IOS_BIN_PATH}/arm-apple-darwin10-llvm-g++-4.2
export IOSCPP=${IOS_BIN_PATH}/arm-apple-darwin10-cpp-4.2.1
export IOSAR=${IOS_BIN_PATH}/ar
export IOSRANLIB=${IOS_BIN_PATH}/ranlib
export IOSLD=${IOS_BIN_PATH}/ld
export IOSAS=${IOS_BIN_PATH}/as

readonly IOS_SDK_GCC_SPECS_PATH=${IOS_SDK_BASE}/lib/gcc/arm-apple-darwin10/4.2.1

readonly IOS_SDK_USR=${IOS_SDK_BASE}/
readonly IOS_SDK_USR_INCLUDE=${IOS_SDK_USR}/include
readonly IOS_SDK_USR_LIB=${IOS_SDK_USR}/lib


######################################################################
# Helper functions
######################################################################

Banner() {
  echo "######################################################################"
  echo $*
  echo "######################################################################"
}


VerifyPath() {
  # make sure path isn't all slashes (possibly from an unset variable)
  local PATH=$1
  local TRIM=${PATH##/}
  if [ ${#TRIM} -ne 0 ]; then
    return 0
  else
    return 1
  fi
}


ChangeDir() {
  local NAME=$1
  if VerifyPath ${NAME}; then
    cd ${NAME}
  else
    echo "ChangeDir called with bad path."
    exit -1
  fi
}


Remove() {
  local NAME=$1
  if VerifyPath ${NAME}; then
    rm -rf ${NAME}
  else
    echo "Remove called with bad path."
    exit -1
  fi
}


MakeDir() {
  local NAME=$1
  if VerifyPath ${NAME}; then
    mkdir -p ${NAME}
  else
    echo "MakeDir called with bad path."
    exit -1
  fi
}


PatchSpecFile() {
  # fix up spaces so gcc sees entire path
  local SED_SAFE_SPACES_USR_INCLUDE=${IOS_SDK_USR_INCLUDE/ /\ /}
  local SED_SAFE_SPACES_USR_LIB=${IOS_SDK_USR_LIB/ /\ /}
  # have nacl-gcc dump specs file & add include & lib search paths
  ${IOS_SDK_BASE}/bin/i686-apple-darwin10-llvm-gcc-4.2 -dumpspecs |\
    sed "/*cpp:/{
      N
      s|$| -I${SED_SAFE_SPACES_USR_INCLUDE}|
    }" |\
    sed "/*link_libgcc:/{
      N
      s|$| -L${SED_SAFE_SPACES_USR_LIB}|
    }" >${IOS_SDK_GCC_SPECS_PATH}/specs
}


DefaultConfigureStep() {
  Banner "Configuring ${PACKAGE_NAME}"
  # export the nacl tools
  export CC=${IOSCC}
  export CXX=${IOSCXX}
  export AR=${IOSAR}
  export RANLIB=${IOSRANLIB}
  export PKG_CONFIG_PATH=${IOS_SDK_USR_LIB}/pkgconfig
  export PKG_CONFIG_LIBDIR=${IOS_SDK_USR_LIB}
  export PATH=${IOS_BIN_PATH}:${PATH};
  ChangeDir ${IOS_PACKAGES_REPOSITORY}/${PACKAGE_NAME}
  Remove ${PACKAGE_NAME}-build
  MakeDir ${PACKAGE_NAME}-build
  cd ${PACKAGE_NAME}-build
  ../configure \
    --host=x86_64-apple-darwin10 \
    --target=arm-apple-darwin \
    --disable-shared \
    --prefix=${IOS_SDK_USR} \
    --exec-prefix=${IOS_SDK_USR} \
    --libdir=${IOS_SDK_USR_LIB} \
    --oldincludedir=${IOS_SDK_USR_INCLUDE} \
    --with-http=off \
    --with-html=off \
    --with-ftp=off \
    --with-x=no
}


DefaultBuildStep() {
  # assumes pwd has makefile
  make clean
  make -j4
}


DefaultInstallStep() {
  # assumes pwd has makefile
  make install
}


DefaultCleanUpStep() {
  PatchSpecFile
  ChangeDir ${SAVE_PWD}
}


DefaultPackageInstall() {
  DefaultPreInstallStep
  DefaultDownloadStep
  DefaultExtractStep
  DefaultPatchStep
  DefaultConfigureStep
  DefaultBuildStep
  DefaultInstallStep
  DefaultCleanUpStep
}
