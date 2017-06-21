//
//  ViewController.m
//  Play
//
//  Created by 陈 on 2017/5/15.
//  Copyright © 2017年 huiben. All rights reserved.
//

#import "PlayVC.h"
#import "LYVideoPlayer.h" // 音乐播放器
//#import "Track.h"

#import "UIImageView+AFNetworking.h"
#import "UIColor+ColorChange.h"
//#import "TJPNetworkUtils.h"
//#import "CacheTool.h"
#import "CartoonAudioEntity.h"

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
@property (nonatomic ,weak) UIButton * englishButton ;
@property (nonatomic ,weak) UILabel*titles ;
@property (nonatomic ,weak) UIButton *backBtn;
@property (nonatomic ,weak) UIButton* previousBtn ;
@property(nonatomic,strong)NSMutableArray *enArr;
@property(nonatomic,strong)NSMutableArray *cnArr;
@property(nonatomic,strong)NSMutableArray *enIndex;
@property(nonatomic,strong)NSMutableArray *cnIndex;

// 当前播放的位置
@property (nonatomic) NSInteger currentIndex;
//  是否播放
@property (nonatomic) BOOL musicIsPlaying;

@property (nonatomic) BOOL languageEnglish;


@end




@implementation PlayVC

{
    
    NSInteger cnCur;
    NSInteger enCur;
    NSUInteger  pageIndex  ;
    BOOL isshow;
    NSMutableString *strtitle ;
    //单页多段中的位置
    NSUInteger Mp3Index ;
    //文件地址
    NSMutableString *mp3filepath ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //当前第几页
    pageIndex =0;
    Mp3Index=0;
    //当前第几首歌
    _currentIndex = 0;
    // 是否显示或者隐藏
    isshow=YES;
    [self loadData];
    
}
//  上一页
-(UIButton*)previousBtn{
    if(!_previousBtn){
        UIButton *previous =[[ UIButton alloc]  initWithFrame:CGRectMake (kScreenWidth/2 -80 ,0 ,50 ,46)];
        [previous setImage:[UIImage imageNamed:@"zuo.png"] forState:UIControlStateNormal] ;
        [previous addTarget:self action:@selector(previousclickBtn) forControlEvents:UIControlEventTouchUpInside];
        [_bottomUiview addSubview:previous];
        _previousBtn =previous;
    }
    return _previousBtn ;
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
        [  _bottomUiview addSubview:englishButton];
        _englishButton =englishButton;
    }
    return _englishButton;
}
// 双语
-(UIButton *)shuangYuButton{
    __weak typeof(self) weakSelf = self;
    if (!_shuangYuButton) {
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
        [shuangYuButton addTarget:self action:@selector(clickShuangyuBtn) forControlEvents:UIControlEventTouchUpInside] ;
        [_bottomUiview addSubview:shuangYuButton] ;
        _shuangYuButton = shuangYuButton ;
    }
    return _shuangYuButton ;
}
// 返回
-(UIButton *)backBtn {
    if (!_backBtn) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(12,0 , 36, 46)] ;
        [button setTitleColor:[UIColor colorWithHexString:@"#1cb0f6"] forState:UIControlStateNormal];
        [ button setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal] ;
        [button addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        [_topUiview addSubview:  button];
        _backBtn =button ;
        
    }
    return _backBtn;

}

// 标题
-(UILabel*) title{
    if (!_titles) {
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
        scrollView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width *_audioInfos.count,[UIScreen mainScreen].bounds.size.height
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
    _shuangYuButton.enabled=YES ;
    self.languageEnglish=YES;
    [self playmusic:pageIndex];
    
}
//初始化的时候 即进入
-( void) clickShuangyuBtn{
    // 改变颜色
    [_shuangYuButton setTitleColor:[UIColor colorWithHexString:@"1cb0f6"] forState:UIControlStateNormal];
    _shuangYuButton.layer.borderColor=[UIColor  colorWithHexString:@"1cb0f6"].CGColor;
    
    [_englishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _englishButton.layer.borderColor=[UIColor  whiteColor].CGColor;
    _englishButton.enabled=YES;
    _shuangYuButton.enabled=NO;
    self.languageEnglish=NO;
    [self playmusic:pageIndex];
}
// 显示和隐藏头底部的view
-( void) touchScrollView{
    _topUiview.hidden=isshow;
    _bottomUiview.hidden=isshow ;
    isshow=!isshow ;
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

// 获取数据
-( void) loadData {
   
    NSLog(@"rand%@",_rand);
    [CartoonManager audioEntity:self.rand successHandler:^(CartoonAudioEntity *entity) {
        [self.audioInfos addObjectsFromArray:entity.data];
        
        NSMutableDictionary *dic=[entity dicFromData];
        [self.enIndex addObjectsFromArray:dic[@"enIndex"]];
        [self.enArr addObjectsFromArray:dic[@"enArr"]];
        [self.cnIndex addObjectsFromArray:dic[@"cnIndex"]];
        [self.cnArr addObjectsFromArray:dic[@"cnArr"]];
        [self setupUI:entity.title];
        self.mDownLoadDone();
        
    } failure:^(NSError *error) {
        
        
    }];
    
}
//  横屏模式
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape; //只支持横
    
}








- (void)setupUI :(NSMutableString *)tile {
    for (int i = 0; i <_audioInfos.count;i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];
        CartoonAudioInfo * info = [_audioInfos objectAtIndex:i ];
        [imageView setImageWithURL:[NSURL URLWithString: info.img]] ;
        [self.scrollView addSubview:imageView];
    }
    [self bottomUiview];
    [self topUiview] ;
    [self previousBtn];
    [self nextButton] ;
    [self shuangYuButton] ;
    [self englishButtonP] ;
    [self count];
    [self title] ;
    [self backBtn];
    
    NSString* strs=   [NSString stringWithFormat:@"%lu / %lu",(pageIndex+1) ,(unsigned long)_audioInfos.count];
    _count.text =strs ;
    [_shuangYuButton sendActionsForControlEvents:UIControlEventTouchUpInside] ;
    strtitle=tile;
}



// 切换横竖屏的时候调用
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)backItemClick {
}

