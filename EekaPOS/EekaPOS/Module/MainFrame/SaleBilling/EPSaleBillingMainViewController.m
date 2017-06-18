//
//  EPSaleBillingMainViewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingMainViewController.h"
#import "EPCameraScanViewController.h"
#import "EPGetGoodsDetailApi.h"
#import "EPGoodsDetailModel.h"
#import "EPGetEntitityDetailApi.h"
#import "EPSaleBillingItemCodeInputView.h"
#import "EPSaleBillingDeductionView.h"

@interface EPSaleBillingMainViewController () <EPCameraScanDelegate,EPSaleBillingItemCodeInputViewDelegate,EPSaleBillingDeductionViewDelegate>
{
    __weak IBOutlet EPSaleBillingItemCodeInputView *_codeInputView;
    
    __weak IBOutlet EPSaleBillingDeductionView *_deductionView;
    
    NSMutableArray *_goodsDetailModel;
    
}

@end

@implementation EPSaleBillingMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"销售开单";
    
    [self MF_wantsFullScreenLayout:NO];
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    _codeInputView.m_delegate = self;
    _deductionView.m_delegate = self;
    
    _goodsDetailModel = [NSMutableArray array];
    
//    [self getEntitityDetail];
    
}

-(void)onClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - EPSaleBillingDeductionViewDelegate
-(void)onClickDeductionBtn:(EPSaleBillingDeductionView *)view
{
    
}

-(void)onClickAddBtn:(EPSaleBillingDeductionView *)view
{
    
}

#pragma mark - EPSaleBillingItemCodeInputViewDelegate
-(void)onClickCameraScanBtn
{
    EPCameraScanViewController *vc = [EPCameraScanViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.m_delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)onScanQRCodeString:(NSString *)strScanned
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self getItemDetail:strScanned];
}

-(void)onInputSaleBillingItemCode:(NSString *)itemCode
{
    if (!itemCode) {
        return;
    }
    
    [self getItemDetail:itemCode];
}


-(void)getItemDetail:(NSString *)itemCode
{
    itemCode = @"R116C72080040";
    
    __weak typeof(self) weakSelf = self;
    
    EPGetGoodsDetailApi *goodsDetailApi = [EPGetGoodsDetailApi new];
    goodsDetailApi.itemCode = itemCode;
    goodsDetailApi.animatingText = @"正在查询商品信息...";
    goodsDetailApi.animatingView = MFAppWindow;
    
    [goodsDetailApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!goodsDetailApi.messageSuccess) {
            [self showTips:goodsDetailApi.errorMessage];
            return;
        }

        EPGoodsDetailModel *detailModel = [EPGoodsDetailModel MM_modelWithJSON:request.responseJSONObject];
        [_goodsDetailModel addObject:detailModel];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)getEntitityDetail
{
    __weak typeof(self) weakSelf = self;
    
    EPGetEntitityDetailApi *entitityDetailApi = [EPGetEntitityDetailApi new];
    [entitityDetailApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!entitityDetailApi.messageSuccess) {
            [self showTips:entitityDetailApi.errorMessage];
            return;
        }

        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
