//
//  EPSaleBillingUpdateViewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/7/11.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingUpdateViewController.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
