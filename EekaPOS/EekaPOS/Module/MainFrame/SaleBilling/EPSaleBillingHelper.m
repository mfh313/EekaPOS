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

+(float)roundFloat:(float)price{
    
    NSString *floatString = [NSString stringWithFormat:@"%.2f",price];
    return (floorf(price*100 + 0.5))/100;
}

+(NSString *)moneyDescWithNumber:(NSNumber *)money
{
    return [NSString stringWithFormat:@"¥ %.1f ",money.floatValue];
}

+(NSMutableArray *)saleBillingDeductionModels
{
    EPSaleBillingDeductionModel *model1 = [EPSaleBillingDeductionModel objectWithName:@"抹零" key:EPSaleBillingDeductionKey_1];
    EPSaleBillingDeductionModel *model2 = [EPSaleBillingDeductionModel objectWithName:@"电子现金劵" key:EPSaleBillingDeductionKey_2];
    EPSaleBillingDeductionModel *model3 = [EPSaleBillingDeductionModel objectWithName:@"纸质现金劵" key:EPSaleBillingDeductionKey_3];
    EPSaleBillingDeductionModel *model4 = [EPSaleBillingDeductionModel objectWithName:@"公司满减" key:EPSaleBillingDeductionKey_4];
    
    return [NSMutableArray arrayWithObjects:model1,model2,model3,model4, nil];
}

@end
