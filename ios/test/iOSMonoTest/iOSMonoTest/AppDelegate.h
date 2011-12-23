//
//  AppDelegate.h
//  iOSMonoTest
//
//  Created by Vladimir Vlasov on 22.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <mono/metadata/appdomain.h>
#include <mono/metadata/assembly.h>
#include <mono/metadata/debug-helpers.h>
#include <mono/metadata/mono-debug.h>
#include <mono/jit/jit.h>

extern void mono_set_corlib_data(void *data, size_t size);
extern void mono_jit_set_aot_only(int aot_only);

extern void* mono_aot_module_MonoTest_info;
extern void* mono_aot_module_mscorlib_info;
extern void mono_jit_set_aot_only(int aot_only);
extern void mono_aot_register_module(void *aot_info);
extern void mono_set_corlib_data(void *data, size_t size);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@end
