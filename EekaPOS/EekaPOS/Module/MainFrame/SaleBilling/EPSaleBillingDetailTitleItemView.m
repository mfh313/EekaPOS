//
//  EPSaleBillingDetailTitleItemView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/24.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDetailTitleItemView.h"

@interface EPSaleBillingDetailTitleItemView ()
{
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet MMOnePixLine *_topLineView;
}

@end

@implementation EPSaleBillingDetailTitleItemView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [_topLineView setHidden:YES];
}

-(void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

-(void)setTitleFont:(UIFont *)font
{
    _titleLabel.font = font;
}

-(void)setTopLineHidden:(BOOL)hidden
{
    [_topLineView setHidden:hidden];
}

@end
