//
//  EPLoginViewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/16.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPLoginViewController.h"
#import "EPMemberLoginApi.h"
#import "EPLoginUserModel.h"
#import "EPAccountMgr.h"

@interface EPLoginViewController ()
{
    __weak IBOutlet UITextField *_userNameTextField;
    __weak IBOutlet UITextField *_passwordTextField;
}

@end

@implementation EPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onClickLoginBtn:(id)sender {
    
    NSString *userName = _userNameTextField.text;
    NSString *password = _passwordTextField.text;
    [self onUserLoginUserName:userName Pwd:password];
}


-(void)onUserLoginUserName:(NSString *)userName Pwd:(NSString *)password
{
#ifdef DEBUG
    userName = @"P10198";
    password = @"eeka2012";
#else
    
#endif
    
    if (!userName || !password) {
        return;
    }
    
    EPMemberLoginApi *loginApi = [[EPMemberLoginApi alloc] initWithUsername:userName password:password];
    
    __weak typeof(self) weakSelf = self;
    loginApi.animatingText = @"正在登录...";
    loginApi.animatingView = MFAppWindow;
    
    [loginApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        if (!loginApi.loginSuccess) {
            NSLog(@"loginApi.errorMessage=%@",loginApi.errorMessage);
            return;
        }
        
        EPLoginUserModel *loginModel = [EPLoginUserModel MM_modelWithJSON:request.responseJSONObject];
        EPAccountMgr *accountMgr = [[MMServiceCenter defaultCenter] getService:[EPAccountMgr class]];
        accountMgr.token = loginModel.token;
        accountMgr.loginModel = loginModel;
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf onloginSuccess];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
    
}

-(void)onloginSuccess
{
    [[EPAppViewControllerManager getAppViewControllerManager] createMainTabViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
