//
//  UISearchBar+XHExtension.h
//  FengYou
//
//  Created by Walkman on 2017/2/7.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (XHExtension)

/** 通过frame 快速创建主页searchBar*/
+ (UISearchBar *)setUpHomePageSearchBarWithFrame:(CGRect)frame;

/** 通过frame 快速创建搜索页searchBar*/
+ (UISearchBar *)setUpSearchViewControllerSearchBarWithFrame:(CGRect)frame;



@end
