//
//  EPSaleBillingListViewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/20.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingListViewController.h"
#import "EPSaleBillingHelper.h"
#import "EPGetSaleBillingListApi.h"
#import "EPSaleBillingListCellView.h"
#import "EPSaleBillingModel.h"
#import "EPDeleteSaleBillingApi.h"
#import "EPSaleBillingDetailViewController.h"
#import "MFMultiMenuTableViewCell.h"
#import "EPDatePickView.h"
#import "EPSaleBillingListSectionView.h"
#import "EPSaleBillingListModel.h"

@interface EPSaleBillingListViewController () <UITableViewDataSource,UITableViewDelegate,LYSideslipCellDelegate,EPDatePickViewDelegate,EPSaleBillingListSectionViewDelegate>
{
    __weak IBOutlet UIButton *_dateBeginBtn;
    __weak IBOutlet UIButton *_dateEndBtn;
    
    NSString *_dateBegin;
    NSString *_dateEnd;
    
    __weak IBOutlet MFUITableView *_tableView;
    NSMutableArray *_sectionsArray;
}

@end

@implementation EPSaleBillingListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

- (IBAction)onClickBeginDate:(id)sender {
    [self showDatePick:_dateBegin viewKey:@"dateBegin"];
}

- (IBAction)onClickBeginEnd:(id)sender {
    [self showDatePick:_dateEnd viewKey:@"dateEnd"];
}

-(void)showDatePick:(NSString *)dateString viewKey:(NSString *)viewKey
{
    EPDatePickView *datePicker = [EPDatePickView nibView];
    datePicker.m_delegate = self;
    datePicker.frame = MFAppWindow.bounds;
    
    [datePicker setDatePickString:dateString];
    datePicker.viewKey = viewKey;
    
    [MFAppWindow addSubview:datePicker];
}

#pragma mark - EPDatePickViewDelegate
-(void)datePickerViewDidSelected:(NSString *)time viewKey:(NSString *)viewKey datePickView:(EPDatePickView *)datePick
{
    if ([viewKey isEqualToString:@"dateBegin"]) {
        _dateBegin = time;
    }
    else if ([viewKey isEqualToString:@"dateEnd"])
    {
        _dateEnd = time;
    }
    
    [datePick removeFromSuperview];
    [self setDateBeginAndEndTitle];
    [self getSaleBillingList];
}

-(void)setDateBeginBtnTitle
{
    NSString *dateBeginBtnTitle = [NSString stringWithFormat:@"%@ 开始",_dateBegin];
    [_dateBeginBtn setTitle:dateBeginBtnTitle forState:UIControlStateNormal];
}

-(void)setDateEndBtnTitle
{
    NSString *dateEndBtnTitle = [NSString stringWithFormat:@"%@ 结束",_dateEnd];
    [_dateEndBtn setTitle:dateEndBtnTitle forState:UIControlStateNormal];
}

