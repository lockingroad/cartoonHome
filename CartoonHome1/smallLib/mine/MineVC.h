//
//  MineViewController.h
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/3.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^logout) ();
@interface MineVC : UIViewController
@property(nonatomic,strong)logout logoutBlock;
@end