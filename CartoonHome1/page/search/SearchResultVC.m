//
//  SearchResultVC.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/7.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "SearchResultVC.h"
#import "CartoonCell.h"
#import "CartoonEntity.h"
static NSString *const cellID=@"searchCell";

@interface SearchResultVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *resultDatas;
@property (nonatomic, weak) UITableView *rootTableView;
@property (nonatomic, weak) UIView *noDataView;
@property (nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSString *searchWord;
@end

@implementation SearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubview];
    [self setupLoadData];
}


-(void)setupSubview
{
    MJWeakSelf;
    [self.view addSubview:self.rootTableView];
    __unsafe_unretained UITableView *mRootTableView=self.rootTableView;
    mRootTableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadDataFromStart:NO search:_searchWord];
        
    }];
}
-(void)setupLoadData{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleColorChange:) name:@"searchBarDidChange" object:nil];
}

-(void)handleColorChange:(NSNotification* )sender
{
    _searchWord = sender.userInfo[@"searchText"];
    [self loadDataFromStart:YES search:_searchWord];
}

-(void)loadDataFromStart:(BOOL)boolean search:(NSString *)search
{
    if(boolean){
        self.page=1;
    }
    [CartoonManager searchCartoonEntity:self.page search:search successHandler:^(CartoonEntity *entity) {
        if(boolean){
            [self.resultDatas removeAllObjects];
        }
        if(entity.data.count==0){
            return ;
        }
        [self.resultDatas addObjectsFromArray:entity.data];
        [self.rootTableView setHidden:NO];
        [self.rootTableView reloadData];
        self.page++;
        [self.rootTableView.mj_footer endRefreshing];
    } failureHandler:^(NSError *error) {
        NSLog(@"失败了")
        
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultDatas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartoonCell *cell=[CartoonCell cellWithTableView:tableView];
    CartoonsInfo *info=self.resultDatas[indexPath.row];
    cell.info=info;
    
    return cell;
}




- (UITableView *)rootTableView {
    if (!_rootTableView) {
        UITableView *rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStylePlain];
        rootTableView.backgroundColor = Global_BGWhite_Color;
        rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        rootTableView.delegate = self;
        rootTableView.dataSource = self;
        rootTableView.rowHeight=234;
        [self.view addSubview:rootTableView];
        [rootTableView registerClass:[CartoonCell class] forCellReuseIdentifier:@"cartoonCell"];
        _rootTableView = rootTableView;

    }
    return _rootTableView;
}

- (UIView *)noDataView {
    if (!_noDataView) {
        UIView *noDataView = [[UIView alloc] initWithFrame:self.rootTableView.frame];
        noDataView.backgroundColor = Global_BGWhite_Color;
        UILabel *label = [[UILabel alloc] init];
        label.font = kFont(16);
        label.text = @"没有搜到你想要的相关信息";
        label.textColor = TJPColor(125, 135, 148);
        [label sizeToFit];
        label.center = CGPointMake(self.view.tjp_width * 0.5, self.view.tjp_height * 0.5);
        [noDataView addSubview:label];
        [self.view addSubview:noDataView];
        _noDataView = noDataView;
        
    }
    return _noDataView;
}

-(NSMutableArray *)resultDatas
{
    if(!_resultDatas){
        _resultDatas=[NSMutableArray array];
    }
    return _resultDatas;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.didSelectText(@"");
}

@end
