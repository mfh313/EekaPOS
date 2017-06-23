//
//  EPSaleBillingItemModel.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPGoodsDetailModel.h"

@interface EPSaleBillingItemModel : EPGoodsDetailModel

@property (nonatomic,strong) NSNumber *saleBillingItemID;
@property (nonatomic,strong) NSNumber *saleBillingID;
@property (nonatomic,strong) NSNumber *receivablePrice;
@property (nonatomic,strong) NSNumber *discount;
@property (nonatomic,strong) NSString *remarks;
@property (nonatomic,strong) NSNumber *number;
@property (nonatomic,assign) BOOL isSpecialDiscount;

@end
