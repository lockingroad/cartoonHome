//
//  HeadView.m
//  MasonryDetailCartoon
//
//  Created by 范宏泳 on 2017/5/26.
//  Copyright © 2017年 范宏泳. All rights reserved.
//

#import "HeadView.h"


@interface HeadView()<UIWebViewDelegate>
@property(nonatomic,weak)UIImageView *topImg;
@property(nonatomic,weak)UILabel *title;
@property(nonatomic,weak)UILabel *yearOld;
@property(nonatomic,weak)UILabel *yearOldMsg;
@property(nonatomic,weak)UILabel *contentLabel;
@property(nonatomic,weak)UIWebView *cartoonWeb;
@property(nonatomic,strong)UILabel *degreeMsg;
@property(nonatomic,strong)UIView *line1;
@property(nonatomic,strong)UIView *line2;
@property(nonatomic,strong)UIWebView *web;

@end

@implementation HeadView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(instancetype)init{
    if(self=[super init]){
        [self setupView];
        [self setupConstraints];
    }
    return self;
}

-(void)setupView{
    UIImage *mTopImg=[UIImage rx_imageViewWithColor:[UIColor blueColor] size:CGSizeMake(40, 50)];
    UIImageView *mTopImgView=[[UIImageView alloc]init];
    mTopImgView.image=mTopImg;
    [self addSubview:mTopImgView];
    self.topImg=mTopImgView;
    
    UILabel *mTitle=[[UILabel alloc]init];
    mTitle.text=@"小蝌蚪找妈妈啊";
    [self addSubview:mTitle];
    self.title=mTitle;
    
    UILabel *mYearMsgLabel=[[UILabel alloc]init];
    mYearMsgLabel.text=@"适合年龄:";
    [self addSubview: mYearMsgLabel];
    self.yearOldMsg=mYearMsgLabel;
    
    UILabel *mYearLabel=[[UILabel alloc]init];
    mYearLabel.text=@"6-9";
    [self addSubview: mYearLabel];
    self.yearOld=mYearLabel;
    
    UILabel *mDegree=[[UILabel alloc]init];
    mDegree.text=@"难度";
    [self addSubview:mDegree];
    self.degreeMsg=mDegree;
    
    
    UIView *mLine1=[[UIView alloc]init];
    mLine1.backgroundColor=[UIColor blackColor];
    [self addSubview:mLine1];
    self.line1=mLine1;
    
    
    UILabel *mContent=[[UILabel alloc]init];
    mContent.text=@"内容啊啊啊啊啊啊啊奥啊啊啊啊啊奥少壮不努力老大徒伤悲 少壮不努力老大徒伤悲 少壮不努力老大徒伤悲 少壮不努力老大徒伤悲";
    mContent.numberOfLines=0;
    [self addSubview:mContent];
    self.contentLabel=mContent;
    
    UIView *mLine2=[[UIView alloc]init];
    mLine2.backgroundColor=[UIColor redColor];
    [self addSubview:mLine2];
    self.line2=mLine2;
    
    UIWebView *mWeb=[[UIWebView alloc]init];
    mWeb.backgroundColor=[UIColor yellowColor];
    mWeb.delegate=self;
    mWeb.userInteractionEnabled=NO;
    mWeb.scrollView.bounces=NO;
    
    
    [self addSubview: mWeb];
    self.web=mWeb;
    
    
    self.backgroundColor=[UIColor greenColor];
    
}
-(void)setupConstraints{
    
    [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(@200);
        
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.topImg.mas_bottom);
    }];
    
    [self.yearOldMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.title);
        make.top.equalTo(self.title.mas_bottom).offset(10);
    }];
    
    
    [self.yearOld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yearOldMsg.mas_top);
        make.left.equalTo(self.yearOldMsg.mas_right);
    }];
    
    
    [self.degreeMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yearOldMsg);
        make.top.equalTo(self.yearOldMsg.mas_bottom).offset(15);
        
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.width, 1));
        make.top.equalTo(self.degreeMsg.mas_bottom);
        make.right.left.equalTo(self);
    }];
    
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.mas_bottom).offset(10);
        make.width.equalTo(self.mas_width);
        make.left.right.equalTo(self);
    }];
    
    
    
    
    [self.web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.equalTo(self.contentLabel.mas_bottom);
        
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@5);
        make.left.right.mas_equalTo(self);
        make.top.equalTo(self.web.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    
    
    
}
-(void)setEntity:(DetailEntity *)entity
{
    _entity=entity;
    [self.topImg fadeImageWithUrl:_entity.picbookapiimg];
    self.title.text=_entity.picbookname;
    self.yearOld.text=_entity.sex;
    
    NSURL *nsUrl=[NSURL URLWithString:_entity.ueditor];
    
    [self.web loadRequest:[NSURLRequest requestWithURL:nsUrl]];
    //    self.contentLabel.text=_entity.content;
}

-(void)mockEntity
{
    NSURL *nsUrl=[NSURL URLWithString:@"http://www.huibenabc.com/app/neahow/ueditor/167.html"];
    
    [self.web loadRequest:[NSURLRequest requestWithURL:nsUrl]];
        self.contentLabel.text=_entity.content;

}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始载入了");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    NSLog(@"hei-->%f",height)
    [_web mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(height);
        
    }];
    self.viewBlock(height);
}

@end
