//
//  EPSaleBillingGoodsCellView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingGoodsCellView.h"

@interface EPSaleBillingGoodsCellView ()
{
    __weak IBOutlet UILabel *_itemCodeLabel;
    __weak IBOutlet UILabel *_itemNameLabel;
    __weak IBOutlet UILabel *_remarkLabel;
    __weak IBOutlet UILabel *_discountAfterLabel;
    __weak IBOutlet UILabel *_discountPreLabel;
    __weak IBOutlet UILabel *_discountRateLabel;
}

@end

@implementation EPSaleBillingGoodsCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setItemCode:(NSString *)itemCode itemName:(NSString *)itemName
{
    _itemCodeLabel.text = itemCode;
    _itemNameLabel.text = itemName;
}

-(void)setRemarkString:(NSString *)remark
{
    _remarkLabel.text = remark;
}

-(void)setDiscountAfter:(NSString *)str
{
    _discountAfterLabel.text = str;
}

-(void)setDiscountPre:(NSString *)str
{
    _discountPreLabel.text = str;
}

-(void)setDiscountRate:(NSString *)str
{
    _discountRateLabel.text = str;
}

@end
