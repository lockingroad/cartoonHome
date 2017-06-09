//
//  CartoonVC.m
//  BasicAFNetTest
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//  刷新下拉时候的 引用使用unsage retain

#import "CartoonVC.h"
#import "CartoonEntity.h"
#import "CartoonCell.h"
#import "CartoonsInfo.h"
#import "DetailVC.h"
@interface CartoonVC()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger page;
@end
@implementation CartoonVC


-(void)viewDidLoad
{
    [self setupSubView];
    [self loadData];
    
}
-(void)setupSubView
{
    [self.view addSubview:self.tableView];
    __unsafe_unretained UITableView *tableView=self.tableView;
    __weak typeof(self)weakSelf=self;//内部block中的都用弱引用?  调用了self的方法?
    tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataFromStart:YES];
        
        
    }];
    tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadDataFromStart:NO];
        
    }];
}
-(void)loadData{
    [self loadDataFromStart:YES];
}

-(void)loadDataFromStart:(BOOL)boolean
{
    if(boolean){
        self.page=1;
    }
    [CartoonManager getCartoonEntity:self.page successHandler:^(CartoonEntity *entity) {
        NSLog(@"num%ld",entity.data.count);
        if(boolean){
            [self.dataArray removeAllObjects];
        }
        
        if(entity.data.count==0){
            return ;
        }
        [self.dataArray addObjectsFromArray:entity.data];
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
        self.page++;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } failureHandler:^(NSError *error) {
        NSLog(@"失败了");
        
    }];
}



-(UITableView *)tableView
{
    if(!_tableView){
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellAccessoryNone;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.rowHeight=234;
//        _tableView.height-=49;
        [_tableView setHidden:YES];
    }
    return _tableView;
}
//通常都是1个section  n个row
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartoonCell *cell=[CartoonCell cellWithTableView:tableView];
    CartoonsInfo *info=self.dataArray[indexPath.row];
    

    NSLog(@"infoImg%@",info.picbookapiimg);
    cell.info=info;
    return cell;
}
//数组初始化的 经典方式!
-(NSMutableArray *)dataArray
{
    if(!_dataArray){
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailVC *detail=[[DetailVC alloc]init];
    [self.navigationController pushViewController:detail animated:NO];
    
}
@end