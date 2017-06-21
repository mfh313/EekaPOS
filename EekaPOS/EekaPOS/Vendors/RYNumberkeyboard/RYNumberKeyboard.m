//
//  RYNumberKeyBoard.m
//  RYNumberKeyboardDemo
//
//  Created by Resory on 16/2/20.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import "RYNumberkeyboard.h"

@interface RYNumberKeyboard ()<UIKeyInput>

@property (strong, nonatomic) IBOutlet UIView *keyboardView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

@implementation RYNumberKeyboard

- (id)initWithInputType:(RYInputType)inputType
{
    self = [super init];
    
    if(self)
    {
        // 通知
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(editingDidBegin:)
//                                                     name:UITextFieldTextDidBeginEditingNotification
//                                                   object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(editingDidEnd:)
//                                                     name:UITextFieldTextDidEndEditingNotification
//                                                   object:nil];
        
        // 添加keyboardview
        [[NSBundle mainBundle] loadNibNamed:@"RYNumberKeyboard" owner:self options:nil];
        self.frame = CGRectMake(0, 0, SYS_DEVICE_WIDTH, 216);
        self.keyboardView.frame = self.frame;
        [self addSubview:self.keyboardView];
        
        // 设置图片
        [self.deleteBtn setImage:[UIImage imageNamed:@"RYNumbeKeyboard.bundle/image/delete.png"]
                        forState:UIControlStateNormal];
        
        self.inputType = inputType;
    }
    
    return self;
}

- (void)setInterval:(NSNumber *)interval
{
    _interval = interval;
}

- (void)setInputType:(RYInputType)inputType
{
    UIButton *negativeBtn = [self viewWithTag:1011];
    UIButton *dotBtn = [self viewWithTag:1010];
    
    _inputType = inputType;
    
    switch (inputType)
    {
        // 浮点数键盘
        case RYIntInputType:
        {
            negativeBtn.hidden = YES;
            dotBtn.hidden = NO;
            break;
        }// 浮点数键盘 0 到 1
        case RYFloatZeroToOneInputType:
        {
            negativeBtn.hidden = YES;
            dotBtn.hidden = NO;
            break;
        }
       
        // 小数只能输入两位
        case RYFloat2DigitInputType:
        {
            negativeBtn.hidden = YES;
            dotBtn.hidden = NO;
            break;
        }
        // 小数 包含负数键盘
        case RYFloatContainNegativeInputType:
        {
            negativeBtn.hidden = NO;
            dotBtn.hidden = NO;
            break;
        }
        // 数字键盘
        default:
        {
            negativeBtn.hidden = YES;
            dotBtn.hidden = YES;
            break;
        }
    }
}

- (IBAction)keyboardViewAction:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    
    switch (tag)
    {
        case 1010:
        {
            // 小数点
            if(self.textInput.text.length > 0 && ![self.textInput.text containsString:@"."])
                [self.textInput insertText:@"."];
        }
            break;
        case 1011:
        {
            // 负数-
            if(self.textInput.text.length <= 0  )
            {
                [self.textInput insertText:@"-"];
            }else
            {
                NSString *strTmp = self.textInput.text;
                NSNumber *f = [ NSNumber numberWithFloat: (strTmp.floatValue * (-1))];
                self.textInput.text = [f stringValue];
            }
        }
            break;
        case 1012:
        {
            // 删除
            if(self.textInput.text.length > 0)
                [self.textInput deleteBackward];
        }
            break;
        case 1013:
        {
            // 确认
            [self.textInput resignFirstResponder];
        }
            break;
        default:
        {
            // 数字
            NSString *text = [NSString stringWithFormat:@"%ld",sender.tag - 1000];
            NSString *strTmp = [NSString stringWithFormat:@"%@%@",self.textInput.text,text]; ;
            
            NSPredicate *predicate ;
            if(self.inputType == RYFloatZeroToOneInputType)
            {
               predicate  = [NSPredicate predicateWithFormat:@"self MATCHES %@",@"^([01](\.0+)?|0\.[0-9]+)$"];
            }else
            {
               predicate = [NSPredicate predicateWithFormat:@"self MATCHES %@",@"^-?[0-9]{0,9}[.]?[0-9]{0,4}$"];
            }
            if ([predicate evaluateWithObject:strTmp]) {
                self.textInput.text = strTmp;
            }
        }
            break;
    }
    
    NSString *strTmp = self.textInput.text;
    RYNumberKeyboard *t =  (RYNumberKeyboard*)self.textInput.inputView;
    
    if(tag == 1013)//确定
    {
        if ([ t.ryDelegate respondsToSelector:@selector(ryNumberKeyboardSubmit:tag:)])
        {
            [t.ryDelegate ryNumberKeyboardSubmit:strTmp tag:self.textInput.tag];
        }
    }else
    {
        if ([ t.ryDelegate respondsToSelector:@selector(ryNumberKeyboardValueChange:tag:)])
        {
            [t.ryDelegate ryNumberKeyboardValueChange:strTmp tag:self.textInput.tag];
        }
    }
}

#pragma mark -
#pragma mark - Notification Action
//- (void)editingDidBegin:(NSNotification *)notification {
//    if (![notification.object conformsToProtocol:@protocol(UITextInput)])
//    {
//        self.textInput = nil;
//        return;
//    }
//    self.textInput = notification.object;
//}
//
//- (void)editingDidEnd:(NSNotification *)notification
//{
//    self.textInput = nil;
//}

#pragma mark -
#pragma mark - UIKeyInput Protocol


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
