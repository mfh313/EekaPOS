//
//  EPSaleBillingGoodsRemarkSelectView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/21.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingGoodsRemarkSelectView.h"
#import "EPSaleBillingHelper.h"

@interface EPSaleBillingGoodsRemarkSelectView ()
{
    __weak IBOutlet UIImageView *_bgImageView;
        
    __weak IBOutlet UIView *_bgTapView;
    
}

@end

@implementation EPSaleBillingGoodsRemarkSelectView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _bgImageView.image = MFImageStretchCenter(@"round");
    self.backgroundColor = [UIColor hx_colorWithHexString:@"#000" alpha:0.3];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [_bgTapView addGestureRecognizer:tapGes];
}

-(void)onTap
{
    [self removeFromSuperview];
}

- (IBAction)onClickBtn:(id)sender
{
    NSString *title = ((UIButton *)sender).titleLabel.text;
    BOOL isNegative = [self isNegativeForRemark:title];
    
    if ([self.m_delegate respondsToSelector:@selector(didSelectRemark:isNegative:)]) {
        [self.m_delegate didSelectRemark:title isNegative:isNegative];
    }
    
    [self removeFromSuperview];
}

-(BOOL)isNegativeForRemark:(NSString *)remark
{
    return [remark isEqualToString:@"退货"];
}


@end
