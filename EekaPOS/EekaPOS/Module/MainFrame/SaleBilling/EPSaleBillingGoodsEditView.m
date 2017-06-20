//
//  EPSaleBillingGoodsEditView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingGoodsEditView.h"
#import "EPSaleBillingItemModel.h"
#import "EPSaleBillingHelper.h"
#import "TKeyBoardView.h"

@interface EPSaleBillingGoodsEditView ()<UITextFieldDelegate>
{
    __weak IBOutlet UIImageView *_bgImageView;
    __weak IBOutlet UIView *_bgTapView;
    __weak IBOutlet UILabel *_itemCodeLabel;
    __weak IBOutlet UILabel *_itemNameLabel;
    __weak IBOutlet UITextField *_itemSizeInputTextField;
    __weak IBOutlet UITextField *_remarkTextField;
    __weak IBOutlet UITextField *_rateTextField;
    __weak IBOutlet UIImageView *_rateBgImageView;
    __weak IBOutlet UIImageView *_itemSizeBgImageView;
    __weak IBOutlet UIImageView *_remarkBgImageView;
    
    __weak IBOutlet UIView *_mainBgView;
    
    TKeyBoardView *_sizeBoardView;
    TKeyBoardView *_rateBoardView;
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
    
    UITapGestureRecognizer *tapMainGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapMainBgView)];
    [_mainBgView addGestureRecognizer:tapMainGes];
    
    
    _sizeBoardView = [TKeyBoardView kBoardView];
    _sizeBoardView.keyTextField = _itemSizeInputTextField;
    
    _rateBoardView = [TKeyBoardView kBoardView];
    _rateBoardView.keyTextField = _rateTextField;
}

-(void)onTapMainBgView
{
    [self endEditing:YES];
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
    
    NSString *sizeString = _itemSizeInputTextField.text;
    NSString *rateString = _rateTextField.text;
    NSString *remarkString = _remarkTextField.text;
    
    NSNumber *sizeNumber = @(sizeString.intValue);
    
    if (remarkString.intValue > 1) {
        return;
    }
    
    float rateFloat = [EPSaleBillingHelper roundFloat:rateString.floatValue];
    NSNumber *rateNumber = @(rateFloat);
    
    if ([self.m_delegate respondsToSelector:@selector(editGoodsWithitemModel:size:rate:isSpecialDiscount:remark:)]) {
        [self.m_delegate editGoodsWithitemModel:self.itemModel size:sizeNumber rate:rateNumber isSpecialDiscount:NO remark:remarkString];
    }
}

@end
