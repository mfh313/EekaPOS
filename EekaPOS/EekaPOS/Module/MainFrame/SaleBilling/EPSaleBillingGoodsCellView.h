//
//  EPSaleBillingGoodsCellView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "EPSaleBillingItemModel.h"

@protocol EPSaleBillingGoodsCellViewDelegate <NSObject>

@optional
-(void)onClickGoodsCellView:(EPSaleBillingItemModel *)itemModel;

@end


@interface EPSaleBillingGoodsCellView : MMUIBridgeView

@property(nonatomic,strong) EPSaleBillingItemModel *itemModel;
@property(nonatomic,weak) id<EPSaleBillingGoodsCellViewDelegate> m_delegate;

-(void)setItemCode:(NSString *)itemCode itemName:(NSString *)itemName;

-(void)setRemarkString:(NSString *)remark;

-(void)setDiscountAfterNumber:(NSNumber *)number;

-(void)setDiscountPreNumber:(NSNumber *)number;

-(void)setDiscountRate:(NSNumber *)rate;

-(void)setDiscountAfter:(NSString *)str;

-(void)setDiscountPre:(NSString *)str;

-(void)setDiscountRateString:(NSString *)str;

@end
