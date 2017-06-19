//
//  EPSaleBillingPhoneInputView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol EPSaleBillingPhoneInputViewDelegate <NSObject>

@optional
-(void)didInputPhone:(NSString *)phone;

@end

@interface EPSaleBillingPhoneInputView : MMUIBridgeView

@property (nonatomic,weak) id<EPSaleBillingPhoneInputViewDelegate> m_delegate;

-(void)setPhone:(NSString *)phone;

@end
