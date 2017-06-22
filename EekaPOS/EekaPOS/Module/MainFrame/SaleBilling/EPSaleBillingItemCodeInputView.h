//
//  EPSaleBillingItemCodeInputView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol EPSaleBillingItemCodeInputViewDelegate <NSObject>

@optional
-(void)onClickCameraScanBtn;
-(void)onInputSaleBillingItemCode:(NSString *)itemCode;

@end

@interface EPSaleBillingItemCodeInputView : MMUIBridgeView

@property (nonatomic,weak) id<EPSaleBillingItemCodeInputViewDelegate> m_delegate;

-(void)setItemCode:(NSString *)itemCode;

@end
