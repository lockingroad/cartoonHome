//
//  CartoonVC.h
//  BasicAFNetTest
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartoonVC : UIViewController

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString *titleID;
-(instancetype)initWithTitleID:(NSString *)title;
@end
