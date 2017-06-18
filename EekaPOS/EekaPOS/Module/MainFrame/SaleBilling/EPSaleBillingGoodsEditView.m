//
//  EPSaleBillingGoodsEditView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingGoodsEditView.h"

@interface EPSaleBillingGoodsEditView ()
{
    __weak IBOutlet UIImageView *_bgImageView;
}

@end

@implementation EPSaleBillingGoodsEditView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _bgImageView.image = MFImageStretchCenter(@"round");
    self.backgroundColor = [UIColor hx_colorWithHexString:@"#000" alpha:0.3];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}



@end
