//
//  DetailVC.m
//  CartoonHome1
//
//  Created by 刘然 on 2017/5/24.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "DetailVC.h"
#import "DetailEntity.h"
#import "DetailWebCell.h"
#import "DetailBasicCell.h"


static NSString *basicCell=@"detailBasicCell";
static NSString *webCell=@"detailWebCell";

@interface DetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)DetailEntity *data;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    [self loadData];
    
}
-(void)loadData{
    [CartoonManager getDetailEntity:@"" token:@"" successHandler:^(DetailEntity *entity) {
        self.data=entity;
        
    } failureHandler:^(NSError *error) {
        
        
    }];
}

-(void)setData:(DetailEntity *)data
{
    _data=data;
    [_tableView reloadData];
}
-(void)initView
{
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_data){
        return 2;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        DetailBasicCell *cell=[tableView dequeueReusableCellWithIdentifier:basicCell];
        if(!cell){
            
        }
    }
    return nil;
}
-(UITableView *)tableView
{
    if(_tableView){
        UITableView *tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView=tableView;
        [_tableView registerClass:[DetailWebCell class] forCellReuseIdentifier:webCell];
        [_tableView registerClass:[DetailBasicCell class] forCellReuseIdentifier:basicCell];
    }
    return _tableView;
}

@end
