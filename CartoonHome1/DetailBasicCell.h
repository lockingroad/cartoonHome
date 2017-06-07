//
//  DetailBasicCell.h
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/24.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailEntity.h"
@interface DetailBasicCell : UITableViewCell
@property(nonatomic,weak)UILabel *title;
@property(nonatomic,weak)UILabel *yearOld;
@property(nonatomic,copy)DetailEntity *entity;
@end
