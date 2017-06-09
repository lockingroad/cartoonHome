//
//  UIColor+ColorChange.h
//  Play
//
//  Created by 陈 on 2017/5/26.
//  Copyright © 2017年 huiben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)
// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
