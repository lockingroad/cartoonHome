//
//  ViewController.m
//  Play
//
//  Created by 陈 on 2017/5/15.
//  Copyright © 2017年 huiben. All rights reserved.
//

#import "PlayVC.h"
#import "TJPSessionManager.h"
#import "BSPlayerModel.h"
#import "LYVideoPlayer.h" // 音乐播放器
#import "Track.h"

#import "UIImageView+AFNetworking.h"
#import "UIColor+ColorChange.h"
#import "TJPNetworkUtils.h"
#import "CacheTool.h"
// 当前状态关键字


@interface  PlayVC() <LYVideoPlayerDelegate>

@property (nonatomic ,strong) LYVideoPlayer *videoPlayer;
@property (nonatomic ,strong) UIView *videoPlayBGView;
@property (nonatomic ,copy)   NSString*videoUrl;

@end


@interface PlayVC () <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIButton * nextButton;

@property (nonatomic ,weak) UIView *bottomUiview ;
@property (nonatomic ,weak) UIView *topUiview ;
@property (nonatomic ,weak) UILabel*count ;
@property (nonatomic ,weak) UIButton *shuangYuButton ;
@property (nonatomic ,weak ) UIButton * englishButton ;
@property (nonatomic ,weak) UILabel*titles ;
@property (nonatomic ,weak) UIButton *backBtn;
@property (nonatomic ,weak ) UIButton* previousBtn ;
@property (nonatomic, strong) TJPSessionManager *sessionManager;



#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height
// 当前播放的位置
@property (nonatomic) NSInteger currentIndex;
//  是否播放
@property (nonatomic) BOOL musicIsPlaying;
    
@property (nonatomic) BOOL languageEnglish;
    

//播放 控制器

@property(nonatomic,strong)TJPNetworkUtils *networking;

@end




@implementation PlayVC

{
    NSUInteger  pageIndex  ;
    BOOL   isshow;
    NSMutableString *   strtitle ;
    //单页多段中的位置
    NSUInteger   Mp3Index ;
    
    //文件地址
    NSMutableString *mp3filepath ;
}
//  上一页
-( UIButton*)previousBtn{
    if(!_previousBtn){
  
     UIButton *previous =[[ UIButton alloc]  initWithFrame:CGRectMake (kScreenWidth/2 -80 ,0 ,50 ,46)];
    [previous setImage:[UIImage imageNamed:@"zuo.png"] forState:UIControlStateNormal] ;
    [previous addTarget:self action:@selector(previousclickBtn) forControlEvents:UIControlEventTouchUpInside];
    [ _bottomUiview addSubview: previous];
        _previousBtn =previous;

  }
    return  _previousBtn ;
}
// 英语
-( UIButton*) englishButtonP{
    __weak typeof(self) weakSelf = self;
    if (!_englishButton) {
     

    UIButton*  englishButton =[[ UIButton alloc] initWithFrame:CGRectMake(90,10 , 50, 27)];
    [englishButton  setTitle: @"英语"forState:UIControlStateNormal];
    englishButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [englishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            englishButton.layer.borderColor=[UIColor  whiteColor].CGColor;
    
    //显示 边框
    [englishButton.layer setMasksToBounds:YES];
    [englishButton.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
    //边框宽度
    [englishButton.layer setBorderWidth:1.0];
    //设置边框颜色有两种方法：第一种如下:
    
        [englishButton addTarget:self action:@selector(clickEnglsihBtn) forControlEvents:UIControlEventTouchUpInside];


    
    [  _bottomUiview addSubview:englishButton] ;
        
        
        

        _englishButton =englishButton ;
        
        
    }
    
    
    return   _englishButton ;
}
// 双语
-(UIButton *)shuangYuButton {
    __weak typeof(self) weakSelf = self;
         /**
          //不允许交互
          button.enabled =NO;
          //允许交互
          button.enabled =YES;
         */
    if (!_shuangYuButton) {
       
    // 双语
    UIButton*  shuangYuButton =[[ UIButton alloc] initWithFrame:CGRectMake(20,10 , 50, 27)];
    [shuangYuButton  setTitle: @"双语"forState:UIControlStateNormal];
    shuangYuButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [shuangYuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            shuangYuButton.layer.borderColor=[UIColor  whiteColor].CGColor;
    //显示 边框
    [shuangYuButton.layer setMasksToBounds:YES];
    [shuangYuButton.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
    //边框宽度
    [shuangYuButton.layer setBorderWidth:1.0];
    //设置边框颜色有两种方法：第一种如下:
    

        [ shuangYuButton  addTarget:self action:@selector(clickShuangyuBtn) forControlEvents:UIControlEventTouchUpInside] ;
    [  _bottomUiview addSubview:shuangYuButton] ;
        
        
       
        _shuangYuButton = shuangYuButton ;
    }
 

    
    
    return _shuangYuButton ;

}
// 返回
-( UIButton *)backBtn {
    if (!_backBtn) {
   
    // 后退
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(12,0 , 36, 46)] ;
    //    [button setTitle:@"标题" forState:UIControlStateNormal];
    //    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [button setTitleColor:[UIColor colorWithHexString:@"#1cb0f6"] forState:UIControlStateNormal];
    //    [button setBackgroundImage:[[PKResManager getInstance] imageForKey:@"theButtonImage"]
    //                      forState:UIControlStateNormal];
    [ button setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal] ;
    [button addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_topUiview addSubview:  button];
        _backBtn =button ;
        
    }
    return  _backBtn ;

}

// 标题
-(UILabel*) title{
    if (!_titles) {
        
   
    // 设置位置在中间
   
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth /2 - (strtitle.length*10)), 0, 320, 46)] ;
    title .text=strtitle;
    title.textColor =[ UIColor whiteColor];
    title.font = [UIFont boldSystemFontOfSize:18];
    
    [_topUiview addSubview: title];
        _titles=title;
    }
    return _titles ;

}

