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
    CGFloat discountFloat = itemModel.listPrice.floatValue * itemModel.discount.floatValue * itemModel.number.floatValue;
    
    [_priceView setItemCode:itemModel.itemCode
                     number:[NSString stringWithFormat:@"%@",itemModel.number]
                  listPrice:[NSString stringWithFormat:@"%.1f",itemModel.listPrice.floatValue]
              discountPrice:[NSString stringWithFormat:@"%.1f",discountFloat]];
    
    _discountLabel.text = [NSString stringWithFormat:@"折扣：.%4f",itemModel.discount.floatValue];
    
    if (itemModel.remarks) {
        _remarkLabel.text = [NSString stringWithFormat:@"备注：%@",itemModel.remarks];
    }
    else
    {
        _remarkLabel.text = nil;
    }
    
}


@end
