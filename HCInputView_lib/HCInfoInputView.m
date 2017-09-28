

//
//  IMInfoInputView.m
//  I-Make
//
//  Created by 陈楠 on 17/4/10.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import "HCInfoInputView.h"
#import "UIColor+hex.h"
#import "IMNull.h"

#define CommonGrayWhite [UIColor colorWithRed:222/255.0 green:223/255.0 blue:224/255.0 alpha:1]
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HE(v)          (v).frame.size.height
#define InputSFont(a)     [UIFont systemFontOfSize:a]
#define MaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define MaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度


@interface HCInfoInputView()
@property (nonatomic ,retain)UIButton *cellBtn;
@property (nonatomic ,retain)UILabel *detailLable;


@property (nonatomic, strong) NSString *max; // 默认99999.99
@property (nonatomic, strong) NSString *tempText;
@property (nonatomic, assign) NSRange tempRange;
@property (nonatomic, strong) NSString *tempString;



@end

@implementation HCInfoInputView


- (instancetype)initWithFrame:(CGRect)frame withInfoName:(NSString *)name withInfoPlaceholder:(NSString *)palaceholder{
    self = [super initWithFrame:frame];
    if (self) {
         _max = @"999999999.99";
        _isLimitPrice = NO;
        self.backgroundColor = [UIColor whiteColor];
        UIView *topline = [[UIView alloc]initWithFrame:CGRectMake(0, 1, frame.size.width, 1)];
        topline.backgroundColor = CommonGrayWhite;
        topline.hidden = YES;
        [self addSubview:topline];
        _isTopLined = topline;
        
        self.backgroundColor = [UIColor whiteColor];
        CGFloat viewY = frame.size.height;
        NSString *nameStr = [NSString stringWithFormat:@"%@ ",name];
        CGSize nameSize = [nameStr sizeWithAttributes:@{NSFontAttributeName:InputSFont(16)}];
        UILabel *infoName = [[UILabel alloc]initWithFrame:CGRectMake(20, 0 , nameSize.width,viewY )];
        infoName.font = InputSFont(15);
        infoName.text = nameStr;
        infoName.textColor = [UIColor colorWithHex:@"444444"];
        [self addSubview:infoName];
        self.infoName = infoName;
        
        UIView *mline = [[UIView alloc]initWithFrame:CGRectMake(MaxX(infoName)+5, 5, 1, HE(self) - 10)];
        mline.backgroundColor = CommonGrayWhite;
        mline.hidden = YES;
        [self addSubview:mline];
        self.mline = mline;
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(MaxX(infoName)+10, 0, frame.size.width-(MaxX(infoName)+10), viewY)];
        textField.placeholder = palaceholder;
        textField.returnKeyType = UIReturnKeyDone;
        textField.font = InputSFont(14);
        [self addSubview:textField];
        textField.delegate = self;
        self.textField = textField;
        
        UIView *botSplitLine = [[UIView alloc]initWithFrame:CGRectMake(MaxX(infoName)+5, frame.size.height/2+13, frame.size.width-(MaxX(infoName)+10), 1)];
        botSplitLine.backgroundColor = CommonGrayWhite;
        [self addSubview:botSplitLine];
        botSplitLine.hidden = YES;
        self.botSplitline = botSplitLine;
        
        
        UIView *botline = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        botline.backgroundColor = CommonGrayWhite;
        botline.hidden = YES;
        [self addSubview:botline];
        _botLine = botline;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardChange) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (instancetype)initWithAllborderFrame:(CGRect)frame withInfoName:(NSString *)name withInfoPlaceholder:(NSString *)palaceholder{
    self = [super initWithFrame:frame];
    if (self) {
         _max = @"999999999.99";
         self.backgroundColor = [UIColor whiteColor];
        UIView *tLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        tLine.backgroundColor = CommonGrayWhite;
        [self addSubview:tLine];
        
        CGFloat viewY = frame.size.height;
        NSString *nameStr = [NSString stringWithFormat:@"%@ ",name];
        CGSize nameSize = [nameStr sizeWithAttributes:@{NSFontAttributeName:InputSFont(15)}];
        
        UILabel *infoName = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(tLine.frame) , nameSize.width,viewY )];
        infoName.font = InputSFont(15);
        infoName.textAlignment = NSTextAlignmentCenter;
        infoName.text = nameStr;
        infoName.textColor = [UIColor colorWithHex:@"444444"];
        [self addSubview:infoName];
        self.infoName = infoName;
        
        UIView *hLine = [[UIView alloc]initWithFrame:CGRectMake(MaxX(infoName)+20, 0, 1, frame.size.height)];
        hLine.backgroundColor = CommonGrayWhite;
        [self addSubview:hLine];
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(MaxX(hLine)+5, 0, frame.size.width-(MaxX(hLine)+5), viewY)];
        textField.placeholder = palaceholder;
        textField.returnKeyType = UIReturnKeyDone;
        textField.font = InputSFont(14);
        [self addSubview:textField];
        textField.delegate = self;
        self.textField = textField;
        
        UIView *bLine = [[UIView alloc]initWithFrame:CGRectMake(0, MaxY(textField)+1, frame.size.width, 1)];
        bLine.backgroundColor = CommonGrayWhite;
        [self addSubview:bLine];
        
        
       
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardChange) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (instancetype)initWithCellborderFrame:(CGRect)frame withInfoName:(NSString *)name{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *topline = [[UIView alloc]initWithFrame:CGRectMake(0, 1, frame.size.width, 1)];
        topline.backgroundColor = CommonGrayWhite;
        topline.hidden = YES;
        [self addSubview:topline];
        _isTopLined = topline;
        
        self.backgroundColor = [UIColor whiteColor];
        CGFloat viewY = frame.size.height;
        NSString *nameStr = [NSString stringWithFormat:@"%@ ",name];
        CGSize nameSize = [nameStr sizeWithAttributes:@{NSFontAttributeName:InputSFont(16)}];
        
        UILabel *infoName = [[UILabel alloc]initWithFrame:CGRectMake(20, 0 , nameSize.width,viewY )];
        infoName.font = InputSFont(15);
        infoName.text = nameStr;
        infoName.textColor = [UIColor colorWithHex:@"444444"];
        [self addSubview:infoName];
        
        UIView *mline = [[UIView alloc]initWithFrame:CGRectMake(MaxX(infoName)+5, 5, 1, HE(self) - 10)];
        mline.backgroundColor = CommonGrayWhite;
        mline.hidden = YES;
        [self addSubview:mline];
        self.mline = mline;
        NSString *btnStr = @"广西壮族自治区南邻市金融城南路";
        CGSize btnSize = [btnStr sizeWithAttributes:@{NSFontAttributeName : InputSFont(14)}];
        
        UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width - btnSize.width-35, 0, btnSize.width, viewY)];
        detailLab.textColor = [UIColor colorWithHex:@"999999"];
        detailLab.font = InputSFont(12);
        detailLab.text = @"请选择";
        detailLab.textAlignment =NSTextAlignmentRight;
        [self addSubview:detailLab];
        self.detailLable = detailLab;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, frame.size.width, viewY) ;
        btn.titleLabel.font = InputSFont(14);
        [btn setTitleColor:[UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1] forState:0];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btn addTarget:self action:@selector(cellWithAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _cellBtn = btn;
        
        UIImageView *nextImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 30, 11, 15, 20)];
        nextImage.image = [UIImage imageNamed:@"nextArrow"];
        [self addSubview:nextImage];
        
        UIView *botline = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        botline.backgroundColor = CommonGrayWhite;
        botline.hidden = YES;
        [self addSubview:botline];
        _botLine = botline;
        
    }
    return self;
}
- (void)setDetailText:(NSString *)detailText{
    _detailText = detailText;
    _detailLable.text = detailText;
    _detailLable.textColor = [UIColor colorWithHex:@"666666"];
    self.textField.text = _detailText;
}
- (void)cellWithAction{
    if (self.InputViewBlock) {
        self.InputViewBlock(_textField.text);
    }
}
- (void)setIsInput:(BOOL)isInput{
    _isInput = isInput;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(MaxX(_infoName)+10, 0, self.frame.size.width-(MaxX(_infoName)+10),self.frame.size.height)  ;
    btn.titleLabel.font = InputSFont(14);
    [btn setTitleColor:[UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1] forState:0];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:self action:@selector(cellWithAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)KeyboardChange{
      self.layer.borderColor = [CommonGrayWhite CGColor];
    if ([IMNull im_helperIsNSStringNULL:_textField.text]) {
        return;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(hcInfoInputView:DidEndEditing:)]) {
         [self.delegate hcInfoInputView:self DidEndEditing:_textField.text];
    }
    if (self.InputViewBlock) {
        self.InputViewBlock(_textField.text);
    }
}


