//
//  TJPSessionManager.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/9.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPSessionManager.h"
#import "AFNetworking.h"

/** 保存所有网络请求的Task*/
static NSMutableArray *TJP_requestTasks;


@interface TJPSessionManager()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSURLSessionTask *task;



@end

@implementation TJPSessionManager

#pragma mark privite
- (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (TJP_requestTasks == nil) {
            TJP_requestTasks = @[].mutableCopy;
        }
    });
    
    return TJP_requestTasks;
}

- (void)cancelAllRequest {
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]]) {
                [task cancel];
            }
        }];
    }
}

- (void)cancelRequestWithURL:(NSString *)url {
    if (!url) {
        @synchronized (self) {
            [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([task isKindOfClass:[NSURLSessionTask class]] && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                    [task cancel];
                    [[self allTasks] removeObject:task];
                    return;
                }
            }];
        }
    }
}

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc] init];
        _sessionManager.requestSerializer.timeoutInterval = 15.0f;
        NSMutableSet *acceptSet = [_sessionManager.responseSerializer.acceptableContentTypes mutableCopy];
        [acceptSet addObject:@"text/plain"];
        [acceptSet addObject:@"text/html"];
        _sessionManager.responseSerializer.acceptableContentTypes = [acceptSet copy];
    }
    return _sessionManager;
}


#pragma mark - 请求方法
- (void)request:(RequestType)requestType urlStr: (NSString *)urlStr parameter: (NSDictionary *)param resultBlock: (void(^)(id responseObject, NSError *error))resultBlock {
    
    [self requestWithUrlStr:urlStr requestType:requestType isShowHUD:NO HUDText:nil parameter:param resultBlock:resultBlock];
}

- (void)requestWithHUD:(NSString *)HUDText requestType:(RequestType)requestType urlStr:(NSString *)urlStr parameter:(NSDictionary *)param resultBlock:(void(^)(id responseObject, NSError *error))resultBlock {
    
    [self requestWithUrlStr:urlStr requestType:requestType isShowHUD:YES HUDText:HUDText parameter:param resultBlock:resultBlock];
}


- (void)uploadWithImage:(UIImage *)image urlStr:(NSString *)urlStr filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters progress:(TJPUploadProgress)progress resultBlock:(void(^)(id responseObject, NSError *error))resultBlock {

    //断言判断
    NSAssert(urlStr, @"请求的url不能为空");
    NSAssert(image, @"image不能为空");


    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    void (^successBlock)(NSURLSessionDataTask *dataTask, id responseObject) = ^(NSURLSessionDataTask *dataTask,id responseObject)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self showProgressHUDSuccess];
        [[self allTasks] removeObject:_task];
        resultBlock(responseObject, nil);
    };
    
    void (^failureBlock)(NSURLSessionDataTask *dataTask,NSError *error) = ^(NSURLSessionDataTask *dataTask,NSError *error)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self dismissErrorHUD:error.localizedDescription];
        [[self allTasks] removeObject:_task];
        resultBlock(nil, error);
    };

    _task=[self.sessionManager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
        
        NSString *imageFileName = filename;
        if (!filename || ![filename isKindOfClass:[NSString class]] || !filename.length) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        // 以流的形式上传
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimeType];
        
    } success:successBlock failure:failureBlock];
  
    if (_task) {
        [[self allTasks] addObject:_task];
    }
}


- (void)uploadFileWithUrlStr:(NSString *)urlStr uploadingFile:(NSString *)uploadingFile progress:(TJPUploadProgress)progress resultBlock:(void(^)(id responseObject, NSError *error))resultBlock {
    
    if (![NSURL URLWithString:uploadingFile]) {

        return;
    }
    NSURL *uploadURL = [NSURL URLWithString:urlStr];
    if (!uploadURL) {

        return;
    }

    
    void (^completionHandler)(NSURLResponse *response, id responseObject, NSError *error) = ^(NSURLResponse *response, id responseObject, NSError *error)
    {
        [[self allTasks] removeObject:_task];
        resultBlock(responseObject, error);
    };
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:uploadURL];
    
//    _task=self.sessionManager uploadTaskWithRequest:<#(nonnull NSURLRequest *)#> fromFile:<#(nonnull NSURL *)#> progress:<#(NSProgress *__autoreleasing  _Nullable * _Nullable)#> completionHandler:<#^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)completionHandler#>
//    _task = [self.sessionManager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
//        if (progress) {
//            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
//            [self showProgressHUDWithFload:uploadProgress.completedUnitCount];
//        }
//    } completionHandler:completionHandler];
    
    if (_task) {
        [[self allTasks] addObject:_task];
    }
}









/** 基础方法*/
- (void)requestWithUrlStr:(NSString *)urlStr
              requestType:(RequestType)requestType
                isShowHUD:(BOOL)isShowHUD
                  HUDText:(NSString *)statusText
                parameter: (NSDictionary *)param
              resultBlock: (void(^)(id responseObject, NSError *error))resultBlock {
    
    //通过断言判断
    NSAssert(urlStr, @"请求的url不能为空");

    //是否需要编码
    
    //HUD
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (isShowHUD) {
       [self showHUD:statusText];
    }
    
    void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        // 移除提示框
        if (isShowHUD) {
            [self dismissHUD];
//            [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:0.25];
        }
        //移除当前请求Task
        [[self allTasks] removeObject:task];
        resultBlock(responseObject, nil);
    };
    
    void(^failBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        // 网络请求错误提示框
        if (isShowHUD) {
            [self dismissErrorHUD];
        }
        //移除当前请求Task
        [[self allTasks] removeObject:task];
        resultBlock(nil, error);
    };
    
    
    if (requestType == RequestTypeGet) {
        
        [self.sessionManager GET:urlStr parameters:param success:successBlock failure:failBlock];
    }else {
        
        [self.sessionManager POST:urlStr parameters:param success:successBlock failure:failBlock];
       
    }
}




#pragma mark - 工具
- (NSString *)encodeUrl:(NSString *)url {
    return [self TJP_URLEncode:url];
}

- (NSString *)TJP_URLEncode:(NSString *)url {
    if ([url respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        
        static NSString * const kAFCharacterHTeneralDelimitersToEncode = @":#[]@";
        static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
        
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [allowedCharacterSet removeCharactersInString:[kAFCharacterHTeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < url.length) {
            NSUInteger length = MIN(url.length - index, batchSize);
            NSRange range = NSMakeRange(index, length);
            range = [url rangeOfComposedCharacterSequencesForRange:range];
            NSString *substring = [url substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(
                                                kCFAllocatorDefault,
                                                (__bridge CFStringRef)url,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
        return encoded;
#pragma clang diagnostic pop
    }
}


#pragma mark - HUD

- (void)showProgressHUDWithFload:(float)progress
{
//    [SVProgressHUD showProgress:progress status:@"loading.."];
}

- (void)showProgressHUDSuccess {
//    [SVProgressHUD showSuccessWithStatus:@"success"];
}

- (void)showHUD:(NSString *)showMessge
{
//    [SVProgressHUD showWithStatus:showMessge];

}

- (void)dismissHUD
{
//    [SVProgressHUD dismiss];

}
- (void)dismissErrorHUD
{
//    [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];

}

- (void)dismissErrorHUD:(NSString *)message
{
//    [SVProgressHUD showErrorWithStatus:message];    
}




@end
