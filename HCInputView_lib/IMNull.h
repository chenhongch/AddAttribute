//
//  IMNull.h
//  I-Make
//
//  Created by 陈楠 on 17/3/15.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMNull : NSObject
/*!
 *  判断字典是否为空
 *
 *  @param obj 传进来的字典
 *
 *  @return YES：为空，NO：不为空
 */
+ (BOOL)im_helperIsNSDictionaryNULL:(id)obj;

/*!
 *  判断字符串判断是否为空
 *
 *  @param stirng 传进来的字符
 *
 *  @return YES：为空，NO：不为空
 */
+ (BOOL)im_helperIsNSStringNULL:(NSString *)stirng;

/*!
 *  判断字符串为空 和 只为空格
 *
 *  @param string 传进来的字符
 *
 *  @return YES：为空，NO：不为空
 */
+ (BOOL)im_helperIsBlankString:(NSString *)string;

/**
 判断字典和数组里面的值是否为空

 @param obj 传进来的数组或字典
 @return 返回对象
 */
+ (id)im_dictAndArrayIsNull:(id)obj;
@end
