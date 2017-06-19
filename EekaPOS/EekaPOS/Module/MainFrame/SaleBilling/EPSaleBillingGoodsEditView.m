//
//  EPSaleBillingGoodsEditView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingGoodsEditView.h"

@interface EPSaleBillingGoodsEditView ()<UITextFieldDelegate>
{
    __weak IBOutlet UIImageView *_bgImageView;
    __weak IBOutlet UIView *_bgTapView;
    __weak IBOutlet UILabel *_itemCodeLabel;
    __weak IBOutlet UILabel *_itemNameLabel;
    __weak IBOutlet UITextField *_itemSizeInputTextField;
    __weak IBOutlet UITextField *_remarkTextField;
    __weak IBOutlet UIImageView *_rateBgImageView;
    
}

@end

@implementation EPSaleBillingGoodsEditView

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

-(void)setItemCode:(NSString *)itemCode
{
    _itemCodeLabel.text = itemCode;
}

-(void)setItemName:(NSString *)itemName
{
    _itemNameLabel.text = itemName;
}

-(void)setItemSize:(NSNumber *)size
{
    _itemSizeInputTextField.text = [NSString stringWithFormat:@"%@",size];
}

-(void)setDiscount:(NSNumber *)discountNumber
{
    
}

-(void)setRemarkString:(NSString *)remark
{
    
}

- (IBAction)onClickSelectDiscount:(id)sender {
    NSLog(@"此功能暂未开发");
}

- (IBAction)onClickSelectRemark:(id)sender {
    NSLog(@"此功能暂未开发");
}


@end
