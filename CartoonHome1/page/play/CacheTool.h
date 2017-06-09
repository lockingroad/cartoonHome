//
//  CacheTool.h
//  Play
//
//  Created by 陈 on 2017/5/18.
//  Copyright © 2017年 huiben. All rights reserved.

// 缓存工具类

#import <Foundation/Foundation.h>


typedef    NS_ENUM( NSInteger , YBCacheType){
    YBCacheTypeReturnCacheDataThenLoad = 0,///< 有缓存就先返回缓存，同步请求数据
    YBCacheTypeReloadIgnoringLocalCacheData, ///< 忽略缓存，重新请求
    YBCacheTypeReturnCacheDataElseLoad,///< 有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    YBCacheTypeReturnCacheDataDontLoad,///< 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
    YBCacheTypeReturnCacheDataExpireThenLoad///< 有缓存就用缓存，如果过期了就重新请求 没过期就不请求
} ;
@interface CacheTool : NSObject


/**
 *  缓存数据
 @param data data 缓存数据的文件名
 @param fileName 需要缓存的二进制
 */
+( void) cacheForData:(NSData *) data  Files :( NSString *) fileName;

/**
 获取缓存

 @return 缓存的二进制数据
 */
+(NSData *)getCacheFileName:(NSString*) fileName;

/**
 是否过期


 */
+(BOOL)isExpire: ( NSString*)filename;


/**
缓存文件大小

 @return <#return value description#>
 */
+( NSUInteger)  getSize;

/**
 *  清除缓存
 */
+ (void)clearCache;

@end
