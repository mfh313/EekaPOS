//
//  EPGetSaleBillingListApi.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@interface EPGetSaleBillingListApi : MFNetworkRequest

@property(nonatomic,strong) NSString *startDate;
@property(nonatomic,strong) NSString *endDate;
@property(nonatomic,strong) NSString *entityName;

@end
