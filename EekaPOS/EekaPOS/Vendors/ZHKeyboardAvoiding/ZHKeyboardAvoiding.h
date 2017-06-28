//
//  ZHKeyboardAvoiding.h
//  键盘
//
//  Created by lzh on 15/7/30.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZHKeyboardAvoiding : NSObject


/**
 *  移动moveView来避免avodingView被键盘遮挡，avodingView一般是moveView的子类或者子类的子类
 *
 *  @param avoidingView 避免被键盘遮挡到的View：必须是UITextField/UITextView
 *  @param moveView     需要被移动的View:可以是UIView，或者是TableView
 *                      UIScrollView正在完善中
 */
+ (void)setAvoidingView:(UIView *)avoidingView  moveView:(UIView *)moveView;


+ (void)setAvoidingView:(UIView *)avoidingView  moveView:(UIView *)moveView offset:(CGFloat)offset;


@end
