//
//  EPAppViewControllerManager.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/16.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EPAppViewControllerManager : NSObject
{
    UIWindow *m_window;
}

+(id)getAppViewControllerManager;
-(id)initWithWindow:(UIWindow *)window;
-(void)jumpToLoginViewController;
-(void)createMainTabViewController;

@end
