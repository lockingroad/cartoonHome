//
//  SearchResultVC.h
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/7.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultVC : UIViewController
@property(nonatomic,copy)void (^didSelectText)(NSString *selectedText);
@end
