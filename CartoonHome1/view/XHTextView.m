//
//  XHTextView.m
//  TopicPage
//
//  Created by Walkman on 16/1/14.
//  Copyright © 2016年 Walkman. All rights reserved.
//

#import "XHTextView.h"

@interface XHTextView () {
    BOOL _shouldDrawPlaceholder;
}

@end

@implementation XHTextView
//重写父类方法
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self drawPlaceholder];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if (![placeholder isEqual:_placeholder]) {
        _placeholder = placeholder;
        [self drawPlaceholder];
    }
}
- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    _placeholderTextColor = placeholderTextColor;
    [self drawPlaceholder];
}

#pragma mark - 父类方法
- (instancetype)init {
    if (self = [super init]) {
        [self configureBase];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self configureBase];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configureBase];
    }
    return self;
}

- (void)XHTextViewWithTextColor:(UIColor *)textColor backgroundColor:(UIColor *)bgColor font:(UIFont *)font placeholder:(NSString *)placeholder andPlaceholderColor:(UIColor *)placeholderColor
{
    self.textColor = textColor;
    self.backgroundColor = bgColor;
    self.font = font;
    self.placeholder = placeholder;
    self.placeholderTextColor = placeholderColor;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (_shouldDrawPlaceholder) {
        [_placeholderTextColor set];
        [_placeholder drawInRect:CGRectMake(8.0f,
                                            8.0f,
                                            self.frame.size.width - 16.0f,
                                            self.frame.size.height - 16.0f) withAttributes:@{NSFontAttributeName : self.font, NSForegroundColorAttributeName: _placeholderTextColor}];
    }
    return;
    

}


- (void)configureBase
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textChanged:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    self.placeholderTextColor = [UIColor lightGrayColor];
    _shouldDrawPlaceholder = NO;
    return;
}

- (void)drawPlaceholder
{
    BOOL prev = _shouldDrawPlaceholder;
    _shouldDrawPlaceholder = self.placeholder && self.placeholderTextColor && self.text.length == 0;
    if (prev != _shouldDrawPlaceholder) {
        [self setNeedsDisplay];
    }
    return;
}

- (void)textChanged:(NSNotification *)notification
{
    [self drawPlaceholder];
    return;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:nil];
}



@end
