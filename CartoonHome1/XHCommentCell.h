//
//  XHCommentCell.h
//  FengYou
//
//  Created by Walkman on 2017/1/24.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentInfo;
@interface XHCommentCell : UITableViewCell

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) CommentInfo *commentItem;





@end
