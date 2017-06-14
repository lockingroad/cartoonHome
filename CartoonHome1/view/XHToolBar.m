//
//  XHToolBar.m
//  FengYou
//
//  Created by Walkman on 2017/1/24.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "XHToolBar.h"
#import "UIButton+XHExtension.h"
#import "XHTextView.h"


@interface XHToolBar () <UITextViewDelegate>
@property (nonatomic, weak) XHTextView *textView;
@property (nonatomic, weak) UIButton *sendButton;


@end

@implementation XHToolBar
{
    NSInteger _maxLineNum;
    NSInteger _currentNum;
    CGFloat _textHeight;
}

#pragma mark - instancetype

- (instancetype)init {
    if (self = [super init]) {
        [self commitInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commitInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commitInit];
    }
    return self;
}



- (void)commitInit {
    self.backgroundColor = TJPColor(247, 247, 246);
    _currentNum = 1;
    _maxLineNum = 4;

    //UI
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.layer.borderWidth = 1;
    line.layer.borderColor = LocTextColor.CGColor;
    [self addSubview:line];
    [self textView];
    [self sendButton];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    WS(weakSelf)
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.offset(15);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 80, 32));
    }];
    
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.offset(-15);
    }];
}



#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    
#if 0   
    static CGFloat maxHeight = 130.0f;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    CGFloat length = size.height;
    NSInteger colomNumber = _textView.contentSize.height / length;
    
    if (size.height >= maxHeight) {
        size.height = maxHeight;
        textView.scrollEnabled = YES;   // 允许滚动
    }else {
        textView.scrollEnabled = NO;    // 不允许滚动，当textview的大小足以容纳它的text的时候，需要设置scrollEnabed为NO，否则会出现光标乱滚动的情况
    }
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y - size.height, frame.size.width, size.height);
    
    if (size.height != textView.frame.size.height)
    {
        CGFloat span = size.height - textView.frame.size.height;
        NSLog(@"span:%f", span);

        CGRect sRect = self.frame;
        sRect.size.height += span;
        sRect.origin.y -= span ;
        self.frame = sRect;
    }
    
#else
    CGSize size = [_textView.text sizeWithAttributes:@{NSFontAttributeName:_textView.font}];
    CGFloat length = size.height;
    NSInteger colomNumber = _textView.contentSize.height / length;

    
#endif
    
}


/** if (currentLineNum < _maxLineNum) {
 //更新布局
 self.frame = CGRectMake(self.tjp_x, self.tjp_y - fontSize.height * currentLineNum, self.tjp_width, self.tjp_height * currentLineNum);
 [textView mas_updateConstraints:^(MASConstraintMaker *make) {
 make.size.mas_equalTo(CGSizeMake(kScreenWidth - 80, textView.tjp_height + fontSize.height * currentLineNum));
 }];
 
 }else {
 //更新布局
 self.frame = CGRectMake(self.tjp_x, self.tjp_y - fontSize.height * _maxLineNum, self.tjp_width, self.tjp_height * _maxLineNum);
 [textView mas_updateConstraints:^(MASConstraintMaker *make) {
 make.size.mas_equalTo(CGSizeMake(kScreenWidth - 80, textView.tjp_height + fontSize.height * _maxLineNum));
 }];
 }*/
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //计算行数
    NSInteger lineNum = [self calculateNumberOfLinesWithTextView:textView range:range replacementText:text];
//    CGSize fontSize = [textView.text sizeWithAttributes:@{NSFontAttributeName:textView.font}];
    
//    if (lineNum > _currentNum) {
//        //如果发现当前文字长度对应的行数超过。 文本框高度，则先调整当前view的高度和位置，然后调整输入框的高度，最后修改currentLineNum的值
//        self.frame = CGRectMake(self.tjp_x, self.tjp_y - fontSize.height * (lineNum - _currentNum), self.tjp_width, self.tjp_height * (lineNum - _currentNum));
//       
//        textView.frame = CGRectMake(textView.tjp_x, textView.tjp_y, textView.tjp_width, textView.tjp_height + fontSize.height * (lineNum - _currentNum));
//        _currentNum = lineNum;
//
//    }
    
    

    if (text.length){//添加字符串，打开用户交互
        [_sendButton setTitleColor:Global_Yellow_Color forState:UIControlStateNormal];
        _sendButton.userInteractionEnabled = YES;
    }
    else{
        if (textView.text.length <= 1) {
            [_sendButton setTitleColor:GrayColor forState:UIControlStateNormal];
            _sendButton.userInteractionEnabled = NO;
        }
    }
    return YES;
}

- (NSInteger)calculateNumberOfLinesWithTextView:(UITextView *)textView range:(NSRange)range replacementText:(NSString *)text{
    NSString *textString = @"Text";
    CGSize fontSize = [textString sizeWithAttributes:@{NSFontAttributeName:textView.font}];
    NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    CGSize tallerSize = CGSizeMake(textView.frame.size.width - 15,textView.frame.size.height * 2);
    
    CGSize newSize = [newText boundingRectWithSize:tallerSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName: textView.font}
                                           context:nil].size;
   return newSize.height / fontSize.height;

}





#pragma mark - priviate
- (void)sendButtonClick {

    [_textView resignFirstResponder];
    self.XHToolBarSendBtnClick(_textView.text);
}

- (void)clearText {
    _textView.text = @"";
}



#pragma mark - lazy
- (XHTextView *)textView {
    if (!_textView) {
        XHTextView *textView = [[XHTextView alloc] init];
        textView.layer.borderColor = TJPColor(214, 214, 214).CGColor;
        textView.layer.borderWidth = 0.5f;
        textView.layer.cornerRadius = 5;
        textView.scrollEnabled = YES;
        textView.scrollsToTop = NO;
        textView.placeholder = @"说点什么...";
        textView.placeholderTextColor = TJPColor(182, 182, 182);
        textView.userInteractionEnabled = YES;
        textView.font = kFont(14);
        textView.delegate = self;
        textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textView.autocorrectionType = UITextAutocorrectionTypeNo;
        [self addSubview:textView];
        _textView = textView;
    }
    return _textView;
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [sendButton setTitleColor:GrayColor forState:UIControlStateNormal];
        sendButton.titleLabel.font = kFont(15);
        [sendButton setEnlargeEdgeWithTop:5.f right:10.f bottom:5.f left:10.f];
        [sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
        sendButton.userInteractionEnabled = NO;
        [sendButton sizeToFit];
        [self addSubview:sendButton];
        _sendButton = sendButton;
    }
    return _sendButton;
}






- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
