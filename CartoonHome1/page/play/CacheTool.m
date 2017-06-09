//
//  CacheTool.m
//  Play
//
//  Created by 陈 on 2017/5/18.
//  Copyright © 2017年 huiben. All rights reserved.
//

#import "CacheTool.h"
#import "YBMD5.h"
#import "CacheConstant.h"

@implementation CacheTool


/**
 缓存文件
 @param data <#data description#>
 @param fileName <#fileName description#>
 */
+(void) cacheForData:(NSData *)data Files:(NSString *)fileName {
    //  地址进行加密   沙盒目录
    NSString  * path=[kCachePath  stringByAppendingString: fileName];
    
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             //写入文件
          [data writeToFile:path atomically:YES];
             
             NSLog(@"cacheForData 写入缓存zhong %@" ,path);
  
         }) ;
    


}
/**
  获取缓存文件

 @param fileName <#fileName description#>
 @return <#return value description#>
 */
+(  NSData *) getCacheFileName:(NSString *)fileName{
       NSString *path = [kCachePath stringByAppendingString:fileName];
    
    NSLog(@" 获取缓存 %@" ,path);

    NSData* datas=[NSData dataWithContentsOfFile:path options:0 error:NULL];
    if (datas) {
        NSLog(@" 有数据");
    }else {
        NSLog(@" 没有缓存");
    }
    return [NSData dataWithContentsOfFile:path options:0 error:NULL];

}
+( NSUInteger) getSize {
    //获取AFN的缓存大小
    NSUInteger afnSize = [self getAFNSize];
    return afnSize;
 
}
+( NSUInteger) getAFNSize {
    NSUInteger size=0;
    // 获取文件管理器
    NSFileManager * fm=[ NSFileManager defaultManager] ;
    NSDirectoryEnumerator * fileEnume =[ fm enumeratorAtPath: kCachePath] ;
    for ( NSString* filename in fileEnume) {
        NSString* filepath =[kCachePath stringByAppendingString: filename] ;
        NSDictionary * atts=[[ NSFileManager  defaultManager] attributesOfItemAtPath:filepath error:nil ];
        size += [ atts fileSize] ;
        
    }
    return  size;
}
+( void) clearCache {
// 清除缓存
    NSFileManager* fm=[ NSFileManager defaultManager];
    NSDirectoryEnumerator* fileenume =[ fm enumeratorAtPath: kCachePath];
    
    for (NSString *fileName in fileenume) {
        NSString *filePath = [kCachePath stringByAppendingPathComponent:fileName];
        
        [fm removeItemAtPath:filePath error:nil];
        
    }

}

+ (BOOL)isExpire:(NSString *)fileName
{
    NSString *path = [kCachePath stringByAppendingPathComponent:[YBMD5 md5:fileName]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *attributesDict = [fm attributesOfItemAtPath:path error:nil];
    NSDate *fileModificationDate = attributesDict[NSFileModificationDate];
    NSTimeInterval fileModificationTimestamp = [fileModificationDate timeIntervalSince1970];
    //现在的时间戳
    NSTimeInterval nowTimestamp = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    return ((nowTimestamp-fileModificationTimestamp)>kYBCache_Expire_Time);
}



@end
