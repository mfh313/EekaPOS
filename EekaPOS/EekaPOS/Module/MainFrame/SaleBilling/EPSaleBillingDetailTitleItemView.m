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
}

@end

@implementation EPSaleBillingDetailTitleItemView

-(void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

-(void)setTitleFont:(UIFont *)font
{
    _titleLabel.font = font;
}

@end
