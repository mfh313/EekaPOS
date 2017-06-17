//
//  EPMemberLoginApi.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFNetworkRequest.h"

@interface EPMemberLoginApi : MFNetworkRequest

- (id)initWithUsername:(NSString *)username password:(NSString *)password;

- (BOOL)loginSuccess;

- (NSString*)errorMessage;

@end
