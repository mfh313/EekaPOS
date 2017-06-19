//
//  EPSaleBillingGoodsCellView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingGoodsCellView.h"
#import "EPSaleBillingHelper.h"

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
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGoodsCellView)];
    [self addGestureRecognizer:tapGes];
}

-(void)onTapGoodsCellView
{
    if ([self.m_delegate respondsToSelector:@selector(onClickGoodsCellView:)]) {
        [self.m_delegate onClickGoodsCellView:self.itemModel];
    }
}

-(void)setItemCode:(NSString *)itemCode itemName:(NSString *)itemName
{
    _itemCodeLabel.text = itemCode;
    _itemNameLabel.text = itemName;
}

-(void)setRemarkString:(NSString *)remark
{
    NSString *stringHeader = @"备注：";
    if (!remark) {
        _remarkLabel.text = [stringHeader stringByAppendingString:@"无"];
        return;
    }
    
    _remarkLabel.text = [stringHeader stringByAppendingString:remark];
}

-(void)setDiscountAfterNumber:(NSNumber *)number
{
    _discountAfterLabel.text = [EPSaleBillingHelper moneyDescWithNumber:number];
}

-(void)setDiscountPreNumber:(NSNumber *)number
{
    _discountPreLabel.text = [EPSaleBillingHelper moneyDescWithNumber:number];
}

-(void)setDiscountRate:(NSNumber *)rate
{
    _discountRateLabel.text = [NSString stringWithFormat:@"%@",rate];
}

-(void)setDiscountAfter:(NSString *)str
{
    _discountAfterLabel.text = str;
}

-(void)setDiscountPre:(NSString *)str
{
    _discountPreLabel.text = str;
}

-(void)setDiscountRateString:(NSString *)str
{
    _discountRateLabel.text = str;
}

@end
