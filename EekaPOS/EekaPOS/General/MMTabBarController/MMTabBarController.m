//
//  MMTabBarController.m
//  YJCustom
//
//  Created by EEKA on 16/9/20.
//  Copyright © 2016年 EEKA. All rights reserved.
//

#import "MMTabBarController.h"

@interface MMTabBarController ()

@end

@implementation MMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    NSLog(@"MMTabBarController viewDidLoad = %@",NSStringFromCGRect(self.view.frame));
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"MMTabBarController viewWillAppear = %@",NSStringFromCGRect(self.view.frame));
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"MMTabBarController viewDidAppear = %@",NSStringFromCGRect(self.view.frame));
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)setTabBarBadgeValue:(NSInteger)value forIndex:(NSInteger)index
{
    UIViewController *indexVC = self.viewControllers[index];
    
    if (value > 0) {
        indexVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",value];
    }
    else
    {
        indexVC.tabBarItem.badgeValue = nil;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
