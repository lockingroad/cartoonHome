//
//  UIBarButtonItem+TJPItem.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/8.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "UIBarButtonItem+TJPItem.h"

@implementation UIBarButtonItem (TJPItem)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target andAction:(SEL)action {
    
    return [self itemWithImage:image contentOffset:UIEdgeInsetsMake(0, 0, 0, 0) highImage:highImage target:target andAction:action];
}

+ (instancetype)itemWithTiele:(NSString *)title image:(NSString *)image target:(id)target andAction:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    //修改按钮排布方式
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.tjp_width - 15, 0, button.imageView.tjp_width)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width, 0, -button.titleLabel.bounds.size.width)];
    
    return [[self alloc] initWithCustomView:button];
    
}
+ (instancetype)itemWithTiele:(NSString *)title titleColor:(UIColor *)titleColor contentOffset:(UIEdgeInsets)edgeInsets image:(NSString *)image target:(id)target andAction:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    if (!titleColor) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.contentEdgeInsets = edgeInsets;
    [button sizeToFit];

    return [[self alloc] initWithCustomView:button];
}


/** 带偏移量属性*/
+ (instancetype)itemWithImage:(NSString *)image contentOffset:(UIEdgeInsets)edgeInsets highImage:(NSString *)highImage target:(id)target andAction:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.contentEdgeInsets = edgeInsets;
    return [[self alloc] initWithCustomView:button];
}




@end
