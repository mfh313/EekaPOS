//
//  EPSaleBillingDeductionView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDeductionView.h"
#import "RYNumberkeyboard.h"
#import "UITextField+RYNumberKeyboard.h"

@interface EPSaleBillingDeductionView () <UITextFieldDelegate,RYNumberKeyboardDelegate>
{
    __weak IBOutlet UILabel *_deductionTypeLabel;
    __weak IBOutlet UITextField *_deductionTextField;

    __weak IBOutlet UIView *_typeNameView;
    __weak IBOutlet UIView *_deductionValueView;
    
    EPSaleBillingDeductionModel *_deductionModel;
}

@end

@implementation EPSaleBillingDeductionView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *typeNameGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickDeductionBtn)];
    [_typeNameView addGestureRecognizer:typeNameGes];
    
    UITapGestureRecognizer *valueGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickDeductionValue)];
    [_deductionValueView addGestureRecognizer:valueGes];
    
    _deductionTextField.ry_inputType = RYFloat2DigitInputType;
    RYNumberKeyboard *rateKeyBoard = (RYNumberKeyboard *)_deductionTextField.inputView;
    rateKeyBoard.ryDelegate = self;
    rateKeyBoard.inputType = RYFloat2DigitInputType;
}

- (void)ryNumberKeyboardValueChange:(NSString *)string tag:(NSInteger)tag
{
    _deductionModel.value = @(string.floatValue);
}

- (void)ryNumberKeyboardSubmit:(NSString *)string tag:(NSInteger)tag
{
    _deductionModel.value = @(string.floatValue);
}

-(void)setDeductionMode:(EPSaleBillingDeductionModel *)deductionModel
{
    _deductionModel = deductionModel;
    
    [self setDeductionTypeName:deductionModel.name];
    
    if (deductionModel.value) {
        _deductionTextField.text = [MFStringUtil floatStringWithTwoPoint:deductionModel.value.floatValue];
    }
    else
    {
        _deductionTextField.text = nil;
    }
}

-(void)setDeductionTypeName:(NSString *)type
{
    if (!type) {
        _deductionTypeLabel.text = @"请点击选择";
        _deductionTypeLabel.textColor = [UIColor hx_colorWithHexString:@"686868"];
        return;
    }
    
    _deductionTypeLabel.text = type;
    _deductionTypeLabel.textColor = [UIColor hx_colorWithHexString:@"282828"];
}

-(void)onClickDeductionValue
{
    [_deductionTextField becomeFirstResponder];
}

-(void)onClickDeductionBtn
{
    if ([self.m_delegate respondsToSelector:@selector(onClickDeductionBtn:deductionModel:)]) {
        [self.m_delegate onClickDeductionBtn:self deductionModel:_deductionModel];
    }
}

- (IBAction)onClickAddBtn:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickAddBtn:deductionModel:)]) {

        [self.m_delegate onClickAddBtn:self deductionModel:[_deductionModel copy]];
    }
}


@end
