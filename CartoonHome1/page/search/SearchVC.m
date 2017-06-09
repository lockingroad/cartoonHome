//
//  SearchVC.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/7.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "SearchVC.h"
#import "UISearchBar+XHExtension.h"
#import "SearchResultVC.h"
static NSString *const historyCellID=@"historyCell";
@interface SearchVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>


@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,copy)NSMutableArray *searchDatas;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *tagsView;
@property(nonatomic,copy)NSMutableArray *historyData;
@property(nonatomic,strong)NSString *path;
@property(nonatomic,strong)SearchResultVC *resultVC;
@end

@implementation SearchVC
{
    NSUInteger _searchCount;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=Global_BGWhite_Color;
    _searchCount=20;
    
    [self tableView];
    
    [self loadTagsForTagView];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.searchBar];
    [_searchBar becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchBar resignFirstResponder];
    [_searchBar removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:historyCellID forIndexPath:indexPath];
    cell.backgroundColor = Global_BGWhite_Color;
    // 添加关闭按钮
    UIButton *closetButton = [[UIButton alloc] init];
    // 设置图片容器大小、图片原图居中
    closetButton.tjp_size = CGSizeMake(cell.tjp_height, cell.tjp_height);
    [closetButton setTitle:@"x" forState:UIControlStateNormal];
    [closetButton addTarget:self action:@selector(closeDidClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = closetButton;
    [closetButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    cell.textLabel.textColor = TJPColor(125, 135, 148);
    cell.textLabel.font = kFont(14);
    cell.textLabel.text = self.historyData[indexPath.row];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _searchBar.text = self.historyData[indexPath.row];
    // 缓存数据并且刷新界面
    [self saveSearch];
    [self searchBar:_searchBar textDidChange:_searchBar.text];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.historyData.count) {
        return @"搜索历史";
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 10, 40)];
    view.backgroundColor = Global_BGWhite_Color;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:view.frame];
    titleLabel.text = @"搜索历史";
    titleLabel.font = kFont(12);
    titleLabel.textColor = TJPColor(180, 180, 180);
    [titleLabel sizeToFit];
    [view addSubview:titleLabel];
    return view;
}

-(SearchResultVC *)resultVC
{
    if(!_resultVC){
        SearchResultVC *resultVC=[[SearchResultVC alloc]init];
        MJWeakSelf;
        [resultVC setDidSelectText:^(NSString *selectText){
            if(!selectText.length||[selectText isEqualToString:@""]){
                [weakSelf.searchBar resignFirstResponder];
            }else{
                // 设置搜索信息
                weakSelf.searchBar.text = selectText;
                // 缓存数据并且刷新界面
                [weakSelf saveSearch];
            }
        }];
    
        resultVC.view.frame=CGRectMake(0, 0, self.view.tjp_width, self.view.tjp_height);
        [self.view addSubview:resultVC.view];
        [self addChildViewController:resultVC];
        _resultVC=resultVC;
    }
    return _resultVC;
}

-(NSMutableArray *)searchDatas
{
    if(!_searchDatas){
        _searchDatas=[NSMutableArray array];
    }
    return _searchDatas;
    
}

-(NSMutableArray *)historyData
{
    if(!_historyData){
        _path=TJPSEARCH_HISTORY_CACHE_PATH;
        _historyData=[NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:_path]];
    }
    return _historyData;
}

-(UISearchBar *)searchBar
{
    if(!_searchBar){
    
        UISearchBar *searchBar=[UISearchBar setUpSearchViewControllerSearchBarWithFrame:CGRectMake(40, 8, kScreenWidth-50, 28)];
        searchBar.delegate=self;
        _searchBar=searchBar;
    }
    return _searchBar;
}

-(UITableView *)tableView
{
    if(!_tableView){
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarHeight) style:UITableViewStylePlain];
        tableView.backgroundColor=Global_BGWhite_Color;
        
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        tableView.tableHeaderView=[self loadHeaderView];
        tableView.tableFooterView=[self loadFooterView];
        tableView.tableFooterView.hidden=self.historyData.count?NO:YES;
        
        [self.view addSubview:tableView];
        _tableView=tableView;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:historyCellID];
        
    }
    return _tableView;
}


-(UIView *)headerView
{
    if(!_headerView){
        _headerView=[[UIView alloc]init];
        _headerView.backgroundColor=Global_BGWhite_Color;
        _headerView.tjp_x=0;
        _headerView.tjp_y=0;
        _headerView.tjp_width=kScreenWidth;
    }
    return _headerView;
}
-(UIView *)loadHeaderView{

    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 13, kScreenWidth-20, 30)];
    titleLabel.text=@"热门搜索";
    titleLabel.font=kFont(12);
    titleLabel.textColor=TJPColor(180, 180, 180);
    [titleLabel sizeToFit];
    [self.headerView addSubview:titleLabel];
    self.tagsView=[[UIView alloc]init];
    self.tagsView.tjp_x=15;
    self.tagsView.tjp_y=titleLabel.tjp_y+30;
    self.tagsView.tjp_width=kScreenWidth-20;
    [self.headerView addSubview:_tagsView];
    return _headerView;
}

