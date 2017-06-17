//
//  EPSaleBillingItemCodeInputView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingItemCodeInputView.h"

@interface EPSaleBillingItemCodeInputView ()
{
    
}

@end

@implementation EPSaleBillingItemCodeInputView

- (IBAction)onClickScanBtn:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(onClickCameraScanBtn)]) {
        [self.m_delegate onClickCameraScanBtn];
    }
}

- (IBAction)onClickDoneBtn:(id)sender {
    
}


@end
