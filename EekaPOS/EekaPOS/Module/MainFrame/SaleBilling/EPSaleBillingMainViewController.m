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
#import "EPSaleBillingPhoneInputView.h"
#import "EPSaleBillingCashierCellView.h"
#import "EPSaleBillingGuidesCellView.h"

@interface EPSaleBillingMainViewController () <EPCameraScanDelegate,EPSaleBillingItemCodeInputViewDelegate,
                                    EPSaleBillingDeductionViewDelegate,EPSaleBillingEmployeeSelectViewDelegate,EPSaleGuideSelectViewControllerDelegate,EPSaleBillingDeductionTypeSelectViewDelegate,EPSaleBillingGoodsEditViewDelegate,EPSaleBillingGoodsCellViewDelegate,EPSaleBillingPhoneInputViewDelegate,EPSaleBillingCashierCellViewDelegate,EPSaleBillingGuidesCellViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet EPSaleBillingItemCodeInputView *_codeInputView;
    __weak IBOutlet EPSaleBillingDeductionView *_deductionView;
    __weak IBOutlet EPSaleBillingGoodsCellView *_goodsCellView;
    __weak IBOutlet UITableView *_tableView;
    
    EPGetIndividualApi *_getIndividualApi;
    EPSaleBillingModel *_saleBillingModel;
    

    NSMutableArray *_saleBillingItemModels;
    NSMutableArray *_saleBillingDeductions;
    
    EPEntitityEmployeeModel *_selectCashier;
    NSMutableArray *_selectGuides;
    
    CGFloat _deductionPrice;
    CGFloat _allPrice;
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
    
    _saleBillingModel = [EPSaleBillingModel new];
    _saleBillingModel.discount = @(0.85);
    _saleBillingModel.phone = @"15813818620";
    
    _saleBillingItemModels = [NSMutableArray array];
    _saleBillingDeductions = [NSMutableArray array];
    _selectGuides = [NSMutableArray array];
    
    _codeInputView.m_delegate = self;
    _deductionView.m_delegate = self;
    _goodsCellView.m_delegate = self;
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
    else if (section == 2)
    {
        return 1;
    }
    else if (section == 3)
    {
        return 1;
    }
    else if (section == 4)
    {
        return _saleBillingDeductions.count;
    }
    else if (section == 5)
    {
        return 1;
    }
    else if (section == 6)
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
    else if (section == 2)
    {
        return [self tableView:tableView telePhoneCellForRowAtIndexPath:indexPath];
    }
    else if (section == 3)
    {
        return [self tableView:tableView saleBillingDeductionInputCellForRowAtIndexPath:indexPath];
    }
    else if (section == 4)
    {
        
    }
    else if (section == 5)
    {
        return [self tableView:tableView cashierCellForRowAtIndexPath:indexPath];
    }
    else if (section == 6)
    {
        return [self tableView:tableView guidesCellForRowAtIndexPath:indexPath];
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
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    
    EPSaleBillingItemModel *itemModel = _saleBillingItemModels[indexPath.row];

    EPSaleBillingGoodsCellView *cellView = (EPSaleBillingGoodsCellView *)cell.m_subContentView;
    
    cellView.itemModel = itemModel;
    
    [cellView setItemCode:itemModel.itemCode itemName:itemModel.itemName];
    [cellView setRemarkString:itemModel.remarks];
    [cellView setDiscountRate:itemModel.discount discountPreNumber:itemModel.listPrice];
    
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

    [cellView setDiscountRate:_saleBillingModel.discount];
    
    [self calculationAllPriceAndReceivablePrice];
    
    [cellView setReceivablePrice:@(_deductionPrice) allPrice:@(_allPrice)];
    
    return cell;
}

