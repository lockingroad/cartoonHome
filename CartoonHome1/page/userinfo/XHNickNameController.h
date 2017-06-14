//
//  XHNickNameController.h
//  NiHao
//
//  Created by Walkman on 16/4/1.
//  Copyright © 2016年 NewLineWow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHNickNameController : UIViewController
@property (strong, nonatomic) NSString * tokenStr;
@property (copy, nonatomic) void(^changeNicknameSuccess)();


@end
