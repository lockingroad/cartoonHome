//
//  HBProtocolViewController.m
//  Play
//
//  Created by 陈 on 2017/5/31.
//  Copyright © 2017年 huiben. All rights reserved.
//

#import "HBProtocolViewController.h"
#import "SVProgressHUD.h"
@interface HBProtocolViewController ()<UIWebViewDelegate>
@property  (nonatomic ,weak )UIWebView* uiwebview;
#define kScreenWidth                         [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                        [UIScreen mainScreen].bounds.size.height
@end

@implementation HBProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"用户协议";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self uiwebview ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIWebView*) uiwebview{
    if (!_uiwebview) {
           UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight - 64)];
        
               [self.view addSubview:webView];
        
        _uiwebview=webView;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/passport.php?ac=userrule"]];
        _uiwebview.delegate = self;
        [_uiwebview loadRequest:request];
    }

    return  _uiwebview ;
}




- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始加载");
    
    
}
// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //开始加载

        [SVProgressHUD showWithStatus:@"请稍后.."];
 
    
    return YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if([error code] == NSURLErrorCancelled){
        return;
    }
//      [MBProgressHUD showMessage:error.localizedDescription inView:self.view];
}

@end
