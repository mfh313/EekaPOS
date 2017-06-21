//
//  EPSaleBillingDiscountInputView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol EPSaleBillingDiscountInputViewDelegate <NSObject>

@optional


@end

@interface EPSaleBillingDiscountInputView : MMUIBridgeView

@property (nonatomic,weak) id<EPSaleBillingDiscountInputViewDelegate> m_delegate;

-(void)setDiscountRate:(NSNumber *)discountRate;

-(void)setReceivablePrice:(NSNumber *)receivablePrice allPrice:(NSNumber *)discountPre;

@end
