//
//  AddAttriCollReusableView.h
//  AddAttribute
//
//  Created by 陈楠 on 17/8/15.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCInfoInputView.h"
typedef void(^ReusableViewBlock)();
typedef void(^ReusableViewHeaderBlock)(NSString *text,NSInteger section);
@interface AddAttriCollReusableView : UICollectionReusableView
@property (nonatomic, retain)HCInfoInputView *headerInfo;
@property (nonatomic, retain)UIButton *headerBtn;

@property (nonatomic, assign)NSInteger section;

@property (nonatomic, copy)ReusableViewBlock footerBlock;
@property (nonatomic, copy)ReusableViewHeaderBlock headerBlock;
@property (nonatomic, copy)ReusableViewHeaderBlock headerDeleBlock;

- (void)setAttriHeaderTitle:(NSString *)title;
- (void)setAttriFooterTitle:(NSString *)title;

@end
