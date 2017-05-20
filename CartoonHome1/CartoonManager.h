//
//  CartoonManager.h
//  BasicAFNetTest
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CartoonEntity;
typedef void (^CompleteHandler)(NSArray *dataArray,NSError *error);
typedef void (^FailureHandler)(NSError *error);
@interface CartoonManager : NSObject

+(void)getCartoonEntity:(NSInteger)page
         successHandler:(void(^)(CartoonEntity *entity))success
         failureHandler:(FailureHandler)failure;


@end
