//
//  EPGetSaleBillingByIdApi.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/22.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPGetSaleBillingByIdApi.h"

@implementation EPGetSaleBillingByIdApi

-(NSString *)requestUrl
{
    return [EPApiManger getSaleBillingByIdURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    EPAccountMgr *accountMgr =[[MMServiceCenter defaultCenter] getService:[EPAccountMgr class]];
    NSString *token = accountMgr.token;
    
    params[@"token"] = token;
    params[@"saleBillingId"] = self.saleBillingId;
    
    return params;
    
}

@end
