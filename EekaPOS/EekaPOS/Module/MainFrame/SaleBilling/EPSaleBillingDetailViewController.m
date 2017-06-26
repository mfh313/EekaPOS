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
#import "EPSaleBillingItemModel.h"
#import "EPSaleBillingDetailHeaderView.h"
#import "EPSaleBillingDetailFooterView.h"
#import "EPSaleBillingDetailDeductionItemView.h"
#import "EPSaleBillingDetailGoodsItemView.h"
#import "EPSaleBillingDetailGoodsItemPriceView.h"
#import "EPSaleBillingDetailTitleItemView.h"
#import "EPSaleBillingHelper.h"
#import "EPUpdateSaleBillingApi.h"
#import "MFMultiMenuTableViewCell.h"

@interface EPSaleBillingDetailViewController () <UITableViewDataSource,UITableViewDelegate,LYSideslipCellDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    EPSaleBillingModel *_saleModel;
    
    EPSaleBillingDetailHeaderView *_headerView;
    EPSaleBillingDetailFooterView *_footerView;
    
    NSMutableArray *_goodsModel;
    NSMutableArray *_deductionModels;
}

@end

@implementation EPSaleBillingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"销售开单详情";
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    _headerView = [EPSaleBillingDetailHeaderView nibView];
    _footerView = [EPSaleBillingDetailFooterView nibView];
    
    _goodsModel = [NSMutableArray array];
    _deductionModels = [NSMutableArray array];
    
    [self getSaleBillingById];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (_goodsModel.count == 0) {
            return 0;
        }
        return 1;
    }
    else if (section == 1)
    {
        return _goodsModel.count;
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
        return _deductionModels.count;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    if (section == 0)
    {
        return 40.0;
    }
    else if (section == 1)
    {
        return 60.0;
    }
    else if (section == 2)
    {
        return 30.0;
    }
    else if (section == 3)
    {
        return 30.0;
    }
    else if (section == 4)
    {
        return 24.0;
    }
    else if (section == 5)
    {
        return 30.0;
    }
    else if (section == 6)
    {
        return 36.0;
    }

    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    if (section == 0)
    {
        return [self tableView:tableView saleBillingGoodsPriceTitleCellForRowAtIndexPath:indexPath];
    }
    else if (section == 1)
    {
        return [self tableView:tableView saleBillingGoodsCellForRowAtIndexPath:indexPath];
    }
    else if (section == 2)
    {
        return [self tableView:tableView amountPriceCellForRowAtIndexPath:indexPath];
    }
    else if (section == 3)
    {
        return [self tableView:tableView discountPriceCellForRowAtIndexPath:indexPath];
    }
    else if (section == 4)
    {
        return [self tableView:tableView deductionItemPriceCellForRowAtIndexPath:indexPath];
    }
    else if (section == 5)
    {
        return [self tableView:tableView trueReceCellForRowAtIndexPath:indexPath];
    }
    else if (section == 6)
    {
        return [self tableView:tableView payTypeCellForRowAtIndexPath:indexPath];
    }
    
    return [UITableViewCell new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView saleBillingGoodsPriceTitleCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsPriceTitleCell"];
    
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodsPriceTitleCell"];
        EPSaleBillingDetailGoodsItemPriceView *cellView = [EPSaleBillingDetailGoodsItemPriceView nibView];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDetailGoodsItemPriceView *cellView = (EPSaleBillingDetailGoodsItemPriceView *)cell.m_subContentView;
    
    [cellView setItemCode:@"商品条码" number:@"数量" listPrice:@"吊牌价" discountPrice:@"折后价"];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView saleBillingGoodsCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFMultiMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EPSaleBillingDetailGoodsItemView"];
    
    if (cell == nil) {
        cell = [[MFMultiMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EPSaleBillingDetailGoodsItemView"];
        cell.delegate = self;
        EPSaleBillingDetailGoodsItemView *cellView = [EPSaleBillingDetailGoodsItemView nibView];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDetailGoodsItemView *cellView = (EPSaleBillingDetailGoodsItemView *)cell.m_subContentView;
    
    [cellView setSaleBillingItemModel:_goodsModel[indexPath.row]];
    
    return cell;
}

#pragma mark - LYSideslipCellDelegate
- (NSArray<LYSideslipCellAction *> *)sideslipCell:(LYSideslipCell *)sideslipCell editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYSideslipCellAction *action = [LYSideslipCellAction rowActionWithStyle:LYSideslipCellActionStyleDestructive title:@"删除" handler:^(LYSideslipCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath)
    {
        [sideslipCell hiddenAllSideslip];
        
        [_goodsModel removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [self updateSaleBilling];
        
    }];
    return @[action];
}

- (BOOL)sideslipCell:(LYSideslipCell *)sideslipCell canSideslipRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView amountPriceCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"amountPriceCell"];
    
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"amountPriceCell"];
        EPSaleBillingDetailTitleItemView *cellView = [EPSaleBillingDetailTitleItemView nibView];
        
        MMOnePixLine *line = [MMOnePixLine new];
        line.frame = CGRectMake(0, 0, CGRectGetWidth(cellView.frame), MFOnePixHeight);
        [cellView addSubview:line];
        
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDetailTitleItemView *cellView = (EPSaleBillingDetailTitleItemView *)cell.m_subContentView;
    
    NSString *amountPrice = [NSString stringWithFormat:@"合计：%.2f元",_saleModel.amountPrice];
    [cellView setTitle:amountPrice];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView discountPriceCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"discountPriceCell"];
    
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"discountPriceCell"];
        EPSaleBillingDetailTitleItemView *cellView = [EPSaleBillingDetailTitleItemView nibView];
        
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDetailTitleItemView *cellView = (EPSaleBillingDetailTitleItemView *)cell.m_subContentView;
    
    CGFloat discountPrice =  [self discountPrice] + [self deductionPrice];
    NSString *discountPriceString = [NSString stringWithFormat:@"优惠金额：%.2f元",discountPrice];
    [cellView setTitle:discountPriceString];
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView deductionItemPriceCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deductionItemPrice"];
    
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deductionItemPrice"];
        EPSaleBillingDetailDeductionItemView *cellView = [EPSaleBillingDetailDeductionItemView nibView];
        
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDetailDeductionItemView *cellView = (EPSaleBillingDetailDeductionItemView *)cell.m_subContentView;
    
    EPSaleBillingDeductionModel *deductionItem = _deductionModels[indexPath.row];
    
    [cellView setTypeName:deductionItem.name value:[NSString stringWithFormat:@"%.2f",deductionItem.value.floatValue]];
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView trueReceCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trueReceCell"];
    
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"trueReceCell"];
        EPSaleBillingDetailTitleItemView *cellView = [EPSaleBillingDetailTitleItemView nibView];
        
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDetailTitleItemView *cellView = (EPSaleBillingDetailTitleItemView *)cell.m_subContentView;
    
    NSString *trueReceString = [NSString stringWithFormat:@"实收金额：%.2f元",_saleModel.trueRece];
    [cellView setTitle:trueReceString];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView payTypeCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payTypeCell"];
    
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"payTypeCell"];
        EPSaleBillingDetailTitleItemView *cellView = [EPSaleBillingDetailTitleItemView nibView];
        [cellView setTitleFont:[UIFont boldSystemFontOfSize:15.0]];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDetailTitleItemView *cellView = (EPSaleBillingDetailTitleItemView *)cell.m_subContentView;
    [cellView setTitle:_saleModel.payType];
    
    return cell;
}

