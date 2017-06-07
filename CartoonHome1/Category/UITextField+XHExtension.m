//
//  UITextField+XHExtension.m
//  FengYou
//
//  Created by Walkman on 2017/2/9.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "UITextField+XHExtension.h"

@implementation UITextField (XHExtension)

+ (instancetype)textFiledWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor isNeedBorder:(BOOL)isNeedBorder andTextFieldType:(XHLoginAndRegisterTextFieldType)type
{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.font = font;
    textField.backgroundColor = backgroundColor;
    textField.placeholder = placeHolder;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.textColor = textColor;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.tag = type;
    if (isNeedBorder) {
        textField.layer.borderColor = textField.textColor.CGColor;
        textField.layer.borderWidth = 0.5;
    }
    return textField;
}

@end
