readonly DESTINATION_DIR=$(pwd)/../MonoTest/MonoTest/bin/Release

rm -f ${DESTINATION_DIR}/*.o
rm -f ${DESTINATION_DIR}/mscorlib.dll.a

/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/mscorlib.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/4.0/mscorlib.dll

ar rcs ${DESTINATION_DIR}/mscorlib.dll.a ${DESTINATION_DIR}/mscorlib.dll.o