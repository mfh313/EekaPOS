//
//  MFTableViewCellInfo.h
//  EekaPOS
//
//  Created by EEKA on 2017/6/27.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "MFTableViewUserInfo.h"

@class MFTableViewCell;

@interface MFTableViewCellInfo : MFTableViewUserInfo
{
    SEL _makeSel;
    __weak id _makeTarget;
    SEL _actionSel;
    __weak id _actionTarget;
    SEL _calHeightSel;
    __weak id _calHeightTarget;
    double _fCellHeight;
    UITableViewCellSelectionStyle _selectionStyle;
    UITableViewCellAccessoryType _accessoryType;
    UITableViewCellEditingStyle _editStyle;
    UITextAutocorrectionType _autoCorrectionType;
    UITableViewCellStyle _cellStyle;
    __weak  MFTableViewCell *_cell;
    BOOL _bNeedSeperateLine;
    BOOL _isNeedFixIpadClassic;
    __weak id <NSObject> _actionTargetForSwitchCell;
}

@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic, assign) UITableViewCellEditingStyle editStyle;
@property (nonatomic, assign) UITextAutocorrectionType autoCorrectionType;

@property (nonatomic, assign) BOOL bNeedSeperateLine;
@property (nonatomic, assign) SEL makeSel;
@property (nonatomic, assign) SEL actionSel;
@property (nonatomic, assign) SEL calHeightSel;
@property (nonatomic, weak) id makeTarget;
@property (nonatomic, weak) id actionTarget;
@property (nonatomic, weak) id actionTargetForSwitchCell;
@property (nonatomic, weak) id calHeightTarget;
@property (nonatomic, assign) CGFloat fCellHeight;

@property (nonatomic, weak) MFTableViewCell *cell;

+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue;

@end
