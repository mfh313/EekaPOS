//
//  EPAppViewControllerManager.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/16.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMTabBarController.h"

@interface EPAppViewControllerManager : NSObject
{
    UIWindow *m_window;
    MMTabBarController *m_tabbarController;
}

+(id)getAppViewControllerManager;
-(id)initWithWindow:(UIWindow *)window;
-(void)jumpToLoginViewController;
-(void)createMainTabViewController;

@end
