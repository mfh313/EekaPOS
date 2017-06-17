//
//  EPLoginUserModel.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/16.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPLoginUserModel : NSObject

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *bgId;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSNumber *entityId;
@property (nonatomic,strong) NSString *fullname;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *pcCode;
@property (nonatomic,assign) int currentTimeMs;

@end
