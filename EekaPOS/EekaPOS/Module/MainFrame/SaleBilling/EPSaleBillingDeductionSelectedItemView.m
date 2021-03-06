//
//  EPSaleBillingDeductionSelectedItemView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDeductionSelectedItemView.h"
#import "EPSaleBillingHelper.h"

@interface EPSaleBillingDeductionSelectedItemView ()
{
    __weak IBOutlet UIButton *_typeBtn;
    __weak IBOutlet UILabel *_typeNameLabel;
    __weak IBOutlet UILabel *_deductionValueLabel;
    
}

@end

@implementation EPSaleBillingDeductionSelectedItemView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [_typeBtn setImage:MFImage(@"sale4") forState:UIControlStateNormal];
}

-(void)setDeductionItemModel:(EPSaleBillingDeductionModel *)model
{
    _typeNameLabel.text = model.name;
    _deductionValueLabel.text = [EPSaleBillingHelper moneyDescWithNumber:model.value];
}

@end
