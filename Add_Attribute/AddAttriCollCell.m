
//
//  AddAttriCollCell.m
//  AddAttribute
//
//  Created by 陈楠 on 17/8/15.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import "AddAttriCollCell.h"
#import "UIColor+hex.h"
@implementation AddAttriCollCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup{
    
    self.attriTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 80, 35.0f/SCY)];
    [self.contentView addSubview:self.attriTextField];
    self.attriTextField.font = [UIFont systemFontOfSize:13];
    self.attriTextField.textAlignment = NSTextAlignmentCenter;
    self.attriTextField.layer.borderWidth = 1;
    self.attriTextField.layer.borderColor = [[UIColor colorWithHex:@"2693ff"] CGColor];
    self.attriTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.attriTextField.tag = 100 + _section;
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(WI(self.attriTextField) - 15, HE(self.attriTextField) - 15, 15, 15);
    [self.contentView addSubview:self.button];
    [self.button setBackgroundImage:[UIImage imageNamed:@"icon_tagDele"] forState:0];
    [self.button addTarget:self action:@selector(buttonCellAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setSection:(NSInteger)section{
    _section = section;
    self.attriTextField.tag = 100 + section;
}
- (void)setAttriTextField:(UITextField *)attriTextField{
    _attriTextField = attriTextField;
    if (self.attriTextField.text.length>0) {
        self.attriTextField.layer.borderColor = [[UIColor colorWithRed:222/255.0 green:223/255.0 blue:224/255.0 alpha:1] CGColor];
    }
}

- (void)buttonCellAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(AddAttriCollCell:withSection:)]) {
        [self.delegate AddAttriCollCell:self withSection:_section];
    }
}
@end
