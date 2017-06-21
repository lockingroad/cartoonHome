//
//  LocalListView.m
//  Play
//
//  Created by 陈 on 2017/5/19.
//  Copyright © 2017年 huiben. All rights reserved.
//

#import "LocaleVC.h"
#import "PlayVC.h"
#import "LocaleCell.h"
@interface LocaleVC () <UITableViewDelegate, UITableViewDataSource,SWTableViewCellDelegate>
@property ( nonatomic ,strong) UITableView*  tableView;
@property(nonatomic,strong)NSMutableArray *data;
@end
@implementation LocaleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadData];
}

-(void)setupView
{
    [self.view addSubview:self.tableView];
}

-(void)loadData{
    [CartoonManager detailList:nil successhandler:^(NSArray *arr) {
        [_data addObjectsFromArray:arr];
    } failure:^(NSError *error) {
        
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-( NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _data.count;

}
-(UITableViewCell  *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LocaleCell *cell=[LocaleCell cellWithTableView:self.tableView
                                           reuseID:@"cell"];

    cell.rightUtilityButtons=[self rightButtons];
    cell.delegate=self;
    DetailEntityStore *entity=[_data objectAtIndex:indexPath.row];
    [cell updateData:entity];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailEntityStore *entity=[_data objectAtIndex:indexPath.row];
    PlayVC * playview= [[PlayVC alloc]  init] ;
    playview.rand=entity.rand;
    [self presentViewController:playview animated:YES completion:^{
        
        
    }];
}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    NSLog(@"点击了--->%ld",index);//more是0 delete是1
}

-(UITableView *)tableView
{
    if(!_tableView){
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight ) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.estimatedRowHeight=100;
        _tableView.backgroundColor=[UIColor whiteColor];
    }
    return _tableView;
}
/**

 删除 按钮
 */
- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    return rightUtilityButtons;
}

-(NSMutableArray *)data
{
    if(!_data){
        _data=[NSMutableArray array];
    }
    return _data;
}
@end
