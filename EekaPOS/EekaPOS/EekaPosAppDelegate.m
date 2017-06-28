//
//  EekaPosAppDelegate.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/15.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EekaPosAppDelegate.h"
#import "MFThirdPartyPlugin.h"
#import "MMServiceCenter.h"
#import "MFThemeHelper.h"
#import "EPAppViewControllerManager.h"
#import <JSPatchPlatform/JSPatch.h>

#define JSPatch_APP_KEY @"a95d77d008b9a872"


@interface EekaPosAppDelegate ()
{
    MMServiceCenter *m_serviceCenter;
    EPAppViewControllerManager *m_appViewControllerMgr;
}

@end

@implementation EekaPosAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    m_serviceCenter = [MMServiceCenter defaultCenter];
    
    MFThirdPartyPlugin *thirdPartyPlugin = [m_serviceCenter getService:[MFThirdPartyPlugin class]];
    [thirdPartyPlugin registerPlugins];
    
    [self registerJSPatchHotFix];
    
    [MFThemeHelper setDefaultThemeColor];
    
    [MFNetwork makeConfigNetwork];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    m_appViewControllerMgr = [[EPAppViewControllerManager getAppViewControllerManager] initWithWindow:self.window];
    
    [[EPAppViewControllerManager getAppViewControllerManager] jumpToLoginViewController];
    
    return YES;
}

-(void)registerJSPatchHotFix
{
    [JSPatch startWithAppKey:JSPatch_APP_KEY];
#ifdef DEBUG
    [JSPatch setupDevelopment];
#endif
    [JSPatch setupRSAPublicKey:@"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC7Y3DvH67G7d6EjFPHF6y37sO/\nTs76k+hLDoDwKNv51PEIcko2lcsWr/DEvyIQdn0fXcmR/A1mgjHIAI2jFmAi5La5\nw11LnksUhDWHuHFDeagcKUlLWG/TC+U25Ym88ikWAYqrhReCLEXjJeAH7XPr6uoM\n4mRLB4IINO7goBcs2QIDAQAB\n-----END PUBLIC KEY-----"];
    [JSPatch sync];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [JSPatch sync];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
