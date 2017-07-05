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
#import "RYNumberkeyboard.h"
#import "UITextField+RYNumberKeyboard.h"
#import "EPSaleBillingGoodsRemarkSelectView.h"

@interface EPSaleBillingGoodsEditView ()<UITextFieldDelegate,RYNumberKeyboardDelegate,EPSaleBillingGoodsRemarkSelectViewDelegate>
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
    
    BOOL _isNegative;
    BOOL _isSpecialDiscount;
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
    
    
    _itemSizeInputTextField.ry_inputType = RYIntInputType;
    RYNumberKeyboard *sizeKeyBoard = (RYNumberKeyboard *)_itemSizeInputTextField.inputView;
    sizeKeyBoard.ryDelegate = self;
    sizeKeyBoard.inputType = RYIntInputType;
    _itemSizeInputTextField.tag = 1100;
    
    _rateTextField.ry_inputType = RYFloatZeroToOneInputType;
    RYNumberKeyboard *rateKeyBoard = (RYNumberKeyboard *)_rateTextField.inputView;
    rateKeyBoard.ryDelegate = self;
    rateKeyBoard.inputType = RYFloatZeroToOneInputType;
    _rateTextField.tag = 1101;
    
    _isSpecialDiscount = NO;
}

- (void)ryNumberKeyboardValueChange:(NSString *)string tag:(NSInteger)tag
{
    if (tag == 1100) {
        
    }
    else if (tag == 1101) {
        _isSpecialDiscount = YES;
    }
}

- (void)ryNumberKeyboardSubmit:(NSString *)string tag:(NSInteger)tag
{
    
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
    _rateTextField.text = [MFStringUtil floatStringWithFourPoint:discountNumber.floatValue];
}

-(void)setRemarkString:(NSString *)remark
{
    _remarkTextField.text = remark;
}

- (IBAction)onClickSelectDiscount:(id)sender {
    NSLog(@"此功能暂未开发");
}

- (IBAction)onClickSelectRemark:(id)sender {
    
    [self endEditing:YES];
    
    EPSaleBillingGoodsRemarkSelectView *remarkSelectView = [EPSaleBillingGoodsRemarkSelectView nibView];
    remarkSelectView.m_delegate = self;
    remarkSelectView.frame = self.bounds;
    [self addSubview:remarkSelectView];
}

-(void)didSelectRemark:(NSString *)remark isNegative:(BOOL)isNegative
{
    _isNegative = isNegative;
    _remarkTextField.text = remark;
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
    
    float rateFloat = [EPSaleBillingHelper roundFourFloat:rateString.floatValue];
    
    NSNumber *rateNumber = @(rateFloat);
    
    if (_isNegative) {
        self.itemModel.number = @(-1);
    }
    else
    {
        self.itemModel.number = @(1);
    }
    
    if ([self.m_delegate respondsToSelector:@selector(editGoodsWithitemModel:size:rate:isSpecialDiscount:remark:)]) {
        [self.m_delegate editGoodsWithitemModel:self.itemModel size:sizeNumber rate:rateNumber isSpecialDiscount:_isSpecialDiscount remark:remarkString];
    }
    
    [self removeFromSuperview];
}

@end
