//
//  DetailVC.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/24.
//  Copyright © 2017年 刘然. All rights reserved.
//   ld表示integer

#import "DetailVC.h"
#import "DetailEntity.h"
#import "DetailWebCell.h"
#import "DetailBasicCell.h"
#import "DetailContentCell.h"
#import "CommentEntity.h"
#import "CommentInfo.h"
#import "CommentCell.h"
#import "CommentEntity.h"
#import "CommentInfo.h"
#import "HeadView.h"
#import "XHCommentCell.h"


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

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self settingNavigation];
    [self initView];
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
        UITableView *tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        tableView.rowHeight=UITableViewAutomaticDimension;
        tableView.estimatedRowHeight=78;
        _tableView=tableView;

//        [_tableView registerClass:[CommentCell class] forCellReuseIdentifier:commentsCell];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
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


@end
