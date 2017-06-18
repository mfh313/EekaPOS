//
//  EPSaleBillingGoodsEditView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol EPSaleBillingGoodsEditViewDelegate <NSObject>

@optional


@end

@interface EPSaleBillingGoodsEditView : MMUIBridgeView

@property (nonatomic,weak) id<EPSaleBillingGoodsEditViewDelegate> m_delegate;

@end
