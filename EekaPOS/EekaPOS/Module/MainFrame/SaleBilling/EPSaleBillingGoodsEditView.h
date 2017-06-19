//
//  EPSaleBillingGoodsEditView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@class EPSaleBillingItemModel;
@protocol EPSaleBillingGoodsEditViewDelegate <NSObject>

@optional
-(void)editGoodsWithSize:(NSNumber *)size rate:(NSNumber *)rate remark:(NSString *)remark itemModel:(EPSaleBillingItemModel *)itemModel;

@end

@interface EPSaleBillingGoodsEditView : MMUIBridgeView

@property (nonatomic,strong) EPSaleBillingItemModel *itemModel;
@property (nonatomic,weak) id<EPSaleBillingGoodsEditViewDelegate> m_delegate;

-(void)setItemCode:(NSString *)itemCode;

-(void)setItemName:(NSString *)itemName;

-(void)setItemSize:(NSNumber *)size;

-(void)setDiscount:(NSNumber *)discountNumber;

-(void)setRemarkString:(NSString *)remark;

@end
