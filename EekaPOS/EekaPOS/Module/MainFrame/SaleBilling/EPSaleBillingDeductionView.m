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
    __weak IBOutlet MFUIButton *_deductionTypeBtn;
    
    EPSaleBillingDeductionModel *_deductionModel;
    
    
}

@end

@implementation EPSaleBillingDeductionView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [_deductionTypeBtn addTarget:self action:@selector(onClickDeductionBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _deductionTextField.ry_inputType = RYIntInputType;
    RYNumberKeyboard *rateKeyBoard = (RYNumberKeyboard *)_deductionTextField.inputView;
    rateKeyBoard.ryDelegate = self;
    rateKeyBoard.inputType = RYIntInputType;
    
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
}

-(void)setDeductionTypeName:(NSString *)type
{
    _deductionTypeLabel.text = type;
}

-(void)onClickDeductionBtn
{
    if ([self.m_delegate respondsToSelector:@selector(onClickDeductionBtn:deductionModel:)]) {
        [self.m_delegate onClickDeductionBtn:self deductionModel:_deductionModel];
    }
}

- (IBAction)onClickAddBtn:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickAddBtn:deductionModel:)]) {
        [self.m_delegate onClickAddBtn:self deductionModel:_deductionModel];
    }
}


@end
