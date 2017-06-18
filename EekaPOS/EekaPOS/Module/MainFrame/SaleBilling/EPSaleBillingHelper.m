//
//  EPSaleBillingHelper.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingHelper.h"

@implementation EPSaleBillingDeductionModel

+(instancetype)objectWithName:(NSString *)name key:(NSString *)key
{
    EPSaleBillingDeductionModel *model = [[EPSaleBillingDeductionModel alloc] init];
    model.name = name;
    model.key = key;
    
    return model;
}

@end



#pragma mark - EPSaleBillingHelper
@implementation EPSaleBillingHelper

+(NSString *)moneyDescWithNumber:(NSNumber *)money
{
    return @"¥ 20.0";
}

+(NSMutableArray *)saleBillingDeductionModels
{
    EPSaleBillingDeductionModel *model1 = [EPSaleBillingDeductionModel objectWithName:@"抹零" key:@"1"];
    EPSaleBillingDeductionModel *model2 = [EPSaleBillingDeductionModel objectWithName:@"电子现金劵" key:@"2"];
    EPSaleBillingDeductionModel *model3 = [EPSaleBillingDeductionModel objectWithName:@"纸质现金劵" key:@"3"];
    EPSaleBillingDeductionModel *model4 = [EPSaleBillingDeductionModel objectWithName:@"公司满减" key:@"4"];
    
    return [NSMutableArray arrayWithObjects:model1,model2,model3,model4, nil];
}

@end
