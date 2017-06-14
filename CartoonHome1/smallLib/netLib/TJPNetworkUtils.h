//
//  TJPNetworkUtils.h
//  NiHao_New
//
//  Created by Walkman on 2016/12/26.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "CacheTool.h"

typedef void(^networkStateBlock)(NSInteger netState);


//请求的类型
typedef NS_ENUM(NSInteger,NetworkRequestType) {
    NetworkGetType,
    NetworkPostType
};

typedef void (^ZmzBlock)(id responseObject,NSError *error);

typedef void (^ZmzDownBlock)(id responseo,id filepath,NSError *error);


//用于上传回调
/** 请求成功的Block */
typedef void(^requestSuccessBlock)(id dic);

/** 请求失败的Block */
typedef void(^requestFailureBlock)(NSError *error);

@interface YBCache : NSObject

@property (nonatomic, copy) NSString *fileName;//缓存文件名
@property (nonatomic, assign) BOOL result;//是否需要重新请求数据

@end

@interface TJPNetworkUtils : NSObject


- (NSString *)fileName:(NSString *)url params:(NSDictionary *)params ;
-( void) showWarningView ;
/**
 *  网络监测
 *
 *  @param block 判断结果回调
 *
 */
+ (void)netWorkState:(networkStateBlock)block;

/**
 *  发送网络请求
 *  @param params  参数
 *  @param type        请求类型
 *  @param resultBlock 返回结果：responseObject,error
 */

- (YBCache *)getCache:(YBCacheType)cacheType url:(NSString *)url params:(NSDictionary *)params withResult:(ZmzBlock)resultBlock ;
-(void)requsetWithPath:(NSString *)path withParams:(NSDictionary *)params withCacheType:(YBCacheType)cacheType withRequestType:(NetworkRequestType)type withResult:(ZmzBlock)resultBlock;

/**
 *  发送网络请求
 *  @param downloadpath  下载路径
 *  @param downloadblock 返回结果：responseObject,error
 */


-(void)downloadWithrequest:(NSString *)urlString downloadpath:(NSString *)downloadpath downloadblock:(ZmzDownBlock)downloadblock;

/**
 *
 *	取消所有请求
 */
- (void)cancelAllRequest;

/**
 *
 *	取消某个请求。如果是要取消某个请求，最好是引用接口所返回来的HYBURLSessionTask对象，
 *  然后调用对象的cancel方法。如果不想引用对象，这里额外提供了一种方法来实现取消某个请求
 *
 *	@param url				URL，可以是绝对URL，也可以是path（也就是不包括baseurl）
 */
- (void)cancelRequestWithURL:(NSString *)url;


/**
 *  上传图片
 *
 *  @param url        请求url
 *  @param imageData      要上传的文件流
 *  @param completion 文件上传成功的回调
 *
 *  @return 请求体
 */
- (NSURLSessionTask *)uploadImageWithUrl:(NSString *)url
                              WithParams:(NSDictionary*)params
                                   image:(NSData *)imageData
                                filename:(NSString *)name
                                mimeType:(NSString *)mimetype
                              completion:(requestSuccessBlock)completion
                              errorBlock:(requestFailureBlock)errorBlock;



/**
 *  上传音视频文件
 *
 *  @param url        请求url
 *  @param vedioData      要上传的文件流
 *  @param completion 文件上传成功的回调
 *
 *  @return 请求体
 */
- (NSURLSessionTask *)uploadVedioWithUrl:(NSString *)url
                              WithParams:(NSDictionary*)params
                                   image:(NSData *)vedioData
                                filename:(NSString *)name
                                mimeType:(NSString *)mimetype
                              completion:(requestSuccessBlock)completion
                              errorBlock:(requestFailureBlock)errorBlock;


@end
