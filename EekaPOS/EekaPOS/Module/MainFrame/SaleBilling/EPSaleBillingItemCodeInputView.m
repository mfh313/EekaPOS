//
//  EPSaleBillingItemCodeInputView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingItemCodeInputView.h"

@interface EPSaleBillingItemCodeInputView () <UITextFieldDelegate>
{
    __weak IBOutlet UIImageView *_textFieldBgView;
    __weak IBOutlet UITextField *_itemCodeTextField;
}

@end

@implementation EPSaleBillingItemCodeInputView

-(void)awakeFromNib
{
    [super awakeFromNib];
    _textFieldBgView.image = MFImageStretchCenter(@"border");
    _itemCodeTextField.delegate = self;
    
}

-(void)setItemCode:(NSString *)itemCode
{
    _itemCodeTextField.text = itemCode;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [self endEditing:YES];
        [self onClickDoneBtn:nil];
        return NO;
    }
    
    return YES;
}


- (IBAction)onClickScanBtn:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickCameraScanBtn)]) {
        [self.m_delegate onClickCameraScanBtn];
    }
}

- (IBAction)onClickDoneBtn:(id)sender {
    NSString *itemCode = _itemCodeTextField.text;
    
    if ([self.m_delegate respondsToSelector:@selector(onInputSaleBillingItemCode:)]) {
        [self.m_delegate onInputSaleBillingItemCode:itemCode];
    }
}


@end
