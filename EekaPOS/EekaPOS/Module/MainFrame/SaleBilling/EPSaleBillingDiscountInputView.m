//
//  EPSaleBillingDiscountInputView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDiscountInputView.h"
#import "EPSaleBillingHelper.h"
#import "RYNumberkeyboard.h"
#import "UITextField+RYNumberKeyboard.h"

@interface EPSaleBillingDiscountInputView () <UITextFieldDelegate,RYNumberKeyboardDelegate>
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
    
    _discountInputTextField.ry_inputType = RYFloatZeroToOneInputType;
    RYNumberKeyboard *rateKeyBoard = (RYNumberKeyboard *)_discountInputTextField.inputView;
    rateKeyBoard.ryDelegate = self;
    rateKeyBoard.inputType = RYFloatZeroToOneInputType;
    _discountInputTextField.tag = 1101;
}

- (void)ryNumberKeyboardValueChange:(NSString *)string tag:(NSInteger)tag
{
    if (tag == 1100) {
        
    }
    else if (tag == 1101) {
        
    }
}

- (void)ryNumberKeyboardSubmit:(NSString *)string tag:(NSInteger)tag
{
    if ([self.m_delegate respondsToSelector:@selector(didSetDiscount:)]) {
        [self.m_delegate didSetDiscount:[EPSaleBillingHelper roundFloat:string.floatValue]];
    }
}

-(void)setDiscountRate:(NSNumber *)discountRate
{
    _discountInputTextField.text = [MFStringUtil floatStringWithTwoPoint:discountRate.floatValue];
    
    [ZHKeyboardAvoiding setAvoidingView:_discountInputTextField  moveView:[self MFViewController].view offset:20];
}

-(void)setReceivablePrice:(NSNumber *)receivablePrice allPrice:(NSNumber *)discountPre
{
    _discountAfterLabel.text = [NSString stringWithFormat:@"%@",[EPSaleBillingHelper moneyDescWithNumber:receivablePrice]];
    
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:[EPSaleBillingHelper moneyDescWithNumber:discountPre]];
    [price addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, price.length)];
    _discountPreLabel.attributedText = price;
}

@end
