//
//  EPDeleteSaleBillingApi.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/22.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPDeleteSaleBillingApi.h"

@implementation EPDeleteSaleBillingApi

-(NSString *)requestUrl
{
    return [EPApiManger deleteSaleBillingURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    EPAccountMgr *accountMgr =[[MMServiceCenter defaultCenter] getService:[EPAccountMgr class]];
    NSString *token = accountMgr.token;
    
    params[@"token"] = token;
    params[@"saleBillingID"] = self.saleBillingID;
    
    return params;
    
}

@end
