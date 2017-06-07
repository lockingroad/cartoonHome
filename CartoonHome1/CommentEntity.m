//
//  CommentEntity.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/5/26.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "CommentEntity.h"

@implementation CommentEntity
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"comments" : @"CommentInfo"
             };
}
@end
