//
//  MFThirdPartyPlugin.m
//  YJCustom
//
//  Created by EEKA on 2016/10/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MFThirdPartyPlugin.h"
#import <Bugly/Bugly.h>

#define BuglyAppID @"900056633"

@implementation MFThirdPartyPlugin

-(void)registerPlugins
{
    [self registerBugly];
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

@end
