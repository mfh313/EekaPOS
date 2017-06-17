//
//  EPAccountMgr.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMService.h"
#import "EPLoginUserModel.h"

@interface EPAccountMgr : MMService

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) EPLoginUserModel *loginModel;

@end
