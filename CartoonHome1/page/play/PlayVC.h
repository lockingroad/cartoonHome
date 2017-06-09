//
//  ViewController.h
//  Play
//
//  Created by 陈 on 2017/5/15.
//  Copyright © 2017年 huiben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayVC : UIViewController

// 保存数据的数组
@property (nonatomic, strong) NSMutableArray * myARR;
- (void)playWithUrl:(NSString *)url ;

/** 播放 */
- (void)playVideo;
/** 暂停 */
- (void)pauseVideo;
/** 停止播放/清空播放器 */
- (void)stopVideo;

-(void) playNextMusic ;
@end

