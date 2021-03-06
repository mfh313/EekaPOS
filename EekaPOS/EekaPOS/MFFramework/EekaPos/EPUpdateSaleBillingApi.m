//
//  EPUpdateSaleBillingApi.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/22.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPUpdateSaleBillingApi.h"
#import "EPSaleBillingModel.h"
#import "EPSaleBillingHelper.h"

@implementation EPUpdateSaleBillingApi

-(NSString *)requestUrl
{
    return [EPApiManger updateSaleBillingURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    EPAccountMgr *accountMgr =[[MMServiceCenter defaultCenter] getService:[EPAccountMgr class]];
    NSString *token = accountMgr.token;
    
    params[@"token"] = token;
    
    NSDictionary *modelJSON = [self.saleBillingModel MMmodelToJSONObject];
    params[@"saleBillingStr"] = [EPSaleBillingHelper dictionaryToJson:modelJSON];
    
    return params;
    
}

@end
