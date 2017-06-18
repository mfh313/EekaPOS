//
//  EPSaleBillingDeductionTypeSelectView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingDeductionTypeSelectView.h"
#import "EPSaleBillingHelper.h"
#import "EPSaleBillingSingleTitleSelectCellView.h"

@interface EPSaleBillingDeductionTypeSelectView ()
{
    __weak IBOutlet UIImageView *_bgImageView;
    
    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet UIView *_bgTapView;
    
    __weak IBOutlet NSLayoutConstraint *_viewHeightConstraint;
    
    NSMutableArray *_deductionTypes;
}
@end

@implementation EPSaleBillingDeductionTypeSelectView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _bgImageView.image = MFImageStretchCenter(@"round");
    self.backgroundColor = [UIColor hx_colorWithHexString:@"#000" alpha:0.3];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _tableView.rowHeight = 44;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [_bgTapView addGestureRecognizer:tapGes];
    
    _deductionTypes = [EPSaleBillingHelper saleBillingDeductionModels];
    
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
    NSInteger rowCount = _deductionTypes.count;
    _viewHeightConstraint.constant = rowCount * _tableView.rowHeight + 40.5;
    
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
    return _deductionTypes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EPSaleBillingEmployeeSelectView"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil) {
        cell = [[MMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EPSaleBillingEmployeeSelectView"];
        EPSaleBillingSingleTitleSelectCellView *cellView = [EPSaleBillingSingleTitleSelectCellView nibView];
        cell.m_subContentView = cellView;
    }
    
    cell.m_subContentView.frame = cell.contentView.bounds;
    
    EPSaleBillingSingleTitleSelectCellView *cellView = (EPSaleBillingSingleTitleSelectCellView *)cell.m_subContentView;
    
    EPSaleBillingDeductionModel *deductionModel = _deductionTypes[indexPath.row];
    
    cellView.nameLabel.text = deductionModel.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    EPSaleBillingDeductionModel *deductionModel = _deductionTypes[indexPath.row];
    
    if ([self.m_delegate respondsToSelector:@selector(didSelectSaleBillingDeductionType:)])
    {
        [self.m_delegate didSelectSaleBillingDeductionType:deductionModel];
    }
    
    [self removeFromSuperview];
}


@end
