//
//  EPSaleBillingCashierCellView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol EPSaleBillingCashierCellViewDelegate <NSObject>

@optional
-(void)onClickCashierCellView;

@end

@interface EPSaleBillingCashierCellView : MMUIBridgeView

@property(nonatomic,weak) id<EPSaleBillingCashierCellViewDelegate> m_delegate;

-(void)setCashierString:(NSString *)string;

@end
