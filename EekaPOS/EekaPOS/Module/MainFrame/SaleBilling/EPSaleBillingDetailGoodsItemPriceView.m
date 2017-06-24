//
//  EPSaleBillingDetailGoodsItemPriceView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/24.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDetailGoodsItemPriceView.h"

@interface EPSaleBillingDetailGoodsItemPriceView ()
{
    __weak IBOutlet UILabel *_itemCodeLabel;
    __weak IBOutlet UILabel *_numberLabel;
    __weak IBOutlet UILabel *_listPriceLabel;
    __weak IBOutlet UILabel *_discountPriceLabel;
}

@end

@implementation EPSaleBillingDetailGoodsItemPriceView

-(void)setItemCode:(NSString *)itemCode
            number:(NSString *)number
         listPrice:(NSString *)listPrice
     discountPrice:(NSString *)discountPrice
{
    _itemCodeLabel.text = itemCode;
    _numberLabel.text = number;
    _listPriceLabel.text = listPrice;
    _discountPriceLabel.text = discountPrice;
}

@end
