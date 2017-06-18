//
//  EPSaleBillingDeductionView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDeductionView.h"

@interface EPSaleBillingDeductionView () <UITextFieldDelegate>
{
    __weak IBOutlet UILabel *_deductionTypeLabel;
    __weak IBOutlet UITextField *_deductionTextField;
    __weak IBOutlet MFUIButton *_deductionTypeBtn;
}

@end

@implementation EPSaleBillingDeductionView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [_deductionTypeBtn addTarget:self action:@selector(onClickDeductionBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)onClickDeductionBtn
{
    if ([self.m_delegate respondsToSelector:@selector(onClickDeductionBtn:)]) {
        [self.m_delegate onClickDeductionBtn:self];
    }
}

- (IBAction)onClickAddBtn:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickAddBtn:)]) {
        [self.m_delegate onClickAddBtn:self];
    }
}


@end
