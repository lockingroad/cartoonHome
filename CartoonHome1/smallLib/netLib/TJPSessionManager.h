//
//  TJPSessionManager.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/9.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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





- (void)uploadWithImage:(UIImage *)image urlStr:(NSString *)urlStr filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters progress:(TJPUploadProgress)progress resultBlock:(void(^)(id responseObject, NSError *error))resultBlock;













@end
