//
//  ZHKeyboardAvoiding.m
//  键盘
//
//  Created by lzh on 15/7/30.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "ZHKeyboardAvoiding.h"
#import <UIKit/UIKit.h>

static UIView *_avoidingView; //避免被遮挡的View
static UIScrollView *_scrollView;
static UIView *_justView;
static NSMutableDictionary *_avoidingViewDictionary;
static NSMutableDictionary *_offsetDictionary;
static CGFloat _recordY;    // _justView上移前的Y值
static CGFloat _recordHeight;
static CGPoint _recordOffset;   // _scrollView上移前的offset值
static CGFloat _keyBoardHeight;
static CGFloat _finalDetal;
static CGFloat _bottomMargin = 5 ;
static float   _keyBoardAnimationDuration  = 0.27 ;
static BOOL    _isScrollViewAction = NO;

@interface ZHKeyboardAvoiding ()


@end


@implementation ZHKeyboardAvoiding

+ (void)willChangeFrame:(NSNotification *)notification{
    
    
    BOOL KeyBoardWillShow  = NO;
    CGRect keyboardFrame   = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    //  键盘是否在显示
    CGSize screenSize  = [UIScreen mainScreen].bounds.size;
    if (!CGRectIsEmpty(keyboardFrame) && (keyboardFrame.origin.y == 0 || (keyboardFrame.origin.y + keyboardFrame.size.height == screenSize.height))) {
        KeyBoardWillShow   = YES;
    }
    
    if (!KeyBoardWillShow) {
        return;
    }
    
    //  获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue  = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect  = [aValue CGRectValue];
    CGFloat keyBoardHeight = keyboardRect.size.height;

    if (_isScrollViewAction) {
        _recordOffset  = _scrollView.contentOffset;
    }else {
        _recordY = _justView.frame.origin.y;
    }
    
    _keyBoardHeight  = keyBoardHeight;
    
    [[ZHKeyboardAvoiding  sharedInstance] performSelector:@selector(delayNotification:) withObject:nil afterDelay:0.01];
}


//   延迟执行的方法。不过不延迟，系统会先调用TextViewDidBeginEditing:或者TextFieldDidBeginEditing:方法
//   将会导致无法准确获得avoidingView 和 moveView

- (void)delayNotification:notification{
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];

    CGRect newRect = [_avoidingView convertRect:_avoidingView.bounds toView:window];
    CGFloat newRectY  = newRect.origin.y;
    
    CGFloat customOffset = [_offsetDictionary[@(_avoidingView.hash)] floatValue];
    _recordHeight = newRect.size.height + customOffset;
    //    CGFloat  delta  = newRectY + _recordHeight  + _keyBoardHeight + customOffset -  window.frame.size.height ;
    
    CGFloat  delta  = newRectY + _recordHeight  + _keyBoardHeight  -  window.frame.size.height ;
    _finalDetal  = delta;
    if (delta < 0)  return;
    
    if (_isScrollViewAction) {
        [UIView animateWithDuration:_keyBoardAnimationDuration animations:^{
            CGPoint targetOffset = _recordOffset;
            targetOffset.y  = targetOffset.y  + _finalDetal;
            _scrollView.contentOffset = targetOffset;
        }];
    }else {
        [UIView animateWithDuration:_keyBoardAnimationDuration animations:^{
            CGRect frame = _justView.frame ;
            CGFloat newY = _justView.frame.origin.y  - _finalDetal ;
            frame.origin.y = newY;
            _justView.frame = frame;
            
        }];
    }
}

+ (void)TextViewDidBeginEditing:(NSNotification *)notification{
    _avoidingView = (UITextView *)notification.object;
    
    UIView *moveView = _avoidingViewDictionary[@(_avoidingView.hash)];
    [self judgeViewWith:moveView];
}

+ (void)TextFieldDidBeginEditing:(NSNotification *)notification{
    _avoidingView = (UITextField *)notification.object;
    
    UIView *moveView = _avoidingViewDictionary[@(_avoidingView.hash)];
    [self judgeViewWith:moveView];

}

+ (void)judgeViewWith:(UIView *)moveView{
    if ([moveView isKindOfClass:[UIScrollView class]]) {
        _scrollView = (UIScrollView *)moveView;
        _justView = nil;
        _isScrollViewAction = YES;
    }else{
        _justView = moveView;
        _scrollView = nil;
        _isScrollViewAction = NO;
    }

}


+ (void)willHide:(NSNotification *)notification{
    if (_isScrollViewAction) {
        _scrollView.contentOffset = _recordOffset ;
    }else {
        CGRect frame = _justView.frame ;
        frame.origin.y = _recordY;
        _justView.frame = frame;
    }
}

#pragma mark - Public Method
+ (void)setAvoidingView:(UIView *)avoidingView  moveView:(UIView *)moveView offset:(CGFloat)offset{
    
    if ( !avoidingView  ||  !moveView) {
        return ;
    }
    
    [self init];
    
    [_avoidingViewDictionary setObject:moveView forKey:@(avoidingView.hash)];
    [_offsetDictionary setObject:@(offset) forKey:@(avoidingView.hash)];
}

+ (void)setAvoidingView:(UIView *)avoidingView  moveView:(UIView *)moveView{
    [self setAvoidingView:avoidingView moveView:moveView offset:0.0f];
}




#pragma mark - Private Methods
+ (void)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // make sure we only add this once
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
        
        
        _avoidingViewDictionary = [NSMutableDictionary dictionary];
        _offsetDictionary = [NSMutableDictionary dictionary];
    });
}


+ (ZHKeyboardAvoiding *)sharedInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


@end
