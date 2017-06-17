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
    NSDictionary *textAttributes = @{NSShadowAttributeName: shadow,NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTintColor:MFCustomLineColor];
    
    [[UITextField appearance] setTintColor:MFCustomNavBarColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexString:@"686868"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexString:@"f23a47"]} forState:UIControlStateSelected];

}

@end
