//
//  EPApiManger.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EPApiManger : NSObject

+(NSString *)loginURL;

+(NSString *)getItemDetailURL;

+(NSString *)getEntitityDetailURL;

+(NSString *)getIndividualDetailURL;

+(NSString *)saveSaleBillingURL;

+(NSString *)getSaleBillingListURL;

@end
