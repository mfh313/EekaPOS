//
//  EPSaleBillingMainFooterView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/30.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingMainFooterView.h"

@interface EPSaleBillingMainFooterView ()
{
    __weak IBOutlet UILabel *_receivablePriceLabel;
}

@end

@implementation EPSaleBillingMainFooterView

-(void)setReceivablePrice:(NSString *)receivablePrice
{
    _receivablePriceLabel.text = receivablePrice;
}

- (IBAction)onClickScanBtn:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickCameraScanBtn)]) {
        [self.m_delegate onClickCameraScanBtn];
    }
}

- (IBAction)onClickSaveBtn:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickSaveBillingBtn)]) {
        [self.m_delegate onClickSaveBillingBtn];
    }
}

@end