-(UIView *)topUiview{
    if (!_topUiview) {
       
 
    UIView* topuiview =[[ UIView alloc] initWithFrame:CGRectMake (0 ,0  ,kScreenWidth  ,46)   ] ;
    
    topuiview.backgroundColor= [[ UIColor blackColor]colorWithAlphaComponent:0.6f ];
            [ self.view addSubview: topuiview];
        
        _topUiview =topuiview ;
        }
    return  _topUiview;
    
}
// 总数
-(UILabel*)count {
    if (!_count) {
    UILabel*count=[[ UILabel alloc]  initWithFrame:CGRectMake(kScreenWidth/2, 0,60, 46)];

    count.textColor=[UIColor whiteColor];
    count.font =[UIFont boldSystemFontOfSize:18];
    [ _bottomUiview addSubview: count];
        _count=count ;
    }
    return  _count ;

}

-( UIView  *)bottomUiview {
    if (!_bottomUiview) {
    
  
    UIView* bottomUiview =[[ UIView alloc] initWithFrame:CGRectMake (0 ,kScreenHeight-46   ,kScreenWidth  ,46)   ] ;
    
    bottomUiview .backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    // 添加底部
    [self. view addSubview:bottomUiview];
        _bottomUiview =bottomUiview ;
     }
    return _bottomUiview ;

}
//   下一页
- (UIButton *)nextButton {
    if (!_nextButton) {
        UIButton *next =[[ UIButton alloc]  initWithFrame:CGRectMake (kScreenWidth/2 +80 ,0 ,50 ,46)];
        [next setImage:[UIImage imageNamed:@"you.png"] forState:UIControlStateNormal] ;
        [next addTarget:self action:@selector(nextclickBtn) forControlEvents:UIControlEventTouchUpInside];
        [ _bottomUiview addSubview: next];
              _nextButton = next;
    }
    return _nextButton;
}



//
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        __weak typeof(self) weakSelf = self;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height
                                                                                  )];
        scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * weakSelf.myARR.count,  [UIScreen mainScreen].bounds.size.height
                                            );
        scrollView.pagingEnabled = YES;
        scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        [self.view addSubview:scrollView];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
        [recognizer setNumberOfTapsRequired:1];
        [recognizer setNumberOfTouchesRequired:1];
        [scrollView addGestureRecognizer:recognizer];

        
        scrollView.minimumZoomScale = 0.3;
        scrollView.maximumZoomScale = 2.0;
        _scrollView = scrollView;
    }
    return _scrollView;
}



