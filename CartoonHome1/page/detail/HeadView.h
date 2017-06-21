//
//  HeadView.h
//  MasonryDetailCartoon
//
//  Created by 范宏泳 on 2017/5/26.
//  Copyright © 2017年 范宏泳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailEntity.h"
typedef void(^viewUpdate)(CGFloat f);
typedef void(^start)();
@interface HeadView : UIView
@property(nonatomic,copy)DetailEntity *entity;
-(void)mockEntity;
@property(nonatomic,strong)viewUpdate viewBlock;
@property(nonatomic,strong)start startBlock;
@end
