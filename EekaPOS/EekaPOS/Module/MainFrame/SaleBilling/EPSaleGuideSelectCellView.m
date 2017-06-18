//
//  EPSaleGuideSelectCellView.m
//  EekaPOS
//
//  Created by EEKA on 2017/6/18.
//  Copyright © 2017年 eeka. All rights reserved.
//

#import "EPSaleGuideSelectCellView.h"

@interface EPSaleGuideSelectCellView ()
{
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UIImageView *_selectBox;
}

@end

@implementation EPSaleGuideSelectCellView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [_selectBox setHidden:YES];
}

-(void)setItemSelected:(BOOL)selected
{
    [_selectBox setHidden:!selected];
}

-(void)setName:(NSString *)name
{
    _nameLabel.text = name;
}


@end
