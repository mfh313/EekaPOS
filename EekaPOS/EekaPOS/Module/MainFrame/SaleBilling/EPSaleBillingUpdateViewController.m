//
//  EPSaleBillingUpdateViewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/7/11.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleBillingUpdateViewController.h"

@interface EPSaleBillingUpdateViewController ()

@end

@implementation EPSaleBillingUpdateViewController

-(instancetype)init
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SaleBilling" bundle:nil];
    
    self = [storyboard instantiateViewControllerWithIdentifier:@"EPSaleBillingMainViewController"];
    
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