- (void)layoutSubviews{
    if (_bordered) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [CommonGrayWhite CGColor];
        self.botSplitline.hidden = YES;
    }else{
        self.layer.borderWidth = 0;
    }
    if (_cornered) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    
    
        if (_botSplitCoverline) {
            self.botSplitline.hidden = NO;
            self.botSplitline.frame = CGRectMake(0, self.frame.size.height/2+15, self.frame.size.width, 1);
        }else{
            self.botSplitline.frame = CGRectMake(MaxX(_infoName)+5, self.frame.size.height/2+13, self.frame.size.width-(MaxX(_infoName)+10), 1);
        }
    
    if (_mcoverLine) {
        self.mline.hidden = NO;
    }

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_bordered) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor redColor] CGColor];
    }
    if ([IMNull im_helperIsNSStringNULL:_textField.text]) {
        return;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (_bordered) {
        self.layer.borderColor = [CommonGrayWhite CGColor];
    }
    if ([IMNull im_helperIsNSStringNULL:_textField.text]) {
        return;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(hcInfoInputView:DidEndEditing:)]) {
        [self.delegate hcInfoInputView:self DidEndEditing:textField.text];
    }
    
    if (self.InputViewBlock) {
           self.InputViewBlock(textField.text);
    }
  
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_bordered) {
        self.layer.borderColor = [CommonGrayWhite CGColor];
        }
    [textField resignFirstResponder];
    if ([IMNull im_helperIsNSStringNULL:_textField.text]) {
        return YES;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(hcInfoInputView:DidEndEditing:)]) {
        [self.delegate hcInfoInputView:self DidEndEditing:textField.text];
    }
    if (self.InputViewBlock) {
         self.InputViewBlock(textField.text);
    }
   
    return YES;
}

