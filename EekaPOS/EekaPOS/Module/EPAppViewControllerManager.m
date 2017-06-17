//
//  EPAppViewControllerManager.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/16.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPAppViewControllerManager.h"
#import "EPLoginViewController.h"
#import "EPMainFrameViewController.h"
#import "EPMeViewController.h"

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

-(void)createMainTabViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Homelist" bundle:nil];
    EPMainFrameViewController *mainFrameVC = [storyboard instantiateViewControllerWithIdentifier:@"EPMainFrameViewController"];
    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:mainFrameVC];
    UITabBarItem *homeTabItem = [[UITabBarItem alloc] initWithTitle:@"POS"
                                                              image:[MFImage(@"tab1b") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                      selectedImage:[MFImage(@"tab1a") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    rootNav.tabBarItem = homeTabItem;
    
    
    UIStoryboard *meStoryboard = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    EPMeViewController *meVC = [meStoryboard instantiateViewControllerWithIdentifier:@"EPMeViewController"];
    MMNavigationController *meRootNav = [[MMNavigationController alloc] initWithRootViewController:meVC];
    UITabBarItem *setTabItem = [[UITabBarItem alloc] initWithTitle:@"我"
                                                             image:[MFImage(@"tab3b") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                     selectedImage:[MFImage(@"tab4a") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    meRootNav.tabBarItem = setTabItem;
    
    m_tabbarController = [self getTabBarController];
    m_tabbarController.viewControllers = @[rootNav,meRootNav];
    m_tabbarController.tabBar.barTintColor = [UIColor whiteColor];
    
    m_window.rootViewController = m_tabbarController;
}

+ (id)getTabBarController
{
    return [[self getAppViewControllerManager] getTabBarController];
}

- (id)getTabBarController
{
    if (!m_tabbarController) {
        m_tabbarController = [[MMTabBarController alloc] init];
    }
    
    return m_tabbarController;
}

@end
