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
#import "EPSaleBillingHelper.h"
#import "EPSaleBillingGoodsEditView.h"
#import "EPSaleBillingGoodsCellView.h"
#import "EPGetIndividualApi.h"
#import "EPSaleBillingModel.h"
#import "EPSaleBillingItemModel.h"
#import "EPSaleBillingDiscountInputView.h"

@interface EPSaleBillingMainViewController () <EPCameraScanDelegate,EPSaleBillingItemCodeInputViewDelegate,
                                    EPSaleBillingDeductionViewDelegate,EPSaleBillingEmployeeSelectViewDelegate,EPSaleGuideSelectViewControllerDelegate,EPSaleBillingDeductionTypeSelectViewDelegate,EPSaleBillingGoodsEditViewDelegate,EPSaleBillingGoodsCellViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet EPSaleBillingItemCodeInputView *_codeInputView;
    __weak IBOutlet EPSaleBillingDeductionView *_deductionView;
    __weak IBOutlet EPSaleBillingGoodsCellView *_goodsCellView;
    __weak IBOutlet UITableView *_tableView;
    
    EPGetIndividualApi *_getIndividualApi;
    EPSaleBillingModel *_saleBillingModel;
    
    NSMutableArray *_saleBillingItemModels;
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
    _goodsCellView.m_delegate = self;
    
    _saleBillingItemModels = [NSMutableArray array];
}

-(void)onClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _saleBillingItemModels.count;
    }
    else if (section == 1)
    {
        return 1;
    }
    
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    if (section == 0)
    {
        return [self tableView:tableView saleBillingDiscountCellForRowAtIndexPath:indexPath];
    }
    else if (section == 1)
    {
        return [self tableView:tableView discountInputCellForRowAtIndexPath:indexPath];
    }
    
    return [UITableViewCell new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView saleBillingDiscountCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saleBillingDiscountCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil) {
        cell = [[MMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"saleBillingDiscountCell"];
        EPSaleBillingGoodsCellView *cellView = [EPSaleBillingGoodsCellView nibView];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    
    EPSaleBillingItemModel *itemModel = _saleBillingItemModels[indexPath.row];

    EPSaleBillingGoodsCellView *cellView = (EPSaleBillingGoodsCellView *)cell.m_subContentView;
    [cellView setItemCode:itemModel.itemCode itemName:itemModel.itemName];
    [cellView setRemarkString:itemModel.remarks];
    [cellView setDiscountPreNumber:itemModel.listPrice];
    [cellView setDiscountAfterNumber:itemModel.receivablePrice];
    [cellView setDiscountRate:itemModel.discount];
    cellView.itemModel = itemModel;
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView discountInputCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"discountInputCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil) {
        cell = [[MMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"discountInputCell"];
        EPSaleBillingDiscountInputView *cellView = [EPSaleBillingDiscountInputView nibView];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDiscountInputView *cellView = (EPSaleBillingDiscountInputView *)cell.m_subContentView;

    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    if (section == 0)
    {
        return 80.0;
    }
    else if (section == 1)
    {
        return 75.0;
    }
    
    return 0;
}


#pragma mark - EPSaleBillingDeductionViewDelegate
-(void)onClickDeductionBtn:(EPSaleBillingDeductionView *)view
{
    [self showSaleBillingDeductionTypeSelectView];
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
    EPGetGoodsDetailApi *goodsDetailApi = [EPGetGoodsDetailApi new];
    goodsDetailApi.itemCode = itemCode;
    goodsDetailApi.animatingText = @"正在查询商品信息...";
    goodsDetailApi.animatingView = MFAppWindow;
    
    [goodsDetailApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!goodsDetailApi.messageSuccess) {
            [self showTips:goodsDetailApi.errorMessage];
            return;
        }
        
        EPSaleBillingItemModel *itemModel = [EPSaleBillingItemModel MM_modelWithJSON:request.responseJSONObject];
        [_saleBillingItemModels addObject:itemModel];
        
        [_tableView reloadData];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)onClickGoodsCellView:(EPSaleBillingItemModel *)itemModel
{
    [self showSaleBillingGoodsEditView:itemModel];
}

//修改商品详情
-(void)showSaleBillingGoodsEditView:(EPSaleBillingItemModel *)itemModel
{
    EPSaleBillingGoodsEditView *goodsEditView = [EPSaleBillingGoodsEditView nibView];
    goodsEditView.m_delegate = self;
    goodsEditView.frame = MFAppWindow.bounds;
    [MFAppWindow addSubview:goodsEditView];
    
    [goodsEditView setItemCode:itemModel.itemCode];
    [goodsEditView setItemSize:itemModel.size];
    [goodsEditView setItemName:itemModel.itemName];
    
    goodsEditView.itemModel = itemModel;
    
}

#pragma mark - EPSaleBillingGoodsEditViewDelegate
-(void)editGoodsWithSize:(NSNumber *)size rate:(NSNumber *)rate remark:(NSString *)remark itemModel:(EPSaleBillingItemModel *)itemModel
{
    
}

//选择扣减
-(void)showSaleBillingDeductionTypeSelectView
{
    EPSaleBillingDeductionTypeSelectView *typeSelectView = [EPSaleBillingDeductionTypeSelectView nibView];
    typeSelectView.m_delegate = self;
    typeSelectView.frame = MFAppWindow.bounds;
    [MFAppWindow addSubview:typeSelectView];
}

-(void)didSelectSaleBillingDeductionType:(EPSaleBillingDeductionModel *)typemodel
{
    [_deductionView setDeductionTypeName:typemodel.name];
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
    
    NSString *guiders = [nameArray componentsJoinedByString:@"、"];
    NSLog(@"guiders=%@",guiders);
}

- (IBAction)onClickSaveBtn:(id)sender {
    [self showSaleBillingEmployeeSelectView];
//    [self showSaleGuidesVC];
//    [self showSaleBillingDeductionTypeSelectView];
}

- (IBAction)onClickScanBtn:(id)sender {
    [self onClickCameraScanBtn];
}

//-(void)getIndividual:(NSString *)telephone
//{
//    __weak typeof(self) weakSelf = self;
//    
//    EPGetIndividualApi *getIndividualApi = [EPGetIndividualApi new];
//    getIndividualApi.brandId = @(1001);
//    getIndividualApi.telephone = telephone;
//    
//    [getIndividualApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
//        
//        if (!getIndividualApi.messageSuccess) {
//            [self showTips:getIndividualApi.errorMessage];
//            return;
//        }
//        
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        
//        
//    } failure:^(YTKBaseRequest * request) {
//        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
//        [self showTips:errorDesc];
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
