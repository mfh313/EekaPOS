//
//  EPSaleBillingUpdateViewController.h
//  EekaPOS
//
//  Created by EEKA on 2017/7/11.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingMainViewController.h"

@class EPSaleBillingModel;
@protocol EPSaleBillingUpdateViewControllerDelegate <NSObject>

@optional
-(void)saleBillingDidUpdate:(EPSaleBillingModel *)model;

@end


@interface EPSaleBillingUpdateViewController : EPSaleBillingMainViewController

@property (nonatomic,weak) id<EPSaleBillingUpdateViewControllerDelegate> m_delegate;
@property (nonatomic,strong) EPSaleBillingModel *saleModel;

@end
