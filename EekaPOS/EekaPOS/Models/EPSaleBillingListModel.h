//
//  EPSaleBillingListModel.h
//  EekaPOS
//
//  Created by EEKA on 2017/7/4.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPSaleBillingListModel : NSObject

@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSNumber *money;
@property (nonatomic,assign) BOOL isExpand;

@end
