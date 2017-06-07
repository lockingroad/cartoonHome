//
//  UIImage+XMGImage.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIImage+XMGImage.h"

@implementation UIImage (XMGImage)

+ (UIImage *)originImageWithName: (NSString *)name {

    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}

- (UIImage *)circleImage {

    CGSize size = self.size;
    CGFloat drawWH = size.width < size.height ? size.width : size.height;


    // 1. 开启图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(drawWH, drawWH));
    // 2. 绘制一个圆形区域, 进行裁剪
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect clipRect = CGRectMake(0, 0, drawWH, drawWH);
    CGContextAddEllipseInRect(context, clipRect);
    CGContextClip(context);

    // 3. 绘制大图片
    CGRect drawRect = CGRectMake(0, 0, size.width, size.height);
    [self drawInRect:drawRect];

    // 4. 取出结果图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();

    // 5. 关闭上下文
    UIGraphicsEndImageContext();
    
    return resultImage;

}


+ (UIImage *)imageWithNavigationBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)imageCompressWithSimple:(UIImage *)image {
    CGSize size = image.size;
    CGFloat scale = 1.0;
    //TODO:KScreenWidth屏幕宽
    if (size.width > kScreenWidth || size.height > kScreenHeight) {
        if (size.width > size.height) {
            scale = kScreenWidth / size.width;
        }else {
            scale = kScreenHeight / size.height;
        }
    }
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    CGSize secSize = CGSizeMake(scaledWidth, scaledHeight);
    //TODO:设置新图片的宽高
    UIGraphicsBeginImageContext(secSize); // this will crop
    [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage* newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)scaleToWidth:(CGFloat)width {
    
    // 如果传入的宽度比当前宽度还要大,就直接返回
    
    if (width > self.size.width) {
        
        return  self;
        
    }
    // 计算缩放之后的高度
    CGFloat height = (width / self.size.width) * self.size.height;
    
    // 初始化要画的大小
    CGRect  rect = CGRectMake(0, 0, width, height);
    
    // 1. 开启图形上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 2. 画到上下文中 (会把当前image里面的所有内容都画到上下文)
    [self drawInRect:rect];
    
    // 3. 取到图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();

    // 4. 关闭上下文
    UIGraphicsEndImageContext();
    
    // 5. 返回
    return image;
}





@end
