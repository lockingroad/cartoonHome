//
//  UIImageView+XMGExtension.m
//  百思不得姐
//
//  Created by 王顺子 on 16/6/16.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIImageView+XMGExtension.h"
#import "UIImage+ImageEffects.h"
#import "UIImageView+WebCache.h"
#import "UIImage+XMGImage.h"


CGFloat const kTJPBlurredImageDefaultBlurRadius            = 20.0;
CGFloat const kTJPBlurredImageDefaultSaturationFactor      = 1.8;

@implementation UIImageView (XMGExtension)


- (void)setURLImageWithURL: (NSURL *)url progress:(void(^)(CGFloat progress))progress complete: (void(^)())complete {
    
    
    [self sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progress != nil)
        {
            progress(1.0 * receivedSize / expectedSize);
        }
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image;
        if (complete != nil)
        {
            complete();
        }

        
    }];
    
}

- (void)setURLImageWithURL: (NSURL *)url placeHoldImage:(UIImage *)placeHoldImage isCircle:(BOOL)isCircle {

    if (isCircle) {
        [self sd_setImageWithURL:url placeholderImage:[placeHoldImage circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            UIImage *resultImage = [image circleImage];

            // 6. 处理结果图片
            if (resultImage == nil) return;
            self.image = resultImage;
            
            
        }];

    }else {
        [self sd_setImageWithURL:url placeholderImage:placeHoldImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            // 6. 处理结果图片
            if (image == nil) return;
            self.image = image;
            
            
        }];

    }
}


/** 处理导航栏相关方法*/
+ (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}



/**
 根据模糊程度来处理图片
 
 @param image 要处理的图片
 @param blurRadius 模糊度
 @param completion 处理完成的block
 */
- (void)setImageToBlur:(UIImage *)image blurRadius:(CGFloat)blurRadius completionBlock:(TJPBlurredImageCompletionBlock)completion {
    if (!image) {
        return;
    }
    NSParameterAssert(image);
    blurRadius = (blurRadius <= 0) ? kTJPBlurredImageDefaultBlurRadius : blurRadius;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *blurredImage = [image applyBlurWithRadius:blurRadius
                                                 tintColor:nil
                                     saturationDeltaFactor:kTJPBlurredImageDefaultSaturationFactor
                                                 maskImage:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = blurredImage;
            if (completion) {
                completion();
            }
        });
    });


}


/**
 图片模糊效果处理
 
 @param image 要处理的图片
 @param completion 处理完成的block
 */
- (void)setImageToBlur:(UIImage *)image
       completionBlock:(TJPBlurredImageCompletionBlock)completion {
    [self setImageToBlur:image
              blurRadius:kTJPBlurredImageDefaultBlurRadius
         completionBlock:completion];
}


/** 播放Image*/
- (void)playGifAnimationWithImages:(NSArray *)images {
    
    if (!images.count) {
        return;
    }
    self.animationImages = images;
    self.animationDuration = 0.5;
    self.animationRepeatCount = 0;//无限循环
    [self startAnimating];
}
/** 停止动画*/
- (void)stopGifAnimation {
    if (self.isAnimating) {
        [self stopAnimating];
    }
    [self removeFromSuperview];
}


/** 获取放大镜图片*/
+ (UIImageView *)getSearchImageViewWithFrame:(CGRect)frame {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:@"search"];
    
    return imageView;
}


@end
