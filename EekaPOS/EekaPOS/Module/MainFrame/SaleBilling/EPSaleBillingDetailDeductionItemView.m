//
//  EPSaleBillingDetailDeductionItemView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/24.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDetailDeductionItemView.h"

@interface EPSaleBillingDetailDeductionItemView ()
{
    __weak IBOutlet UILabel *_typeNameLabel;
    __weak IBOutlet UILabel *_valueLabel;
}

@end

@implementation EPSaleBillingDetailDeductionItemView

-(void)setTypeName:(NSString *)typeName value:(NSString *)value
{
    _typeNameLabel.text = typeName;
    _valueLabel.text = value;
}

@end