- (instancetype)initWithCellFrame:(CGRect)frame withInfoName:(NSString *)name withDetail:(NSString *)detailText{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        UIView *topline = [[UIView alloc]initWithFrame:CGRectMake(0, 1, frame.size.width, 1)];
        topline.backgroundColor = CommonGrayWhite;
        topline.hidden = YES;
        [self addSubview:topline];
        _isTopLined = topline;
        
        CGFloat viewY = frame.size.height;
        NSString *nameStr = [NSString stringWithFormat:@"%@ ",name];
        CGSize nameSize = [nameStr sizeWithAttributes:@{NSFontAttributeName:InputSFont(16)}];
        
        UILabel *infoName = [[UILabel alloc]initWithFrame:CGRectMake(20, 0 , nameSize.width,viewY )];
        infoName.font = [UIFont systemFontOfSize:15];
        infoName.text = nameStr;
        infoName.textColor = RGB(102, 102, 102);
        [self addSubview:infoName];
        
        UIView *mline = [[UIView alloc]initWithFrame:CGRectMake(MaxX(infoName)+5, 5, 1, HE(self) - 10)];
        mline.backgroundColor = CommonGrayWhite;
        mline.hidden = YES;
        [self addSubview:mline];
    
        NSString *btnStr = @"广西壮族自治区南邻市金融城南路市金融城南路";
        CGSize btnSize = [btnStr sizeWithAttributes:@{NSFontAttributeName : InputSFont(14)}];
        
        UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width - btnSize.width-35, 0, btnSize.width, viewY)];
        detailLab.text = detailText;
        detailLab.textAlignment = NSTextAlignmentRight;
        detailLab.textColor = [UIColor colorWithHex:@"999999"];
        detailLab.font = InputSFont(12);
        [self addSubview:detailLab];
        self.detailLable = detailLab;

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, frame.size.width, viewY) ;
        btn.titleLabel.font = InputSFont(14);
        [btn setTitleColor:[UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1] forState:0];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btn addTarget:self action:@selector(cellWithAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _cellBtn = btn;
        
        UIImageView *nextImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 30, (frame.size.height - btnSize.height)/2, 10, btnSize.height)];
        nextImage.image = [UIImage imageNamed:@"nextArrow"];
        [self addSubview:nextImage];
        _cellImageView = nextImage;
        
        UIView *botline = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        botline.backgroundColor = CommonGrayWhite;
        botline.hidden = YES;
        [self addSubview:botline];
        _botLine = botline;

        
    }
    return self;
}

