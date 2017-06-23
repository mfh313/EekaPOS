//
//  EPSaleBillingDetailFooterView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/23.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDetailFooterView.h"

@interface EPSaleBillingDetailFooterView ()
{
    __weak IBOutlet UILabel *_printDateLabel;
}

@end

@implementation EPSaleBillingDetailFooterView

-(void)setPrintDate:(NSString *)printDate
{
    NSString *printDateString = [NSString stringWithFormat:@"打印日期：%@",printDate];
    
    _printDateLabel.text = printDateString;
}

@end
