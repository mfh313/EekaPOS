//
//  MFThemeHelper.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFThemeHelper.h"

@implementation MFThemeHelper

+(void)setDefaultThemeColor
{
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor clearColor];
    NSDictionary *textAttributes = @{NSShadowAttributeName: shadow,NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTintColor:MFCustomNavBarColor];
    
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    [[UINavigationBar appearance] setBackgroundImage:MFImageStretchCenter(@"navbg") forBarMetrics:UIBarMetricsDefault];
    
    [[UITextField appearance] setTintColor:MFCustomNavBarColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexString:@"71D0FF"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:MFCustomNavBarColor} forState:UIControlStateSelected];

}

@end
