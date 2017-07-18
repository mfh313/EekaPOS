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

+(NSString *)loginURL
{
    return MFURLWithPara(@"pos/employee/login");
}

+(NSString *)getItemDetailURL
{
    return MFURLWithPara(@"pos/employee/getItemDetail");
}

+(NSString *)getEntitityDetailURL
{
    return MFURLWithPara(@"pos/employee/getEntitityDetail");
}

+(NSString *)getSallerListURL
{
    return MFURLWithPara(@"pos/employee/getSallerList");
}

+(NSString *)getIndividualDetailURL
{
    return MFURLWithPara(@"pos/employee/getIndividual");
}

+(NSString *)saveSaleBillingURL
{
    return MFURLWithPara(@"pos/employee/saveSaleBilling");
}

+(NSString *)getSaleBillingListURL
{
    return MFURLWithPara(@"pos/employee/getSaleBillingListByDate");
}

+(NSString *)getSaleBillingByIdURL
{
    return MFURLWithPara(@"pos/employee/getSaleBillingById");
}

+(NSString *)updateSaleBillingURL
{
    return MFURLWithPara(@"pos/employee/updateSaleBilling");
}

+(NSString *)deleteSaleBillingURL
{
    return MFURLWithPara(@"pos/employee/deleteSaleBilling");
}


@end
