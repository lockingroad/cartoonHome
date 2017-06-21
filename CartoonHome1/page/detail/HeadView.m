//
//  HeadView.m
//  MasonryDetailCartoon
//
//  Created by 范宏泳 on 2017/5/26.
//  Copyright © 2017年 范宏泳. All rights reserved.
//

#import "HeadView.h"
#import "TJPStarScoreView.h"

@interface HeadView()<UIWebViewDelegate>
@property(nonatomic,strong)UIImageView *topImg;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *yearOld;
@property(nonatomic,strong)UILabel *yearOldMsg;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *degreeMsg;
@property(nonatomic,strong)UIView *line1;
@property(nonatomic,strong)UIView *line2;
@property(nonatomic,strong)UIView *line3;
@property(nonatomic,strong)UIWebView *web;
@property(nonatomic,strong)TJPStarScoreView *scoreView;
@property(nonatomic,strong)UILabel *contentTitleLa;
@property(nonatomic,strong)UIButton *start;
@property(nonatomic,strong)UILabel *commentLa;
@property(nonatomic,strong)UILabel *commentNum;
@property(nonatomic,strong)UILabel *commentUnit;



@end

@implementation HeadView
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
    mYearLabel.text=@"6-9岁";
    [self addSubview: mYearLabel];
    self.yearOld=mYearLabel;
    
    UILabel *mDegree=[[UILabel alloc]init];
    mDegree.text=@"难度";
    [self addSubview:mDegree];
    self.degreeMsg=mDegree;
    
    
    TJPStarScoreView *mScoreView=[[TJPStarScoreView alloc]initWithFrame:CGRectMake(kScreenWidth - (kScoreViewW + 11), 200, kScoreViewW, 16) numberOfStarCount:5];
    [self addSubview:mScoreView];
    self.scoreView=mScoreView;
    
    UIButton *mStart=[[UIButton alloc]init];
    mStart.mj_size=CGSizeMake(65, 23);
    [mStart setTitle:@"阅读" forState:UIControlStateNormal];
    mStart.titleLabel.text=@"阅读";
    mStart.layer.borderColor =[kUIColorFromRGB(0x1cBDF6) CGColor];
    //设置边框宽度
    mStart.layer.borderWidth = 1.0f;
    //给按钮设置角的弧度
    mStart.layer.cornerRadius = 4.0f;
    //设置背景颜色
    mStart.backgroundColor = [UIColor whiteColor];
    mStart.layer.masksToBounds = YES;
    mStart.titleLabel.textColor=kUIColorFromRGB(0x1cBDF6);
    [mStart addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mStart];
    self.start=mStart;
    
    UIView *mLine1=[[UIView alloc]init];
    mLine1.backgroundColor=[UIColor grayColor];
    [self addSubview:mLine1];
    self.line1=mLine1;
    
    UILabel *mContentTitleLa=[[UILabel alloc]init];
    mContentTitleLa.text=@"绘本介绍";
    mContentTitleLa.font=kFont(18);
    [self addSubview:mContentTitleLa];
    self.contentTitleLa=mContentTitleLa;
    
    UILabel *mContent=[[UILabel alloc]init];
    mContent.text=@"内容啊啊啊啊啊啊啊奥啊啊啊啊啊奥少壮不努力老大徒伤悲 少壮不努力老大徒伤悲 少壮不努力老大徒伤悲 少壮不努力老大徒伤悲";
    mContent.numberOfLines=0;
    [self addSubview:mContent];
    self.contentLabel=mContent;
    
    UIView *mLine2=[[UIView alloc]init];
    mLine2.backgroundColor=kUIColorFromRGB(0x1CBDF6);
    [self addSubview:mLine2];
    self.line2=mLine2;
    
    UIView *mLine3=[[UIView alloc]init];
    mLine3.backgroundColor=[UIColor grayColor];
    [self addSubview:mLine3];
    self.line3=mLine3;
    
    UIWebView *mWeb=[[UIWebView alloc]init];
    mWeb.delegate=self;
    mWeb.userInteractionEnabled=NO;
    mWeb.scrollView.bounces=NO;
    
    [self addSubview: mWeb];
    self.web=mWeb;
    
    
    UILabel *mCommentLa=[[UILabel alloc]init];
    mCommentLa.text=@"全部评论";
    mCommentLa.textColor=kUIColorFromRGB(0x1CBDF6);
    mCommentLa.font=kFont(16);
    [self addSubview:mCommentLa];
    self.commentLa=mCommentLa;
    
    UILabel *mCommentNum=[[UILabel alloc]init];
    mCommentNum.text=@"10";
    mCommentNum.textColor=kUIColorFromRGB(0x1CBDF6);
    mCommentNum.font=kFont(10);
    [self addSubview:mCommentNum];
    self.commentNum=mCommentNum;
    
    
    UILabel *mCommentUnit=[[UILabel alloc]init];
    mCommentUnit.text=@"条";
    mCommentUnit.textColor=kUIColorFromRGB(0x1CBDF6);
    mCommentUnit.font=kFont(10);
    [self addSubview:mCommentUnit];
    self.commentUnit=mCommentUnit;
    
}
-(void)setupConstraints{
    
    [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(@209);
        
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.topImg.mas_bottom).offset(10);
    }];
    
    [self.yearOldMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.title);
        make.top.equalTo(self.title.mas_bottom).offset(10);
    }];
    
    
    [self.yearOld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yearOldMsg.mas_top);
        make.left.equalTo(self.yearOldMsg.mas_right).offset(5);
    }];
    
    
    [self.degreeMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yearOldMsg);
        make.top.equalTo(self.yearOldMsg.mas_bottom).offset(15);
        
    }];
    
    [self.scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.degreeMsg.mas_right).offset(10);
        make.top.equalTo(self.degreeMsg);
        make.bottom.equalTo(self.degreeMsg);
        
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@1);
        make.top.equalTo(self.degreeMsg.mas_bottom).offset(15);
        make.right.left.equalTo(self).offset(5);
    }];
    
    [self.contentTitleLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.mas_bottom).offset(15);
        make.left.equalTo(self.degreeMsg);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTitleLa.mas_bottom).offset(10);
