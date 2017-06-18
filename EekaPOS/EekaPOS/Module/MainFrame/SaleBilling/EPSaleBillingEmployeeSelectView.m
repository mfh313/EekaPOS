//
//  EPSaleBillingEmployeeSelectView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingEmployeeSelectView.h"
#import "EPEntitityEmployeeModel.h"
#import "EPEntitityService.h"
#import "EPSaleBillingEmployeeSelectCellView.h"

@interface EPSaleBillingEmployeeSelectView () <UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UIImageView *_bgImageView;
    
    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet UIView *_bgTapView;
    
    __weak IBOutlet NSLayoutConstraint *_viewHeightConstraint;
    
    NSMutableArray *_entitityEmployees;
}

@end

@implementation EPSaleBillingEmployeeSelectView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _bgImageView.image = MFImageStretchCenter(@"round");
    self.backgroundColor = [UIColor hx_colorWithHexString:@"#000" alpha:0.3];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    EPEntitityService *entitityService = [[MMServiceCenter defaultCenter] getService:[EPEntitityService class]];
    
    _entitityEmployees = [entitityService getEntitityEmployees];
    
    _tableView.rowHeight = 44;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [_bgTapView addGestureRecognizer:tapGes];

}

-(void)onTap
{
    [self removeFromSuperview];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setTableViewConstaint];
}

-(void)setTableViewConstaint
{
    NSInteger rowCount = _entitityEmployees.count;
    _viewHeightConstraint.constant = rowCount * _tableView.rowHeight + 41;
    
    [_tableView reloadData];
    
    CGFloat maxHeight = CGRectGetHeight(self.bounds) - 100;
    if (_viewHeightConstraint.constant < maxHeight) {
        _tableView.scrollEnabled = NO;
    }
    else
    {
        _viewHeightConstraint.constant =  maxHeight;
        _tableView.scrollEnabled = YES;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _entitityEmployees.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EPSaleBillingEmployeeSelectView"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil) {
        cell = [[MMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EPSaleBillingEmployeeSelectView"];
        EPSaleBillingEmployeeSelectCellView *cellView = [EPSaleBillingEmployeeSelectCellView nibView];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingEmployeeSelectCellView *cellView = (EPSaleBillingEmployeeSelectCellView *)cell.m_subContentView;
    
    EPEntitityEmployeeModel *employeeModel = _entitityEmployees[indexPath.row];
    
    cellView.nameLabel.text = employeeModel.contactName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    EPEntitityEmployeeModel *employeeModel = _entitityEmployees[indexPath.row];
    
    if ([self.m_delegate respondsToSelector:@selector(didSelectEmployee:view:)])
    {
        [self.m_delegate didSelectEmployee:employeeModel view:self];
    }
}


@end
