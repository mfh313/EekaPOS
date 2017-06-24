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
#import "EPSaleBillingDetailGoodsItemView.h"
#import "EPSaleBillingDetailGoodsItemPriceView.h"

@interface EPSaleBillingDetailViewController () <UITableViewDataSource,UITableViewDelegate>
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

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return _saleModel.itemList.count;
    }
    else if (section == 2)
    {
        return 0;
    }
    else if (section == 3)
    {
        return 0;
    }
    else if (section == 4)
    {
        return 0;
    }
    else if (section == 5)
    {
        return 0;
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
        return nil;
    }
    else if (section == 3)
    {
        return nil;
    }
    else if (section == 4)
    {
        return nil;
    }
    else if (section == 5)
    {
        return nil;
    }
    
    return [UITableViewCell new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView saleBillingGoodsPriceTitleCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsPriceTitleCell"];
    
    if (cell == nil) {
        cell = [[MMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodsPriceTitleCell"];
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
    MMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EPSaleBillingDetailGoodsItemView"];
    
    if (cell == nil) {
        cell = [[MMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EPSaleBillingDetailGoodsItemView"];
        EPSaleBillingDetailGoodsItemView *cellView = [EPSaleBillingDetailGoodsItemView nibView];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingDetailGoodsItemView *cellView = (EPSaleBillingDetailGoodsItemView *)cell.m_subContentView;
    
    [cellView setSaleBillingItemModel:_saleModel.itemList[indexPath.row]];
    
    return cell;
}

-(void)setHeaderAndFooterView
{
    [_headerView setSaleBillingModel:_saleModel];
    CGFloat headerHeight = [_headerView headerHeightForSaleBillingModel:_saleModel];
    _headerView.frame = CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), headerHeight);
    
    _tableView.tableHeaderView  =_headerView;
    
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
        [_tableView reloadData];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
