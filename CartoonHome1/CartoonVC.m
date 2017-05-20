//
//  CartoonVC.m
//  BasicAFNetTest
//
//  Created by 刘然 on 2017/5/18.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "CartoonVC.h"
#import "CartoonManager.h"
#import "CartoonEntity.h"
#import "CartoonCell.h"
#import "CartoonsInfo.h"
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
}
-(void)loadData{
    NSLog(@"进入了嗯");
    [CartoonManager getCartoonEntity:0 successHandler:^(CartoonEntity *entity) {
        NSLog(@"num%ld",entity.data.count);
        
        [self.dataArray addObjectsFromArray:entity.data];
        NSLog(@"num%ld",_dataArray.count);
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
        
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
        _tableView.rowHeight=264;
        _tableView.height-=49;
        [_tableView setHidden:YES];
    }
    return _tableView;
}

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
-(NSMutableArray *)dataArray
{
    if(!_dataArray){
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
@end
