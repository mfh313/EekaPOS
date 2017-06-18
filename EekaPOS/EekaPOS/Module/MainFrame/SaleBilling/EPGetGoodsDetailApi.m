//
//  EPGetGoodsDetailApi.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPGetGoodsDetailApi.h"

@implementation EPGetGoodsDetailApi

-(NSString *)requestUrl
{
    return [EPApiManger getItemDetailURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    EPAccountMgr *accountMgr =[[MMServiceCenter defaultCenter] getService:[EPAccountMgr class]];
    NSString *token = accountMgr.token;
    
    params[@"token"] = token;
    params[@"itemCode"] = self.itemCode;
    
    return params;

}

-(BOOL)messageSuccess
{
    NSDictionary *dict = self.responseJSONObject;
    NSNumber *number = dict[@"errcode"];
    if (number.intValue == 0 || number.intValue == 1)
    {
        return YES;
    }
    
    return NO;
}

-(NSString*)errorMessage
{
    NSDictionary *dict = self.responseJSONObject;
    id string = dict[@"errmsg"];
    if ([string isKindOfClass:[NSNull class]]) {
        string = @"服务器无错误描述";
    }
    
    return string;
}

@end
