//
//  MFStringUtil.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFStringUtil : NSObject

+(BOOL)isBlankString:(NSString *)string;

+(BOOL)isPhoneString:(NSString *)string;

+(NSString *)URLEncodedString:(NSString *)str;

+(NSString *)URLDecodedString:(NSString *)str;

@end
