//
//  EPSaleBillingListSectionView.m
//  EekaPOS
//
//  Created by EEKA on 2017/7/4.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingListSectionView.h"

@interface EPSaleBillingListSectionView () <CAAnimationDelegate>
{
    __weak IBOutlet UIButton *_arrowBtn;
    __weak IBOutlet UILabel *_timeLabel;
    __weak IBOutlet UILabel *_moneyLabel;
    
    BOOL _isOpen;
}

@end

@implementation EPSaleBillingListSectionView

-(void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [self addGestureRecognizer:tapGes];
}

-(void)onTap
{
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.duration = 0.15;
    rotation.toValue = @(M_PI/2);
    rotation.removedOnCompletion = NO;
    rotation.fillMode = kCAFillModeForwards;
    rotation.delegate = self;
    
    if (_isOpen) {
        rotation.toValue = @(-M_PI/2);
    }
    
    [_arrowBtn.layer addAnimation:rotation forKey:@"rotation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if([_arrowBtn.layer animationForKey:@"rotation"] == anim)
    {
        if ([self.m_delegate respondsToSelector:@selector(onClickSection:)]) {
            [self.m_delegate onClickSection:self.section];
        }
    }
}

-(void)setIsOpen:(BOOL)open
{
    _isOpen = open;
    
    if (open)
    {
        [_arrowBtn setImage:MFImage(@"sj1") forState:UIControlStateNormal];
    }
    else
    {
        [_arrowBtn setImage:MFImage(@"sj2") forState:UIControlStateNormal];
    }
}

-(void)setTimeString:(NSString *)time
{
    _timeLabel.text = time;
}

-(void)setMoneyString:(NSString *)moneyString
{
    _moneyLabel.text = moneyString;
}

@end