-(CGFloat)discountPrice
{
    CGFloat discountPrice = 0;
    NSMutableArray *itemList = _saleModel.itemList;
    for (int i = 0; i < itemList.count; i++) {
        EPSaleBillingItemModel *item = itemList[i];
        
        discountPrice += item.listPrice.floatValue * (1 - item.discount.floatValue) * item.number.floatValue;
    }
    
    return discountPrice;
}

-(CGFloat)allDiscountAfter
{
    CGFloat allDiscountAfter = 0;
    NSMutableArray *itemList = _saleModel.itemList;
    for (int i = 0; i < itemList.count; i++) {
        EPSaleBillingItemModel *item = itemList[i];
        
        allDiscountAfter += item.listPrice.floatValue * item.discount.floatValue * item.number.floatValue;
    }
    
    return allDiscountAfter;
}

-(CGFloat)deductionPrice
{
    CGFloat deductionPrice = 0;
    for (int i = 0; i < _deductionModels.count; i++) {
        EPSaleBillingDeductionModel *model = _deductionModels[i];
        deductionPrice += model.value.floatValue;
    }
    
    return deductionPrice;
}

-(void)setHeaderAndFooterView
{
    [_headerView setSaleBillingModel:_saleModel];
    CGFloat headerHeight = [_headerView headerHeightForSaleBillingModel:_saleModel headerWidth:CGRectGetWidth(_tableView.frame)];
    _headerView.frame = CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), headerHeight);
    _tableView.tableHeaderView  =_headerView;
    
    [_footerView setPrintDate:[EPSaleBillingHelper dateStringWithDate:[NSDate date]]];
    
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
        
        _goodsModel = [NSMutableArray arrayWithArray:_saleModel.itemList];
        _deductionModels = [EPSaleBillingHelper deductionModelsForString:_saleModel.deductionStr];
        
        [_tableView reloadData];
        
        //收款异常 自行判断 ：收款的钱 小于 应收款的钱~~~
        CGFloat payMoney = [EPSaleBillingHelper payMoneyForString:_saleModel.payType];
        if (_saleModel.status == 30 && payMoney < _saleModel.trueRece) {
            [strongSelf showTips:@"收款异常"];
        }
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(void)updateSaleBilling
{
    _saleModel.itemList = _goodsModel;
    _saleModel.trueRece = [self allDiscountAfter] - [self deductionPrice];
    
    __weak typeof(self) weakSelf = self;
    EPUpdateSaleBillingApi *updateApi = [EPUpdateSaleBillingApi new];
    updateApi.saleBillingModel = _saleModel;
    updateApi.animatingText = @"正在修改...";
    updateApi.animatingView = MFAppWindow;
    [updateApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (!updateApi.messageSuccess) {
            [strongSelf showTips:updateApi.errorMessage];
            return;
        }
        
        [strongSelf showTips:@"修改成功"];
        [strongSelf getSaleBillingById];
        
    } failure:^(YTKBaseRequest * request) {
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
