//
//  XHNickNameController.m
//  NiHao
//
//  Created by Walkman on 16/4/1.
//  Copyright © 2016年 NewLineWow. All rights reserved.
//

#import "XHNickNameController.h"
#import "UIBarButtonItem+TJPItem.h"
#import "NSString+XMGExtension.h"
#import "TJPSessionManager.h"
#import "UIColor+ColorChange.h"
#import "SimpleEntity.h"



@interface XHNickNameController () <UITextFieldDelegate>
@property (nonatomic, weak) UITextField *nickNameTextField;
@property (nonatomic, strong) TJPSessionManager *sessionManager;


@end

@implementation XHNickNameController

#pragma mark - lazy
- (TJPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[TJPSessionManager alloc] init];
    }
    return _sessionManager;
}

- (UITextField *)nickNameTextField {
    if (!_nickNameTextField) {
        UITextField * nickNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 37)];
        nickNameTextField.backgroundColor = [UIColor whiteColor];
        [nickNameTextField becomeFirstResponder];
        nickNameTextField.delegate = self;
        nickNameTextField.borderStyle = UITextBorderStyleNone;
        nickNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        nickNameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        nickNameTextField.placeholder = @"请输入要修改的昵称(2-8个字符)";
        nickNameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        nickNameTextField.leftViewMode = UITextFieldViewModeAlways;
   
        [nickNameTextField setValue: [UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [self.view addSubview:nickNameTextField];
        _nickNameTextField = nickNameTextField;
    }
    return _nickNameTextField;
}



#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#b6b6b6"];
    self.title = @"更改姓名";
    
    [self settingNavigationItem];

    [self nickNameTextField];
    
    
    
}
- (void)settingNavigationItem
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTiele:@"完成" titleColor:nil contentOffset:UIEdgeInsetsMake(0, 15, 0, 0) image:nil target:self andAction:@selector(updateUserData)];
    
}
- (void)updateUserData {
    [self.view endEditing:YES];
    
    if (_nickNameTextField.text.length < 2 || _nickNameTextField.text.length> 8) {
        return;
    }else {
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"username"] = _nickNameTextField.text;
        params[@"token"] = [[ NSUserDefaults standardUserDefaults] objectForKey:@"user_token"];
        
//        [self.sessionManager requestWithHUD:@"请稍后.." requestType:RequestTypePost urlStr:@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php?ac=updateinfo" parameter:params resultBlock:^(NSDictionary *responseObject, NSError *error) {
//            if (error) {
//                
//                return;
//            }
//            if ([responseObject[@"status"] integerValue]) { //成功
//                    //  更新成功保存账户名
//                
//                    [[NSUserDefaults  standardUserDefaults]setObject:_nickNameTextField.text forKey:@"user_name"];
//
//                self.changeNicknameSuccess();
//                [self.navigationController popViewControllerAnimated:YES];
//            }else {//失败
//            
//            }
//        }];
        
        [CartoonManager updateNickName:_nickNameTextField.text token:@"hjs88YWS6ZCjcqui421Usw==" successHandler:^(SimpleEntity *entity) {
            if(entity.status){
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSError *error) {
            
            
        }];
    }
}



#pragma mark - UITextFieldDelegate
//限制昵称长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * lengthStr = [NSString stringWithFormat:@"%@%@", textField.text, string];
    
    return lengthStr.length < 8;
}





@end
