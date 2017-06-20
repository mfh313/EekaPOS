//
//  EPMeViewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPMeViewController.h"

@interface EPMeViewController ()
{
    
}

@end

@implementation EPMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onClickLogutBtn:(id)sender {
    [[EPAppViewControllerManager getAppViewControllerManager] jumpToLoginViewController];
    [[EPAppViewControllerManager getAppViewControllerManager] userLogOut];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
