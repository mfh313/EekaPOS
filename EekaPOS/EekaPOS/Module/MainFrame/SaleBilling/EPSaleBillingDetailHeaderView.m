//
//  EPSaleBillingDetailHeaderView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/22.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDetailHeaderView.h"
#import "EPSaleBillingModel.h"

@interface EPSaleBillingDetailHeaderView ()
{
    __weak IBOutlet UILabel *_storeNameLabel;
    __weak IBOutlet UILabel *_sellDateLabel;
    __weak IBOutlet UILabel *_guiderLabel;
    __weak IBOutlet UILabel *_cashierLabel;
    
}

@end

@implementation EPSaleBillingDetailHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
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
    
    _storeNameLabel.text = storeNameString;
    _sellDateLabel.text = sellDateString;
    _guiderLabel.text = guiderString;
    _cashierLabel.text = cashierString;
    
}

-(CGFloat)headerHeightForSaleBillingModel:(EPSaleBillingModel *)model
{
    [_cashierLabel sizeToFit];
    [_guiderLabel sizeToFit];
    
    return 75 + MAX(CGRectGetHeight(_cashierLabel.frame), CGRectGetHeight(_guiderLabel.frame)) + 30;
}

@end
