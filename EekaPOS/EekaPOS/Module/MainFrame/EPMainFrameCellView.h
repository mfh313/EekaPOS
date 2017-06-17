//
//  EPMainFrameCellView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

typedef void(^onClickMainFrameCellBlock)();

@interface EPMainFrameCellView : MMUIBridgeView

@property (nonatomic,copy) onClickMainFrameCellBlock clickBlock;

-(void)setContentView:(UIImage *)iconImage desc:(NSString *)desc;

@end
