//
//  LocalListView.m
//  Play
//
//  Created by 陈 on 2017/5/19.
//  Copyright © 2017年 huiben. All rights reserved.
//

#import "LocalListView.h"
#import"Item_Locall.h"
#import "PlayVC.h"


#define kScreenWidth                         [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                        [UIScreen mainScreen].bounds.size.height
// 保存系统了路径

#define TJPSEARCH_HISTORY_CACHE_PATH        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"TJPSearchHistories.plist"] // 搜索历史存储路径

static NSString * const historyCell = @"historyCell";
static NSString *const commentCell = @"commentCell";
@interface LocalListView () <UITableViewDelegate, UITableViewDataSource>

//创建tabview
@property ( nonatomic , weak) UITableView*  tabview;
// 数据
@property (nonatomic, strong) NSMutableArray *rootDatas;
//  缓存 数据的路径
@property (nonatomic, copy) NSString *  CachePath;
@end
static NSString * const topicCell = @"topicCell";


@implementation LocalListView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
        [self commentTableView];
    
        [self loadNewData];
}

// 获取 缓存的数据
-( NSMutableArray * ) rootDatas {
    if (!_rootDatas) {
             _rootDatas = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:TJPSEARCH_HISTORY_CACHE_PATH]];
    }

    return _rootDatas ;

}
// listview

- (UITableView *)commentTableView {
    if (!_tabview) {
        UITableView *commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight ) style:UITableViewStylePlain];
        commentTableView.backgroundColor = [UIColor whiteColor];
        commentTableView.delegate = self;
        commentTableView.dataSource = self;
        commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        commentTableView.rowHeight = UITableViewAutomaticDimension;
        commentTableView.estimatedRowHeight = 180;
        [self.view addSubview:commentTableView];
        _tabview = commentTableView;
        [_tabview registerNib:[UINib nibWithNibName:@"Item_Locall" bundle:nil] forCellReuseIdentifier:commentCell];
    }
    NSLog(@"jinqu ");
    return _tabview;
}
// 获取缓存的路径


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 获取缓存的数据
-(void) loadNewData {


    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
// 实现tabview  的方法
#pragma mark - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// 设置条数
-( NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.rootDatas.count ;
    return  6;

}

 //
-(UITableViewCell  *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Item_Locall *cell = [tableView dequeueReusableCellWithIdentifier:commentCell];
    if (!cell) {
        cell = [[Item_Locall alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCell];
   
    
    
    
    }
    cell.backgroundColor = [UIColor whiteColor];

    return cell;
}
//// 标题
//-( NSString *)   tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
// return @" 历史记录";
//}

// 设置每个item 的高度  暂时去掉
//-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//
//
//    return 80 ;
//}

// 点击点击item 执行的操作
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayVC * playview= [[PlayVC alloc]  init] ;
    [self presentViewController:playview animated:YES completion:^{
        
        
    }];
//  [self presentModalViewController:playview animated:YES];
//    NSLog(@"点击了第%d个",indexPath.row) ;//打开播放中心
 
}
@end
