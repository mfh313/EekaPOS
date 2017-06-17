//
//  EPMemberLoginApi.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPMemberLoginApi.h"

@interface EPMemberLoginApi ()
{
    NSString *_account;
    NSString *_password;
}

@end

@implementation EPMemberLoginApi

- (id)initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (self) {
        _account = username;
        _password = password;
    }
    return self;
}

-(NSString *)requestUrl
{
    return [EPApiManger loginUrl];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"account":_account,
             @"password":_password
             };
}

-(BOOL)loginSuccess
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
