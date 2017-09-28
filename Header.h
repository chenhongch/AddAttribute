//
//  Header.h
//  AddAttribute
//
//  Created by 陈楠 on 17/8/15.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#ifndef Header_h
#define Header_h

// 屏幕尺寸
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define SCX 375*kScreenW
#define SCY 667*kScreenH
#define APPBackgroundCorlor RGB(38, 186, 255)
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define WI(v)           (v).frame.size.width
#define HE(v)          (v).frame.size.height
#endif /* Header_h */
