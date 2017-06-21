//
//  LocaleCell.h
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/16.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <SWTableViewCell/SWTableViewCell.h>
#import "DetailEntityStore.h"
@interface LocaleCell : SWTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableview reuseID:(NSString *)reuseID;
-(void)updateData:(DetailEntityStore *)entity;
@end
