//
//  RegisterViewController.m
//  Play
//
//  Created by 陈 on 2017/5/27.
// 注册页面
//  Copyright © 2017年 huiben. All rights reserved.
//

#import "RegisterViewController.h"

#import "UITextField+XHExtension.h"
#import "UIButton+XHExtension.h"
#import "UIColor+ColorChange.h"
#import "TJPNetworkUtils.h"
#import "UIBarButtonItem+TJPItem.h"
#import "NSArray+MASAdditions.h"

#import "HBProtocolViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
@property(nonatomic,weak) UITextField * nametext;
@property(nonatomic,weak) UITextField * passwodtext;
@property(nonatomic,weak) UITextField * confirmText;
@property(nonatomic ,weak)UIButton* registered ;

@property(nonatomic,strong)TJPNetworkUtils *networking;
@property (nonatomic, weak) UILabel *agreeLab;
@property (nonatomic, weak) UILabel *protocolLab;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle];
    
    [self  nametext];
    [self passwodtext];
    [self confirmText];
    [self registered];
    [self agreeLab];
    [self  protocolLab];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    
}
// 用户名
-(UITextField *) nametext{

    if (!_nametext) {
        UITextField *accountText=[  UITextField textFiledWithFrame:CGRectMake(14, 35,   [UIScreen mainScreen].bounds.size.width - 28, 44)
                                                       placeHolder:@"用户名"
                                                              font:[UIFont  systemFontOfSize:15]
                                                         textColor:      [UIColor colorWithHexString:@"b6b6b6"] // 字体颜色
                                                   backgroundColor:[UIColor whiteColor]
                                                      isNeedBorder:YES
                                                  andTextFieldType:XHLoginAndRegisterTextFieldTypeAccount];
        accountText.delegate=self;
         accountText.keyboardType = UIKeyboardTypeEmailAddress;
        [self.view addSubview: accountText];
        _nametext= accountText;
            }

    return _nametext ;
}
// 密码
-(UITextField*)passwodtext{
    if (!_passwodtext) {
   
    UITextField* password=[ UITextField textFiledWithFrame:CGRectMake(_nametext.frame.origin.x, CGRectGetMaxY(_nametext.frame)+15, _nametext.frame.size.width, _nametext.frame.size.height) placeHolder:@"密码" font:[UIFont  systemFontOfSize:15] textColor:[UIColor colorWithHexString:@"b6b6b6"] backgroundColor:[UIColor whiteColor] isNeedBorder:YES andTextFieldType:XHLoginAndRegisterTextFieldTypeAccount];
        password.delegate =self;
        password.keyboardType=UIKeyboardTypeEmailAddress ;
        [self.view addSubview:password];
        _passwodtext= password;
        
    }
    return _passwodtext;
}
// 确认密码
-(UITextField *) confirmText{
    if (!_confirmText) {
      UITextField*confimtext =[UITextField  textFiledWithFrame:CGRectMake(_passwodtext.frame.origin.x, CGRectGetMaxY(_passwodtext.frame)+15, _passwodtext.frame.size.width, _passwodtext.frame.size.height) placeHolder:@"确认密码" font:[UIFont  systemFontOfSize:15] textColor:[UIColor colorWithHexString:@"b6b6b6"] backgroundColor:[UIColor whiteColor] isNeedBorder:YES andTextFieldType:XHLoginAndRegisterTextFieldTypeAccount];
        
        confimtext.delegate=self;
        [self.view addSubview: confimtext];
        _confirmText= confimtext;
    }
    return _confirmText;
}
-( UIButton*) registered {
    if (!_registered) {
        UIButton * registered=[ UIButton buttonWithFrame:CGRectMake(_nametext.frame.origin.x,  CGRectGetMaxY(_confirmText.frame)+15, _nametext.frame.size.width, _nametext.frame.size.height) title:@"注册" titleColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithHexString:@"18A8F6"] font: [UIFont  systemFontOfSize:17]
 isNeedBorder:YES target:self andAction:@selector(RegisteredBtnClick)];
        
        registered.enabled=YES;
        [self. view addSubview: registered];
        _registered=registered;

        
    }
    return _registered;

}
//文字
-(UILabel*) agreeLab {

    if(!_agreeLab){
        UILabel *agreeLab = [[UILabel alloc] init];
        
        CGRect frame = agreeLab.frame;
        frame.origin.x = 60;
           frame.origin.y = CGRectGetMaxY(_registered.frame) + 20;
        
        agreeLab.frame = frame;
        agreeLab.text = @"完成注册,表示您已阅读并同意";
        agreeLab.textColor = [UIColor colorWithHexString:@"b6b6b6"];
        agreeLab.font = [UIFont systemFontOfSize:12];
        [agreeLab sizeToFit];
        [self.view addSubview:agreeLab];
        _agreeLab = agreeLab;

        
    }
    return _agreeLab;
}


