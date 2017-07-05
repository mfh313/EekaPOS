//
//  EPSaleBillingDetailGoodsItemView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/23.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDetailGoodsItemView.h"
#import "EPSaleBillingDetailGoodsItemPriceView.h"
#import "EPSaleBillingItemModel.h"

@interface EPSaleBillingDetailGoodsItemView ()
{
    __weak IBOutlet EPSaleBillingDetailGoodsItemPriceView *_priceView;
    
    __weak IBOutlet UILabel *_discountLabel;
    __weak IBOutlet UILabel *_remarkLabel;
}

@end

@implementation EPSaleBillingDetailGoodsItemView

-(void)setSaleBillingItemModel:(EPSaleBillingItemModel *)itemModel
{
    if (!itemModel.number) {
        itemModel.number = @(1);
    }
    
    [_priceView setItemCode:itemModel.itemCode
                     number:[NSString stringWithFormat:@"%@",itemModel.number]
                  listPrice:[NSString stringWithFormat:@"%.2f",itemModel.listPrice.floatValue]
              discountPrice:[NSString stringWithFormat:@"%.2f",itemModel.receivablePrice.floatValue]];
    
    
    _discountLabel.text = [NSString stringWithFormat:@"折扣：%.4f",itemModel.discount.floatValue];
    
    if (![MFStringUtil isBlankString:itemModel.remarks]) {
        _remarkLabel.text = [NSString stringWithFormat:@"备注：%@",itemModel.remarks];
    }
    else
    {
        _remarkLabel.text = nil;
    }
    
    BOOL refund = (itemModel.number.floatValue < 0 ? YES : NO);
    [self setIsRefund:refund];
    
}

-(void)setIsRefund:(BOOL)refund
{
    if (refund)
    {
        self.backgroundColor = [UIColor hx_colorWithHexString:@"ff6868"];
    }
    else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
}


@end
