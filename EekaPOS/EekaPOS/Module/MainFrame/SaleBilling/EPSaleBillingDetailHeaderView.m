//
//  EPSaleBillingDetailHeaderView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/22.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDetailHeaderView.h"
#import "TTTAttributedLabel.h"
#import "EPSaleBillingModel.h"

@interface EPSaleBillingDetailHeaderView ()
{
    TTTAttributedLabel *_contentLabel;
    
    __weak IBOutlet UILabel *_storeNameLabel;
    __weak IBOutlet UILabel *_sellDateLabel;
    __weak IBOutlet UILabel *_guiderLabel;
    __weak IBOutlet UILabel *_cashierLabel;
    
}

@end

@implementation EPSaleBillingDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentLabel = [[TTTAttributedLabel alloc] initWithFrame:self.bounds];
        _contentLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_contentLabel];
    }
    
    return self;
}

-(void)setSaleBillingModel:(EPSaleBillingModel *)model
{
    [self setStoreName:model.storeName
              sellDate:model.sellDate
                guider:model.guider
               cashier:model.cashier];
}

-(void)setStoreName:(NSString *)storeName
           sellDate:(NSString *)sellDate
             guider:(NSString *)guider
            cashier:(NSString *)cashier
{
    NSString *storeNameString = [NSString stringWithFormat:@"店铺：%@",storeName];
    NSString *sellDateString = [NSString stringWithFormat:@"销售日期：%@",sellDate];
    NSString *guiderString = [NSString stringWithFormat:@"导购员：%@",guider];
    NSString *cashierString = [NSString stringWithFormat:@"收银员：%@",cashier];
    
    [_contentLabel setAttributedText:nil];
    
}


+(NSMutableAttributedString *)headerSizeForSaleBillingModel:(EPSaleBillingModel *)SaleBillingModel
{
    return nil;
}

@end
