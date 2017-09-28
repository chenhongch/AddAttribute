//
//  IMNull.m
//  I-Make
//
//  Created by 陈楠 on 17/3/15.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import "IMNull.h"

@implementation IMNull
#pragma mark - ***** 判断字典是否为空
+ (BOOL)im_helperIsNSDictionaryNULL:(id)obj
{
    if(obj == nil) return YES;
    
    if(![obj isKindOfClass:[NSDictionary class]])
        return YES;
    
    //if([obj count] <= 0) return YES;
    return NO;
}

#pragma mark - ***** 判断字符串是否为空
+ (BOOL)im_helperIsNSStringNULL:(NSString *)stirng
{
    if([stirng isKindOfClass:[NSNull class]]) return YES;
    if(![stirng isKindOfClass:[NSString class]]) return YES;
    
    if(stirng == nil) return YES;
    
    NSString * string1 = [stirng stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSUInteger len=[string1 length];
    if (len <= 0) return YES;
    return NO;
}

#pragma mark - ***** 判断字符串为空 和 只为空格
+ (BOOL)im_helperIsBlankString:(NSString *)string
{
    if (string == nil)
    {
        return YES;
    }
    
    if (string == NULL)
    {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    
    if (string.length==0)
    {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {
        return YES;
    }
    
    return NO;
}

+ (id)im_dictAndArrayIsNull:(id)obj{
        const NSString *blank = @"";
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
            for(NSString *key in [dt allKeys]) {
                id object = [dt objectForKey:key];
                if([object isKindOfClass:[NSNull class]]) {
                    
                    [dt setObject:blank
                           forKey:key];
                }
                else if ([object isKindOfClass:[NSString class]]){
                    NSString *strobj = (NSString*)object;
                    if ([strobj isEqualToString:@"<null>"]) {
                        [dt setObject:blank
                               forKey:key];
                    }
                }
                else if ([object isKindOfClass:[NSArray class]]){
                    NSArray *da = (NSArray*)object;
                    da = [self im_dictAndArrayIsNull:da];
                    [dt setObject:da
                           forKey:key];
                }
                else if ([object isKindOfClass:[NSDictionary class]]){
                    NSDictionary *ddc = (NSDictionary*)object;
                    ddc = [self im_dictAndArrayIsNull:object];
                    [dt setObject:ddc forKey:key];
                }
            }
            return [dt copy];
        }
        else if ([obj isKindOfClass:[NSArray class]]){
            NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
            for (int i=0; i<[da count]; i++) {
                NSDictionary *dc = [obj objectAtIndex:i];
                dc = [self im_dictAndArrayIsNull:dc];
                [da replaceObjectAtIndex:i withObject:dc];
            }
            return [da copy];
        }
        else{
            return obj;
        }
    
}
@end
