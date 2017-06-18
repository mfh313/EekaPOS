//
//  EPGetGoodsDetailApi.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@interface EPGetGoodsDetailApi : MFNetworkRequest

@property(nonatomic,strong) NSString *itemCode;



@end
