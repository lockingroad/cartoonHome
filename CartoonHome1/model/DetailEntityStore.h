//
//  DetailEntityStore.h
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "CoreModel.h"
#import "DetailEntity.h"
//不能有id 不能有下划线!

@interface DetailEntityStore : CoreModel
@property(nonatomic,strong)NSString *entityID;
@property(nonatomic,strong)NSString *picbookname;
@property(nonatomic,strong)NSString *picbookapiimg;
@property(nonatomic,strong)NSString *goutindex;
@property(nonatomic,strong)NSString *picbookapiimgx;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *ueditor;
@property(nonatomic,strong)NSString *rand;
-(instancetype)initWithEntity:(DetailEntity *)entity;
@end
