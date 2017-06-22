//
//  EPGetSallerListApi.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/22.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPGetSallerListApi.h"

@implementation EPGetSallerListApi

-(NSString *)requestUrl
{
    return [EPApiManger getSallerListURL];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    EPAccountMgr *accountMgr =[[MMServiceCenter defaultCenter] getService:[EPAccountMgr class]];
    NSString *token = accountMgr.token;
    
    params[@"token"] = token;
    params[@"strEntityId"] = self.strEntityId;

    return params;
    
}

@end
