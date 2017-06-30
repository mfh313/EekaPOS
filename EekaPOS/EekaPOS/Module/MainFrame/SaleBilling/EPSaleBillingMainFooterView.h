//
//  EPSaleBillingMainFooterView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/30.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol EPSaleBillingMainFooterViewDelegate <NSObject>

@optional
-(void)onClickCameraScanBtn;
-(void)onClickSaveBillingBtn;


@end

@interface EPSaleBillingMainFooterView : MMUIBridgeView

@property (nonatomic,weak) id<EPSaleBillingMainFooterViewDelegate> m_delegate;

-(void)setReceivablePrice:(NSString *)receivablePrice;

@end
