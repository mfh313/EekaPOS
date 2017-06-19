//
//  EPSaleGuideSelectViewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleGuideSelectViewController.h"
#import "EPEntitityEmployeeModel.h"
#import "EPEntitityService.h"
#import "EPSaleGuideSelectCellView.h"

@interface EPSaleGuideSelectViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UISearchBar *_searchBar;
    __weak IBOutlet MFUITableView *_tableView;
    
    NSMutableArray *_entititySallerList;
    
    NSMutableArray *_selectedSallers;
    
}

@end

@implementation EPSaleGuideSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择销售人员";
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    [self setRightNaviButtonWithTitle:@"完成" action:@selector(onClickRightDoneBtn)];
    
    _tableView.rowHeight = 44;
    
    EPEntitityService *entitityService = [[MMServiceCenter defaultCenter] getService:[EPEntitityService class]];
    
    _entititySallerList = [entitityService getEntititySallerList];
    
    if (!_selectedSallers) {
        _selectedSallers = [NSMutableArray array];
    }
}

-(void)onClickRightDoneBtn
{
    if ([self.m_delegate respondsToSelector:@selector(didSelectEmployees:viewController:)]) {
        [self.m_delegate didSelectEmployees:_selectedSallers viewController:self];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _entititySallerList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EPSaleGuideSelectViewController"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil) {
        cell = [[MMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EPSaleGuideSelectViewController"];
        EPSaleGuideSelectCellView *cellView = [EPSaleGuideSelectCellView nibView];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleGuideSelectCellView *cellView = (EPSaleGuideSelectCellView *)cell.m_subContentView;
    
    EPEntitityEmployeeModel *employeeModel = _entititySallerList[indexPath.row];
    
    [cellView setName:employeeModel.contactName];
    
    if ([_selectedSallers containsObject:employeeModel]) {
        [cellView setItemSelected:YES];
    }
    else
    {
        [cellView setItemSelected:NO];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    EPEntitityEmployeeModel *employeeModel = _entititySallerList[indexPath.row];
    
    if ([_selectedSallers containsObject:employeeModel]) {
        [_selectedSallers removeObject:employeeModel];
    }
    else
    {
       [_selectedSallers addObject:employeeModel];
    }
    
    [_tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
