//
//  NSTimer+Addition.h
//  LMWebViewLoadProgress
//
//  Created by limin on 17/1/16.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)
/** 暂定*/
- (void)pause;
/** 恢复*/
- (void)resume;
/** 设定多久恢复*/
- (void)resumeWithTimeInterval:(NSTimeInterval)time;
@end
