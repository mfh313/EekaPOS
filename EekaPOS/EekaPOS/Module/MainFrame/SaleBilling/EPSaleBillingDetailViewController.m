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

@interface EPSaleBillingDetailViewController ()
{
    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation EPSaleBillingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"销售开单详情";
    
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    [self getSaleBillingById];
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
        
        EPSaleBillingModel *model = [EPSaleBillingModel MM_modelWithJSON:request.responseJSONObject];
        
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
