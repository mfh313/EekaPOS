//
//  EPSaleBillingDetailHeaderView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/22.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@class EPSaleBillingModel;
@interface EPSaleBillingDetailHeaderView : MMUIBridgeView

-(void)setSaleBillingModel:(EPSaleBillingModel *)SaleBillingModel;

-(CGFloat)headerHeightForSaleBillingModel:(EPSaleBillingModel *)model headerWidth:(CGFloat)headerWidth;

@end
