//
//  CommentCell.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/5/26.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "CommentCell.h"
@interface CommentCell()
@property(nonatomic,weak)UILabel *content;
@property(nonatomic,weak)UILabel *nick;
@property(nonatomic,weak)UIImageView *avatar;

@end
@implementation CommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return  self;
}

-(void)initView
{
    WS(weakSelf);
    UILabel *mContent=[[UILabel alloc]init];
    mContent.text=@"内容";
    [self.contentView addSubview:mContent];
    [mContent mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView).offset(10);
        
    }];
    weakSelf.content=mContent;
    
    UILabel *mNick=[[UILabel alloc]init];
    mNick.text=@"昵称哦";
    [self.contentView addSubview:mNick];
    [mNick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mContent.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        
    }];
    weakSelf.nick=mNick;
}

-(void)setComment:(CommentInfo *)comment
{
    _comment=comment;
    self.content.text=_comment.contents;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