-(void)calculationAllPriceAndReceivablePrice
{
    _allPrice = 0;
    _deductionPrice = 0;
    
    for (int i = 0; i < _saleBillingItemModels.count; i++)
    {
        EPSaleBillingItemModel *itemModel = _saleBillingItemModels[i];
        
        _allPrice += itemModel.listPrice.floatValue;
        
        if (itemModel.isSpecialDiscount) {
            
            _deductionPrice += itemModel.listPrice.floatValue * itemModel.discount.floatValue;
        }
        else
        {
            _deductionPrice += itemModel.listPrice.floatValue * _saleBillingModel.discount.floatValue;
        }

    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView telePhoneCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"telePhoneCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil) {
        cell = [[MMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"telePhoneCell"];
        EPSaleBillingPhoneInputView *cellView = [EPSaleBillingPhoneInputView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingPhoneInputView *cellView = (EPSaleBillingPhoneInputView *)cell.m_subContentView;
    [cellView setPhone:_saleBillingModel.phone];
    
    return cell;
}

-(void)didInputPhone:(NSString *)phone
{
    _saleBillingModel.phone = phone;
}

-(UITableViewCell *)tableView:(UITableView *)tableView saleBillingDeductionInputCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saleBillingDeductionInput"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil) {
        cell = [[MMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"saleBillingDeductionInput"];
        EPSaleBillingDeductionView *cellView = [EPSaleBillingDeductionView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDeductionView *cellView = (EPSaleBillingDeductionView *)cell.m_subContentView;
    
    return cell;
}






-(UITableViewCell *)tableView:(UITableView *)tableView cashierCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saleBillingCashierCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil) {
        cell = [[MMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"saleBillingCashierCell"];
        EPSaleBillingCashierCellView *cellView = [EPSaleBillingCashierCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingCashierCellView *cellView = (EPSaleBillingCashierCellView *)cell.m_subContentView;
    [cellView setCashierString:_selectCashier.contactName];
    
    return cell;
}

#pragma mark - EPSaleBillingCashierCellViewDelegate
-(void)onClickCashierCellView
{
    [self showSaleBillingEmployeeSelectView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView guidesCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saleBillingCashierCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil) {
        cell = [[MMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"saleBillingCashierCell"];
        EPSaleBillingGuidesCellView *cellView = [EPSaleBillingGuidesCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingGuidesCellView *cellView = (EPSaleBillingGuidesCellView *)cell.m_subContentView;
    [cellView setGuidesString:[self selectGuiderNames]];
    
    return cell;
}

#pragma mark - EPSaleBillingGuidesCellViewDelegate
-(void)onClickGuidesCellView
{
    [self showSaleGuidesVC];
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
    else if (section == 2)
    {
        return 46.0;
    }
    else if (section == 3)
    {
        return 128.0;
    }
    else if (section == 4)
    {
        return 40.0;
    }
    else if (section == 5)
    {
        return 46.0;
    }
    else if (section == 6)
    {
        return 46.0;
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
        itemModel.discount = _saleBillingModel.discount;
        itemModel.isSpecialDiscount = NO;
        
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
    _selectCashier = selectEmployee;
    _saleBillingModel.cashier = _selectCashier.contactID.stringValue;
    
    [_tableView reloadData];
    
    [view removeFromSuperview];
    view = nil;
}

//选择导购员
-(void)showSaleGuidesVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SaleBilling" bundle:nil];
    EPSaleGuideSelectViewController *guideSelectVC = [storyboard instantiateViewControllerWithIdentifier:@"EPSaleGuideSelectViewController"];
    guideSelectVC.selectedSallers = _selectGuides;
    guideSelectVC.m_delegate = self;
    guideSelectVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:guideSelectVC animated:YES];
}

#pragma mark - EPSaleGuideSelectViewControllerDelegate
-(void)didSelectEmployees:(NSMutableArray *)selectEmployees viewController:(EPSaleGuideSelectViewController *)viewController
{
    _selectGuides = selectEmployees;
    
    [_tableView reloadData];
}

-(NSString *)selectGuiderNames
{
    NSMutableArray *nameArray = [NSMutableArray array];
    for (int i = 0; i < _selectGuides.count; i++) {
        EPEntitityEmployeeModel *employee = _selectGuides[i];
        [nameArray addObject:employee.contactName];
    }
    
    NSString *guiders = [nameArray componentsJoinedByString:@","];
    return guiders;
}

-(NSString *)selectGuiderIds
{
    NSMutableArray *contactIDs = [NSMutableArray array];
    for (int i = 0; i < _selectGuides.count; i++) {
        EPEntitityEmployeeModel *employee = _selectGuides[i];
        [contactIDs addObject:employee.contactID];
    }
    
    NSString *selectGuiderIds = [contactIDs componentsJoinedByString:@","];
    return selectGuiderIds;
}

- (IBAction)onClickScanBtn:(id)sender
{
    [self onClickCameraScanBtn];
}

- (IBAction)onClickSaveBtn:(id)sender
{
    
}

/*

-(void)getIndividual:(NSString *)telephone
{
    __weak typeof(self) weakSelf = self;
    
    EPGetIndividualApi *getIndividualApi = [EPGetIndividualApi new];
    getIndividualApi.brandId = @(1001);
    getIndividualApi.telephone = telephone;
    
    [getIndividualApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!getIndividualApi.messageSuccess) {
            [self showTips:getIndividualApi.errorMessage];
            return;
        }
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

*/
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
