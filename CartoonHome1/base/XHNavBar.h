//
//  TJPNavBar.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/7.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHNavBar : UINavigationBar

/**
 *  设置全局的导航栏背景颜色
 */
+ (void)setGlobalBackGroundColor: (UIColor *)color withTintColor: (UIColor *)tintColor;
/**
 *  设置全局导航栏标题颜色, 和文字大小
 *
 *  @param globalTextColor 全局导航栏标题颜色
 *  @param fontSize        全局导航栏文字大小
 */
+ (void)setGlobalTextColor: (UIColor *)globalTextColor andFontSize: (CGFloat)fontSize;

@end
