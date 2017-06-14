//
//  UIBarButtonItem+TJPItem.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/8.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TJPItem)

/** 图片创建Item*/
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target andAction:(SEL)action;
/** 通过图片带偏移量创建Item*/
+ (instancetype)itemWithImage:(NSString *)image contentOffset:(UIEdgeInsets)edgeInsets highImage:(NSString *)highImage target:(id)target andAction:(SEL)action;
/** 创建包含文字颜色图片的Item*/
+ (instancetype)itemWithTiele:(NSString *)title titleColor:(UIColor *)titleColor contentOffset:(UIEdgeInsets)edgeInsets image:(NSString *)image target:(id)target andAction:(SEL)action;

/** 文字图片Item*/
+ (instancetype)itemWithTiele:(NSString *)title image:(NSString *)image target:(id)target andAction:(SEL)action;

@end