-(UIView *)loadFooterView{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *footLabel=[[UILabel alloc]initWithFrame:footerView.frame];
    footLabel.textColor=[UIColor grayColor];
    footLabel.font=[UIFont systemFontOfSize:13];
    footLabel.userInteractionEnabled=YES;
    footLabel.text=@"清空搜索记录";
    footLabel.textAlignment=NSTextAlignmentCenter;
    [footLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emptyClick)]];
    [footerView addSubview:footLabel];
    return footerView;
}
-(void)emptyClick{
    self.tableView.tableFooterView.hidden=YES;
    [self.historyData removeAllObjects];
    [NSKeyedArchiver archiveRootObject:self.searchDatas toFile:self.path];
    [self.tableView reloadData];
}


-(void)saveSearch{
    UISearchBar *searchBar=self.searchBar;
    [searchBar resignFirstResponder];
    [self.historyData removeObject:searchBar.text];
    [self.historyData insertObject:searchBar.text atIndex:0];
    
    if(self.historyData.count>_searchCount){
        [self.historyData removeLastObject];
    }
    
    [NSKeyedArchiver archiveRootObject:self.historyData toFile:self.path];
    [self.tableView reloadData];
}


- (void)closeDidClick:(UIButton *)sender
{
    // 获取当前cell
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    // 移除搜索信息
    [self.historyData removeObject:cell.textLabel.text];
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.historyData toFile:TJPSEARCH_HISTORY_CACHE_PATH];
    if (self.historyData.count == 0) {
        self.tableView.tableFooterView.hidden = YES;
    }
    // 刷新
    [self.tableView reloadData];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchText=searchBar.text;
    if(searchText.length){
        [self saveSearch];
        [self searchText:searchText];
    }
}

-(void)searchText:(NSString*)searchText{
    if (!searchText.length || [searchText isEqualToString:@""]) {
        self.resultVC.view.hidden = YES;
        self.tableView.hidden = NO;
    }
    else
    {
        self.resultVC.view.hidden = NO;
        self.tableView.hidden = YES;
        [self.view bringSubviewToFront:self.resultVC.view];
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"searchBarDidChange" object:nil userInfo:@{@"searchText":searchText}];
    }

}



- (void)loadTagsForTagView {
    CGFloat allLabelWidth = 0;
    CGFloat allLabelHeight = 0;
    int rowHeight = 0;
    
    for (int i = 0; i < self.tagsArray.count; i++) {
        if (i != self.tagsArray.count - 1) {
            CGFloat width = [self getWidthWithTitle:self.tagsArray[i + 1] font:kFont(14)];
            if (allLabelWidth + width + 10 > self.tagsView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight * 35;
            }
        } else {
            CGFloat width = [self getWidthWithTitle:self.tagsArray[self.tagsArray.count - 1] font:kFont(14)];
            if (allLabelWidth + width + 10 > self.tagsView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight * 35;
            }
        }
        
        UILabel *rectangleTagLabel = [[UILabel alloc] init];
        // 设置属性
        rectangleTagLabel.userInteractionEnabled = YES;
        rectangleTagLabel.font = kFont(14);
        rectangleTagLabel.textColor = TJPColor(125, 135, 148);
        rectangleTagLabel.backgroundColor = [UIColor whiteColor];
        rectangleTagLabel.layer.borderWidth = 1;
        rectangleTagLabel.layer.borderColor = TJPColor(231, 234, 241).CGColor;
        rectangleTagLabel.text = self.tagsArray[i];
        rectangleTagLabel.textAlignment = NSTextAlignmentCenter;
        [rectangleTagLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidClick:)]];
        
        CGFloat labelWidth = [self getWidthWithTitle:self.tagsArray[i] font:kFont(14)];
        rectangleTagLabel.layer.cornerRadius = 2;
        [rectangleTagLabel.layer setMasksToBounds:YES];
        
        rectangleTagLabel.frame = CGRectMake(allLabelWidth, allLabelHeight, labelWidth, 25);
        [self.tagsView addSubview:rectangleTagLabel];
        
        allLabelWidth = allLabelWidth + 10 + labelWidth;
    }
    
    self.tagsView.tjp_height = rowHeight * 40 + 40;
    self.headerView.tjp_height = self.tagsView.tjp_y + self.tagsView.tjp_height + 10;
    
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    
    return label.frame.size.width + 10;
}

- (void)tagDidClick:(UITapGestureRecognizer *)tap {
    UILabel *label = (UILabel *)tap.view;
    self.searchBar.text = label.text;
    
    // 缓存数据并且刷新界面
    [self saveSearch];
    
    self.tableView.tableFooterView.hidden = NO;
    
    
    self.resultVC.view.hidden = NO;
    self.tableView.hidden = YES;
    [self.view bringSubviewToFront:self.resultVC.view];
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"searchBarDidChange" object:nil userInfo:@{@"searchText":label.text}];
}

@end
