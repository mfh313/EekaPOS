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
    __weak IBOutlet UIImageView *_typeImageView;
    __weak IBOutlet UILabel *_typeNameLabel;
    __weak IBOutlet UILabel *_deductionValueLabel;
    
}

@end

@implementation EPSaleBillingDeductionSelectedItemView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _typeImageView.image = MFImage(@"sale1");
    _typeNameLabel.text = @"抹零";
    _deductionValueLabel.text = [EPSaleBillingHelper moneyDescWithNumber:@(10.0)];
}

@end
