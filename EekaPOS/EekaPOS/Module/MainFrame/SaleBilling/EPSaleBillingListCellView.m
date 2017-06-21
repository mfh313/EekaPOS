//
//  EPSaleBillingListCellView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingListCellView.h"

@interface EPSaleBillingListCellView ()
{
    __weak IBOutlet UILabel *_namesLabel;
    __weak IBOutlet UILabel *_moneyLabel;
    __weak IBOutlet UILabel *_timeLabel;
    __weak IBOutlet UILabel *_statusLabel;
}

@end

@implementation EPSaleBillingListCellView

-(void)setNames:(NSString *)names
{
    _namesLabel.text = names;
}

-(void)setTimeString:(NSString *)time
{
    _timeLabel.text = time;
}

-(void)setMoneyString:(NSString *)money
{
    _moneyLabel.text = money;
}

-(void)setStatus:(int)status
{
    NSString *statusString = nil;
    UIColor *textColor = nil;
    
    if (status == 10) {
        statusString = @"未开单";
        textColor = [UIColor hx_colorWithHexString:@"ea3d2e"];
    }
    else if(status == 20)
    {
        statusString = @"已开单";
        textColor = [UIColor hx_colorWithHexString:@"989898"];
    }
    else if(status == 30)
    {
        statusString = @"已收款";
        textColor = [UIColor hx_colorWithHexString:@"989898"];
    }
    
    _statusLabel.textColor = textColor;
    [self setStatusString:statusString];
}

-(void)setStatusString:(NSString *)status
{
    _statusLabel.text = status;
}

@end
