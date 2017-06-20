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
        
        [m_employees removeAllObjects];
        NSArray *employees = request.responseObject[@"employees"];
        for (int i = 0; i < employees.count; i++) {
            EPEntitityEmployeeModel *model = [EPEntitityEmployeeModel MM_modelWithDictionary:employees[i]];
            [m_employees addObject:model];
        }
        
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        NSLog(@"%@",errorDesc);
    }];
    
}

-(NSMutableArray *)getEntitityEmployees
{
    return m_employees;
}


-(NSMutableArray *)getEntititySallerList
{
    return m_employees;
}

/*
 
 -(void)getIndividual:(NSString *)telephone
 {
 __weak typeof(self) weakSelf = self;
 
 EPGetIndividualApi *getIndividualApi = [EPGetIndividualApi new];
 getIndividualApi.brandId = @(1001);
 getIndividualApi.telephone = telephone;
 
 [getIndividualApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
 
 if (!getIndividualApi.messageSuccess) {
 [self showTips:getIndividualApi.errorMessage];
 return;
 }
 
 __strong typeof(weakSelf) strongSelf = weakSelf;
 
 
 } failure:^(YTKBaseRequest * request) {
 NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
 [self showTips:errorDesc];
 }];
 }
 
 */

@end
