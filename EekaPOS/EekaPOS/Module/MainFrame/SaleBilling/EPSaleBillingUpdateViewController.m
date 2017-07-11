//
//  EPSaleBillingUpdateViewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/7/11.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingUpdateViewController.h"
#import "EPUpdateSaleBillingApi.h"

@interface EPSaleBillingUpdateViewController ()

@end

@implementation EPSaleBillingUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"销售开单修改";
    
    _saleBillingModel = self.saleModel;
    
    [self updateSaleBillingDatas];
}

-(void)updateSaleBillingDatas
{
    _selectGuides = [NSMutableArray array];
    
//    EPEntitityService *entitityService = [[MMServiceCenter defaultCenter] getService:[EPEntitityService class]];
//    _selectCashier = [entitityService getEntitityEmployees].firstObject;
    
    _saleBillingItemModels = [NSMutableArray arrayWithArray:_saleBillingModel.itemList];
    _saleBillingDeductions = [EPSaleBillingHelper deductionModelsForString:_saleBillingModel.deductionStr];
    
    [self reSetTableSubViews];
}

-(void)onClickSaveBillingBtn
{
    [self updateSaleBilling];
}

-(void)updateSaleBilling
{
    EPAccountMgr *accountMgr = [[MMServiceCenter defaultCenter] getService:[EPAccountMgr class]];
    _saleBillingModel.storeName = accountMgr.loginModel.fullname;
    _saleBillingModel.deductionStr = [EPSaleBillingHelper saleBillingSelectDeductionsStr:_saleBillingDeductions];
    _saleBillingModel.sellDate = [EPSaleBillingHelper dateStringWithDate:[NSDate date]];
    _saleBillingModel.printDate = [EPSaleBillingHelper dateStringWithDate:[NSDate date]];
    _saleBillingModel.amountPrice = _allPrice;
    _saleBillingModel.trueRece = [self receivablePrice];
    _saleBillingModel.itemList = _saleBillingItemModels;
    
    BOOL canSaveSaleBilling = [self canSaveSaleBilling];
    if (!canSaveSaleBilling) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    EPUpdateSaleBillingApi *updateApi = [EPUpdateSaleBillingApi new];
    updateApi.saleBillingModel = _saleBillingModel;
    updateApi.animatingText = @"正在修改...";
    updateApi.animatingView = MFAppWindow;
    [updateApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (!updateApi.messageSuccess) {
            [strongSelf showTips:updateApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:@"修改成功"];
        
        EPSaleBillingModel *saleBillingModel = [EPSaleBillingModel MM_modelWithJSON:request.responseJSONObject];
        [strongSelf reloadEditInfo:saleBillingModel];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)reloadEditInfo:(EPSaleBillingModel *)model
{
    if ([self.m_delegate respondsToSelector:@selector(saleBillingDidUpdate:)]) {
        [self.m_delegate saleBillingDidUpdate:model];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
