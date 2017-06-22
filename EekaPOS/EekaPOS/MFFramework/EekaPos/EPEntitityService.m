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
#import "EPGetSallerListApi.h"

@implementation EPEntitityService

- (instancetype)init
{
    self = [super init];
    if (self) {
        m_employees = [NSMutableArray array];
        m_sallers = [NSMutableArray array];
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
        
        m_brand = [NSMutableArray arrayWithArray:request.responseObject[@"brands"]];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        NSLog(@"%@",errorDesc);
    }];
    
}

-(void)getEntititySallers:(NSString *)strEntityId
{
    EPGetSallerListApi *sallerListApi = [EPGetSallerListApi new];
    sallerListApi.strEntityId = strEntityId;
    [sallerListApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!sallerListApi.messageSuccess)
        {
            NSLog(@"%@",sallerListApi.errorMessage);
            return;
        }
        
        [m_sallers removeAllObjects];
        NSArray *employees = request.responseObject[@"mainData"];
        for (int i = 0; i < employees.count; i++) {
            EPEntitityEmployeeModel *model = [EPEntitityEmployeeModel MM_modelWithDictionary:employees[i]];
            [m_sallers addObject:model];
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
    return m_sallers;
}

-(NSNumber *)getEntitityFirstBrandId
{
    return m_brand.firstObject[@"brandID"];
}

@end
