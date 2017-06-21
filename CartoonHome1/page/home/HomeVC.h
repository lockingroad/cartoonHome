//
//  HomeVC.h
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/19.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^bloLeft)();
typedef void (^bloRight)();
@interface HomeVC : UIViewController
@property(nonatomic,copy)bloLeft mBloLeft;
@property(nonatomic,copy)bloRight mBloRight;

@end
