//
//  RYNumberKeyBoard.h
//  RYNumberKeyboardDemo
//
//  Created by Resory on 16/2/20.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SYS_DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)                 //屏幕宽度
#define SYS_DEVICE_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)                //屏幕长度

typedef NS_ENUM(NSUInteger, RYInputType) {
    RYIntInputType,        // 整数键盘
    RYFloatContainNegativeInputType,      // 浮点数键盘  包含负数   ／／
    RYFloatZeroToOneInputType,      // 浮点数键盘 0到1之间的
    RYFloat2DigitInputType,      // 浮点数键盘 小数只能输入两位
};


//the defined numberPad delegate
@protocol RYNumberKeyboardDelegate<NSObject>

@optional
// delegate function to press keyboard button
- (void)ryNumberKeyboardValueChange:(NSString *)string tag:(NSInteger)tag;


- (void)ryNumberKeyboardSubmit:(NSString *)string tag:(NSInteger)tag;

@end

@interface RYNumberKeyboard : UIView

@property (nonatomic, weak) UITextField<UITextInput> *textInput;
@property (nonatomic, assign) RYInputType inputType;        // 键盘类型
@property (nonatomic, strong) NSNumber *interval;           // 每隔多少个数字空一格

- (id)initWithInputType:(RYInputType)inputType;

@property (nonatomic, assign) id<RYNumberKeyboardDelegate> ryDelegate;
@end
