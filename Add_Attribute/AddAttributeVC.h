//
//  AddAttributeVC.h
//  AddAttribute
//
//  Created by 陈楠 on 17/8/15.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddAttributeVCBlock)(NSString *text,NSString *textid);

@interface AddAttributeVC : UIViewController

@property (nonatomic, copy)AddAttributeVCBlock block;


@end
