//
//  XHTextView.h
//  TopicPage
//
//  Created by Walkman on 16/1/14.
//  Copyright © 2016年 Walkman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHTextView : UITextView
/**
 *  @brief 占位符
 */
@property (nonatomic, strong) NSString * placeholder;
/**
 *  @brief 占位符文本颜色
 */
@property (nonatomic, strong) UIColor * placeholderTextColor;


/**
 TextView

 @param textColor 字体颜色
 @param bgColor 背景颜色
 @param font 字号
 @param placeholder 占位符
 @param placeholderColor 占位符颜色
 */
- (void)XHTextViewWithTextColor:(UIColor *)textColor backgroundColor:(UIColor *)bgColor font:(UIFont *)font placeholder:(NSString *)placeholder andPlaceholderColor:(UIColor *)placeholderColor;
@end
