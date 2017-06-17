//
//  EPApiManger.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPApiManger.h"

#define MFURL [EPApiManger hostUrl]

#define MFURLWithPara(para) [MFURL stringByAppendingPathComponent:para]

NSString const *EPApiTestUrl = @"https://pos.koradior.info:8443/";
NSString const *EPApiUrl = @"https://pos.szyingjia.cn:8888/";


@implementation EPApiManger

+ (NSString *)hostUrl
{
    return @"http://120.76.242.182:8083/";
}

+(NSString *)loginUrl
{
    return MFURLWithPara(@"pos/employee/login.json");
}

@end
