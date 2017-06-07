//
//  UIButton+XHExtension.h
//  FengYou
//
//  Created by Walkman on 2017/2/9.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (XHExtension)

/** 通过fram快速创建button*/
+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font isNeedBorder:(BOOL)needBorder target:(id)target andAction:(SEL)action;



/**
 扩大button点击范围
 
 @param top top
 @param right right
 @param bottom bottom
 @param left left
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;


@end
