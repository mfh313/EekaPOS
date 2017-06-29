//
//  MFThirdPartyPlugin.m
//  YJCustom
//
//  Created by EEKA on 2016/10/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MFThirdPartyPlugin.h"
#import <Bugly/Bugly.h>
#import <JSPatchPlatform/JSPatch.h>

#define JSPatch_APP_KEY @"a95d77d008b9a872"

#define BuglyAppID @"3f8f72c024"

@implementation MFThirdPartyPlugin

-(void)registerPlugins
{
    [self registerBugly];
    
    [self registerJSPatchHotFix];
}

-(void)registerBugly
{
    BuglyConfig *config = [BuglyConfig new];
    config.blockMonitorEnable = YES;
    config.unexpectedTerminatingDetectionEnable = YES;
    config.reportLogLevel = BuglyLogLevelWarn;
    [Bugly startWithAppId:BuglyAppID config:config];
    [BuglyLog initLogger:BuglyLogLevelWarn consolePrint:YES];
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

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [JSPatch sync];
}

@end
