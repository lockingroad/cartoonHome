//
//  NSString+XMGExtension.h
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/16.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XMGExtension)
/** 计算缓存大小*/
- (unsigned long long)fileSize;


/** 判断是否为中文*/
+ (BOOL)isChinese:(NSString *)str;


/** 计算一段字符串的长度，两个英文字符占一个长度*/
+ (CGFloat)caculateTheStringLength:(NSString *)str;
@end
