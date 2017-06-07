//
//  XHCommentCell.m
//  FengYou
//
//  Created by Walkman on 2017/1/24.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "XHCommentCell.h"
#import "CommentInfo.h"


@interface XHCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation XHCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setContent:(NSString *)content {
    _content = content;
    
    _contentLab.text = content;
    
}

- (void)setCommentItem:(CommentInfo *)commentItem {
    _commentItem = commentItem;
    

    [_headImage fadeImageWithUrl:commentItem.headimg];
    

    _nickName.text = commentItem.hbid;
    _contentLab.text = commentItem.contents;
    _timeLab.text = commentItem.dateline;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
