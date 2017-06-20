//
//  EPSaleBillingGuidesCellView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/19.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingGuidesCellView.h"

@interface EPSaleBillingGuidesCellView ()
{
    __weak IBOutlet UILabel *_guidesLabel;
}

@end

@implementation EPSaleBillingGuidesCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapCashierLabel)];
    [self addGestureRecognizer:tapGes];
}

-(void)onTapCashierLabel
{
    if ([self.m_delegate respondsToSelector:@selector(onClickGuidesCellView)]) {
        [self.m_delegate onClickGuidesCellView];
    }
}

-(void)setGuidesString:(NSString *)string
{
    _guidesLabel.text = string;
}

@end
