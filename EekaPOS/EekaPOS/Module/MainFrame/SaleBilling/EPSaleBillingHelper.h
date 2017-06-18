//
//  EPSaleBillingHelper.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPSaleBillingDeductionModel : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *key;

+(instancetype)objectWithName:(NSString *)name key:(NSString *)key;

@end

#pragma mark - EPSaleBillingHelper
@interface EPSaleBillingHelper : NSObject

+(NSString *)moneyDescWithNumber:(NSNumber *)money;

+(NSMutableArray *)saleBillingDeductionModels;

@end
