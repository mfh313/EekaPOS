//
//  EPSaveSaleBillingApi.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"
#import "EPSaleBillingModel.h"

@interface EPSaveSaleBillingApi : MFNetworkRequest

@property(nonatomic,strong) EPSaleBillingModel *saleBillingModel;

@end

