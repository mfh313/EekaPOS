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
#import "EPSaleBillingDeductionSelectedItemView.h"
#import "EPSaveSaleBillingApi.h"
#import "EPEntitityService.h"
#import "MFMultiMenuTableViewCell.h"


@interface EPSaleBillingMainViewController () <EPCameraScanDelegate,EPSaleBillingItemCodeInputViewDelegate,
                                    EPSaleBillingDeductionViewDelegate,EPSaleBillingEmployeeSelectViewDelegate,EPSaleGuideSelectViewControllerDelegate,EPSaleBillingDeductionTypeSelectViewDelegate,EPSaleBillingGoodsEditViewDelegate,EPSaleBillingGoodsCellViewDelegate,EPSaleBillingPhoneInputViewDelegate,EPSaleBillingCashierCellViewDelegate,EPSaleBillingGuidesCellViewDelegate,EPSaleBillingDiscountInputViewDelegate,UITableViewDataSource,UITableViewDelegate,LYSideslipCellDelegate>
{
    __weak IBOutlet EPSaleBillingItemCodeInputView *_codeInputView;
    
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UILabel *_receivablePriceLabel;
    
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

@end

@implementation EPSaleBillingMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"销售开单";
    
    [self MF_wantsFullScreenLayout:NO];
    
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    _codeInputView.m_delegate = self;
    
    _saleBillingItemModels = [NSMutableArray array];
    _saleBillingDeductions = [NSMutableArray array];
    _selectGuides = [NSMutableArray array];
    
    EPEntitityService *entitityService = [[MMServiceCenter defaultCenter] getService:[EPEntitityService class]];
    _selectCashier = [entitityService getEntitityEmployees].firstObject;
    
    _saleBillingModel = [EPSaleBillingModel new];
    _saleBillingModel.discount = @(1.0);
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
        return [self tableView:tableView saleBillingGoodsCellForRowAtIndexPath:indexPath];
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
        return [self tableView:tableView deductionItemCellForRowAtIndexPath:indexPath];
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

-(UITableViewCell *)tableView:(UITableView *)tableView saleBillingGoodsCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFMultiMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saleBillingGoodsCell"];
    
    if (cell == nil) {
        cell = [[MFMultiMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"saleBillingGoodsCell"];
        cell.delegate = self;
        
        EPSaleBillingGoodsCellView *cellView = [EPSaleBillingGoodsCellView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingItemModel *itemModel = _saleBillingItemModels[indexPath.row];

    EPSaleBillingGoodsCellView *cellView = (EPSaleBillingGoodsCellView *)cell.m_subContentView;
    
    cellView.itemModel = itemModel;
    
    return cell;
}

#pragma mark - LYSideslipCellDelegate
- (NSArray<LYSideslipCellAction *> *)sideslipCell:(LYSideslipCell *)sideslipCell editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYSideslipCellAction *action = [LYSideslipCellAction rowActionWithStyle:LYSideslipCellActionStyleDestructive title:@"删除" handler:^(LYSideslipCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath)
                                    {
                                        [sideslipCell hiddenAllSideslip];
                                        if (indexPath.section == 0)
                                        {
                                            [_saleBillingItemModels removeObjectAtIndex:indexPath.row];
                                            
                                        }
                                        else if (indexPath.section == 4)
                                        {
                                            [_saleBillingDeductions removeObjectAtIndex:indexPath.row];
                                        }
                                        
                                        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                                        [self reSetTableSubViews];
                                        
                                    }];
    return @[action];
}

- (BOOL)sideslipCell:(LYSideslipCell *)sideslipCell canSideslipRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView discountInputCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"discountInputCell"];
    
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"discountInputCell"];
        EPSaleBillingDiscountInputView *cellView = [EPSaleBillingDiscountInputView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDiscountInputView *cellView = (EPSaleBillingDiscountInputView *)cell.m_subContentView;

    [cellView setDiscountRate:_saleBillingModel.discount];
    
    [self calculationAllPriceAndReceivablePrice];
    
    [cellView setReceivablePrice:@(_discountPrice) allPrice:@(_allPrice)];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView telePhoneCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"telePhoneCell"];
    
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"telePhoneCell"];
        EPSaleBillingPhoneInputView *cellView = [EPSaleBillingPhoneInputView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingPhoneInputView *cellView = (EPSaleBillingPhoneInputView *)cell.m_subContentView;
    [cellView setPhone:_saleBillingModel.phone];
    [cellView setName:_currrentIndividualName];
    
    return cell;
}

#pragma mark - EPSaleBillingPhoneInputView
-(void)didInputPhone:(NSString *)phone
{
    _saleBillingModel.phone = phone;
    
    [self getIndividual:phone];
}

