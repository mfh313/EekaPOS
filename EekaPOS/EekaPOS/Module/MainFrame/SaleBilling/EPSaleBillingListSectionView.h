//
//  EPSaleBillingListSectionView.h
//  EekaPOS
//
//  Created by EEKA on 2017/7/4.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "SLExpandableTableView.h"

@interface EPSaleBillingListSectionView : MMUIBridgeView

-(void)setIsOpen:(BOOL)open;
-(void)setTimeString:(NSString *)time;
-(void)setMoneyString:(NSString *)moneyString;

@end


@class EPSaleBillingListModel;
#pragma mark - EPSaleBillingListSectionCell
@interface EPSaleBillingListSectionCell : MFTableViewCell <UIExpandingTableViewCell>
{
    EPSaleBillingListSectionView *_contentView;
    EPSaleBillingListModel *_listModel;
}

@property (nonatomic, assign, getter = isLoading) BOOL loading;

@property (nonatomic, readonly) UIExpansionStyle expansionStyle;
- (void)setExpansionStyle:(UIExpansionStyle)expansionStyle animated:(BOOL)animated;

- (void)setListModel:(EPSaleBillingListModel *)listModel;

@end
