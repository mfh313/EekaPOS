//
//  EPSaleGuideSelectViewController.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMViewController.h"

@class EPSaleGuideSelectViewController;
@protocol EPSaleGuideSelectViewControllerDelegate <NSObject>

@optional
-(void)didSelectEmployees:(NSMutableArray *)selectEmployees viewController:(EPSaleGuideSelectViewController *)viewController;

@end

@interface EPSaleGuideSelectViewController : MMViewController

@property(nonatomic,weak) id<EPSaleGuideSelectViewControllerDelegate> m_delegate;

@property(nonatomic,strong) NSMutableArray *selectedSallers;

@end