// 点击英语
-(void )clickEnglsihBtn {
     __weak typeof(self) weakSelf = self;
    NSLog(@"点击英语") ;
    [_englishButton setTitleColor:[UIColor colorWithHexString:@"1cb0f6"] forState:UIControlStateNormal];
    _englishButton.layer.borderColor=[UIColor  colorWithHexString:@"1cb0f6"].CGColor;
    [_shuangYuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _shuangYuButton.layer.borderColor=[UIColor  whiteColor].CGColor;
    
    
    // 避免多次点击
    _englishButton.enabled =NO ;
    _shuangYuButton .enabled=YES ;
    self.languageEnglish = YES ;
   
        // 播放
       [ self playmusic: pageIndex] ;

}

-( void) clickShuangyuBtn{
    __weak typeof(self) weakSelf = self;
NSLog(@"点击双语") ;
     // 改变颜色
    [_shuangYuButton setTitleColor:[UIColor colorWithHexString:@"1cb0f6"] forState:UIControlStateNormal];
    _shuangYuButton.layer.borderColor=[UIColor  colorWithHexString:@"1cb0f6"].CGColor;
    
    [_englishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _englishButton.layer.borderColor=[UIColor  whiteColor].CGColor;
    _englishButton.enabled =YES ;
    _shuangYuButton .enabled=NO ;
  self.languageEnglish = NO ;
    
    [ self playmusic: pageIndex] ;
    
}
// 显示和隐藏头底部的view
-( void) touchScrollView{
    NSLog(@"touchScrollView");

    _topUiview .hidden=isshow;
    _bottomUiview.hidden=isshow ;
    isshow =! isshow ;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //当前第几页
    pageIndex =0;
    Mp3Index=0;
    //当前第几首歌
    _currentIndex = 0;
    // 是否显示或者隐藏
    isshow = YES;


    [self getPlayDate];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

// 获取数据
-( void) getPlayDate {
     __weak typeof(self) weakSelf = self;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    int rand = 154;
    
    self.networking = [[TJPNetworkUtils alloc]init];

   NSUInteger  siez= [CacheTool getSize] ;
    
    NSLog(@"缓存大小%d",siez) ;
    [self.networking requsetWithPath:[NSString stringWithFormat:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/plays.php?ac=play_view&rand=%d",rand] withParams:params withCacheType:YBCacheTypeReturnCacheDataThenLoad withRequestType:NetworkGetType withResult:^(id responseObject, NSError *error) {

        if (!error) {
            NSDictionary *dataDic = (NSDictionary *)responseObject;
            
            
            if ([dataDic[@"status"] integerValue]) { //成功
                BSPlayerModel * model = [[BSPlayerModel alloc]initWithDictionary:dataDic];
                
                for (int i = 0; i < model.data.count; i++) {
                    BSData* data = [model.data objectAtIndex:i];
                    // 保存数据
                    [weakSelf.myARR addObject:data];
                }
                
                    
                [self setupUI :  model.title];
                
            }

   
        }else{
            
//            YBCache *cache = [self.networking getCache:NetworkGetType url:[NSString stringWithFormat:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/plays.php?ac=play_view&rand=%d",rand] params:params withResult:nil];
//            NSString *fileName = cache.fileName;
//                 
            
            NSData *data = [CacheTool getCacheFileName: @"123"];
            if (data) {
                NSLog(@" 有缓存数据");
           NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([jsonDict[@"status"] integerValue]) { //成功
                BSPlayerModel * model = [[BSPlayerModel alloc]initWithDictionary:jsonDict];
                
                for (int i = 0; i < model.data.count; i++) {
                    BSData* data = [model.data objectAtIndex:i];
                    
                    [weakSelf.myARR addObject:data];
                }
                
                [self setupUI :  model.title];
                
            }
            } else{
            
                //访问失败进行提示
                [ self.networking  showWarningView];

            }
        }
        
        
    }];

}
//  横屏模式
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{

        return UIInterfaceOrientationMaskLandscape; //只支持横
    
}





- (TJPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[TJPSessionManager alloc] init];
    }
    return _sessionManager;
}



- (void)setupUI :(NSMutableString *)tile {
    __weak typeof(self) weakSelf = self;
    // 设置引导 页面的图片
    //    NSAssert(_firstImages.count, @"引导页图片数据源不能为空");
    //设置滚动视图区域

    for (int i = 0; i < weakSelf.myARR.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];
           BSData * datas = [ weakSelf.myARR objectAtIndex:i ];
//        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString: datas.img]];
//
        
//          NSURLRequest *request = [NSURLRequest requestWithURL:datas.img];
//        imageView.image = [UIImage imageWithData:data];
        NSLog(@"%@" , datas.img);
        [ imageView setImageWithURL:[NSURL URLWithString: datas.img]] ;

        [self.scrollView addSubview:imageView];
    }

    [self  bottomUiview];
    [self topUiview] ;
    // 上一页
    [self previousBtn];
    //下一页
    [self nextButton] ;
    //双语
    [self shuangYuButton] ;
    // 英语
    [self englishButtonP] ;
    // 个数
    [self count];
    
    [self title] ;
    [self   backBtn];
   
    NSString* strs=   [NSString stringWithFormat:@"%d / %d",pageIndex +1 ,weakSelf. myARR.count];
    
    _count.text =strs ;
    
     // 设置双语默认点击
    [_shuangYuButton sendActionsForControlEvents:UIControlEventTouchUpInside] ;
     strtitle=tile;

   }



