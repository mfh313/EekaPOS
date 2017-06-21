//
//  EPMainFrameViewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPMainFrameViewController.h"
#import "EPAccountMgr.h"
#import "EPMainFrameCellView.h"
#import "EPSaleBillingMainViewController.h"
#import "EPSaleBillingListViewController.h"

@interface EPMainFrameViewController () 
{
    __weak IBOutlet UILabel *_currentEntityNameLabel;
    
    __weak IBOutlet EPMainFrameCellView *_saleBillingView;
    __weak IBOutlet EPMainFrameCellView *_billingListView;
}

@end

@implementation EPMainFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"POS";
    
    EPAccountMgr *accountMgr = [[MMServiceCenter defaultCenter] getService:[EPAccountMgr class]];
    EPLoginUserModel *loginModel = accountMgr.loginModel;
    
    _currentEntityNameLabel.text = [NSString stringWithFormat:@"当前账号： %@",loginModel.fullname];
    
    __weak typeof(self) weakSelf = self;
    
    [_saleBillingView setContentView:MFImage(@"pos3") desc:@"销售开单"];
    [_saleBillingView setClickBlock:^() {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf pushSaleBillingMainVC];
    }];
    
    [_billingListView setContentView:MFImage(@"pos4") desc:@"开单列表"];
    [_billingListView setClickBlock:^() {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf pushBillingListVC];
    }];
}

-(void)pushSaleBillingMainVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SaleBilling" bundle:nil];
    EPSaleBillingMainViewController *saleBillingMainVC = [storyboard instantiateViewControllerWithIdentifier:@"EPSaleBillingMainViewController"];
    saleBillingMainVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:saleBillingMainVC animated:YES];
}

-(void)pushBillingListVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SaleBilling" bundle:nil];
    EPSaleBillingListViewController *saleBillingListVC = [storyboard instantiateViewControllerWithIdentifier:@"EPSaleBillingListViewController"];
    saleBillingListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:saleBillingListVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
