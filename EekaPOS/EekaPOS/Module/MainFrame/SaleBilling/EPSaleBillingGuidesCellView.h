//
//  EPSaleBillingGuidesCellView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol EPSaleBillingGuidesCellViewDelegate <NSObject>

@optional
-(void)onClickGuidesCellView;

@end

@interface EPSaleBillingGuidesCellView : MMUIBridgeView

@property(nonatomic,weak) id<EPSaleBillingGuidesCellViewDelegate> m_delegate;

-(void)setGuidesString:(NSString *)string;

@end
