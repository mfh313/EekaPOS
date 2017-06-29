//
//  EPCameraScanViewController.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPCameraScanViewController.h"

@interface EPCameraScanViewController ()
{
    UIView *_bottomItemsView;
    UIButton *_btnFlash;
    UILabel *_tipLabel;
}

@end

@implementation EPCameraScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品条形码扫描";
    
    [self setLeftNaviButtonWithAction:@selector(onClickBackBtn:)];
    
    self.style = [[self class] notSquare];
    self.isOpenInterestRect = YES;
    
}

-(void)onClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setFlashView];
    
}

-(void)setFlashView
{
    if (_bottomItemsView) {
        return;
    }
    
    //设置闪光灯
    _bottomItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-164-50,
                                                                   CGRectGetWidth(self.view.frame), 150)];
    _bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    [self.view addSubview:_bottomItemsView];
    
    NSString *text = @"请将蓝色的中间线条对准需要扫描的条形码";
    
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(_bottomItemsView.frame), 30);
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/2, 15);
    [_tipLabel setText:text];
    _tipLabel.font = [UIFont systemFontOfSize:14.0];
    _tipLabel.textColor = [UIColor redColor];
    [_bottomItemsView addSubview:_tipLabel];
    
    CGSize size = CGSizeMake(65, 87);
    _btnFlash = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnFlash.frame = CGRectMake(0, 0, size.width, size.height);
    _btnFlash.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/2, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [_btnFlash addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomItemsView addSubview:_btnFlash];
}

//开关闪光灯
- (void)openOrCloseFlash
{
    [super openOrCloseFlash];
    
    if (self.isOpenFlash)
    {
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    }
    else
    {
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    }
}

#pragma mark -实现类继承该方法，作出对应处理

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (!array ||  array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
//    经测试，可以ZXing同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {

        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //TODO: 这里可以根据需要自行添加震动或播放声音提示相关代码
    //...
    
    [self showNextVCWithScanResult:scanResult];
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
    
//    __weak __typeof(self) weakSelf = self;
//    [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult buttonsStatement:@[@"知道了"] chooseBlock:^(NSInteger buttonIdx) {
//        
//        [weakSelf reStartDevice];
//    }];
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    UIImage* imgScanned = strResult.imgScanned;
    
    NSString* strScanned = strResult.strScanned;
    
    NSString* strBarCodeType = strResult.strBarCodeType;
    
    
    if ([self.m_delegate respondsToSelector:@selector(onScanQRCodeString:)]) {
        [self.m_delegate onScanQRCodeString:strScanned];
    }
    
}

+ (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (LBXScanViewStyle*)notSquare
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 4;
    style.photoframeAngleW = 28;
    style.photoframeAngleH = 16;
    style.isNeedShowRetangle = NO;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_LineStill;
    style.animationImage = [[self class] createImageWithColor:MFCustomNavBarColor];
    //非正方形
    //设置矩形宽高比
    style.whRatio = 4.3/2.18;
    //离左边和右边距离
    style.xScanRetangleOffset = 30;
    
    return style;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
