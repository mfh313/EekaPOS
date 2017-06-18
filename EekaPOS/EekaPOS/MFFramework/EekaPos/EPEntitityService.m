//
//  EPEntitityService.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPEntitityService.h"
#import "EPGetEntitityDetailApi.h"

#import "EPEntitityEmployeeModel.h"

@implementation EPEntitityService

- (instancetype)init
{
    self = [super init];
    if (self) {
        m_employees = [NSMutableArray array];
    }
    return self;
}

-(void)getEntitityDetail
{
    EPGetEntitityDetailApi *entitityDetailApi = [EPGetEntitityDetailApi new];
    [entitityDetailApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!entitityDetailApi.messageSuccess)
        {
            NSLog(@"%@",entitityDetailApi.errorMessage);
            return;
        }
        
        NSArray *employees = request.responseObject[@"employees"];
        NSLog(@"employees=%@",employees);
        
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        NSLog(@"%@",errorDesc);
    }];
    
}


@end
