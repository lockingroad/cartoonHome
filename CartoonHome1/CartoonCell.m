//
//  CartoonCell.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "CartoonCell.h"
#import "CartoonsInfo.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "TJPStarScoreView.h"

@interface CartoonCell ()
@property(nonatomic,weak)UILabel *label;
@property(nonatomic,strong)TJPStarScoreView *scoreView;
@end
@implementation CartoonCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *reuseId=@"cartoonCell";
    CartoonCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseId];
    if(!cell){
        cell=[[CartoonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        UIImageView *imgView=[[UIImageView alloc]init];
        [self.contentView addSubview:imgView];
        self.imgView=imgView;
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.contentView);
            make.height.mas_equalTo(200);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            
        }];
        
        UIView *bottomView=[[UIView alloc]init];
        [self.contentView addSubview:bottomView];
        bottomView.backgroundColor=kUIColorFromRGBA(0x000000, 0.5);
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(@30);
            make.bottom.mas_equalTo(self.imgView).offset(0);
            
        }];
        
        UILabel *titleLabel=[[UILabel alloc]init];
        titleLabel.font=BTFont(16);
        titleLabel.textAlignment=NSTextAlignmentLeft;
        titleLabel.textColor=kUIColorFromRGB(0xffffff);
        [bottomView addSubview:titleLabel];
        self.label=titleLabel;
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(bottomView.centerY);
            make.left.mas_equalTo(bottomView.left).with.offset(10);
        }];
        
       
        UILabel *levelLable=[[UILabel alloc]init];
        
    
        levelLable.font=[UIFont systemFontOfSize:11];
        levelLable.textColor=kUIColorFromRGB(0xffffff);
        [bottomView addSubview:levelLable];
        levelLable.text=@"难度系数";
        
        TJPStarScoreView *scoreView=[[TJPStarScoreView alloc]initWithFrame:CGRectMake(kScreenWidth - (kScoreViewW + 11), 200, kScoreViewW, 16) numberOfStarCount:5];
        [bottomView addSubview:scoreView];
        
        
        [levelLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bottomView);
            make.right.mas_equalTo(scoreView.mas_left);
        }];
        
        
       
        
        [scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@70);
            make.height.mas_equalTo(@40);
            make.top.mas_equalTo(levelLable.mas_top);
            make.right.mas_equalTo(bottomView.mas_right).with.offset(-10);
//            make.right.mas_equalTo(bottomView).width.offset(-10);
        }];
//
////        scoreView.backgroundColor=[UIColor redColor];
//        [scoreView setScore:3.0 isAnimation:NO];
    }
    return self;
    
}

-(void)setInfo:(CartoonsInfo *)info
{
    
    _info=info;
    NSLog(@"img%@",info.picbookapiimg);
    [self.imgView fadeImageWithUrl:info.picbookapiimg];
    
    self.label.text=info.picbookname;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}

@end
