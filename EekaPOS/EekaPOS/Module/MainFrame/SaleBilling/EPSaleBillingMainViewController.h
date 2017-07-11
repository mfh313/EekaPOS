//
//  EPSaleBillingMainViewController.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMViewController.h"
#import "EPCameraScanViewController.h"
#import "EPGetGoodsDetailApi.h"
#import "EPGoodsDetailModel.h"
#import "EPEntitityEmployeeModel.h"
#import "EPSaleBillingItemCodeInputView.h"
#import "EPSaleBillingDeductionView.h"
#import "EPSaleBillingEmployeeSelectView.h"
#import "EPSaleBillingDeductionTypeSelectView.h"
#import "EPSaleGuideSelectViewController.h"
#import "EPSaleBillingHelper.h"
#import "EPSaleBillingGoodsEditView.h"
#import "EPSaleBillingGoodsCellView.h"
#import "EPGetIndividualApi.h"
#import "EPSaleBillingModel.h"
#import "EPSaleBillingItemModel.h"
#import "EPSaleBillingDiscountInputView.h"
#import "EPSaleBillingPhoneInputView.h"
#import "EPSaleBillingCashierCellView.h"
#import "EPSaleBillingGuidesCellView.h"
#import "EPSaleBillingDeductionSelectedItemView.h"
#import "EPSaveSaleBillingApi.h"
#import "EPEntitityService.h"
#import "MFMultiMenuTableViewCell.h"
#import "EPSaleBillingMainFooterView.h"

@interface EPSaleBillingMainViewController : MMViewController
{
    EPSaleBillingItemCodeInputView *_codeInputView;
    MFUITableView *_tableView;
    
    EPSaleBillingMainFooterView *_footView;;
    
    EPGetIndividualApi *_getIndividualApi;
    EPSaleBillingModel *_saleBillingModel;
    
    NSMutableArray *_saleBillingItemModels;
    NSMutableArray *_saleBillingDeductions;
    
    EPEntitityEmployeeModel *_selectCashier;
    EPSaleBillingDeductionModel *_selectedDeductionModel;
    NSMutableArray *_selectGuides;
    
    NSString *_currrentIndividualName;
    
    CGFloat _discountPrice;
    CGFloat _allPrice;
    CGFloat _deductionPrice;
}

-(void)reSetTableSubViews;


@end
