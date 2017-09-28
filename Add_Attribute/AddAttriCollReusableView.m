
//
//  AddAttriCollReusableView.m
//  AddAttribute
//
//  Created by 陈楠 on 17/8/15.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import "AddAttriCollReusableView.h"
#import "UIColor+hex.h"
@implementation AddAttriCollReusableView

/**
 header

 @param title 标题
 */
- (void)setAttriHeaderTitle:(NSString *)title{
    __weak __typeof(&*self)weakSelf = self;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
    view.backgroundColor = [UIColor whiteColor];
    view.tag = _section+10;
    [self addSubview:view];

    HCInfoInputView *infoView = [[HCInfoInputView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 40) withInfoName:@"规格名" withInfoPlaceholder:@"填写规格名，如颜色"];
    [view addSubview:infoView];
    self.headerInfo = infoView;
    infoView.InputViewBlock = ^(NSString *text){
        weakSelf.headerBlock(text,view.tag - 10);
    };
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(WI(infoView) - 50, 10, 22, 22);
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_delete"] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:APPBackgroundCorlor forState:0];
    [btn addTarget:self action:@selector(btnWithheaderAction:) forControlEvents:UIControlEventTouchUpInside];
    [infoView addSubview:btn];
    btn.tag = 1000+_section;
    self.headerBtn = btn;
    
}

/**
 Footer

 @param title 标题
 */
- (void)setAttriFooterTitle:(NSString *)title{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 35)];
    [self addSubview:view];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 0, kScreenW - 30, 35);
    [btn setTitle:@"添加规格参数" forState:0];
    [btn setImage:[UIImage imageNamed:@"icon_blueAdd"] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor colorWithHex:@"2693ff"] forState:0];
    [btn addTarget:self action:@selector(btnWithFooterAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];

}
- (void)btnWithFooterAction{
    if (self.footerBlock) {
        self.footerBlock(@"");
    }
}
- (void)btnWithheaderAction:(UIButton *)sender{
    if (self.headerDeleBlock) {
        self.headerDeleBlock(@"",sender.tag - 1000);
    }
}


@end
