//
//  LoginViewController.m
//  Play
//
//  Created by 陈 on 2017/5/25.
//  Copyright © 2017年 huiben. All rights reserved.
//

#import "LoginViewController.h"

#import "XHSpecialButton.h"
#import "UITextField+XHExtension.h"
#import "UIButton+XHExtension.h"
#import "UIColor+ColorChange.h"

#import "UIBarButtonItem+TJPItem.h"
#import "NSArray+MASAdditions.h"
#import "View+MASAdditions.h"
#import "TJPNetworkUtils.h"
#import <UMSocialCore/UMSocialCore.h>
#import "RegisterViewController.h"

    //editext  监听器
@interface LoginViewController () <UITextFieldDelegate>
// 账户
@property (nonatomic ,weak) UITextField * MaccountText ;
// 密码
@property ( nonatomic ,weak)UITextField* PWdtext;
@property(nonatomic,strong)TJPNetworkUtils *networking;

// 登录密码
@property(nonatomic,weak) UIButton* btnLogin;




#define kScreenWidth                         [UIScreen mainScreen].bounds.size.width
#define kFont(size) [UIFont systemFontOfSize:size]
@end

@implementation LoginViewController  {
    NSString *_platform;

}

- (void)viewDidLoad {
    

    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    [ self settingNavigationItem];
    [ self MaccountText];
    [self PWdtext];
    [self btnLogin] ;
    
    [self creactThirdView];
    
    [self addNoative];
    

    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//创建账号edtext
-(UITextField *) MaccountText {
    if (!_MaccountText) {
    
  
    UITextField *accountTextField = [UITextField textFiledWithFrame:CGRectMake(14, 35, kScreenWidth - 28, 44)
                                                        placeHolder:@"账号"
                                                               font:kFont(15)
                                                          textColor:      [UIColor colorWithHexString:@"b6b6b6"] // 字体颜色
                                                    backgroundColor:[UIColor whiteColor]
                                                       isNeedBorder:YES
                                                   andTextFieldType:XHLoginAndRegisterTextFieldTypeAccount];
        accountTextField.delegate=self;
                 accountTextField.keyboardType = UIKeyboardTypeEmailAddress;
        [self.view addSubview:accountTextField];
            _MaccountText = accountTextField;
          }
       return  _MaccountText ;


}
// 监听 输入是否是合法的
-( void)addNoative {
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_MaccountText] ;
    
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_PWdtext] ;
}

- (void)textFieldTextDidChange:(NSNotification *)notification{
    if (_MaccountText.text.length >0 & _PWdtext.text.length>0) {
        _btnLogin.enabled=YES;
          [_btnLogin setBackgroundColor:[UIColor colorWithHexString:@"18A8F6"]];
    } else{
        _btnLogin.enabled=NO;
        [_btnLogin setBackgroundColor:[UIColor grayColor]];
    
    }


}

//  创建密码
//CGRectGetMaxY(_MaccountText.frame) 这个方法 是获取当前view  所在的y 最下面的y
-(UITextField*)PWdtext{
    if(!_PWdtext){
        UITextField* pwdText=[UITextField  textFiledWithFrame:CGRectMake(_MaccountText.frame.origin.x, CGRectGetMaxY(_MaccountText.frame)+15, _MaccountText.frame.size.width, _MaccountText.frame.size.height) placeHolder:@"密码" font:kFont(15) textColor:[UIColor colorWithHexString:@"b6b6b6"] backgroundColor:[UIColor whiteColor] isNeedBorder:YES andTextFieldType:XHLoginAndRegisterTextFieldTypeAccount];
        pwdText.delegate=self;
        pwdText.keyboardType=UIKeyboardTypeASCIICapable ; //密码类型
        [self.view addSubview:pwdText];
        _PWdtext=pwdText;
    }
    return _PWdtext ;
}
//登录按钮
-(UIButton*) btnLogin{
    
    if(!_btnLogin){
     
        UIButton * loginBtn=[ UIButton buttonWithFrame:CGRectMake(_MaccountText.frame.origin.x,  CGRectGetMaxY(_PWdtext.frame)+15, _MaccountText.frame.size.width, _MaccountText.frame.size.height) title:@"登录" titleColor:[UIColor whiteColor] backgroundColor:[ UIColor grayColor] font:kFont(17) isNeedBorder:YES target:self andAction:@selector(loginBtnClick)];
        
        loginBtn.enabled=NO;
        [self. view addSubview: loginBtn];
        _btnLogin=loginBtn;
    }
    return _btnLogin;
}