-(UITableViewCell *)tableView:(UITableView *)tableView saleBillingDeductionInputCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saleBillingDeductionInput"];
    
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"saleBillingDeductionInput"];
        EPSaleBillingDeductionView *cellView = [EPSaleBillingDeductionView nibView];
        cellView.m_delegate = self;
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDeductionView *cellView = (EPSaleBillingDeductionView *)cell.m_subContentView;
    [cellView setDeductionMode:_selectedDeductionModel];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView deductionItemCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFMultiMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deductionItemCell"];
    
    if (cell == nil) {
        cell = [[MFMultiMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deductionItemCell"];
        cell.delegate = self;
        
        EPSaleBillingDeductionSelectedItemView *cellView = [EPSaleBillingDeductionSelectedItemView nibView];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDeductionSelectedItemView *cellView = (EPSaleBillingDeductionSelectedItemView *)cell.m_subContentView;
    
    EPSaleBillingDeductionModel *deductionModel = _saleBillingDeductions[indexPath.row];
    [cellView setDeductionItemModel:deductionModel];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cashierCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saleBillingCashierCell"];
    
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"saleBillingCashierCell"];
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
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saleBillinGuidesCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"saleBillinGuidesCell"];
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
        return 46.0;
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

-(NSIndexPath *)indexPathForsaleBillingDeductionView
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:3];
    return indexpath;
}

#pragma mark - EPSaleBillingDeductionViewDelegate

