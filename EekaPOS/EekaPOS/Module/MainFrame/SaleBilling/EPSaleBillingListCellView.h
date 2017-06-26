//
//  EPSaleBillingListCellView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@class EPSaleBillingModel;
@interface EPSaleBillingListCellView : MMUIBridgeView

-(void)setNames:(NSString *)names;

-(void)setTimeString:(NSString *)time;

-(void)setMoneyString:(NSString *)money;

-(void)setStatus:(int)status model:(EPSaleBillingModel *)model;

@end
