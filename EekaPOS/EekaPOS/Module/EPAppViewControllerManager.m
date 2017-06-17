//
//  EPAppViewControllerManager.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/16.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPAppViewControllerManager.h"
#import "EPLoginViewController.h"

@implementation EPAppViewControllerManager

+ (id)getAppViewControllerManager
{
    static EPAppViewControllerManager *_sharedAppViewControllerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAppViewControllerManager = [[self alloc] init];
    });
    
    return _sharedAppViewControllerManager;
}

-(id)initWithWindow:(UIWindow *)window
{
    self = [[self class] getAppViewControllerManager];
    if (self) {
        m_window = window;
    }
    return self;
}

-(void)jumpToLoginViewController
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"EekaPosMain" bundle:nil];
    EPLoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"EPLoginViewController"];
    
    m_window.rootViewController  = loginVC;
}


@end
