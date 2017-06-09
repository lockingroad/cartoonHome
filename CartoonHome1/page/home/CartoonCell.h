//
//  CartoonCell.h
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CartoonsInfo;
@interface CartoonCell : UITableViewCell
@property(nonatomic,strong)CartoonsInfo *info;
@property(nonatomic,weak)UIImageView *imgView;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
