//
//  CacheConstant.h
//  Play
//
//  Created by 陈 on 2017/5/18.
//  Copyright © 2017年 huiben. All rights reserved.
//

#ifndef CacheConstant_h
#define CacheConstant_h

#ifdef DEBUG // 调试状态, 打开LOG功能
#define YBLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define YBLog(...)

#endif /* CacheConstant_h */

/**
 缓存的有效期  单位是s
 */
#define kYBCache_Expire_Time (3600*24)

/**
 请求的API
 */
#define kAPI_URL @""

/**
 弱引用
 */
#define YBWeakSelf __weak typeof(self) weakSelf = self;
/**
 *  沙盒Cache路径
 */
#define kCachePath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject])

#endif /* YBCacheConstant_h */
