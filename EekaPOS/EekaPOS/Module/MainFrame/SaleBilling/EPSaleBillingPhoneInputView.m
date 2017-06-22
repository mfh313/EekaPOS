//
//  EPSaleBillingPhoneInputView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingPhoneInputView.h"

@interface EPSaleBillingPhoneInputView () <UITextFieldDelegate>
{
    __weak IBOutlet UITextField *_phoneTextField;
    __weak IBOutlet UILabel *_nameLabel;
}

@end

@implementation EPSaleBillingPhoneInputView

-(void)awakeFromNib
{
    [super awakeFromNib];
    _phoneTextField.delegate = self;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapCashierLabel)];
    [self addGestureRecognizer:tapGes];
}

-(void)onTapCashierLabel
{
    [_phoneTextField becomeFirstResponder];
}

-(void)setPhone:(NSString *)phone
{
    _phoneTextField.text = phone;
}

-(void)setName:(NSString *)name
{
    if ([MFStringUtil isBlankString:name]) {
        _nameLabel.text = nil;
        return;
    }
    
    _nameLabel.text = name;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = textField.text;
    
    NSString *regex = @"^[0-9]*$";
    NSString *phoneNumberRegex = MFPhoneNumberRegex; //手机号码
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    NSPredicate *phoneNumberPredicate = [NSPredicate predicateWithFormat:@"self matches %@", phoneNumberRegex];
    
    NSMutableString *resultString = [NSMutableString stringWithString:text];
    if (range.location <= resultString.length) {
        [resultString insertString:string atIndex:range.location];
    }
    
    BOOL result = [predicate evaluateWithObject:resultString];
    
    if (resultString.length > 11) {
        return NO;
    }
    
    if (result)
    {
        if ([phoneNumberPredicate evaluateWithObject:resultString]) {
            
            [textField resignFirstResponder];
            
            _phoneTextField.text = resultString;
            
            if ([self.m_delegate respondsToSelector:@selector(didInputPhone:)]) {
                [self.m_delegate didInputPhone:resultString];
            }
            
            return YES;
        }
    }
    
    return result;
}


@end
