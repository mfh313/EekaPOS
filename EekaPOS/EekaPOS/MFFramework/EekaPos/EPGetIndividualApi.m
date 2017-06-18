//
//  EPGetIndividualApi.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPGetIndividualApi.h"

@implementation EPGetIndividualApi

-(NSString *)requestUrl
{
    return [EPApiManger getIndividualDetailURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    EPAccountMgr *accountMgr =[[MMServiceCenter defaultCenter] getService:[EPAccountMgr class]];
    NSString *token = accountMgr.token;
    
    params[@"token"] = token;
//    params[@"itemCode"] = self.itemCode;
    
    return params;
    
}

@end
