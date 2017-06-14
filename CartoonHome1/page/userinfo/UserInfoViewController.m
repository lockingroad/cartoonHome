//
//  UserInfoViewController.m
//  Play
//
//  Created by 陈 on 2017/5/31.
//  Copyright © 2017年 huiben. All rights reserved.
//

#import "UserInfoViewController.h"
#import "XHUserInfoItem.h"
#import "UIBarButtonItem+TJPItem.h"
#import "NSObject+MJKeyValue.h"
#import "LCActionSheet.h"
//照片选择
#import "RSKImageCropViewController.h"


#import "UIImage+XMGImage.h"
#import "UIColor+ColorChange.h"
#import "TJPNetworkUtils.h"
#import "TJPSessionManager.h"

#import "NSArray+MASAdditions.h"
#import "UIImageView+AFNetworking.h"

#import "XHImagePickerController.h"
#import "XHNickNameController.h"
#import "SimpleEntity.h"
@interface UserInfoViewController ()<RSKImageCropViewControllerDelegate ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate , LCActionSheetDelegate ,UITableViewDelegate ,UITableViewDataSource>

//@property(nonatomic,weak)NSMutableArray *settingData;
@property (nonatomic ,weak)UILabel *    name;
@property( nonatomic,weak )   UIView*  headview ;

@end

@implementation UserInfoViewController  {

    NSMutableString *    headImg;
}


static NSString * const persongSettingCell = @"persongSetting";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupNavigation];
    [self setUi];
    
    [self.view setBackgroundColor: [UIColor colorWithHexString:@"#d6d6d6"]];
}

-(void)leftBarButtonItemClicked
{

    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

-(void)setupNavigation
{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"global_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(leftBarButtonItemClicked) forControlEvents:UIControlEventTouchUpInside];
    [backButton setExclusiveTouch:YES];
    [backButton sizeToFit];
    
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

-(void) setUi {

     self.title=@"个人设置";
        UIView* head=[[UIView alloc] initWithFrame:CGRectMake(0,10,[UIScreen mainScreen].bounds.size.width, 50)] ;
    head. backgroundColor=[UIColor whiteColor];

    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [head addGestureRecognizer:tapGesturRecognizer]; // 设置点击事件
    [self.view addSubview: head];
    UILabel * imageheadText=[[UILabel alloc ] initWithFrame:CGRectMake(18,   CGRectGetMinY(head.frame)-5, [ UIScreen mainScreen] .bounds.size.width-44, 44) ] ;
    imageheadText.text=@"我的头像";
    imageheadText.textColor=[UIColor  colorWithHexString:@"#4e5562"];
    [head addSubview:imageheadText] ;
    [self loadDataWithImage :nil];
  
    //    (1)创建
    UIImageView *imageView = [[UIImageView alloc ] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50, CGRectGetMinY(head.frame)-5,  44,44)];

    UIImage *image = [UIImage imageNamed: headImg];
    imageView.image = image;
    NSLog(@"设置的头像地址%@" ,headImg) ;
    [head addSubview:imageView] ;
    
    
    UIView * myname=[[UIView alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY(head.frame) +10, [UIScreen mainScreen].bounds.size.width, 50)];

    myname.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:myname];
     UILabel * username=[[UILabel alloc ] initWithFrame:CGRectMake(18,   CGRectGetMinY(head.frame)-5, [ UIScreen mainScreen] .bounds.size.width-44, 44) ] ;
    
    username.text=@"名字";
    username.textColor=[UIColor  colorWithHexString:@"#4e5562"];
    [myname addSubview:username];
    
    
    UITapGestureRecognizer *tochangeNameGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tochangeName)];
    [myname addGestureRecognizer:tochangeNameGesturRecognizer]; // 设置点击事件
    
};
-(void) tochangeName {
   //  更改昵称
    XHNickNameController *nickNameVc =  [XHNickNameController new];
    [self.navigationController pushViewController:nickNameVc animated:YES];
}
-(void) tapAction {
   // 点击事件
    
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:@"选取照片"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"从相册选择 ", @"拍摄", nil];
    [actionSheet show];

}
// 选择的图片
#pragma mark - data
- (void)loadDataWithImage:(UIImage *)selectImage{
        NSArray *dataArr;
    if (selectImage) {
        dataArr =@[@{@"text": @"我的头像",@"headImage":selectImage}];
    } else {
                        //获取保存的用户信息
       NSDictionary *infoDic=   [[NSUserDefaults standardUserDefaults]   objectForKey: @"user_info" ];
        if (infoDic) {
            
            XHUserInfoItem * userinfo=[XHUserInfoItem   mj_objectWithKeyValues: infoDic];
            if ([userinfo.headimg hasPrefix:@"https://"] || [userinfo.headimg hasPrefix:@"http://"]) {
                headImg = userinfo.headimg;
            }else {
                headImg = [NSString stringWithFormat:@"%@%@", @"http://www.huibenabc.com/", userinfo.headimg];
            }
            
        }  else{
            // 默认头像
             headImg=@"default_headImg";
        
        }
        dataArr=@[@{@"text" : @"我的头像", @"headImage" : headImg}];
        
         }
//     self.settingData.array = dataArr;
}


