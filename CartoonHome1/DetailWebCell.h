//
//  DetailWebCell.h
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/24.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailWebCell : UITableViewCell
@property(nonatomic,copy)NSString *webContent;
@property(nonatomic,weak)UIWebView *web;
@end
