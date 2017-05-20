//
//  TJPSessionManager.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/9.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    
    RequestTypeGet,
    RequestTypePost
    
}RequestType;


typedef void (^TJPUploadProgress)(int64_t bytesWritten, int64_t totalBytesWritten);
typedef void (^TJPDownloadProgress)(int64_t bytesRead, int64_t totalBytesRead);


typedef void(^TJPResponseSuccess)(id response);
typedef void(^TJPResponseFail)(NSError *error);

@interface TJPSessionManager : NSObject

/** 取消所有请求*/
- (void)cancelAllRequest;
/** 取消某个单独的请求*/
- (void)cancelRequestWithURL:(NSString *)url;



/** 无进度条 无提示框的请求*/
- (void)request:(RequestType)requestType urlStr:(NSString *)urlStr parameter:(NSDictionary *)param resultBlock:(void(^)(id responseObject, NSError *error))resultBlock;


/** 无进度条 有提示框的请求*/
- (void)requestWithHUD:(NSString *)HUDText requestType:(RequestType)requestType urlStr:(NSString *)urlStr parameter:(NSDictionary *)param resultBlock:(void(^)(id responseObject, NSError *error))resultBlock;




/**
 上传图片，若不指定baseurl，可传完整的url

 @param image       图片对象
 @param urlStr      上传图片的接口路径，如/path/images/
 @param filename    给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 @param name        与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 @param mimeType    默认为image/jpeg
 @param parameters  参数
 @param progress    上传进度
 @param resultBlock resultBlock
 */
//- (void)uploadWithImage:(UIImage *)image urlStr:(NSString *)urlStr filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters progress:(TJPUploadProgress)progress resultBlock:(void(^)(id responseObject, NSError *error))resultBlock;


/**
 上传文件操作
 
 @param urlStr          上传路径
 @param uploadingFile   待上传文件的路径
 @param progress        上传进度
 @param resultBlock     回调
 */
- (void)uploadFileWithUrlStr:(NSString *)urlStr uploadingFile:(NSString *)uploadingFile progress:(TJPUploadProgress)progress resultBlock:(void(^)(id responseObject, NSError *error))resultBlock;










@end
