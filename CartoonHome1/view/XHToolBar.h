//
//  XHToolBar.h
//  FengYou
//
//  Created by Walkman on 2017/1/24.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHToolBar : UIView


@property (nonatomic, copy) void(^XHToolBarSendBtnClick)(NSString *content);



- (void)clearText;

@end
