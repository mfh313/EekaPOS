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
#import "EPGetSaleBillingByIdApi.h"

@interface EPSaleBillingListViewController () <UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UIButton *_dateBeginBtn;
    __weak IBOutlet UIButton *_dateEndBtn;
    
    NSString *_dateBegin;
    NSString *_dateEnd;
    
    NSMutableArray *_saleBillingList;
    
    __weak IBOutlet MFUITableView *_tableView;
    
}

@end

@implementation EPSaleBillingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"开单列表";
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    _tableView.rowHeight = 80.0;
    
    _dateEnd = [EPSaleBillingHelper yMDdateStringWithDate:[NSDate date]];
    _dateBegin = [EPSaleBillingHelper getMonthBeginWith:_dateEnd];
    
    NSString *dateBeginBtnTitle = [NSString stringWithFormat:@"%@ 开始",_dateBegin];
    NSString *dateEndBtnTitle = [NSString stringWithFormat:@"%@ 结束",_dateEnd];
    [_dateBeginBtn setTitle:dateBeginBtnTitle forState:UIControlStateNormal];
    [_dateEndBtn setTitle:dateEndBtnTitle forState:UIControlStateNormal];
    
    _saleBillingList = [NSMutableArray array];
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
        
        [_saleBillingList removeAllObjects];
        NSArray *saleBillingLists = request.responseJSONObject[@"saleBillingList"];
        for (int i = 0; i < saleBillingLists.count; i++) {
            EPSaleBillingModel *model = [EPSaleBillingModel MM_modelWithJSON:saleBillingLists[i]];
            [_saleBillingList addObject:model];
        }
        
        [_tableView reloadData];
        
        
        
        
    } failure:^(YTKBaseRequest * request) {
        
        NSString *errorDesc = [NSString stringWithFormat:@"错误状态码=%@\n错误原因=%@",@(request.error.code),[request.error localizedDescription]];
        [self showTips:errorDesc];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _saleBillingList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EPSaleBillingEmployeeSelectView"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil) {
        cell = [[MMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EPSaleBillingEmployeeSelectView"];
        EPSaleBillingListCellView *cellView = [EPSaleBillingListCellView nibView];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingModel *model = _saleBillingList[indexPath.row];
    EPSaleBillingListCellView *cellView = (EPSaleBillingListCellView *)cell.m_subContentView;
    
    [cellView setNames:model.guider];
    [cellView setTimeString:model.sellDate];
    [cellView setStatus:model.status];
    [cellView setMoneyString:[EPSaleBillingHelper moneyDescWithNumber:@(model.trueRece)]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EPSaleBillingModel *model = _saleBillingList[indexPath.row];
    
    
    EPGetSaleBillingByIdApi *getSaleBillingByIdApi = [EPGetSaleBillingByIdApi new];
    getSaleBillingByIdApi.saleBillingId = model.saleBillingID;;
    getSaleBillingByIdApi.animatingText = @"正在获取开单信息...";
    getSaleBillingByIdApi.animatingView = MFAppWindow;
    
    __weak typeof(self) weakSelf = self;
    [getSaleBillingByIdApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (!getSaleBillingByIdApi.messageSuccess) {
            NSLog(@"错误描述=%@",getSaleBillingByIdApi.errorMessage);
            return;
        }
        
        EPSaleBillingModel *model = [EPSaleBillingModel MM_modelWithJSON:request.responseJSONObject];
        
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
