//
//  UserMsgEntity.h
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/21.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserMsgInfo.h"
@interface UserMsgEntity : NSObject
@property(nonatomic,assign)NSNumber* status;
@property(nonatomic,strong)UserMsgInfo *userinfo;
@end
