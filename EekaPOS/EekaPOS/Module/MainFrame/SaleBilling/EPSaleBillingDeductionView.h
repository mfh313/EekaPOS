//
//  EPSaleBillingDeductionView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "EPSaleBillingHelper.h"

@class EPSaleBillingDeductionView;
@protocol EPSaleBillingDeductionViewDelegate <NSObject>

@optional
-(void)onClickDeductionBtn:(EPSaleBillingDeductionView *)view deductionModel:(EPSaleBillingDeductionModel *)deductionModel;
-(void)onClickAddBtn:(EPSaleBillingDeductionView *)view deductionModel:(EPSaleBillingDeductionModel *)deductionModel;

@end

@interface EPSaleBillingDeductionView : MMUIBridgeView

@property (nonatomic,weak) id<EPSaleBillingDeductionViewDelegate> m_delegate;

-(void)setDeductionMode:(EPSaleBillingDeductionModel *)deductionModel;

@end
