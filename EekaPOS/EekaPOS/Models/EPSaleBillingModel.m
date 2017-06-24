//
//  EPSaleBillingModel.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingModel.h"
#import "EPSaleBillingItemModel.h"

@implementation EPSaleBillingModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"itemList" : [EPSaleBillingItemModel class]};
}

@end
