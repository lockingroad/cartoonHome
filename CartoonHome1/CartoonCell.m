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

@interface CartoonCell ()
@property(nonatomic,weak)UILabel *label;
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
            
        }];
        
        
        UILabel *titleLabel=[[UILabel alloc]init];
        titleLabel.font=BTFont(16);
        titleLabel.textAlignment=NSTextAlignmentLeft;
        titleLabel.textColor=kUIColorFromRGB(0x777777);
        [self.contentView addSubview:titleLabel];
        self.label=titleLabel;
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.imgView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(kScreen_Width, 36));
            
        }];
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
