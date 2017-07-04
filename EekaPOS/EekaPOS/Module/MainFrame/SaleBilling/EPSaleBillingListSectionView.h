//
//  EPSaleBillingListSectionView.h
//  EekaPOS
//
//  Created by EEKA on 2017/7/4.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@protocol EPSaleBillingListSectionViewDelegate <NSObject>

@optional
-(void)onClickSection:(NSInteger)section;

@end

@interface EPSaleBillingListSectionView : MMUIBridgeView

@property (nonatomic,assign) NSInteger section;
@property (nonatomic,weak) id<EPSaleBillingListSectionViewDelegate> m_delegate;

-(void)setIsOpen:(BOOL)open;
-(void)setTimeString:(NSString *)time;
-(void)setMoneyString:(NSString *)moneyString;

@end
