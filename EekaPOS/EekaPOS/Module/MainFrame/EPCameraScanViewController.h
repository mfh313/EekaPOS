//
//  EPCameraScanViewController.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/17.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "LBXScanViewController.h"

@protocol EPCameraScanDelegate <NSObject>

@optional

- (void)onScanQRCodeString:(NSString *)strScanned;

@end

@interface EPCameraScanViewController : LBXScanViewController

@property(nonatomic,weak) id<EPCameraScanDelegate> m_delegate;

@end
