//
//  DetailVC.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/24.
//  Copyright © 2017年 刘然. All rights reserved.
//   ld表示integer

#import "DetailVC.h"
#import "DetailEntity.h"
#import "CommentEntity.h"
#import "CommentInfo.h"
#import "CommentEntity.h"
#import "CommentInfo.h"
#import "HeadView.h"
#import "XHCommentCell.h"
#import "XHToolBar.h"
#import "SimpleEntity.h"


static const CGFloat headViewHei=250;
static const CGFloat kHeaderViewH = 250;
static NSString *commentsCell=@"commentCell";

@interface DetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)DetailEntity *data;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)CommentEntity *commentData;
@property(nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic, strong) UIImageView * navigationImageView;
@property(nonatomic,strong)XHToolBar *toolBar;
@property(nonatomic,assign)CGFloat originY;
@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNotification];
    [self settingNavigation];
    [self initView];
    [self toolBar];
    [self loadData];
    
}
-(void)loadData{
    [CartoonManager getDetailEntity:@"" token:@"" successHandler:^(DetailEntity *entity) {
        self.data=entity;
        
    } failureHandler:^(NSError *error) {
        
        
    }];
    self.page=1;
    [CartoonManager getComments:self.page successHandler:^(CommentEntity *entity) {
        self.commentData=entity;
    
        CommentInfo *info=entity.comments[0];
        NSLog(@"hbid%@",info.hbid)
        [self.dataArr addObjectsFromArray:entity.comments];
        
        NSLog(@"daxn....%ld",self.dataArr.count);
        
        
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
    } failureHandler:^(NSError *error) {
        
        
    }];
}

-(void)setData:(DetailEntity *)data
{
    _data=data;
    HeadView *headView=[[HeadView alloc]init];
    
    [_tableView setTableHeaderView:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.mas_width);
        
    }];
    headView.viewBlock = ^(CGFloat f) {
        
        
        NSLog(@"hei----%f",f);
        CGRect newFrame = headView.frame;
        newFrame.size.height = newFrame.size.height + f/2;
        headView.frame = newFrame;
        [self.tableView setTableHeaderView: headView];
    };
    [headView setEntity:_data];
    [_tableView reloadData];
    [_tableView .tableHeaderView layoutIfNeeded];
}
-(void)initView
{
    [self.view addSubview:self.tableView];
    self.view.backgroundColor=[UIColor greenColor];
    
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:@"UIKeyboardWillHideNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return self.dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index-->%ld--->%ld",indexPath.row,indexPath.section);
    
    XHCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:commentsCell];
    
    if(self.dataArr){
        [cell setCommentItem:self.dataArr[indexPath.row]];
    }
    return cell;
}
-(UITableView *)tableView
{
    if(!_tableView){
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-(kToolBarHeight)) style:UITableViewStylePlain];
        
        
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        tableView.rowHeight=UITableViewAutomaticDimension;
        tableView.estimatedRowHeight=78;
        _tableView=tableView;

        
        [_tableView registerNib:[UINib nibWithNibName:@"XHCommentCell" bundle:nil] forCellReuseIdentifier:commentsCell];
    }
    return _tableView;
}
-(UIView *)setUpHeadView
{
    HeadView *topView=[[HeadView alloc]init];
//    topView.size=CGSizeMake(kScreen_Width, 350);
//    topView.entity=self.data;
    return topView;
}

-(NSMutableArray *)dataArr
{
    if(!_dataArr){
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}

-(XHToolBar *)toolBar
{
    if(!_toolBar){
//        CGFloat originY=self.navigationController.navigationBar.translucent?(kScreenHeight-kToolBarHeight):(kScreenHeight-(kNavigationBarHeight+kToolBarHeight));
        CGFloat originY=(kScreenHeight-kToolBarHeight);
        
        _originY=originY;
        XHToolBar *toolBar = [[XHToolBar alloc] initWithFrame:CGRectMake(0, originY, kScreenWidth, kToolBarHeight)];
        [self.view addSubview:toolBar];
        _toolBar = toolBar;
        MJWeakSelf;
        [_toolBar setXHToolBarSendBtnClick:^(NSString *content) {
            [weakSelf updateCommentDataWithContent:content];
            
        }];

    }
    return _toolBar;
}


#pragma mark - privite
- (void)updateCommentDataWithContent:(NSString *)content {
    [CartoonManager doComments:content token:nil hbid:@"167" replayuid:@"" successHandler:^(SimpleEntity *entity) {
        SimpleEntity *other=entity;
        NSLog(@"评论成功了%d",other.status);
        
    } failureHandler:^(NSError *error) {
        
        
    }];
}

- (void)hideNavigationBar {
    self.navigationController.navigationBar.translucent = YES;
    //去导航条边线和背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    self.navigationImageView.hidden = YES;
}

- (void)settingNavigation {
    self.automaticallyAdjustsScrollViewInsets = NO;
    //背景透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    //去掉导航栏边线
    self.navigationImageView = [UIImageView findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    [self setNavigationItemWithLeftImage:@"detail_back" andRightImage:@"detail_comment"];
    
}

- (void)setNavigationItemWithLeftImage:(NSString *)leftImage andRightImage:(NSString *)rightImage {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:leftImage contentOffset:UIEdgeInsetsMake(0, -20, 0, 0) highImage:@"" target:self andAction:@selector(leftClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:rightImage contentOffset:UIEdgeInsetsMake(-4, 0, 0, -20) highImage:@"" target:self andAction:@selector(rightClick)];
}

#pragma mark - privite
- (void)updateNavigationItemWithLeftImage:(NSString *)leftImage andRightImage:(NSString *)rightImage {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:leftImage contentOffset:UIEdgeInsetsMake(0, -3, 0, 0) highImage:@"" target:self andAction:@selector(leftClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:rightImage contentOffset:UIEdgeInsetsMake(0, 0, 0, -9) highImage:@"" target:self andAction:@selector(rightClick)];
}

-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightClick
{
    
}

- (void)keyboardWillHidden:(NSNotification *)sender{
    self.toolBar.tjp_y = _originY;
}


- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect keyboardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.toolBar.tjp_y = self.view.frame.size.height - keyboardRect.size.height - _toolBar.tjp_height;
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)cancelNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    CGFloat offset = _tableView.contentOffset.y;
    
    if (offset > kNavigationBarHeight) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithNavigationBgColor:[UIColor colorWithRed:0 / 255.0f green:0 / 255.0f blue:0 / 255.0f alpha:offset / kHeaderViewH]] forBarMetrics:UIBarMetricsDefault];
        [self updateNavigationItemWithLeftImage:@"detail_back" andRightImage:@"detail_comment"];
        self.title = @"haha";
    }else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithNavigationBgColor:[UIColor colorWithRed:0 / 255.0f green:0 / 255.0f blue:0 / 255.0f alpha:0]] forBarMetrics:UIBarMetricsDefault];
        [self setNavigationItemWithLeftImage:@"detail_back" andRightImage:@"detail_comment"];
        self.title = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //隐藏nav
    [self hideNavigationBar];
    
    if (self.tableView.contentOffset.y > 100) { //tableView 偏移量如果超过100 设置颜色
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithNavigationBgColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    }
    
}


- (void)dealloc
{
    [self cancelNotification];
}

@end
