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
//    return @"http://10.8.143.30:8080";  //zaolong
    return @"http://120.76.242.182:8083/";
}

+(NSString *)loginURL
{
    return MFURLWithPara(@"pos/employee/login.json");
}

+(NSString *)getItemDetailURL
{
    return MFURLWithPara(@"pos/employee/getItemDetail.json");
}

+(NSString *)getEntitityDetailURL
{
    return MFURLWithPara(@"pos/employee/getEntitityDetail.json");
}

+(NSString *)getIndividualDetailURL
{
    return MFURLWithPara(@"pos/employee/getIndividual.json");
}

+(NSString *)saveSaleBillingURL
{
    return MFURLWithPara(@"pos/employee/saveSaleBilling.json");
}

+(NSString *)getSaleBillingListURL
{
    return MFURLWithPara(@"pos/employee/getSaleBillingList.json");
}

@end
