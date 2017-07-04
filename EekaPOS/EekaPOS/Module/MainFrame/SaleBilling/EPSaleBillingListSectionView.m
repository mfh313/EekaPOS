//
//  EPSaleBillingListSectionView.m
//  EekaPOS
//
//  Created by EEKA on 2017/7/4.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingListSectionView.h"
#import "EPSaleBillingListModel.h"
#import "EPSaleBillingHelper.h"

@interface EPSaleBillingListSectionView ()
{
    __weak IBOutlet UIButton *_arrowBtn;
    __weak IBOutlet UILabel *_timeLabel;
    __weak IBOutlet UILabel *_moneyLabel;
}

@end

@implementation EPSaleBillingListSectionView

-(void)setIsOpen:(BOOL)open
{
    if (open)
    {
        [_arrowBtn setImage:MFImage(@"sj1") forState:UIControlStateNormal];
    }
    else
    {
        [_arrowBtn setImage:MFImage(@"sj2") forState:UIControlStateNormal];
    }
}

-(void)setTimeString:(NSString *)time
{
    _timeLabel.text = time;
}

-(void)setMoneyString:(NSString *)moneyString
{
    _moneyLabel.text = moneyString;
}

@end


#pragma mark - EPSaleBillingListSectionCell
@implementation EPSaleBillingListSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _contentView = [EPSaleBillingListSectionView nibView];
        _contentView.frame = self.contentView.bounds;
        [self setM_subContentView:_contentView];
    }
    return self;
}

- (void)setLoading:(BOOL)loading
{
    if (loading != _loading) {
        _loading = loading;
        [self _updateDetailView];
    }
}

- (void)setExpansionStyle:(UIExpansionStyle)expansionStyle animated:(BOOL)animated
{
    if (expansionStyle != _expansionStyle) {
        _expansionStyle = expansionStyle;
        [self _updateDetailView];
    }
}

-(void)_updateDetailView
{
    [_contentView setIsOpen:_listModel.isExpand];
    [_contentView setTimeString:_listModel.time];
    [_contentView setMoneyString:[EPSaleBillingHelper moneyDescWithNumber:_listModel.money]];
}

- (void)setListModel:(EPSaleBillingListModel *)listModel
{
    _listModel = listModel;
    
    [self _updateDetailView];
}

@end
