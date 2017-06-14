//
//  UIImage+XMGImage.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XMGImage)

/** Origin Image*/
+ (UIImage *)originImageWithName: (NSString *)name;
/** Navigaion Color*/
+ (UIImage *)imageWithNavigationBgColor:(UIColor *)color;

- (UIImage *)circleImage;
/** 等比压缩图片*/
+ (UIImage *)imageCompressWithSimple:(UIImage *)image;

- (UIImage *)scaleToWidth:(CGFloat)width;

@end