//        make.width.equalTo(self.mas_width);
        make.left.equalTo(self.contentTitleLa);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@1);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(15);
        make.right.left.equalTo(self).offset(5);
    }];
    
    
    [self.web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.equalTo(self.line3.mas_bottom);
        
    }];
    
    
    [self.start mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yearOldMsg).offset(2);
        make.right.equalTo(self.mas_right).offset(-10);
        
    }];
    
    [self.commentLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.web.mas_bottom).offset(20);
        make.left.mas_equalTo(self.contentTitleLa.mas_left);
    }];
    [self.commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.commentLa.mas_bottom);
        make.left.mas_equalTo(self.commentLa.mas_right).offset(10);
    }];
    [self.commentUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.commentLa.mas_bottom);
        make.left.mas_equalTo(self.commentNum.mas_right);
        
    }];
    
    //line2 在最下面
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.left.right.mas_equalTo(self);
        make.top.equalTo(self.commentLa.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];

}

-(void)startClick:(UIButton *)btn{
    _startBlock();//通信  两次点击怎么办!
}
-(void)setEntity:(DetailEntity *)entity
{
    _entity=entity;
    
    [self.topImg fadeImageWithUrl:_entity.picbookapiimg];
    NSURL *nsUrl=[NSURL URLWithString:entity.ueditor];
    
    [self.web loadRequest:[NSURLRequest requestWithURL:nsUrl]];
    self.contentLabel.text=_entity.content;
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
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"失败了");
    [_web mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(0);
        
    }];
    self.viewBlock(0);
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    NSLog(@"hei-->%f",height);
    [_web mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(height);
        
    }];
    self.viewBlock(height);//webview绘制完成的时候 进行一次回调
}

@end
