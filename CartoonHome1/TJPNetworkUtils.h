//
//  TJPNetworkUtils.h
//  NiHao_New
//
//  Created by Walkman on 2016/12/26.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^networkStateBlock)(NSInteger netState);

@interface TJPNetworkUtils : NSObject



/**
 *  网络监测
 *
 *  @param block 判断结果回调
 *
 */
+ (void)netWorkState:(networkStateBlock)block;

@end
