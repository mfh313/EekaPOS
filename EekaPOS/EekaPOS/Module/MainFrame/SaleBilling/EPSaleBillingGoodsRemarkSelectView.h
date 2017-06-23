//
//  EPSaleBillingGoodsRemarkSelectView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol EPSaleBillingGoodsRemarkSelectViewDelegate <NSObject>

@optional
-(void)didSelectRemark:(NSString *)remark isNegative:(BOOL)isNegative;

@end

@interface EPSaleBillingGoodsRemarkSelectView : MMUIBridgeView

@property (nonatomic,weak) id<EPSaleBillingGoodsRemarkSelectViewDelegate> m_delegate;

@end
