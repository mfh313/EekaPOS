//
//  EPSaveSaleBillingApi.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaveSaleBillingApi.h"
#import "MFModelHelper.h"

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
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:modelJSON
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    params[@"saleBillingStr"] = jsonString;
    
    return params;
    
}

//- (NSString*)dictionaryToJson:(NSDictionary *)dic
//
//{
//    NSError *parseError = nil;
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
//    
//    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//}

@end
