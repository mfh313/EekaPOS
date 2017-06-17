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

-(void)createMainTabViewController
{
    
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"OrderList" bundle:nil];
//    m_orderListVC = [storyboard instantiateViewControllerWithIdentifier:@"YJOrderListViewController"];
//    
//    MMNavigationController *rootNav = [[MMNavigationController alloc] initWithRootViewController:m_orderListVC];
//    [MFImage(@"set1") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UITabBarItem *homeTabItem = [[UITabBarItem alloc] initWithTitle:@"主页"
//                                                              image:[MFImage(@"home2") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                                                      selectedImage:[MFImage(@"home1") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    rootNav.tabBarItem = homeTabItem;
//    [rootNav setNavigationBarHidden:YES animated:NO];
//    
//    
//    UIStoryboard *settingStoryboard = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
//    MMSettingViewController *settingVC = [settingStoryboard instantiateViewControllerWithIdentifier:@"MMSettingViewController"];
//    MMNavigationController *settingRootNav = [[MMNavigationController alloc] initWithRootViewController:settingVC];
//    UITabBarItem *setTabItem = [[UITabBarItem alloc] initWithTitle:@"设置"
//                                                             image:[MFImage(@"set2") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                                                     selectedImage:[MFImage(@"set1") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    settingRootNav.tabBarItem = setTabItem;
//    
//    m_tabbarController = [self getTabBarController];
//    m_tabbarController.viewControllers = @[rootNav,settingRootNav];
//    m_tabbarController.tabBar.barTintColor = [UIColor hx_colorWithHexString:@"f9f9f9"];
//    
//    m_window.rootViewController = m_tabbarController;
}
@end
