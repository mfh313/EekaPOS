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
    
    _discountPreLabel.textColor = [UIColor lightGrayColor];
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

-(void)setDiscountRate:(NSNumber *)rate discountPreNumber:(NSNumber *)number
{
    [self setDiscountRate:rate];
    
    CGFloat rateAfter = (rate.floatValue) * (number.floatValue);
    
    [self setDiscountAfterNumber:@(rateAfter)];
    [self setDiscountPreNumber:number];
}

-(void)setDiscountAfterNumber:(NSNumber *)number
{
    _discountAfterLabel.text = [EPSaleBillingHelper moneyDescWithNumber:number];
}

-(void)setDiscountPreNumber:(NSNumber *)number
{
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:[EPSaleBillingHelper moneyDescWithNumber:number]];
    [price addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, price.length)];
    
    _discountPreLabel.attributedText = price;

}

-(void)setDiscountRate:(NSNumber *)rate
{
    _discountRateLabel.text = [MFStringUtil floatStringWithTwoPoint:rate.floatValue];
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