-(void)setDateBeginAndEndTitle
{
    [self setDateBeginBtnTitle];
    [self setDateEndBtnTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"开单列表";
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    _dateEnd = [EPSaleBillingHelper yMDdateStringWithDate:[NSDate date]];
    _dateBegin = [EPSaleBillingHelper getMonthBeginWith:_dateEnd];
    [self setDateBeginAndEndTitle];
    
    _tableView.rowHeight = 80.0;
    _tableView.sectionHeaderHeight = 66.0;
    
    _sectionsArray = [NSMutableArray array];
    [self getSaleBillingList];
}

-(void)getSaleBillingList
{
    EPAccountMgr *accountMgr = [[MMServiceCenter defaultCenter] getService:[EPAccountMgr class]];

    EPGetSaleBillingListApi *listApi = [EPGetSaleBillingListApi new];
    listApi.startDate = _dateBegin;
    listApi.endDate = _dateEnd;
    listApi.entityName = accountMgr.loginModel.fullname;
    
    __weak typeof(self) weakSelf = self;
    listApi.animatingText = @"正在获取开单列表...";
    listApi.animatingView = MFAppWindow;
    [listApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (!listApi.messageSuccess) {
            [strongSelf showTips:listApi.errorMessage];
            return;
        }
        
        NSMutableArray *saleBillingList = [NSMutableArray array];
        NSArray *saleBillingLists = request.responseJSONObject[@"saleBillingList"];
        for (int i = 0; i < saleBillingLists.count; i++) {
            EPSaleBillingModel *model = [EPSaleBillingModel MM_modelWithJSON:saleBillingLists[i]];
            [saleBillingList addObject:model];
        }
        
        [_sectionsArray removeAllObjects];
        
        EPSaleBillingListModel *model = [EPSaleBillingListModel new];
        model.isExpand = NO;
        model.time = @"2017-07-02";
        model.money = @(11.00);
        model.models = saleBillingList;
        
        EPSaleBillingListModel *model1 = [EPSaleBillingListModel new];
        model1.isExpand = NO;
        model1.time = @"2017-07-04";
        model1.money = @(123.00);
        model1.models = saleBillingList;
        
        EPSaleBillingListModel *model2 = [EPSaleBillingListModel new];
        model2.isExpand = NO;
        model2.time = @"2017-07-06";
        model2.money = @(145.00);
        model2.models = saleBillingList;
        
        [_sectionsArray addObject:model];
        [_sectionsArray addObject:model1];
        [_sectionsArray addObject:model2];
        
        for (int i = 0; i < 10; i++) {
            EPSaleBillingListModel *model = [EPSaleBillingListModel new];
            model.isExpand = NO;
            model.time = @"2017-07-02";
            model.money = @(11.00);
            model.models = saleBillingList;
            [_sectionsArray addObject:model];
        }
        
        if (_sectionsArray.count > 0) {
            ((EPSaleBillingListModel *)_sectionsArray.firstObject).isExpand = YES;
        }
        
        [_tableView reloadData];
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    EPSaleBillingListModel *listModel = _sectionsArray[section];
    if (listModel.isExpand) {
        return listModel.models.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFMultiMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EPSaleBillingListCellView"];
  
    if (cell == nil) {
        cell = [[MFMultiMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EPSaleBillingListCellView"];
        cell.delegate = self;
        
        EPSaleBillingListCellView *cellView = [EPSaleBillingListCellView nibView];
        cell.m_subContentView = cellView;
    }
    
    [cell addSelectedBackgroundView];
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingListModel *listModel = _sectionsArray[indexPath.section];
    EPSaleBillingModel *model = listModel.models[indexPath.row];
    
    EPSaleBillingListCellView *cellView = (EPSaleBillingListCellView *)cell.m_subContentView;
    
    [cellView setNames:model.guider];
    [cellView setTimeString:model.sellDate];
    [cellView setStatus:model.status model:model];
    [cellView setMoneyString:[EPSaleBillingHelper moneyDescWithNumber:@(model.trueRece)]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 60)];
    
    EPSaleBillingListSectionView *sectionView = [EPSaleBillingListSectionView nibView];
    sectionView.m_delegate = self;
    sectionView.frame = view.bounds;
    sectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [view addSubview:sectionView];
    
    EPSaleBillingListModel *listModel = _sectionsArray[section];
    sectionView.section = section;
    [sectionView setIsOpen:listModel.isExpand];
    [sectionView setTimeString:listModel.time];
    [sectionView setMoneyString:[EPSaleBillingHelper moneyDescWithNumber:listModel.money]];
    
    return view;
}

#pragma mark - EPSaleBillingListSectionViewDelegate
-(void)onClickSection:(NSInteger)section
{
    EPSaleBillingListModel *listModel = _sectionsArray[section];
    listModel.isExpand = !listModel.isExpand;
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - LYSideslipCellDelegate
- (NSArray<LYSideslipCellAction *> *)sideslipCell:(LYSideslipCell *)sideslipCell editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYSideslipCellAction *action = [LYSideslipCellAction rowActionWithStyle:LYSideslipCellActionStyleDestructive title:@"删除" handler:^(LYSideslipCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath)
                                    {
                                        [sideslipCell hiddenAllSideslip];
                                        EPSaleBillingListModel *listModel = _sectionsArray[indexPath.section];
                                        EPSaleBillingModel *model = listModel.models[indexPath.row];
                                        
                                        [self deleteSaleBilling:model.saleBillingID];
                                        
                                    }];
    return @[action];
}

- (BOOL)sideslipCell:(LYSideslipCell *)sideslipCell canSideslipRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EPSaleBillingListModel *listModel = _sectionsArray[indexPath.section];
    EPSaleBillingModel *model = listModel.models[indexPath.row];
    
    [self pushSaleBillingDetailViewController:model.saleBillingID];
}

-(void)pushSaleBillingDetailViewController:(NSNumber *)saleBillingId
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SaleBilling" bundle:nil];
    EPSaleBillingDetailViewController *saleBillingDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"EPSaleBillingDetailViewController"];
    saleBillingDetailVC.hidesBottomBarWhenPushed = YES;
    saleBillingDetailVC.saleBillingId = saleBillingId;
    [self.navigationController pushViewController:saleBillingDetailVC animated:YES];
}

-(void)deleteSaleBilling:(NSNumber *)saleBillingID
{
    EPDeleteSaleBillingApi *deleteApi = [EPDeleteSaleBillingApi new];
    deleteApi.saleBillingID = saleBillingID;
    
    __weak typeof(self) weakSelf = self;
    deleteApi.animatingText = @"正在删除...";
    deleteApi.animatingView = MFAppWindow;
    [deleteApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!deleteApi.messageSuccess) {
            [strongSelf showTips:deleteApi.errorMessage];
            return;
        }
        
        [strongSelf getSaleBillingList];
 
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
