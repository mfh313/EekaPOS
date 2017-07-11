//
//  EPSaleBillingDetailViewController.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/22.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMViewController.h"

@protocol EPSaleBillingDetailViewControllerDelegate <NSObject>

@optional
-(void)saleBillingDidUpdate;

@end

@interface EPSaleBillingDetailViewController : MMViewController

@property(nonatomic,strong) NSNumber *saleBillingId;
@property (nonatomic,weak) id<EPSaleBillingDetailViewControllerDelegate> m_delegate;

@end
