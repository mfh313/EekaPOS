//
//  EPSaleBillingGoodsCellView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@interface EPSaleBillingGoodsCellView : MMUIBridgeView

-(void)setItemCode:(NSString *)itemCode itemName:(NSString *)itemName;

-(void)setRemarkString:(NSString *)remark;

-(void)setDiscountAfter:(NSString *)str;

-(void)setDiscountPre:(NSString *)str;

-(void)setDiscountRate:(NSString *)str;

@end
