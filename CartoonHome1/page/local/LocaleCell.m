//
//  LocaleCell.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/16.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "LocaleCell.h"
#import "DetailEntity.h"
#import "TJPStarScoreView.h"
@interface LocaleCell()
@property(nonatomic,strong)UIImageView *posterImg;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *degreeLa;
@property(nonatomic,strong)TJPStarScoreView *scoreView;
@property(nonatomic,strong)UILabel *yearOld;
@property(nonatomic,strong)UILabel *yearOldLa;

@end
@implementation LocaleCell

+(instancetype)cellWithTableView:(UITableView *)tableview reuseID:(NSString *)reuseID
{
    LocaleCell *cell=[tableview dequeueReusableCellWithIdentifier:reuseID];
    if(!cell){
        cell=[[LocaleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return  cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupView];
        [self setupConstraints];
    }
    return self;
}
-(void)setupView
{
    
    [self.contentView addSubview:self.posterImg];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.yearOldLa];
    [self.contentView addSubview:self.yearOld];
    [self.contentView addSubview:self.degreeLa];
    [self.contentView addSubview:self.scoreView];
    _title.text=@"你的头上有只鸟aa123";
    _yearOld.text=@"8-9岁";
    _posterImg.image=[UIImage rx_imageViewWithColor:[UIColor redColor] size:CGSizeMake(30, 30)];
    [_scoreView setScore:3 isAnimation:NO];
}
-(void)setupConstraints
{
    [_posterImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(130, 74));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_posterImg).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.left.mas_equalTo(_posterImg.mas_right).offset(10);
        
    }];
    [_yearOldLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_title);
        make.top.mas_equalTo(_title.mas_bottom).offset(5);
    }];
    [_yearOld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_yearOldLa.mas_right).offset(10);
        make.top.mas_equalTo(_yearOldLa);
    }];
    [_degreeLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_title);
        make.top.mas_equalTo(_yearOldLa.mas_bottom).offset(5);
    }];
    
    [_scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_degreeLa.mas_right).offset(10);
        make.bottom.top.mas_equalTo(_degreeLa);
    }];
    
    

}
-(UIImageView *)posterImg
{
    if(!_posterImg){
        _posterImg=[[UIImageView alloc]init];
    }
    return _posterImg;
}
-(UILabel *)title
{
    if(!_title){
        _title=[[UILabel alloc]init];
        [_title setFont:kFont(15)];
        _title.textColor=kUIColorFromRGB(0x616673);
    }
    return _title;
}
-(UILabel *)yearOld
{
    if(!_yearOld){
        _yearOld=[[UILabel alloc]init];
        [_yearOld setFont:kFont(12)];
        _yearOld.textColor=kUIColorFromRGB(0x666666);
    }
    return _yearOld;
}
-(UILabel *)yearOldLa
{
    if(!_yearOldLa){
        _yearOldLa=[[UILabel alloc]init];
        [_yearOldLa setFont:kFont(12)];
        _yearOldLa.textColor=kUIColorFromRGB(0x666666);
        _yearOldLa.text=@"适合年龄:";
    }
    return _yearOldLa;
}
-(UILabel *)degreeLa
{
    if(!_degreeLa){
        _degreeLa=[[UILabel alloc]init];
        [_degreeLa setFont:kFont(12)];
        _degreeLa.textColor=kUIColorFromRGB(0x616673);
        _degreeLa.text=@"难度";
    }
    return _degreeLa;
}
-(TJPStarScoreView *)scoreView
{
    if(!_scoreView){
        _scoreView=[[TJPStarScoreView alloc]initWithFrame: CGRectMake(kScreenWidth - (kScoreViewW + 11), 200, kScoreViewW, 16) numberOfStarCount:5];
    }
    return _scoreView;
}
@end
