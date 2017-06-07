//
//  DetailContentCell.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/5/25.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "DetailContentCell.h"

@interface DetailContentCell()
@property(nonatomic,weak)UILabel *contentLabel;
@property(nonatomic,weak)UILabel *contentShow;
@end
@implementation DetailContentCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor=[UIColor greenColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initView];
    }
    
    return self;
}

-(void)initView
{
    WS(weakSelf)
    UILabel *csLabel=[[UILabel alloc]init];
    csLabel.font=[UIFont systemFontOfSize:19];
    csLabel.text=@"主要内容是";
    [self.contentView addSubview:csLabel];
    [csLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
    
        
    }];
    
    
    UILabel *cLabel=[[UILabel alloc]init];
    cLabel.font=[UIFont systemFontOfSize:15];
    cLabel.text=@"这是内容啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊奥";
    [self.contentView addSubview:cLabel];
    [cLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(csLabel.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
    }];
    NSLog(@"test");
    weakSelf.contentLabel=cLabel;
    NSLog(@"test123123");
}

-(void)setContent:(NSString *)content
{
 
    self.contentLabel.text=content;
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
