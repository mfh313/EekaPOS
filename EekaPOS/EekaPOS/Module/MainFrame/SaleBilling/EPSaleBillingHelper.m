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

+ (NSString *)getMonthBeginWith:(NSString *)dateStr
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL rangeOfUnit = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (rangeOfUnit)
    {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }
    else
    {
        return @"";
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    return beginString;
}

+(NSString *)dateStringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    //@"2017-06-20 09:25"
    return strDate;
}

+(NSString *)yMDdateStringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    return strDate;
}

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

+(NSString *)saleBillingSelectDeductionsStr:(NSMutableArray *)saleBillingDeductions
{
//    return @"抹零:25.0&电子现金劵:60.0&纸质现金劵:90.0&公司满减:20.0";
    
    NSMutableArray *deductionsArray = [NSMutableArray array];
    for (int i = 0; i < saleBillingDeductions.count; i++)
    {
        EPSaleBillingDeductionModel *model = saleBillingDeductions[i];
        NSString *name = model.name;
        NSNumber *value = model.value;
        
        NSString *deduction = [NSString stringWithFormat:@"%@:%@",name,value];
        [deductionsArray addObject:deduction];
    }
    
    NSString *deductions = [deductionsArray componentsJoinedByString:@"&"];
    return deductions;
}

@end
