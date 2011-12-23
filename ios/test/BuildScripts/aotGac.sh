 #!/bin/bash

# for i in /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/*/*/*.dll; do
# 	echo $i;
# done

readonly DESTINATION_DIR=$(pwd)/../MonoTest/MonoTest/bin/Release

mkdir -p ${DESTINATION_DIR}

rm -f ${DESTINATION_DIR}/*.o
rm -f ${DESTINATION_DIR}/libgac.a
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/Accessibility.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/Accessibility/4.0.0.0__b03f5f7f11d50a3a/Accessibility.dll
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/I18N.Other.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/I18N.Other/4.0.0.0__0738eb9f132ed756/I18N.Other.dll
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/I18N.Rare.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/I18N.Rare/4.0.0.0__0738eb9f132ed756/I18N.Rare.dll
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/I18N.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/I18N/4.0.0.0__0738eb9f132ed756/I18N.dll
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/Mono.Posix.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/Mono.Posix/4.0.0.0__0738eb9f132ed756/Mono.Posix.dll
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/Mono.Security.Win32.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/Mono.Security.Win32/4.0.0.0__0738eb9f132ed756/Mono.Security.Win32.dll
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/Mono.Security.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/Mono.Security/4.0.0.0__0738eb9f132ed756/Mono.Security.dll
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/System.Configuration.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/System.Configuration/4.0.0.0__b03f5f7f11d50a3a/System.Configuration.dll
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/System.Core.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/System.Core/4.0.0.0__b77a5c561934e089/System.Core.dll
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/System.Drawing.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/System.Drawing/4.0.0.0__b03f5f7f11d50a3a/System.Drawing.dll
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/System.Security.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/System.Security/4.0.0.0__b03f5f7f11d50a3a/System.Security.dll
# /Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/System.Windows.Forms.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/System.Windows.Forms/4.0.0.0__b77a5c561934e089/System.Windows.Forms.dll
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/System.Xml.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/System.Xml/4.0.0.0__b77a5c561934e089/System.Xml.dll
/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin-mono --debug --aot=full,static,nodebug,outfile=${DESTINATION_DIR}/System.dll.o /Developer/Platforms/iPhoneOS.platform/Developer/usr/lib/mono/gac/System/4.0.0.0__b77a5c561934e089/System.dll

ar rcs ${DESTINATION_DIR}/libgac.a ${DESTINATION_DIR}/Accessibility.dll.o ${DESTINATION_DIR}/I18N.dll.o ${DESTINATION_DIR}/I18N.Other.dll.o ${DESTINATION_DIR}/I18N.Rare.dll.o ${DESTINATION_DIR}/Mono.Posix.dll.o ${DESTINATION_DIR}/Mono.Security.dll.o ${DESTINATION_DIR}/Mono.Security.Win32.dll.o ${DESTINATION_DIR}/System.Configuration.dll.o ${DESTINATION_DIR}/System.Core.dll.o ${DESTINATION_DIR}/System.dll.o ${DESTINATION_DIR}/System.Drawing.dll.o ${DESTINATION_DIR}/System.Security.dll.o ${DESTINATION_DIR}/System.Xml.dll.o
# ar rcs ${DESTINATION_DIR}/libgac.a ${DESTINATION_DIR}/Accessibility.dll.o ${DESTINATION_DIR}/I18N.dll.o ${DESTINATION_DIR}/I18N.Other.dll.o ${DESTINATION_DIR}/I18N.Rare.dll.o ${DESTINATION_DIR}/Mono.Posix.dll.o ${DESTINATION_DIR}/Mono.Security.dll.o ${DESTINATION_DIR}/Mono.Security.Win32.dll.o ${DESTINATION_DIR}/System.Configuration.dll.o ${DESTINATION_DIR}/System.Core.dll.o ${DESTINATION_DIR}/System.dll.o ${DESTINATION_DIR}/System.Drawing.dll.o ${DESTINATION_DIR}/System.Security.dll.o ${DESTINATION_DIR}/System.Windows.Forms.dll.o ${DESTINATION_DIR}/System.Xml.dll.o