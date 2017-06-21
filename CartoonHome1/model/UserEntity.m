//
//  UserBean.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/21.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init]){
        self.status=[aDecoder decodeObjectForKey:@"status"];
        self.userid=[aDecoder decodeObjectForKey:@"userid"];
        self.token=[aDecoder decodeObjectForKey:@"token"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.userid forKey:@"userid"];
    [aCoder encodeObject:self.token forKey:@"token"];
}
@end
