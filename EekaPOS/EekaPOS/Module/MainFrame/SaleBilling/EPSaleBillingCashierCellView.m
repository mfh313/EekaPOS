//
//  EPSaleBillingCashierCellView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingCashierCellView.h"

@interface EPSaleBillingCashierCellView ()
{
    __weak IBOutlet UILabel *_cashierLabel;
}

@end

@implementation EPSaleBillingCashierCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapCashierLabel)];
    _cashierLabel.userInteractionEnabled = YES;
    [_cashierLabel addGestureRecognizer:tapGes];
}

-(void)onTapCashierLabel
{
    if ([self.m_delegate respondsToSelector:@selector(onClickCashierCellView)]) {
        [self.m_delegate onClickCashierCellView];
    }
}

-(void)setCashierString:(NSString *)string
{
    _cashierLabel.text = string;
}

@end