// 返回
- (void)clickBtn{
    NSLog(@"点击返回");
    //    [self.navigationController popViewControllerAnimated:NO];
     [self dismissModalViewControllerAnimated:YES];
    [self.videoPlayer stopVideo];
   
    
}
//下一页
- (void)nextclickBtn{
    if (pageIndex<_audioInfos.count-1) {
        pageIndex++;
        [_scrollView setContentOffset:CGPointMake(pageIndex * kScreenWidth, 0) animated:YES];
        NSString* strs=   [NSString stringWithFormat:@"%lu / %lu",(pageIndex+1) ,(unsigned long)_audioInfos.count];
        _count.text =strs ;
        [self playmusic:pageIndex] ;
    }
}
// 上一页
- (void)previousclickBtn{
    if (pageIndex>0) {
        pageIndex=--pageIndex;
        [_scrollView setContentOffset:CGPointMake(pageIndex * kScreenWidth, 0) animated:YES];
        NSString *strs=[NSString stringWithFormat:@"%lu / %lu",(pageIndex+1) ,(unsigned long)_audioInfos.count];
        _count.text =strs ;
        // 播放音乐
        [self playmusic:pageIndex] ;
    }
}
//播放 音乐
-(void)playmusic:(NSUInteger)Index{
    if(Index<_enIndex.count){
        if(_languageEnglish){
            NSNumber *number=[_enIndex objectAtIndex:Index];
            enCur=[number integerValue];
            mp3filepath=[_enArr objectAtIndex:enCur];
        }else{
            NSNumber *number=[_cnIndex objectAtIndex:Index];
            cnCur=[number integerValue];
            mp3filepath=[_cnArr objectAtIndex:cnCur];
            NSLog(@"mp3-->%@",mp3filepath);
        }
        [self createStreamer:mp3filepath];
    }
}


// 播放完成
-( void) playNextMusic {
    
    if(_languageEnglish){
        enCur++;
        if(enCur==_enArr.count){
            [self nextclickBtn];
        }else{
            NSNumber *number=[NSNumber numberWithInteger:enCur];
            if([_enIndex containsObject:number]){
                NSInteger index=[_enIndex indexOfObject:number];
                pageIndex=index-1;
                NSLog(@"%ld",index);
                [_nextButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            }else{
                mp3filepath=[_enArr objectAtIndex:enCur];
                [self createStreamer:mp3filepath];
            }
            
        }
    }else{
        cnCur++;
        if(cnCur==_cnArr.count){
            [self nextclickBtn];
        }else{
            NSNumber *number=[NSNumber numberWithInteger:cnCur];
            if([_cnIndex containsObject:number]){
                NSInteger index=[_cnIndex indexOfObject:number];
                NSLog(@"%ld",index);
                pageIndex=index-1;
                [_nextButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            }else{
                mp3filepath=[_cnArr objectAtIndex:cnCur];
                [self createStreamer:mp3filepath];
            }
        }
    }
}
// 初始化播放器 进行播放
- (void)createStreamer: (NSString * )soundFilePath {
    [self.videoPlayer stopVideo];
    self.videoUrl =[@"http://www.huibenabc.com/app/neahow/"stringByAppendingString:soundFilePath];
    self.videoPlayer = [[LYVideoPlayer alloc] init];
    self.videoPlayer.delegate = self;
    [self.videoPlayer playWithUrl:self.videoUrl showView:nil];
    __weak typeof(self) weakSelf = self;
    [self.videoPlayer setPlayVeidoFinish:^{
        [weakSelf playNextMusic];
    }];
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
    NSString* strs= [NSString stringWithFormat:@"%d / %d",pageIndex +1,_audioInfos.count];
    _count.text=strs ;
    [self playmusic:pageIndex];
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
-(NSMutableArray *)enArr
{
    if(!_enArr){
        _enArr=[NSMutableArray array];
    }
    return _enArr;
}
-(NSMutableArray *)enIndex
{
    if(!_enIndex){
        _enIndex=[NSMutableArray array];
    }
    return _enIndex;
}
-(NSMutableArray *)cnArr
{
    if(!_cnArr){
        _cnArr=[NSMutableArray array];
    }
    return _cnArr;
}
-(NSMutableArray *)cnIndex{
    if(!_cnIndex){
        _cnIndex=[NSMutableArray array];
    }
    return _cnIndex;
}
-(NSMutableArray *)audioInfos
{
    if(!_audioInfos){
        _audioInfos=[NSMutableArray array];
    }
    return _audioInfos;
}
@end
