//
//  EPEntitityService.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMService.h"

@interface EPEntitityService : MMService
{
    NSMutableArray *m_employees;
    NSMutableArray *m_sallers;
    NSMutableArray *m_brand;
}

-(void)getEntitityDetail;
-(void)getEntititySallers:(NSString *)strEntityId;
-(NSMutableArray *)getEntitityEmployees;
-(NSMutableArray *)getEntititySallerList;
-(NSNumber *)getEntitityFirstBrandId;


@end
