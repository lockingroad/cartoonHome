//
//  CartoonAudioEntity.h
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/13.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartoonAudioInfo.h"
#import "AudioInfo.h"
@interface CartoonAudioEntity : NSObject
@property(nonatomic,assign)BOOL status;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *back;
@property(nonatomic,strong)NSArray *data;
-(NSMutableDictionary *)dicFromData;
@end
