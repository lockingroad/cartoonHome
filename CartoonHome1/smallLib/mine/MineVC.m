//
//  MineViewController.m
//  CartoonHome1
//
//  Created by 范宏泳 on 2017/6/3.
//  Copyright © 2017年 刘然. All rights reserved.
//

#import "MineVC.h"
#import "UserInfoViewController.h"
#import "XHNavigationController.h"
#import "UserMsgEntity.h"

@interface MineVC ()

@property(nonatomic,strong) UIImageView *headImage;

@property (nonatomic,strong)UIImageView* removeImage;
@property(nonatomic,strong)UIImageView *settingImage;
@property(nonatomic,strong)UILabel*clearText;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UILabel *userSetingtext;
@property(nonatomic,strong)UIView *clearLine ;
@property(nonatomic,strong)UIView *setingLine ;
@property (nonatomic,strong) UIButton *btnlogout;
@property(nonatomic,strong)UserMsgInfo *data;


@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupConstraint];
    NSString *token=[CartoonHelper getToken];
    if(token){
        [CartoonManager userMsg:token successHandler:^(UserMsgEntity *entity) {
            if(entity.status){
                NSLog(@"成功了");
                self.data=entity.userinfo;
                [self updateUI];
            }
            
        } failure:^(NSError *error) {
            
            
        }];
    }
    
}



-(void)setupView{
    
    [self.view addSubview:self.userSetingtext];
    

    

    [self.view addSubview:self.btnlogout];

    
    
//    [self.view addSubview:self.userSetingtext];
    
    
    [self.view addSubview:self.settingImage];
    [self.view addSubview:self.setingLine];
    [self.view addSubview:self.clearLine];
    [self.view addSubview:self.clearText];
    [self.view addSubview:self.removeImage];
    [self.view addSubview:self.userName];
    [self.view addSubview:self.headImage];
}
-(void)setupConstraint{

    
    [self.btnlogout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-30);
        make.centerX.lessThanOrEqualTo(self. view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 36));
        
    }];
    
    [self.userSetingtext mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.clearLine.mas_bottom).with.offset(10);
        make.left.equalTo(self.settingImage.mas_right).with.offset(13);

        
    }];
    [self.settingImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.removeImage.mas_bottom).with.offset(27);
        make.left.mas_equalTo(27);
        
    }];
    
    [self.setingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userSetingtext.mas_bottom).with.offset(18);
        make.left.equalTo(self.removeImage.mas_right).with.offset(13);
        make.size.mas_equalTo(CGSizeMake(200, 1));
        make.right.lessThanOrEqualTo(@10);
        
    }];
    
    [self.clearLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.clearText.mas_bottom).with.offset(18);
        make.left.equalTo(self.removeImage.mas_right).with.offset(13);
        make.size.mas_equalTo(CGSizeMake(200, 1));
        make.right.lessThanOrEqualTo(@10);
    }];
    
    [self.clearText mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.userName.mas_bottom).with.offset(124);
        make.left.equalTo(self.removeImage.mas_right).with.offset(13);
        
    }];
    
    [self.removeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).with.offset(124);
        make.left.mas_equalTo(27);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).with.offset(20);
        make.centerX.lessThanOrEqualTo(self. headImage.mas_centerX);
        
    }];
    
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.width.height.mas_equalTo(@35);
        make.centerX.lessThanOrEqualTo(self.view.mas_centerX);
    }];
}


