//
//  EPSaveSaleBillingApi.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaveSaleBillingApi.h"
#import "MFModelHelper.h"
#import "EPSaleBillingHelper.h"

@implementation EPSaveSaleBillingApi

-(NSString *)requestUrl
{
    return [EPApiManger saveSaleBillingURL];
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
    
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:modelJSON
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    params[@"saleBillingStr"] = [EPSaleBillingHelper dictionaryToJson:modelJSON];
    
    return params;
    
}



@end
