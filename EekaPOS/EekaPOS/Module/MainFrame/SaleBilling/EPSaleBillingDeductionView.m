//
//  EPSaleBillingDeductionView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDeductionView.h"
#import "TKeyBoardView.h"

@interface EPSaleBillingDeductionView () <UITextFieldDelegate>
{
    __weak IBOutlet UILabel *_deductionTypeLabel;
    __weak IBOutlet UITextField *_deductionTextField;
    __weak IBOutlet MFUIButton *_deductionTypeBtn;
    
    EPSaleBillingDeductionModel *_deductionModel;
    
    TKeyBoardView *_keyBoardView;
}

@end

@implementation EPSaleBillingDeductionView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [_deductionTypeBtn addTarget:self action:@selector(onClickDeductionBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _keyBoardView = [TKeyBoardView kBoardView];
    _keyBoardView.keyTextField = _deductionTextField;
    
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
