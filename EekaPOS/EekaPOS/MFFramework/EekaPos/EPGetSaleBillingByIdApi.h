//
//  EPGetSaleBillingByIdApi.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/22.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@interface EPGetSaleBillingByIdApi : MFNetworkRequest

@property(nonatomic,strong) NSNumber *saleBillingId;

@end
