//
//  EPSaleBillingDetailViewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/22.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDetailViewController.h"
#import "EPGetSaleBillingByIdApi.h"
#import "EPSaleBillingModel.h"
#import "EPSaleBillingDetailHeaderView.h"
#import "EPSaleBillingDetailFooterView.h"
#import "EPSaleBillingDetailDeductionItemView.h"

@interface EPSaleBillingDetailViewController ()
{
    __weak IBOutlet UITableView *_tableView;
    EPSaleBillingModel *_saleModel;
    
    EPSaleBillingDetailHeaderView *_headerView;
    EPSaleBillingDetailFooterView *_footerView;
    
}

@end

@implementation EPSaleBillingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"销售开单详情";
    
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    _headerView = [EPSaleBillingDetailHeaderView nibView];
    _footerView = [EPSaleBillingDetailFooterView nibView];
    
    [self getSaleBillingById];

}

-(void)setHeaderAndFooterView
{
    [_headerView setSaleBillingModel:_saleModel];
    CGFloat headerHeight = [_headerView headerHeightForSaleBillingModel:_saleModel];
    _headerView.frame = CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), headerHeight);
    
    [_tableView beginUpdates];
    _tableView.tableHeaderView  =_headerView;
    [_tableView endUpdates];
    
    [_footerView setPrintDate:_saleModel.printDate];
    _footerView.frame = CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), 90);
    _tableView.tableFooterView  =_footerView;
}

-(void)getSaleBillingById
{
    EPGetSaleBillingByIdApi *getSaleBillingByIdApi = [EPGetSaleBillingByIdApi new];
    getSaleBillingByIdApi.saleBillingId = self.saleBillingId;;
    getSaleBillingByIdApi.animatingText = @"正在获取开单信息...";
    getSaleBillingByIdApi.animatingView = MFAppWindow;
    
    __weak typeof(self) weakSelf = self;
    [getSaleBillingByIdApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (!getSaleBillingByIdApi.messageSuccess) {
            [strongSelf showTips:getSaleBillingByIdApi.errorMessage];
            return;
        }
        
        _saleModel = [EPSaleBillingModel MM_modelWithJSON:request.responseJSONObject];
        [strongSelf setHeaderAndFooterView];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
