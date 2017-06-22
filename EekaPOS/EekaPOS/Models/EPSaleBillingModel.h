//
//  EPSaleBillingModel.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPSaleBillingModel : NSObject

@property(nonatomic,strong) NSNumber *saleBillingID;
@property(nonatomic,strong) NSString *saleNo;
@property(nonatomic,strong) NSString *storeName;
@property(nonatomic,strong) NSString *guider;
@property(nonatomic,strong) NSString *guiderIds;
@property(nonatomic,strong) NSString *cashier;
@property(nonatomic,strong) NSString *sellDate;
@property(nonatomic,strong) NSString *printDate;

@property(nonatomic,assign) float amountPrice;
@property(nonatomic,assign) float trueRece;
@property(nonatomic,strong) NSNumber *discount;

@property(nonatomic,assign) int status;
@property(nonatomic,assign) int isDelete;

@property(nonatomic,strong) NSString *phone;

@property(nonatomic,strong) NSString *deductionStr;
@property(nonatomic,strong) NSString *payType;
@property(nonatomic,strong) NSString *posvoucherId;

@property(nonatomic,strong) NSMutableArray *itemList;

@end
