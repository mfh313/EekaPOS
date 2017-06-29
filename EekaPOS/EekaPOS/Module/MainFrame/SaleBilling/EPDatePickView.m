//
//  EPDatePickView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/29.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPDatePickView.h"
#import "EPSaleBillingHelper.h"

@interface EPDatePickView ()
{
    __weak IBOutlet UIView *_bgTapView;
    __weak IBOutlet UIImageView *_bgImageView;
    __weak IBOutlet UIDatePicker *_datePicker;
}

@end

@implementation EPDatePickView



-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor hx_colorWithHexString:@"#000" alpha:0.3];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _bgImageView.image = MFImageStretchCenter(@"round");
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.timeZone = [[self class] timeZone];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [_bgTapView addGestureRecognizer:tapGes];
}

-(void)onTap
{
    [self removeFromSuperview];
}

+(NSTimeZone *)timeZone
{
    return [NSTimeZone timeZoneWithName:@"GMT"];
}

+(NSDate *)dateWithTime:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[[self class] timeZone]];
    NSDate *date = [formatter dateFromString:dateStr];
    
    if (date == nil) {
        NSString *defaultDateString = [formatter stringFromDate:[NSDate date]];
        date = [formatter dateFromString:defaultDateString];
    }
    
    return date;
}

-(void)setDatePickString:(NSString *)time
{
    NSDate *date = [[self class] dateWithTime:time];
    [_datePicker setDate:date animated:NO];
}

- (IBAction)onClickDoneBtn:(id)sender {
    NSDate *selectDate = _datePicker.date;
    NSString *dateString = [EPSaleBillingHelper yMDdateStringWithDate:selectDate];
    if ([self.m_delegate respondsToSelector:@selector(datePickerViewDidSelected:viewKey:datePickView:)])
    {
        [self.m_delegate datePickerViewDidSelected:dateString viewKey:self.viewKey datePickView:self];
    }
}

@end