-(void)onClickDeductionBtn:(EPSaleBillingDeductionView *)view deductionModel:(EPSaleBillingDeductionModel *)deductionModel
{
    [self.view endEditing:YES];
    
    NSIndexPath *deductionIndexPath = [self indexPathForsaleBillingDeductionView];
    [_tableView scrollToRowAtIndexPath:deductionIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    
    [self showSaleBillingDeductionTypeSelectView];
}

-(void)onClickAddBtn:(EPSaleBillingDeductionView *)view deductionModel:(EPSaleBillingDeductionModel *)deductionModel
{
    if (!_selectedDeductionModel) {
        [self showTips:@"请选择扣减项目"];
        return;
    }
    
    if (!deductionModel.value) {
        [self showTips:@"请输入扣减金额"];
        return;
    }
    
    _selectedDeductionModel.value = deductionModel.value;
    
    [_saleBillingDeductions addObject:deductionModel];
    
    [self reSetTableSubViews];
    
    _selectedDeductionModel = nil;
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
    [goodsEditView setRemarkString:itemModel.remarks];
    [goodsEditView setDiscount:itemModel.discount];
    
    goodsEditView.itemModel = itemModel;
    
}

#pragma mark - EPSaleBillingDiscountInputViewDelegate
-(void)didSetDiscount:(CGFloat)allDiscount
{
    _saleBillingModel.discount = @(allDiscount);
    
    [self reSetTableSubViews];
}

#pragma mark - EPSaleBillingGoodsEditViewDelegate
-(void)editGoodsWithitemModel:(EPSaleBillingItemModel *)itemModel
                         size:(NSNumber *)size
                         rate:(NSNumber *)rate
            isSpecialDiscount:(BOOL)isSpecialDiscount
                       remark:(NSString *)remark
{
    itemModel.size = size;
    itemModel.discount = rate;
    itemModel.remarks = remark;
    itemModel.isSpecialDiscount = isSpecialDiscount;
    
    [self reSetTableSubViews];
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
    _selectedDeductionModel = typemodel;
    
    [self reSetTableSubViews];
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
    
    [self reSetTableSubViews];
    
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
    
    [self reSetTableSubViews];
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
    [self saveSaleBilling];
}

-(void)saveSaleBilling
{
    EPAccountMgr *accountMgr = [[MMServiceCenter defaultCenter] getService:[EPAccountMgr class]];
    _saleBillingModel.storeName = accountMgr.loginModel.fullname;
    _saleBillingModel.cashier = _selectCashier.contactName;
    _saleBillingModel.guider = [self selectGuiderNames];
    _saleBillingModel.deductionStr = [EPSaleBillingHelper saleBillingSelectDeductionsStr:_saleBillingDeductions];
    _saleBillingModel.sellDate = [EPSaleBillingHelper dateStringWithDate:[NSDate date]];
    _saleBillingModel.printDate = [EPSaleBillingHelper dateStringWithDate:[NSDate date]];
    _saleBillingModel.amountPrice = _allPrice;
    _saleBillingModel.trueRece = [self receivablePrice];
    _saleBillingModel.itemList = _saleBillingItemModels;
    
    BOOL canSaveSaleBilling = [self canSaveSaleBilling];
    if (!canSaveSaleBilling) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    EPSaveSaleBillingApi *saveSaleBillingApi = [EPSaveSaleBillingApi new];
    saveSaleBillingApi.saleBillingModel = _saleBillingModel;
    saveSaleBillingApi.animatingText = @"正在销售开单...";
    saveSaleBillingApi.animatingView = MFAppWindow;
    [saveSaleBillingApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (!saveSaleBillingApi.messageSuccess) {
            [strongSelf showTips:saveSaleBillingApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:@"销售开单成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[EPAppViewControllerManager getAppViewControllerManager] pushSaleBillingListViewController];
        });
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(BOOL)canSaveSaleBilling
{
    if (_saleBillingItemModels.count == 0) {
        [self showTips:@"请录入商品"];
        return NO;
    }
    
    if ([MFStringUtil isBlankString:_saleBillingModel.phone]) {
        [self showTips:@"请输入会员手机号码"];
        return NO;
    }
    
    if ([MFStringUtil isBlankString:_saleBillingModel.cashier]) {
        [self showTips:@"请选择收银员"];
        return NO;
    }
    
    if ([MFStringUtil isBlankString:_saleBillingModel.guider]) {
        [self showTips:@"请选择导购员"];
        return NO;
    }
    
    return YES;
}

-(void)calculationAllPriceAndReceivablePrice
{
    _allPrice = 0;
    _discountPrice = 0;
    
    for (int i = 0; i < _saleBillingItemModels.count; i++)
    {
        EPSaleBillingItemModel *itemModel = _saleBillingItemModels[i];
        
        _allPrice += itemModel.listPrice.floatValue;
        
        CGFloat receivablePrice = 0;
        
        if (!itemModel.isSpecialDiscount) {
            itemModel.discount = _saleBillingModel.discount;
        }

        receivablePrice = itemModel.listPrice.floatValue * itemModel.discount.floatValue * itemModel.number.floatValue;
        _discountPrice += receivablePrice;
        itemModel.receivablePrice = @(receivablePrice);
    }
    
    _deductionPrice = [EPSaleBillingHelper saleBillingSelectDeductionsValue:_saleBillingDeductions];
}

-(void)reSetTableSubViews
{
    [self calculationAllPriceAndReceivablePrice];
    [_tableView reloadData];
    [_receivablePriceLabel setText:[EPSaleBillingHelper moneyDescWithNumber:@([self receivablePrice])]];
}

-(double)receivablePrice
{
    return (_discountPrice - _deductionPrice);
}

-(void)getItemDetail:(NSString *)itemCode
{
    __weak typeof(self) weakSelf = self;
    
    EPGetGoodsDetailApi *goodsDetailApi = [EPGetGoodsDetailApi new];
    goodsDetailApi.itemCode = itemCode;
    goodsDetailApi.animatingText = @"正在查询商品信息...";
    goodsDetailApi.animatingView = MFAppWindow;
    [goodsDetailApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (!goodsDetailApi.messageSuccess) {
            [strongSelf showTips:goodsDetailApi.errorMessage];
            return;
        }
        
        EPSaleBillingItemModel *itemModel = [EPSaleBillingItemModel MM_modelWithJSON:request.responseJSONObject];
        itemModel.isSpecialDiscount = NO;
        itemModel.discount = @(1.00);
        itemModel.number = @(1);
        
        [_saleBillingItemModels addObject:itemModel];
        
        [strongSelf reSetTableSubViews];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}


-(void)getIndividual:(NSString *)telephone
{
    __weak typeof(self) weakSelf = self;
    
    EPEntitityService *entitityService = [[MMServiceCenter defaultCenter] getService:[EPEntitityService class]];
    
    EPGetIndividualApi *getIndividualApi = [EPGetIndividualApi new];
    getIndividualApi.animatingText = @"正在查询顾客...";
    getIndividualApi.animatingView = MFAppWindow;
    
    getIndividualApi.brandId = [NSString stringWithFormat:@"%@",[entitityService getEntitityFirstBrandId]];
    getIndividualApi.telephone = telephone;
    
    [getIndividualApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!getIndividualApi.messageSuccess) {
            [self showTips:getIndividualApi.errorMessage];
            return;
        }
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        id individualID = request.responseJSONObject[@"individualID"];
        
        if (individualID && ![individualID isKindOfClass:[NSNull class]]) {
            
            _currrentIndividualName = request.responseJSONObject[@"individualName"];
            
            [self showTips:@"会员加载成功"];
            [strongSelf reSetTableSubViews];
            
        }        
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
