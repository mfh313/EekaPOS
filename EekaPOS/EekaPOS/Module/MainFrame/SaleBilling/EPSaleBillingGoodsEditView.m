//
//  EPSaleBillingGoodsEditView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingGoodsEditView.h"
#import "EPGoodsDetailModel.h"

@interface EPSaleBillingGoodsEditView ()<UITextFieldDelegate>
{
    __weak IBOutlet UIImageView *_bgImageView;
    __weak IBOutlet UIView *_bgTapView;
    __weak IBOutlet UILabel *_itemCodeLabel;
    __weak IBOutlet UILabel *_itemNameLabel;
    __weak IBOutlet UITextField *_itemSizeInputTextField;
    __weak IBOutlet UITextField *_remarkTextField;
    __weak IBOutlet UIImageView *_rateBgImageView;
    __weak IBOutlet UIImageView *_itemSizeBgImageView;
    __weak IBOutlet UIImageView *_remarkBgImageView;
    
}

@end

@implementation EPSaleBillingGoodsEditView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _bgImageView.image = MFImageStretchCenter(@"round");
    _rateBgImageView.image = MFImageStretchCenter(@"border");
    _remarkBgImageView.image = MFImageStretchCenter(@"border");
    _itemSizeBgImageView.image = MFImageStretchCenter(@"border");
    
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

- (IBAction)onClickCancelBtn:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)onClickDoneBtn:(id)sender {
    if ([self.m_delegate respondsToSelector:@selector(editGoodsWithSize:rate:remark:goodsModel:)]) {
        [self.m_delegate editGoodsWithSize:@(39) rate:@(0.47) remark:@"生日假期,尽快" goodsModel:self.goodsModel];
    }
}

@end
