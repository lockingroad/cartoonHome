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
#import "UserEntity.h"

@interface LoginViewController () <UITextFieldDelegate>
// 账户
@property (nonatomic ,weak)UITextField * MaccountText ;
// 密码
@property (nonatomic ,weak)UITextField* PWdtext;
@property(nonatomic,strong)TJPNetworkUtils *networking;
@property(nonatomic,weak) UIButton* btnLogin;
@end

@implementation LoginViewController  {
    NSString *_platform;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    [self setupNavigation];
    [self MaccountText];
    [self PWdtext];
    [self btnLogin] ;
    [self creactThirdView];
    [self addNoative];
}

- (void)setupNavigation
{
    self.title = @"登录";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTiele:@"注册" titleColor:[UIColor whiteColor]contentOffset:UIEdgeInsetsMake(0, 14, 0, 0) image:nil target:self andAction:@selector(goRegister)];
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
-(void)addNoative {
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_MaccountText] ;
    
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_PWdtext] ;
}

//验证格式非空
- (void)textFieldTextDidChange:(NSNotification *)notification{
    if (_MaccountText.text.length >0 & _PWdtext.text.length>0) {
        _btnLogin.enabled=YES;
        [_btnLogin setBackgroundColor:[UIColor colorWithHexString:@"18A8F6"]];
    } else{
        _btnLogin.enabled=NO;
        [_btnLogin setBackgroundColor:[UIColor grayColor]];
    }
}

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
    MJWeakSelf
    NSString *account=_MaccountText.text;
    NSString *pwd=_PWdtext.text;
    
    [CartoonManager login:account pwd:pwd successHandler:^(UserEntity *entity) {
        NSLog(@"%@",entity);
        if(entity.status){
            [CartoonHelper insertToken:entity.token];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
//            [UserDefaults setObject:entity forKey:User_Info];
            
            
        }
    } failure:^(NSError *error) {
        
        
    }];
}


-(void) goRegister{
    [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
}

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
    MJWeakSelf
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
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
        NSLog(@"  友盟,%d" , error);
        [CartoonManager SDKLogin:params successHandler:^(UserEntity *entity) {
            if(entity.status){
                [UserDefaults setObject:entity.token forKey:User_Token];
                [weakSelf.navigationController popViewControllerAnimated:NO];
            }
        } failure:^(NSError *error) {
        }];
        
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
