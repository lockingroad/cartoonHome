//
//  TJPStarScoreView.m
//  FengYou
//
//  Created by Walkman on 2017/1/18.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "TJPStarScoreView.h"

#define kBackgroundImage @"icon_star"
#define kForegroundImage @"icon_star_selected"
#define kStarDefaultNumber  5
CGFloat const kStarMargin = 2.5;

@interface TJPStarScoreView ()

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;

@end

@implementation TJPStarScoreView

#pragma mark instancetype
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfStarCount:kStarDefaultNumber];
}


- (instancetype)initWithFrame:(CGRect)frame numberOfStarCount:(NSUInteger)starCount {
    if (self = [super initWithFrame:frame]) {
        _starCount = starCount;
        [self commonInit];
    }
    return self;
}
-(instancetype)init
{
    if(self=[super init]){
        _starCount=5;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _starCount = kStarDefaultNumber;
    [self commonInit];
}


#pragma mark privite
- (void)commonInit
{
    self.starBackgroundView = [self buidlStarViewWithImageName:kBackgroundImage];
    self.starForegroundView = [self buidlStarViewWithImageName:kForegroundImage];
    [self addSubview:self.starBackgroundView];
    [self addSubview:self.starForegroundView];
}
-(void)initAgain
{
    [self commonInit];
}

- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < self.starCount; i ++){
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake((kStarMargin + i * frame.size.width) / self.starCount, 0, frame.size.width / self.starCount - kStarMargin, frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}


- (void)setScore:(CGFloat)score isAnimation:(BOOL)isAnimate
{
    [self setScore:score withAnimation:isAnimate completion:^(BOOL finished){}];
}


- (void)setScore:(CGFloat)score withAnimation:(BOOL)isAnimate completion:(void (^)(BOOL finished))completion
{
    NSAssert((score >= 0.0)&&(score <= 5.0), @"score must be between 0 and 5");
    
    if (score < 0){
        score = 0;
    }
    
    if (score > 5){
        score = 5;
    }
    
    CGPoint point = CGPointMake(score * self.frame.size.width, 0);
    
    if(isAnimate){
        __weak __typeof(self)weakSelf = self;
        
        [UIView animateWithDuration:0.2 animations:^{
            [weakSelf changeStarForegroundViewWithPoint:point];
        } completion:^(BOOL finished){
            if (completion){
                completion(finished);
            }
        }];
    } else {
        [self changeStarForegroundViewWithPoint:point];
    }
}



- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    
    if (p.x < 0){
        p.x = 0;
    }
    
    if (p.x > self.frame.size.width){
        p.x = self.frame.size.width;
    }
    
    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
    float score = [str floatValue];
    p.x = score * self.frame.size.width;
    self.starForegroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
    
//    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)]){
//        [self.delegate starRatingView:self score:score];
//    }
}


#pragma mark - Touche Event
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isNeedTouch) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if(CGRectContainsPoint(rect,point)){
        [self changeStarForegroundViewWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isNeedTouch) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak __typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf changeStarForegroundViewWithPoint:point];
    }];
}








@end