// 切换横竖屏的时候调用
- (void)viewWillLayoutSubviews {
    __weak typeof(self) weakSelf = self;
    [super viewWillLayoutSubviews];
//    CGFloat buttonX = (kScreenWidth * weakSelf.myARR.count - kScreenWidth * 0.5) - (kScreenWidth * 0.4 * 0.5);
//    _button.frame = CGRectMake(buttonX, kScreenHeight - 50, kScreenWidth * 0.4, 40);
    
}

- (void)backItemClick {
   }

// 返回
- (void)clickBtn{
    NSLog(@"点击返回");
//    [self.navigationController popViewControllerAnimated:NO];
    [self.videoPlayer stopVideo];
   [self dismissModalViewControllerAnimated:YES];
    
}
//下一页
- (void) nextclickBtn{

     __weak typeof(self) weakSelf = self;
    if (pageIndex+1<weakSelf.myARR.count) {
    pageIndex =   ++pageIndex  ;

     [_scrollView setContentOffset:CGPointMake(pageIndex * kScreenWidth, 0) animated:YES];
        NSString* strs=   [NSString stringWithFormat:@"%d / %d",pageIndex +1 ,weakSelf. myARR.count];
        
        _count.text =strs ;
        
        [self playmusic :pageIndex] ;
        
        }

}
// 上一页
- (void)previousclickBtn{
      __weak typeof(self) weakSelf = self;
        NSLog(@"previousclickBtn %d" ,pageIndex) ;
    if (pageIndex>0) {
        pageIndex = --pageIndex  ;
        
        [_scrollView setContentOffset:CGPointMake(pageIndex * kScreenWidth, 0) animated:YES];
        NSString* strs=   [NSString stringWithFormat:@"%d / %d",pageIndex +1 ,weakSelf. myARR.count];
        
        _count.text =strs ;
        
        // 播放音乐
        [self playmusic :pageIndex] ;
      
    }

  }
    //播放 音乐
    -( void) playmusic : (NSUInteger ) Index  {
       
     __weak typeof(self) weakSelf = self;
        // 获取当前位置的音频信息
    
        
         NSLog(@"  播放音乐 总数%d" ,weakSelf. myARR .count);
        BSData * datas =    weakSelf.myARR[Index];
        BSAudio *  shuangYuAudio ;
        //  双语的音频
        if ( _languageEnglish) {
                shuangYuAudio =       datas.audio[1];
        } else {
        
                shuangYuAudio =       datas.audio[0];
        }
      
        NSString* Basemp3Path=   shuangYuAudio.audiopath ;
        
        
        // 如果有多段音频
        if (shuangYuAudio.audioname .count >1) {
            Mp3Index =     Mp3Index +1 ;
            
            if (Mp3Index  <shuangYuAudio.audioname .count ) {
                    mp3filepath= [Basemp3Path stringByAppendingString:shuangYuAudio.audioname[Mp3Index]] ;
                
            }
            
            
            
        } else {// 单个 音频
            mp3filepath= [Basemp3Path stringByAppendingString:shuangYuAudio.audioname[0]] ;
        }
        
        
        
        [ self createStreamer:mp3filepath ] ;
    
    }

    
        // 播放完成
    -( void) playNextMusic {
        __weak typeof(self) weakSelf = self;
        // 获取当前位置的音频信息
        
        
        NSLog(@"  播放完成 总数%d" ,weakSelf. myARR .count);
        
     
       
        
    
        // 获取当前位置的音频信息
        BSData * datas =        weakSelf.myARR[pageIndex];
        //  双语的音频
        if( _languageEnglish){
        
        }
        
        BSAudio*   shuangYuAudio =       datas.audio[0];
        NSString* Basemp3Path=   shuangYuAudio.audiopath ;
        

        // 如果有多段音频
        if (shuangYuAudio.audioname .count >1) {
            Mp3Index =     Mp3Index +1 ;
            
            if (Mp3Index  <shuangYuAudio.audioname .count ) {
               mp3filepath= [Basemp3Path stringByAppendingString:shuangYuAudio.audioname[Mp3Index]] ;
                [self createStreamer:mp3filepath ] ;

            }else{
            // 进行下一页
                NSLog(@" 下一首") ;

                [_nextButton sendActionsForControlEvents:UIControlEventTouchUpInside] ;
            }
         
            
                  }
        else {
          //进行下一页 ,
            NSLog(@" 下一首") ;

            
            [_nextButton sendActionsForControlEvents:UIControlEventTouchUpInside] ;
 
        }

    
    }
