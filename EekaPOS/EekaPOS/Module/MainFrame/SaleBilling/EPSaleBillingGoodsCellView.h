//
//  EPSaleBillingGoodsCellView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "EPGoodsDetailModel.h"

@protocol EPSaleBillingGoodsCellViewDelegate <NSObject>

@optional
-(void)onClickGoodsCellView:(EPGoodsDetailModel *)goodsModel;

@end

@interface EPSaleBillingGoodsCellView : MMUIBridgeView

@property(nonatomic,strong) EPGoodsDetailModel *goodsModel;
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
