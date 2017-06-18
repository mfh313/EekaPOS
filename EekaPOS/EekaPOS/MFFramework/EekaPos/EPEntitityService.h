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
}

-(void)getEntitityDetail;

@end
