//
//  DetailWebCell.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/24.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "DetailWebCell.h"
@interface DetailWebCell()<UIWebViewDelegate>

@end
@implementation DetailWebCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor=kUIColorFromRGB(0xffffff);
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initView];
    }
    self.backgroundColor=[UIColor grayColor];
    return self;
}

-(void)initView
{
    WS(weakSelf)
    UIView *topView=[[UIView alloc]init];
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.width.mas_equalTo(self.contentView.width);
        make.height.mas_equalTo(@30);
    }];
    
    UIWebView *webView=[[UIWebView alloc]init];
    [self.contentView addSubview:webView];

    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    [webView.scrollView addObserver:self
                         forKeyPath:@"contentSize"
                            options:NSKeyValueObservingOptionNew
                            context:nil];
    webView.backgroundColor=kUIColorFromRGB(0xffffff);
    webView.delegate=self;
    webView.userInteractionEnabled=NO;
    webView.scrollView.bounces=NO;
    
    weakSelf.web=webView;
    
    UILabel *tLabel=[[UILabel alloc]init];
    [self.contentView addSubview:tLabel];
    tLabel.font=[UIFont systemFontOfSize:14];
    tLabel.text=@"以上!";
    tLabel.textColor=[UIColor blueColor];
    [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(webView.mas_bottom);
        
    }];
}

-(void)setWebContent:(NSString *)webContent
{
    _webContent=webContent;
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
