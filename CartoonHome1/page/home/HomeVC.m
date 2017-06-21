//
//  HomeVC.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/19.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "HomeVC.h"
#import "DFSegmentBaseController.h"
#import "DFSegmentView.h"
#import <Masonry.h>
#import "CartoonVC.h"
#import "EmptyVC.h"
#import "SearchVC.h"
#import "LocaleVC.h"
#import "TitleEntity.h"
#import "TitleInfo.h"
#import "LoginViewController.h"
@interface HomeVC ()<DFSegmentViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong)NSMutableArray *arrData;
@property(nonatomic,strong)DFSegmentView *segment;
@property(nonatomic,strong)TitleEntity *entity;
@property(nonatomic,strong)NSString *token;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSegmentView];
    [self setupNavigation];
    [self loadData];
}

-(void)loadData{

    [CartoonManager titles:nil successHandler:^(TitleEntity *entity) {
        self.entity=entity;
        NSMutableArray *arr=[NSMutableArray array];
        for(TitleInfo *info in entity.data){
            [arr addObject:info.title];
        }
        [self.arrData addObjectsFromArray:arr];
        [self.segment reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];

    
}
-(void)setupSegmentView{
    [self.view addSubview:self.segment];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.segment.delegate = self;
    
    
    self.segment.reloadTitleArr = self.arrData;
    //    segment.reloadTitleArr=@[@"推荐",@"系列绘本",@"学龄前",@"小学生",@"最新"];
    self.segment.tintColor=[UIColor blackColor];
    self.segment.headViewLinelColor=[UIColor redColor];
    self.segment.headViewTextLabelColor=[UIColor greenColor];
    [self.segment tintColorDidChange];
    [self.segment reloadData];
}

-(void)setupNavigation
{
    self.view.backgroundColor=[UIColor yellowColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage rx_imageViewWithColor:kUIColorFromRGB(0x18a8f6) size:CGSizeMake(30, 30)] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.titleView=[self recommendTitleView];
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem rx_barBtnItemWithNmlImg:@"icon_mine" hltImg:@"icon_mine" target:self action:@selector(rightClick)];
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem rx_barBtnItemWithNmlImg:@"icon_download" hltImg:@"icon_download" target:self action:@selector(leftClick)];
    
    
}
-(void)rightClick{
    
    _token=[CartoonHelper getToken];
    if(_token.length){
        _mBloRight();
    }else{
        LoginViewController *loginVC=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}
//直接跳转
-(void)leftClick{
    _mBloLeft();
    LocaleVC *local =[[LocaleVC alloc] init];
    [self.navigationController pushViewController:local animated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage rx_imageViewWithColor:kUIColorFromRGB(0x18a8f6) size:CGSizeMake(30, 30)] forBarMetrics:UIBarMetricsDefault];
}

-(DFSegmentView *)segment
{
    if(!_segment){
        _segment = [[DFSegmentView alloc] initWithFrame:CGRectZero andDelegate:self andTitlArr:nil];
    }
    return _segment;
}
#pragma mark - privite
- (UIView *)recommendTitleView {
    
    CGFloat titleW;
    if (IS_IPHONE_5) {
        titleW = kScreen_Width * 0.688 - 10;
    }else {
        titleW = kScreen_Width * 0.688;
    }
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleW, 35)];
    //    titleView.backgroundColor = [UIColor redColor];
    
    //searchBar
    UISearchBar *searchBar = [UISearchBar setUpHomePageSearchBarWithFrame:titleView.frame];
    searchBar.delegate = self;
    [titleView addSubview:searchBar];
    
    //line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(titleView.tjp_x, 34, titleView.tjp_width, 1)];
    lineView.layer.borderWidth = 1;
    lineView.layer.borderColor = Global_Yellow_Color.CGColor;
    [titleView addSubview:lineView];
    return titleView;
}

- (UIViewController *)superViewController {
    return self;
}

//对应的cartoonVC
- (UIViewController *)subViewControllerWithIndex:(NSInteger)index {
    TitleInfo *info=[self.entity.data objectAtIndex:index];
    CartoonVC *cartoon=[[CartoonVC alloc]initWithTitleID:info.title_id];
    return cartoon;
}
-(NSMutableArray *)arrData
{
    if(!_arrData){
        _arrData=[NSMutableArray array];
    }
    return _arrData;
}

- (void)headTitleSelectWithIndex:(NSInteger)index {
    
    NSLog(@"---%ld",index);
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    SearchVC *searchVC=[SearchVC new];
    searchVC.tagsArray=@[@"长吻鳄", @"测试", @"测试", @"测试"];
    
    [self.navigationController pushViewController:searchVC animated:NO];
    return NO;
}

@end
