//
//  UITextField+XHExtension.h
//  FengYou
//
//  Created by Walkman on 2017/2/9.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    XHLoginAndRegisterTextFieldTypeUnknown = 0,
    XHLoginAndRegisterTextFieldTypeAccount,
    XHLoginAndRegisterTextFieldTypePassword,
    XHLoginAndRegisterTextFieldTypeMakeSure
}XHLoginAndRegisterTextFieldType;

@interface UITextField (XHExtension)

/** 快速创建textFiled*/
+ (instancetype)textFiledWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor isNeedBorder:(BOOL)isNeedBorder andTextFieldType:(XHLoginAndRegisterTextFieldType)type;

@end
