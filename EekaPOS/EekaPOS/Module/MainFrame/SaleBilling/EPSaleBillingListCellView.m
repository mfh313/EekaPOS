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

-(void)setStatusString:(NSString *)status
{
    _statusLabel.text = status;
}

@end
