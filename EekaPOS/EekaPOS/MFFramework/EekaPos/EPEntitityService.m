//
//  EPEntitityService.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPEntitityService.h"
#import "EPGetEntitityDetailApi.h"

@implementation EPEntitityService

-(void)getEntitityDetail
{
    EPGetEntitityDetailApi *entitityDetailApi = [EPGetEntitityDetailApi new];
    [entitityDetailApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!entitityDetailApi.messageSuccess)
        {
            NSLog(@"%@",entitityDetailApi.errorMessage);
            return;
        }
        
        
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        NSLog(@"%@",errorDesc);
    }];
    
}

@end
