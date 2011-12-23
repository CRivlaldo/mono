//
//  AppDelegate.m
//  iOSMonoTest
//
//  Created by Vladimir Vlasov on 22.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

void RunMono()
{
    NSString *testLibPath = [[NSBundle mainBundle] pathForResource:@"MonoTest" ofType:@"dll"]; 
    NSString* workingDir = [testLibPath stringByDeletingLastPathComponent];
    
    NSString *corilbPath = [workingDir stringByAppendingString:@"/MonoRuntime/lib/mono/4.0/mscorlib.dll"];  
    printf("%s\n", [corilbPath UTF8String]);
    NSData *corlibData = [NSData dataWithContentsOfFile:corilbPath];     
    printf("%s\n", [testLibPath UTF8String]);
    
    if (corlibData) 
    {  
        mono_set_corlib_data((void*)[corlibData bytes], [corlibData length]); 
    } 
    else
    {
        printf("corlibData = NULL\n");
        return;
    }
    
    printf("address of mono_aot_module_mscorlib_info:  %p\n", mono_aot_module_mscorlib_info);
    printf("address of mono_aot_module_TestLib_info:  %p\n", mono_aot_module_MonoTest_info);
                    
    //set mono directories
    {
        NSString *monoLibPath = [workingDir stringByAppendingString:@"/MonoRuntime/lib"];  
        NSString *monoEtcPath = [workingDir stringByAppendingString:@"/MonoRuntime/etc"];  
        
        //1 - path to "lib" directory
        //2 - config file path (by default in the mono path to "etc" directory)
        mono_set_dirs([monoLibPath UTF8String], [monoEtcPath UTF8String]);
    }
    
    // mono_jit_set_aot_only(TRUE) should be enabled now.
    // if not enabled, I suspect we're still jitting...
    mono_jit_set_aot_only(1);
    
    mono_aot_register_module(mono_aot_module_mscorlib_info);
    mono_aot_register_module(mono_aot_module_MonoTest_info);
    
    mono_debug_init(MONO_DEBUG_FORMAT_MONO);
    MonoDomain *domain = mono_jit_init_version("MonoTest.dll", "v4.0.30319");
    printf("mono domain: %p\n", domain);
    
    MonoAssembly *ma = mono_domain_assembly_open(domain, [testLibPath UTF8String]);
    printf("mono assembly: %p\n", ma);
    
    MonoImage *mi = mono_assembly_get_image(ma);
    printf("mono image: %p\n", mi);
    
    MonoClass *mc = mono_class_from_name(mi, "MonoTest", "Test");
    printf("mono class: %p\n", mc);
    
    MonoMethodDesc *mmd = mono_method_desc_new("MonoTest.Test:RunTest", 1);
    printf("mono desc method: %p\n", mmd);
    
    MonoMethod *mm = mono_method_desc_search_in_image(mmd, mi);
    printf("mono method: %p\n", mm);
    
    int stringCount = 10000;
	void* params[1];
	params[0] = &stringCount;
    MonoObject *mo = mono_runtime_invoke(mm, NULL, params, NULL);
    
    printf("mono object: %p\n", mo);
}

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    RunMono();
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
