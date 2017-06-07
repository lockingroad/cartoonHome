//
//  TJPStarScoreView.h
//  FengYou
//
//  Created by Walkman on 2017/1/18.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TJPStarScoreView : UIView

@property (nonatomic, assign, readonly) NSUInteger starCount;

@property (nonatomic, assign) BOOL isNeedTouch;





/**
 初始化方法 默认5颗星

 @param frame frame
 @param starCount starCount
 */
- (instancetype)initWithFrame:(CGRect)frame numberOfStarCount:(NSUInteger)starCount;


- (void)setScore:(CGFloat)score isAnimation:(BOOL)isAnimate;


/**
 设置控件分数

 @param score 分数(满分5分)，必须在 0 － 5 之间
 @param isAnimate 是否启用动画
 @param completion 动画完成block
 */
- (void)setScore:(CGFloat)score withAnimation:(BOOL)isAnimate completion:(void (^)(BOOL finished))completion;

-(void)initAgain;
@end
