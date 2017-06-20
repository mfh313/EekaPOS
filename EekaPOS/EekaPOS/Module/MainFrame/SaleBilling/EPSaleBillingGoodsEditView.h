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
-(void)editGoodsWithitemModel:(EPSaleBillingItemModel *)itemModel
                         size:(NSNumber *)size
                         rate:(NSNumber *)rate
            isSpecialDiscount:(BOOL)isSpecialDiscount
                       remark:(NSString *)remark;

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