-(UIButton*)btnlogout {
    
    if (!_btnlogout) {
        UIButton* newlogout=[[UIButton alloc] init];
        
        [ newlogout setTitleColor:[UIColor colorWithHexString:@"#1cb0f6"] forState:UIControlStateNormal];
        [newlogout setFont:[UIFont systemFontOfSize:18]];
        newlogout.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [newlogout setTitle:@"退出登录" forState:UIControlStateNormal];
        [newlogout addTarget:self action:@selector(logOutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        newlogout.layer.cornerRadius = 1.0;//2.0是圆角的弧度，根据需求自己更改
        newlogout.layer.borderColor =[UIColor colorWithHexString:@"1cb0f6"].CGColor;
        newlogout.layer.borderWidth = 1.0f;//设置边框颜色
        _btnlogout=newlogout;
    }
    
    return _btnlogout;
}

-(UILabel *)userSetingtext {
    if (!_userSetingtext) {
        UILabel* newuserSetingtext= [[UILabel alloc]init ];
        newuserSetingtext.text=@"个人设置";
        newuserSetingtext.textColor=[UIColor colorWithHexString:@"#616673"];
        newuserSetingtext.font=[UIFont systemFontOfSize:18];


        
        
        
        newuserSetingtext.userInteractionEnabled=YES;

        [newuserSetingtext addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(configClick:)]];
        _userSetingtext=newuserSetingtext;
    }
    return _userSetingtext ;
}


-(UIImageView *)settingImage {
    if (!_settingImage) {
        UIImageView *  newsettingima=[[UIImageView alloc]init ];
        
        UIImage * image=[UIImage imageNamed:@"shezhi"];
        newsettingima.image= image ;
        _settingImage= newsettingima ;
    }
    return _settingImage;
}

-(void) logOutBtnClicked {
    
    NSLog(@" 点击退出按钮");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示!" message:@"确定退出当前账号" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [CartoonHelper delToken];//删除了 token
        _logoutBlock();

    }]];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


-(void)updateUI{
    [self.headImage fadeImageWithUrl:self.data.headimg];
    self.userName.text=self.data.username;
}




-(UIView *)setingLine {
    if (!_setingLine) {
        UIView*   newsetingrLine=[[UIView alloc] init ];
        newsetingrLine . backgroundColor=[UIColor colorWithHexString:@"#1cb0f6"];
        _setingLine=newsetingrLine;
    }
    return _setingLine;
}
-(UIView*) clearLine{
    if(!_clearLine){
        
        UIView*   newclearLine=[[UIView alloc] init ];
        newclearLine . backgroundColor=[UIColor colorWithHexString:@"#1cb0f6"];
        _clearLine =newclearLine;
    }
    return _clearLine ;
}
-(UILabel*)clearText{
    if (!_clearText) {
        UILabel * newClear=[[UILabel alloc] init ];
        newClear.text=@"清除缓存";
        newClear.textColor=[UIColor colorWithHexString:@"#616673"];
        newClear.font=[UIFont systemFontOfSize:18];
       
        _clearText=newClear;
    }
    return _clearText;
    
    
}
-(UIImageView*) removeImage {
    if (!_removeImage) {
        UIImageView* newimage=[[UIImageView alloc] init];
        UIImage * image =[UIImage imageNamed:@"qingchu"];
        newimage.image=image;
        
    
        _removeImage=newimage;
    }
    
    
    return _removeImage;
}
-( UILabel *) userName {
    if (!_userName) {
        UILabel* newName=[[ UILabel alloc] init];
        newName.text=@"张三";
        newName.textColor=[UIColor colorWithHexString:@"#616673"];
        newName.font=[UIFont systemFontOfSize:18];
        
        _userName=newName;

        
        
    }
    return _userName;
    
    
}
-(UIImageView*)headImage {
    if (!_headImage) {
        UIImageView *  headImagview=[[UIImageView alloc] init ];
        //        headImagview.image=@"default_headImg" ;
        UIImage *image = [UIImage imageNamed:@"default_headImg"];
        headImagview.image = image;
        headImagview.layer.borderWidth = 1.5f;
        headImagview.layer.cornerRadius=headImagview.frame.size.width/2;//裁成圆角
        headImagview .layer.masksToBounds=YES;//隐藏裁剪掉的部分
        //  给头像加一个圆形边框
        headImagview.layer.borderWidth = 1.5f;//宽度
        headImagview.layer.borderColor = [UIColor whiteColor].CGColor;//颜色
        _headImage=headImagview;
    }
    
    return _headImage;
}
-(void)configClick:(UITapGestureRecognizer *)tap
{
    UserInfoViewController *userVC=[[UserInfoViewController alloc]init];
    
    XHNavigationController *userNav=[[XHNavigationController alloc]initWithRootViewController:userVC];
    
    [self presentViewController:userNav animated:NO completion:^{
        
        
    }];
}





@end
