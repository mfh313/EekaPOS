//
//  EPSaleBillingPhoneInputView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingPhoneInputView.h"

@interface EPSaleBillingPhoneInputView ()
{
    __weak IBOutlet UITextField *_phoneTextField;
}

@end

@implementation EPSaleBillingPhoneInputView

-(void)setPhone:(NSString *)phone
{
    _phoneTextField.text = phone;
}


@end
