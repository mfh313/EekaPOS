//
//  EPDatePickView.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/29.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MMUIBridgeView.h"

@class EPDatePickView;
@protocol EPDatePickViewDelegate <NSObject>

@optional
-(void)datePickerViewDidSelected:(NSString *)time viewKey:(NSString *)viewKey datePickView:(EPDatePickView *)datePick;

@end

@interface EPDatePickView : MMUIBridgeView

@property (nonatomic,weak) id<EPDatePickViewDelegate> m_delegate;
@property (nonatomic,strong) NSString *viewKey;

-(void)setDatePickString:(NSString *)time;

@end