- (UILabel *)protocolLab {
    if (!_protocolLab) {
        UILabel *protocolLab = [[UILabel alloc] init];
        
        CGRect frame = protocolLab.frame;
        frame.origin.x =  CGRectGetMaxX(_agreeLab.frame) + 5;
          frame.origin.y=  CGRectGetMaxY(_registered.frame) + 20;
        protocolLab.frame=frame;
        protocolLab.textColor = [UIColor colorWithHexString:@"18A8F6"];
        protocolLab.textAlignment = NSTextAlignmentCenter;
        protocolLab.font = [UIFont systemFontOfSize:12];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:@"猫头鹰用户协议"];
        NSRange contentRange = {0,[content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        protocolLab.attributedText = content;
        protocolLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protocolLabelTap)];
        [protocolLab addGestureRecognizer:tap];
        [protocolLab sizeToFit];
        [self.view addSubview:protocolLab];
        _protocolLab = protocolLab;
    }
    return _protocolLab;
}

// 监听 输入是否合法
-( void) addNotice {
//    [[ NSNotificationCenter defaultCenter]addObserver: self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_nametext ];
//    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_passwodtext];
//    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_confirmText];
    
    [self textFieldTextDidChange];
}

- (void)textFieldTextDidChange{
    
    if (!_nametext.text.length && !_passwodtext.text.length && !_confirmText.text.length) {
//        [MBProgressHUD showMessage:@"请完善注册信息" inView:self.view];

    }else if (!_nametext.text.length) {
//        [MBProgressHUD showMessage:@"用户名不能为空" inView:self.view];
        

    }else if (!_passwodtext.text.length) {
//        [MBProgressHUD showMessage:@"密码不能为空" inView:self.view];


    }else if (![_passwodtext.text isEqualToString:_confirmText.text]) {
//        [MBProgressHUD showMessage:@"两次密码不一致" inView:self.view];

    }else if (_nametext.text.length<2 || _nametext.text.length >8) {
//        [MBProgressHUD showMessage:@"账号长度2-8个字符(英文2个字符~8个长度)" inView:self.view afterDelayTime:1.5];
    

    }else if ((_passwodtext.text.length < 6 || _passwodtext.text.length > 14) || (_confirmText.text.length < 6 || _confirmText.text.length > 14)) {
//        [MBProgressHUD showMessage:@"密码长度应该在6-14个字符之间" inView:self.view];

    }else{
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"username"] = _nametext.text;
        params[@"password"] =_passwodtext.text;
        
        [self requestDataWithUrl:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/passport.php?ac=register" parameter:params];
   
        [_registered setBackgroundColor:[UIColor colorWithHexString:@"18A8F6"]];
    }

    
    
}
// 用户协议
-(void) protocolLabelTap {
    HBProtocolViewController * protocolVC = [HBProtocolViewController new];
    [self.navigationController pushViewController:protocolVC animated:YES];
    
    

}
// 点击注册按钮
-(void) RegisteredBtnClick {

    [self addNotice];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setNavigationTitle{

    self.title=@"注册";


}

/** 数据请求*/
- (void)requestDataWithUrl:(NSString *)urlStr parameter:(NSMutableDictionary *)params {
    __weak typeof(self) weakSelf = self;
    
    weakSelf.networking = [[TJPNetworkUtils alloc]init];
    [ weakSelf. networking requsetWithPath:urlStr withParams:params withCacheType:YBCacheTypeReturnCacheDataExpireThenLoad withRequestType:NetworkPostType withResult:^(id responseObject, NSError *error) {
        if (!error) {
            
            
            if([responseObject[@"status"] integerValue]){
//                [MBProgressHUD showMessage:@"注册成功"inView:self.view];
                
                //保存token
                [[NSUserDefaults standardUserDefaults] setObject: responseObject[@"token"] forKey:@"UserToken"];
                // 获取 token
                //                      NSString*strtoken=   [[NSUserDefaults standardUserDefaults]  objectForKey:@"UserToken"];
                
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                [delegate rootview];
            }else{
                
//                [MBProgressHUD showMessage:@"注册失败,请重试"inView:self.view];
            }
        }
    }];
}
// 返回首页



@end
