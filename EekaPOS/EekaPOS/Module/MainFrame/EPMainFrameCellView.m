//
//  EPMainFrameCellView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPMainFrameCellView.h"

@interface EPMainFrameCellView ()
{
    __weak IBOutlet UIButton *_iconBtn;
    __weak IBOutlet UILabel *_nameLabel;
}

@end

@implementation EPMainFrameCellView

-(void)setContentView:(UIImage *)iconImage desc:(NSString *)desc
{
    [_iconBtn setImage:iconImage forState:UIControlStateNormal];
    _nameLabel.text = desc;
}

@end
