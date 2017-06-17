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
    
    [_saleBillingView setContentView:MFImage(@"home") desc:@"销售开单"];
    [_billingListView setContentView:MFImage(@"home") desc:@"开单列表"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
