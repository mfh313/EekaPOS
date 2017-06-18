//
//  EPSaleBillingDiscountInputView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDiscountInputView.h"

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
    _discountRateLabel.text = @"1.0";
}



@end
