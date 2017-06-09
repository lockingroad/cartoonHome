//
//  Item_Locall.m
//  Play
//
//  Created by 陈 on 2017/5/19.
//  Copyright © 2017年 huiben. All rights reserved.
//

#import "Item_Locall.h"

@interface Item_Locall ()

@end

@implementation Item_Locall

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
