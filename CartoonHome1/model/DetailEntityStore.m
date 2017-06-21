//
//  DetailEntityStore.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "DetailEntityStore.h"

@implementation DetailEntityStore
-(instancetype)initWithEntity:(DetailEntity *)entity
{
    if(self=[super init]){
        self.entityID=entity.id;
        self.picbookname=entity.picbookname;
        self.picbookapiimg=entity.picbookapiimg;
        self.picbookapiimgx=entity.picbookapiimgx;
        self.goutindex=entity.gout_index;
        self.sex=entity.sex;
        self.content=entity.content;
        self.ueditor=entity.ueditor;
        self.rand=entity.rand;
        self.hostID=[self.entityID integerValue];
        
    }
    return self;
}
@end
