//
//  EPSaleBillingMainViewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingMainViewController.h"
#import "EPCameraScanViewController.h"
#import "EPSaleBillingItemCodeInputView.h"

@interface EPSaleBillingMainViewController () <EPCameraScanDelegate,EPSaleBillingItemCodeInputViewDelegate>
{
    __weak IBOutlet EPSaleBillingItemCodeInputView *_codeInputView;
}

@end

@implementation EPSaleBillingMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"销售开单";
    
    [self MF_wantsFullScreenLayout:NO];
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    _codeInputView.m_delegate = self;
    
}

-(void)onClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onClickCameraScanBtn
{
    EPCameraScanViewController *vc = [EPCameraScanViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.m_delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)onScanQRCodeString:(NSString *)strScanned
{
    NSLog(@"扫描到的码=%@",strScanned);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
