//
//  EPSaleBillingListModel.m
//  EekaPOS
//
//  Created by EEKA on 2017/7/4.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingListModel.h"
#import "EPSaleBillingModel.h"

@implementation EPSaleBillingListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"time" : @"sellDate",
             @"money" : @"amount",
             @"models" : @"saleBillingList"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"models" : [EPSaleBillingModel class]};
}


@end
