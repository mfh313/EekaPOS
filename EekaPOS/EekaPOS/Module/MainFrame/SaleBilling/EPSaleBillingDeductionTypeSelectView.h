//
//  EPSaleBillingDeductionTypeSelectView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@class EPSaleBillingDeductionModel;
@protocol EPSaleBillingDeductionTypeSelectViewDelegate <NSObject>

@optional
-(void)didSelectSaleBillingDeductionType:(EPSaleBillingDeductionModel *)typemodel;

@end

@interface EPSaleBillingDeductionTypeSelectView : MMUIBridgeView

@property (nonatomic,weak) id<EPSaleBillingDeductionTypeSelectViewDelegate> m_delegate;

@end
