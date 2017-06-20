//
//  EPSaleBillingHelper.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EPSaleBillingDeductionKey_1  @"NotCountTheSmallChange"
#define EPSaleBillingDeductionKey_2  @"E-cash"
#define EPSaleBillingDeductionKey_3  @"PaperCash"
#define EPSaleBillingDeductionKey_4  @"CompanyFullDiscount"

@interface EPSaleBillingDeductionModel : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSNumber *value;

+(instancetype)objectWithName:(NSString *)name key:(NSString *)key;

@end

#pragma mark - EPSaleBillingHelper
@interface EPSaleBillingHelper : NSObject

+(NSString *)dateStringWithDate:(NSDate *)date;

+(NSString *)yMDdateStringWithDate:(NSDate *)date;

+(float)roundFloat:(float)price;

+(NSString *)moneyDescWithNumber:(NSNumber *)money;

+(NSMutableArray *)saleBillingDeductionModels;

@end
