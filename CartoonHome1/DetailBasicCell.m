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
    self.backgroundColor=[UIColor yellowColor];
    return self;
}
-(void)initView
{
    WS(weakSelf);
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:titleLabel];
    _title=titleLabel;
    _title.text=@"哈哈哈昂昂昂昂昂";

    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).with.offset(10);
        make.top.equalTo(weakSelf.contentView).with.offset(5);
    }];
    
    UILabel *yearContent=[[UILabel alloc]init];
    yearContent.textColor=kUIColorFromRGB(0x000000);
    yearContent.font=[UIFont systemFontOfSize:13];
    yearContent.text=@"适合年龄: ";
    [self.contentView addSubview:yearContent];
    [yearContent mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(titleLabel).with.offset(5);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(15);
        
    }];
    
    
    UILabel *yearLabel=[[UILabel alloc]init];
    yearLabel.textColor=kUIColorFromRGB(0x000000);
    yearLabel.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:yearLabel];
    _yearOld=yearLabel;
    [_yearOld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(yearContent);
        make.left.mas_equalTo(yearContent.mas_right).offset(5);
       
    }];
    
    UILabel *level=[[UILabel alloc]init];

    level.textColor=kUIColorFromRGB(0x000000);
    level.font=[UIFont systemFontOfSize:14];
    level.text=@"难度";
    [self.contentView addSubview:level];
    [level mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yearContent);
        make.top.mas_equalTo(yearContent.mas_bottom).offset(15);
       
    }];
}


-(void)setEntity:(DetailEntity *)entity
{
    _entity=entity;
    self.title.text=_entity.picbookname;
    self.yearOld.text=_entity.sex;
    
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
