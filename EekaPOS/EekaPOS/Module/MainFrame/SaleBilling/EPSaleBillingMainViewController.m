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
#import "EPEntitityEmployeeModel.h"
#import "EPSaleBillingItemCodeInputView.h"
#import "EPSaleBillingDeductionView.h"
#import "EPSaleBillingEmployeeSelectView.h"
#import "EPSaleBillingDeductionTypeSelectView.h"
#import "EPSaleGuideSelectViewController.h"

@interface EPSaleBillingMainViewController () <EPCameraScanDelegate,EPSaleBillingItemCodeInputViewDelegate,
                                    EPSaleBillingDeductionViewDelegate,EPSaleBillingEmployeeSelectViewDelegate,EPSaleGuideSelectViewControllerDelegate,EPSaleBillingDeductionTypeSelectViewDelegate>
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
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    _codeInputView.m_delegate = self;
    _deductionView.m_delegate = self;
    
    _goodsDetailModel = [NSMutableArray array];
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
    if ([MFStringUtil isBlankString:itemCode]) {
        [self showTips:@"请输入正确的商品码"];
        return;
    }
    
    [self getItemDetail:itemCode];
}

-(void)getItemDetail:(NSString *)itemCode
{
//    __weak typeof(self) weakSelf = self;
    
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
        
//        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

//选择扣减
-(void)showSaleBillingDeductionTypeSelectView
{
    EPSaleBillingDeductionTypeSelectView *typeSelectView = [EPSaleBillingDeductionTypeSelectView nibView];
    typeSelectView.m_delegate = self;
    typeSelectView.frame = MFAppWindow.bounds;
    [MFAppWindow addSubview:typeSelectView];
}

//选择收银员
-(void)showSaleBillingEmployeeSelectView
{    
    EPSaleBillingEmployeeSelectView *employeeSelectView = [EPSaleBillingEmployeeSelectView nibView];
    employeeSelectView.m_delegate = self;
    employeeSelectView.frame = MFAppWindow.bounds;
    [MFAppWindow addSubview:employeeSelectView];
}

#pragma mark - EPSaleBillingEmployeeSelectViewDelegate
-(void)didSelectEmployee:(EPEntitityEmployeeModel *)selectEmployee view:(EPSaleBillingEmployeeSelectView *)view
{
    NSLog(@"选中收银员=%@",selectEmployee.contactName);
    
    [view removeFromSuperview];
    view = nil;
}

//选择销售人员
-(void)showSaleGuidesVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SaleBilling" bundle:nil];
    EPSaleGuideSelectViewController *guideSelectVC = [storyboard instantiateViewControllerWithIdentifier:@"EPSaleGuideSelectViewController"];
    guideSelectVC.m_delegate = self;
    guideSelectVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:guideSelectVC animated:YES];
}

#pragma mark - EPSaleGuideSelectViewControllerDelegate
-(void)didSelectEmployees:(NSMutableArray *)selectEmployees viewController:(EPSaleGuideSelectViewController *)viewController
{
    NSMutableArray *nameArray = [NSMutableArray array];
    for (int i = 0; i < selectEmployees.count; i++) {
        EPEntitityEmployeeModel *employee = selectEmployees[i];
        [nameArray addObject:employee.contactName];
    }
    
    NSString *names = [nameArray componentsJoinedByString:@"、"];
    NSLog(@"names=%@",names);
}

- (IBAction)onClickSaveBtn:(id)sender {
//    [self showSaleBillingEmployeeSelectView];
    [self showSaleGuidesVC];
}

- (IBAction)onClickScanBtn:(id)sender {
    [self onClickCameraScanBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
