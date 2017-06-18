//
//  EPSaleBillingEmployeeSelectView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@class EPSaleBillingEmployeeSelectView,EPEntitityEmployeeModel;
@protocol EPSaleBillingEmployeeSelectViewDelegate <NSObject>

@optional
-(void)didSelectEmployee:(EPEntitityEmployeeModel *)selectEmployee view:(EPSaleBillingEmployeeSelectView *)view;


@end

@interface EPSaleBillingEmployeeSelectView : MMUIBridgeView

@property (nonatomic,weak) id<EPSaleBillingEmployeeSelectViewDelegate> m_delegate;

@end