-(void) loginBtnClick {
    NSLog(@"点击登录");
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"username"] = _MaccountText.text;
    params[@"password"] =_PWdtext.text;
    
    [self requestDataWithUrl:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/passport.php?ac=login" parameter:params];

}
- (void)settingNavigationItem
{

    self.title = @"登录";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTiele:@"注册" titleColor:[UIColor whiteColor]contentOffset:UIEdgeInsetsMake(0, 14, 0, 0) image:nil target:self andAction:@selector(goRegister)];
    
}
// 注册页面
-(void) goRegister{
    
    NSLog(@"点击注册");
    
    [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
}

// 微信登录和qq 登录
-( void)creactThirdView{
    // 先创建一个view 来装
    UIView*bottomView=[[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_btnLogin.frame)+15 ,kScreenWidth, 100)] ;
    bottomView.backgroundColor=[UIColor whiteColor];
    

    
    
    XHSpecialButton* qqBtn = [ self setupSpecialButtonWithImage:@"qq"
                                                highLightedImage:@"qq"
                                                           title:@"QQ登录"
                                                             tag:12
                                                          target:self
                                                       andAction:@selector(thirdLogMethod:)];
    [bottomView addSubview:qqBtn];
    
    
    XHSpecialButton *weChatBtn = [self setupSpecialButtonWithImage:@"weixin"
                                                  highLightedImage:@"weixin"
                                                             title:@"微信登录"
                                                               tag:11
                                                            target:self
                                                         andAction:@selector(thirdLogMethod:)];
    
    [bottomView addSubview:weChatBtn];
    
    
    
    
    
    [@[weChatBtn, qqBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [@[weChatBtn, qqBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(30);
    }];
    
    [self.view addSubview:bottomView];

    


}
    // 友盟
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
        
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"platform"] = _platform;
        params[@"snsuid"] = resp.uid;
        params[@"username"] = resp.name;
        params[@"headimg"] = resp.iconurl;
        NSLog(@"  友盟,%d" , error) ;
          [self requestDataWithUrl:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/passport.php?ac=snslogin" parameter:params];
    }];
}


/** 数据请求*/
- (void)requestDataWithUrl:(NSString *)urlStr parameter:(NSMutableDictionary *)params {
 __weak typeof(self) weakSelf = self;
    
     weakSelf.networking = [[TJPNetworkUtils alloc]init];
        [ weakSelf. networking requsetWithPath:urlStr withParams:params withCacheType:YBCacheTypeReturnCacheDataExpireThenLoad withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
            if (!error) {
                //json 转字典

                
                
                if([responseObject[@"status"] integerValue]){
//                [MBProgressHUD showMessage:@"登录成功"inView:self.view];

                    //保存token
                    [[NSUserDefaults standardUserDefaults] setObject: responseObject[@"token"] forKey:@"UserToken"];
                    // 获取 token
//                      NSString*strtoken=   [[NSUserDefaults standardUserDefaults]  objectForKey:@"UserToken"];
            
                        [weakSelf.navigationController popViewControllerAnimated:YES];
            
            }else{
            
//                [MBProgressHUD showMessage:@"登录失败"inView:self.view];
            }
            }
        }];
}
#pragma mark - pravite
- (XHSpecialButton *)setupSpecialButtonWithImage:(NSString *)image highLightedImage:(NSString *)hightImage title:(NSString *)title tag:(NSInteger)tag target:(id)target andAction:(SEL)action {
    
    XHSpecialButton *specialBtn = [XHSpecialButton buttonWithType:UIButtonTypeCustom];
    [specialBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [specialBtn setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [specialBtn setTitle:title forState:UIControlStateNormal];
    [specialBtn setTitleColor:[UIColor  colorWithHexString:@"b6b6b6"] forState:UIControlStateNormal];
    specialBtn.titleLabel.font = kFont(12);
    [specialBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    specialBtn.tag = tag;
    specialBtn.imgTextDistance = 15;
    [specialBtn setButtonTitleWithImageAlignment:UIButtonTitleWithImageAlignmentDown];
    [specialBtn sizeToFit];
    
    return specialBtn;
    
}


- (void)thirdLogMethod:(XHSpecialButton *)button {
    [self cancelFirstResponder];
    switch (button.tag) {
        case 11:
        {
            NSLog(@"微信登录");
            _platform = @"weixin";
            [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
        }
            break;
        case 12:
        {
            NSLog(@"qq登录");
            _platform = @"qq";
            [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
            
        }
            break;

        default:
            break;
    }
}
- (void)cancelFirstResponder {
    [_MaccountText resignFirstResponder];
    [_PWdtext resignFirstResponder];
}


@end
