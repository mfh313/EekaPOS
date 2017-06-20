//
//  EPGetSaleBillingListApi.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPGetSaleBillingListApi.h"

@implementation EPGetSaleBillingListApi

-(NSString *)requestUrl
{
    return [EPApiManger getSaleBillingListURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    EPAccountMgr *accountMgr =[[MMServiceCenter defaultCenter] getService:[EPAccountMgr class]];
    NSString *token = accountMgr.token;
    
    params[@"token"] = token;
    params[@"startDate"] = self.startDate;
    params[@"endDate"] = self.endDate;
    params[@"entityName"] = self.entityName;
    
    return params;
    
}

@end