// 初始化播放器 进行播放
- (void)createStreamer: (NSString * )soundFilePath {
    
//    // 音乐缓存
//    Track *track = [[Track alloc] init];
//    // 文件地址
////    NSString* soundFilePath=@"http://www.huibenabc.com/app/neahow/audio/2017041820235501980.mp3" ;
//    NSURL * fileURL =[[ NSURL alloc]  initFileURLWithPath:soundFilePath] ;
//    //传递播放地址
//    track .audioFileURL =[ NSURL URLWithString:soundFilePath] ;
//
//    // 先删除旧的 观察着
//    @try {
//        [self removeStreamerObserver];
//    } @catch(id anException){
//    }
//    
//    _streamer =nil;
//    _streamer =[DOUAudioStreamer  streamerWithAudioFile:track] ;
//    // 添加 观察着
//        [self addStreamerObserver];
//    // 进行播放
////        [self.streamer play];
//    
//            [_streamer play];
    
    [self.videoPlayer stopVideo];
    self.videoUrl =soundFilePath ;
    self.videoPlayer = [[LYVideoPlayer alloc] init];
    self.videoPlayer.delegate = self;
    [self.videoPlayer playWithUrl:self.videoUrl showView:nil];
    __weak typeof(self) weakSelf = self;
    [self.videoPlayer setPlayVeidoFinish:^{
        [weakSelf playNextMusic];
    }];

    
}

    
    
    

#pragma mark - UIScrollViewDelegate


- (NSMutableArray *)myARR{
    if (!_myARR) {
        _myARR = [NSMutableArray array];
    }
    return _myARR;
}

#pragma mack - 实现协议UIScrollViewDelegate
//设置指定的图片变形
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return scrollView.subviews[0];//通过视图的子视图数组得到_imageView
}
////一旦滚动就一直调用 直到停止
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //设置_pageControl当前小圆点的位置
//    _pageControl.currentPage = _scrollView.contentOffset.x / kScreenWidth;
    //         int  i=_scrollView.contentOffset.x / kScreenWidth;
    //    NSLog(@"  直到停止当前位置%d",i);
}


//将要开始拖拽的时候调用(开始滚动的时候)(手指开始拖拽屏幕的时候)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
}
//将要停止拖拽的时候调用
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
}
//已经停止拖拽调用 （手指离开滚动视图的时候）
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    
}

//将要开始减速的时候 （手指离开屏幕开始调用）//必须要有减速过程
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
}
//减速到停止的时候（静止）的时候调用
//这边进行下一首
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int  i=_scrollView.contentOffset.x / kScreenWidth;
    
    pageIndex =i;
    
    NSString* strs=   [NSString stringWithFormat:@"%d / %d",pageIndex +1 , _myARR.count];
    
    _count.text =strs ;
    
    [self playmusic :pageIndex] ;
    NSLog(@" 当前位置%d",i);
}
//变形结束调用
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
//
}
//变形开始的时候调用
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
}
//变形过程中调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
}
//当点击状态栏 回到顶部的时候调用//首先要设置 _scrollView.scrollsToTop = YES;
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
}
//_scrollView.scrollsToTop = YES;之后 在将要开始滚动到顶部的时候调用下面的函数 如果下面是YES 允许滚动到顶部 NO 是不可以的//_scrollView.scrollsToTop = NO 下面的方法失效
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return YES;
}
@end
