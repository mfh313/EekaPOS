//
//  EPSaleBillingDetailGoodsItemPriceView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/24.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@interface EPSaleBillingDetailGoodsItemPriceView : MMUIBridgeView

-(void)setItemCode:(NSString *)itemCode
            number:(NSString *)number
         listPrice:(NSString *)listPrice
     discountPrice:(NSString *)discountPrice;

-(void)setNumberColor:(NSNumber *)number;

@end
