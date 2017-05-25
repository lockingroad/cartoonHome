//
//  DetailBasicCell.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/24.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "DetailBasicCell.h"

@interface DetailBasicCell()


@end
@implementation DetailBasicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor=kUIColorFromRGB(0xffffff);
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}
-(void)initView
{
    WS(weakSelf);
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.textColor=kUIColorFromRGB(0x000000);
    titleLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:titleLabel];
    _title=titleLabel;

    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.contentView.left).with.offset(5);
        make.top.mas_equalTo(weakSelf.contentView.top).with.offset(5);
        
    }];
    
    UILabel *yearContent=[[UILabel alloc]init];
    yearContent.textColor=kUIColorFromRGB(0x000000);
    yearContent.font=[UIFont systemFontOfSize:12];
    yearContent.text=@"适合年龄";
    [self.contentView addSubview:yearContent];
    [yearContent mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(weakSelf.contentView.left).with.offset(5);
        make.top.mas_equalTo(weakSelf.title.bottom).with.offset(5);
        
    }];
    
    
    UILabel *yearLabel=[[UILabel alloc]init];
    yearLabel.textColor=kUIColorFromRGB(0x000000);
    yearLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:yearLabel];
    _yearOld=yearLabel;
    [_yearOld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(yearContent);
        make.left.mas_equalTo(yearContent.right).offset(5);
        
        
    }];
    
    UILabel *level=[[UILabel alloc]init];

    level.textColor=kUIColorFromRGB(0x000000);
    level.font=[UIFont systemFontOfSize:14];
    level.text=@"难度";
    [self.contentView addSubview:level];
    [level mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yearLabel.left);
        make.top.mas_equalTo(yearLabel.bottom);
        
    }];
    
    
}


-(void)awakeFromNib
{
    [super awakeFromNib];
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
@end
