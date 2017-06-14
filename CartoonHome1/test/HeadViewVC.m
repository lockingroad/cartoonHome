//
//  HeadViewVC.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/5/31.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "HeadViewVC.h"
#import "HeadView.h"
#import "StaticHeadView.h"

@interface HeadViewVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSMutableArray *data;
@end

@implementation HeadViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupTableView];

   
}


-(void)setupTableView
{
    UITableView *mTableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    mTableView.delegate=self;
    mTableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    
    mTableView.dataSource=self;
    [self.view addSubview: mTableView];
    
    
    self.tableView=mTableView;
    
    
//    HeadView *mHeadView=[[HeadView alloc]init];
//    
//    [mTableView setTableHeaderView:mHeadView];
//    [mHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(self.view.width);
//        
//    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [mHeadView mockEntity];
//    });
//    
//    mHeadView.viewBlock = ^(CGFloat f) {
//     
//
//        NSLog(@"hei----%f",f);
//        CGRect newFrame = mHeadView.frame;
//        newFrame.size.height = newFrame.size.height + f/2;
//        mHeadView.frame = newFrame;
//        [self.tableView setTableHeaderView: mHeadView];
//        
//    };
    
    
//    StaticHeadView *staticHead=[[StaticHeadView alloc]init];
//    [mTableView setTableHeaderView:staticHead];
//    [staticHead mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(self.view.width);
//        
//    }];
//    
//    [self.tableView.tableHeaderView layoutIfNeeded];

}
-(NSMutableArray *)data
{
    if((_data=[NSMutableArray array])){
        for(int i=0;i<20;i++){
            [_data addObject:[NSString stringWithFormat:@"item--->%d",i]];
        }
    }
    return _data;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=self.data[indexPath.row];
    return cell;
}


@end
