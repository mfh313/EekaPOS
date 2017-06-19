//
//  EPSaleBillingDiscountInputView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDiscountInputView.h"
#import "EPSaleBillingHelper.h"

@interface EPSaleBillingDiscountInputView () <UITextFieldDelegate>
{
    __weak IBOutlet UILabel *_discountAfterLabel;
    __weak IBOutlet UILabel *_discountPreLabel;
    __weak IBOutlet UILabel *_discountRateLabel;
    __weak IBOutlet UITextField *_discountInputTextField;
    
}

@end

@implementation EPSaleBillingDiscountInputView

-(void)awakeFromNib
{
    [super awakeFromNib];
    _discountAfterLabel.textColor = [UIColor hx_colorWithHexString:@"0080C0"];
    _discountInputTextField.text = @"1.0";
    _discountRateLabel.text = @"1.0";
}

-(void)setDiscountRate:(NSNumber *)discountRate
{
    _discountRateLabel.text = [NSString stringWithFormat:@"%@",discountRate];
    _discountInputTextField.text = [NSString stringWithFormat:@"%@",discountRate];
}

-(void)setReceivablePrice:(NSNumber *)receivablePrice allPrice:(NSNumber *)discountPre
{
    _discountAfterLabel.text = [NSString stringWithFormat:@"%@",[EPSaleBillingHelper moneyDescWithNumber:receivablePrice]];
    
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:[EPSaleBillingHelper moneyDescWithNumber:discountPre]];
    [price addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, price.length)];
    _discountPreLabel.attributedText = price;
}

@end
