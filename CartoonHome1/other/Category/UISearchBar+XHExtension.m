//
//  UISearchBar+XHExtension.m
//  FengYou
//
//  Created by Walkman on 2017/2/7.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "UISearchBar+XHExtension.h"
#import "UIImageView+XMGExtension.h"


@implementation UISearchBar (XHExtension)

+ (UISearchBar *)setUpHomePageSearchBarWithFrame:(CGRect)frame {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:(CGRectMake(KLeftMargin, 0, frame.size.width, frame.size.height))];
    searchBar.placeholder = @"每天听新故事";
//    searchBar.delegate = self;  //谁用就在谁那设置delegate
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    NSArray *searchBarChildArr = [searchBar.subviews.firstObject subviews];
    
    /** 自定义searchBar的样式*/
    UITextField* searchField = nil;
    // 注意searchBar的textField处于孙图层中
    for (UIView* subview  in searchBarChildArr) {
        /*
         打印出两个结果:
         UISearchBarBackground
         UISearchBarTextField
         */
        if ([subview isKindOfClass:[UITextField class]]) {
            searchField = (UITextField*)subview;
            //修改 搜索框占位符的 放大镜
            searchField.leftView = [UIImageView getSearchImageViewWithFrame:CGRectMake(10, 0, 15, 15)];
            
            [searchField setValue:kUIColorFromRGBA(0xffffff, 1) forKeyPath:@"_placeholderLabel.textColor"];
            [searchField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
            
            // 删除searchBar输入框的背景
            [searchField setBackground:nil];
            [searchField setBorderStyle:UITextBorderStyleNone];
            
            searchField.backgroundColor = kUIColorFromRGBA(0x000000, 0);
            searchField.textColor =kUIColorFromRGB(0xffffff);
            // 设置圆角
            searchField.layer.cornerRadius = 15;
            searchField.layer.masksToBounds = YES;
            break;
        }
    }
    return searchBar;
}

+ (UISearchBar *)setUpSearchViewControllerSearchBarWithFrame:(CGRect)frame {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:frame];
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.tintColor = [UIColor whiteColor];
    searchBar.placeholder = @" 每天听新故事";
    NSArray *searchBarChildArr = [searchBar.subviews.firstObject subviews];
    /** 自定义searchBar的样式*/
    UITextField* searchField = nil;
    // 注意searchBar的textField处于孙图层中
    for (UIView* subview  in searchBarChildArr) {
        //  打印出两个结果: UISearchBarBackground UISearchBarTextField
        if ([subview isKindOfClass:[UITextField class]]) {
            searchField = (UITextField*)subview;
            //修改 搜索框占位符的 放大镜
            searchField.leftView = [UIImageView getSearchImageViewWithFrame:CGRectMake(10, 0, 15, 15)];
            [searchField setValue:kUIColorFromRGBA(0xffffff, 1) forKeyPath:@"_placeholderLabel.textColor"];
            [searchField setValue:kFont(14) forKeyPath:@"_placeholderLabel.font"];
            
            // 删除searchBar输入框的背景
            [searchField setBackground:nil];
            [searchField setBorderStyle:UITextBorderStyleNone];
            
            searchField.backgroundColor = kUIColorFromRGBA(0x000000, 0);
            searchField.textColor = kUIColorFromRGB(0xffffff);
            // 设置圆角
            searchField.layer.cornerRadius = 2;

            
            searchField.layer.borderColor=Global_BGWhite_Color.CGColor;
            searchField.layer.borderWidth = 0.5;
            searchField.layer.masksToBounds = YES;
            break;
        }
    }
    return searchBar;
}




@end
