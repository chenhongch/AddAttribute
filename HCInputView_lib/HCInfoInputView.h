//
//  IMInfoInputView.h
//  I-Make
//
//  Created by 陈楠 on 17/4/10.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCInfoInputView;

typedef HCInfoInputView *(^inputViewBoolBlock)(BOOL);
typedef void(^inputViewUITextFieldBlock)(UITextField *);
typedef void(^inputViewUILabelBlock)(UILabel *);
typedef void(^inputViewNSStringBlock)(NSString *);

typedef  void(^HCInfoInputViewBlock)(NSString *text);
@protocol HCInfoInputViewDelegate <NSObject>

- (void)hcInfoInputView:(HCInfoInputView *)InputView DidEndEditing:(NSString *)text;

@end

@interface HCInfoInputView : UIView<UITextFieldDelegate>

#pragma mark - Basic setting
/**
 输入框标题
 */
@property (nonatomic,retain)UILabel *infoName;
/**
 输入框
 */
@property (nonatomic,retain)UITextField *textField;

/**
 输入文字 、 cell类型显示文字
 */
@property (nonatomic, copy)NSString *detailText;

/**
 底部分割线---以标题开头
 */
@property (nonatomic,retain)UIView *botSplitline;
/**
 底部下划线铺满
 */
@property (nonatomic, assign)BOOL botSplitCoverline;

/**
 中间分割线 离上下边距 5
 */
@property (nonatomic,retain)UIView *mline;

/**
 是否使用中间分割线并铺满 离上下边距 5
 */
@property (nonatomic, assign)BOOL mcoverLine;

/**
 顶部下划线
 */
@property (nonatomic, retain)UIView *topLine;
/**
 底部分割线
 */
@property (nonatomic, retain)UIView *botLine;
/**
 是否使用顶部分割线
 */
@property (nonatomic, assign)BOOL isTopLined;
/**
 是否使用底部分割线
 */
@property (nonatomic, assign)BOOL isBotLined;

@property (nonatomic, assign)BOOL isInput;

/**
 链式-输入框标题
 */
- (inputViewUILabelBlock)b_infoName;
/**
 链式-输入框
 */
- (inputViewUITextFieldBlock)b_textField;
/**
 链式- 输入文字 、 cell类型显示文字
 */
- (inputViewNSStringBlock)b_detailText;

/**
 链式-底部下划线铺满
 */
- (inputViewBoolBlock)b_botSplitCoverline;
/**
 链式-是否使用中间分割线并铺满 离上下边距 0
 */
- (inputViewBoolBlock)b_mcoverLine;
/**
 链式-是否使用底部分割线
 */
- (inputViewBoolBlock)b_isBotLined;
/**
 链式-是否使用顶部分割线
 */
- (inputViewBoolBlock)b_isTopLined;

/**
 链式-是否使用边框
 */
- (inputViewBoolBlock)b_bordered;
/**
 链式-是否使用圆角
 */
- (inputViewBoolBlock)b_cornered;
/**
 链式-隐藏键盘
 */
- (inputViewBoolBlock)b_isKeyBoard;
/**
 链式-是否只输入价格---其他限制 可自行添加
 */
- (inputViewBoolBlock)b_isLimitPrice;
/**
 链式-是否显示附加图 -默认显示
 */
- (inputViewBoolBlock)b_displayAdd;
/**
 链式- icon_name
 */
- (inputViewNSStringBlock)b_cellImageStr;



#pragma mark - Effect setting
/**
 是否使用边框（仅仅只是外边框）--使用边框，底部分割线不显示,有提示框效果
 如果不需要这种效果 直接 设置控件 layerborderWith
 */
@property (nonatomic, assign)BOOL bordered;
/**
 是否使用圆角
 */
@property (nonatomic, assign)BOOL cornered;

/**
 隐藏键盘
 */
@property (nonatomic, assign)BOOL isKeyBoard;



//initWithFrame---控制输入内容
/**
 是否只输入价格---其他限制 可自行添加
 */
@property (nonatomic, assign)BOOL isLimitPrice;

//cell类型---
@property (nonatomic,retain)UIImageView *cellImageView;
/**
 icon_name
 */
@property (nonatomic, copy)NSString *cellImageStr;

/**
 是否显示附加图 -默认显示
 */
@property (nonatomic,assign)BOOL displayAdd;





#pragma mark - Data back (blokc、delegate)
/**
 IMInfoInputViewDelegate
 */
@property (nonatomic, assign) id<HCInfoInputViewDelegate>delegate;
/**
 IMInfoInputViewBlock
 */
@property (nonatomic, copy)HCInfoInputViewBlock InputViewBlock;




#pragma mark - Basic init
/**
 控件初始化----一般输入框

 @param frame 尺寸
 @param name title
 @param palaceholder 提示文字
 @return 控件对象
 */
- (instancetype)initWithFrame:(CGRect)frame withInfoName:(NSString *)name withInfoPlaceholder:(NSString *)palaceholder;

#pragma mark - Allborder init
/**
 控件初始化- -  全部设置边框(外边框 内边框)
 
 @param frame 尺寸
 @param name title
 @param palaceholder 提示文字
 @return 控件对象
 */
- (instancetype)initWithAllborderFrame:(CGRect)frame withInfoName:(NSString *)name withInfoPlaceholder:(NSString *)palaceholder;

#pragma mark - Allborder init
/**
 控件初始化- -  UITableViewCell类型边框(外边框 内边框)----默认提示文字
 
 @param frame 尺寸
 @param name title
 @return 控件对象
 */
- (instancetype)initWithCellborderFrame:(CGRect)frame withInfoName:(NSString *)name;
//控件初始化- -  UITableViewCell类型输入框自定义
- (instancetype)initWithCellFrame:(CGRect)frame withInfoName:(NSString *)name withDetail:(NSString *)detailText;




@end
