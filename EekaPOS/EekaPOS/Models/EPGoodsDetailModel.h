//
//  EPGoodsDetailModel.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPGoodsDetailModel : NSObject

@property (nonatomic,strong) NSNumber *adjustPrice;
@property (nonatomic,strong) NSNumber *brandID;
@property (nonatomic,strong) NSNumber *color;
@property (nonatomic,strong) NSString *colorName;
@property (nonatomic,strong) NSNumber *entityID;
@property (nonatomic,strong) NSString *itemCode;
@property (nonatomic,strong) NSNumber *itemId;
@property (nonatomic,strong) NSString *itemName;
@property (nonatomic,strong) NSNumber *listPrice;
@property (nonatomic,strong) NSNumber *size;
@property (nonatomic,strong) NSNumber *stdItemID;
@property (nonatomic,strong) NSString *uMCode;

@property (nonatomic,assign) int currentTimeMs;

@end