// 选择相册
 -(void) openPhotoLibrary {
     
     if ([XHImagePickerController  isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
         XHImagePickerController *imagePickerControl = [[XHImagePickerController alloc] init];
         imagePickerControl.delegate = self;
         imagePickerControl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
         [self presentViewController:imagePickerControl animated:YES completion:nil];
     }
     
}
-(void)openPhotoCamera {
     
     if([XHImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
         if ( [XHImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
             XHImagePickerController * controller=[[ XHImagePickerController alloc]init ];
             controller.sourceType=UIImagePickerControllerSourceTypeCamera;
             controller.delegate = self;
             [self presentViewController:controller animated:YES completion:nil];

         }
     
     
     } else {
         NSLog(@"没有相机");
         
     }
}
                                      
#pragma mark - LCActionSheet Delegate

-(void )actionSheet:(LCActionSheet *)actionSheet clickedButtonAtIndex:(NSUInteger)buttonIndex{
    // 开启相册
    if (buttonIndex==1) {
        
        [self openPhotoLibrary];
    }else if(buttonIndex==2){
        [self openPhotoCamera];
        
    }else{
        
        return;
    }
}


    // 选择照片之后
-( void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info

{
    UIImage* image= info[@"UIImagePickerControllerOriginalImage"];
    RSKImageCropViewController *  imageCropvc=[[RSKImageCropViewController alloc] initWithImage: image cropMode:RSKImageCropModeCircle ];
    
    imageCropvc.delegate=self ;
    [picker pushViewController:imageCropvc animated:YES];
    



}
#pragma mark - RSKImageCropViewControllerDelegate
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect
{
    UIImage *newImage = croppedImage;
    if (croppedImage.size.width > 500) {
        newImage = [UIImage imageCompressWithSimple:croppedImage];
        //        newImage =[croppedImage scaleToWidth:450];
    }
    //上传头像到服务器
    [self updateHeadImageWithImage:newImage];

    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)updateHeadImageWithImage:(UIImage *)headImage{
   
    //上传头像????
    
    NSString *token2=@"hjs88YWS6ZCjcqui421Usw==";
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"token"]=token2;
    
    
    NSString *str2=@"http://www.huibenabc.com/app/neahow/huibenapi/api1.0/homepage.php?ac=updateinfo";
    TJPSessionManager *manager=[[TJPSessionManager alloc]init];
    [manager uploadWithImage:headImage urlStr:str2 filename:nil name:@"headimg" mimeType:@"image/jpeg" parameters:params progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
        
        
    } resultBlock:^(id responseObject, NSError *error) {
        
        SimpleEntity *entity=[SimpleEntity mj_objectWithKeyValues:responseObject];
        NSLog(@"返回-->%@",responseObject);
        NSLog(@"返回错误了-->%@",entity);
        
    }];

}



@end