- (void)setDisplayAdd:(BOOL)displayAdd{
    _displayAdd = displayAdd;
    _cellImageView.hidden = displayAdd;
}
- (void)setCellImageStr:(NSString *)cellImageStr{
    _cellImageStr = cellImageStr;
    _cellImageView.image = [UIImage imageNamed:cellImageStr];
}

- (void)setIsBotLined:(BOOL)isBotLined{
    _isBotLined = isBotLined;
    _botLine.hidden = isBotLined;
}

- (void)setIsTopLined:(BOOL)isTopLined{
    _isTopLined = isTopLined;
    _topLine.hidden = isTopLined;
}

- (void)setIsKeyBoard:(BOOL)isKeyBoard{
    _isKeyBoard = isKeyBoard;
    if (isKeyBoard) {
         [self.textField resignFirstResponder];
    }
   
}




#pragma mark------------UITextFieldDelegate---------------
//限制只能输入金额的正则表达式
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (_isLimitPrice) {
        NSString * str = [NSString stringWithFormat:@"%@%@",textField.text,string];
        //匹配以0开头的数字
        NSPredicate * predicate0 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0][0-9]+$"];
        //匹配两位小数、整数
        NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(([1-9]{1}[0-9]*|[0])\\.?[0-9]{0,2})$"];
        return ![predicate0 evaluateWithObject:str] && [predicate1 evaluateWithObject:str] ? YES : NO;
    }
    
    return YES;
}



//****************************************************
/**
 链式-输入框标题
 */
- (inputViewUILabelBlock)b_infoName{
    return ^(UILabel *lab){
        self.infoName = lab;
    };
}
/**
 链式-输入框
 */
- (inputViewUITextFieldBlock)b_textField{
    return ^(UITextField *fie){
        self.textField = fie;
    };
}
/**
 链式- 输入文字 、 cell类型显示文字
 */
- (inputViewNSStringBlock)b_detailText{
    return ^(NSString *str){
        self.textField.text = str;
    };
}

/**
 链式-底部下划线铺满
 */
- (inputViewBoolBlock)b_botSplitCoverline{
    return ^(BOOL bo){
        self.botSplitCoverline = bo;
        return self;
    };
}
/**
 链式-是否使用中间分割线并铺满 离上下边距 0
 */
- (inputViewBoolBlock)b_mcoverLine{
    return ^(BOOL bo){
        self.mcoverLine = bo;
          return self;
    };
}

/**
 链式-是否使用底部分割线
 */
- (inputViewBoolBlock)b_isBotLined{
    return ^(BOOL bo){
        self.isBotLined = bo;
          return self;
    };
}

/**
 链式-是否使用顶部分割线
 */
- (inputViewBoolBlock)b_isTopLined{
    return ^(BOOL bo){
        self.isTopLined = bo;
          return self;
    };
}


/**
 链式-是否使用边框
 */
- (inputViewBoolBlock)b_bordered{
    return ^(BOOL bo){
        self.bordered = bo;
          return self;
    };
}

/**
 链式-是否使用圆角
 */
- (inputViewBoolBlock)b_cornered{
    return ^(BOOL bo){
        self.cornered = bo;
          return self;
    };
}

/**
 链式-隐藏键盘
 */
- (inputViewBoolBlock)b_isKeyBoard{
    return ^(BOOL bo){
        self.isKeyBoard = bo;
          return self;
    };
}

/**
 链式-是否只输入价格---其他限制 可自行添加
 */
- (inputViewBoolBlock)b_isLimitPrice{
    return ^(BOOL bo){
        self.isLimitPrice = bo;
        return self;
    };
}

/**
 链式-是否显示附加图 -默认显示
 */
- (inputViewBoolBlock)b_displayAdd{
    return ^(BOOL bo){
        self.displayAdd = bo;
        return self;
    };
}

/**
 链式- icon_name
 */
- (inputViewNSStringBlock)b_cellImageStr{
    return ^(NSString *str){
        self.cellImageView.image = [UIImage imageNamed:str];
    };
}



@end
