//
//  PublicHeader.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/7.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h


/**    尺寸类    **/
#define kScreenWidth                         [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                        [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight                     20
#define kNavigationBarHeight                 64
#define kSegementBarHeight                   40
#define kToolBarHeight                       44

#define kDefaultMargin                       10
#define kTableViewMargin                     5
#define kScoreViewW                          70
#define KLeftMargin                          5
#define KRootCellHeight                      179



//设备型号
#define IS_IPAD     [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE   [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )960) < DBL_EPSILON )


#define IOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 9.0)
#define IOS8_10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 10.0)
#define IOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)






/**    颜色     **/
#define TJPColorA(r, g, b, a)                                       [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define TJPColor(r, g, b)                                           TJPColorA((r), (g), (b), 1)

#define kWhiteColor                                                 [UIColor whiteColor]
#define kLightGrayColor                                             [UIColor lightGrayColor]
#define kBlackColor                                                 [UIColor blackColor]
#define kRedColor                                                   [UIColor redColor]




#define Global_Nav_Color                                            TJPColor(0, 0, 0)
#define Segment_Bar_Color                                           TJPColorA(0, 0, 0, 0.8)
#define Global_Yellow_Color                                         [UIColor colorWithHexString:@"ffca00"]
#define Mask_View_Color                                             TJPColor(0, 0, 0)
#define Command_Dark_Color                                          TJPColor(34, 34, 34)

#define LocTextColor                                                TJPColor(204, 204, 204)
#define ImageShadowColor                                            TJPColor(23, 24, 27)
#define Stimulate_Line_Color                                        TJPColor(218, 218, 219)
#define Global_BGWhite_Color                                        TJPColor(248, 248, 248)
#define GrayColor                                                   TJPColor(182, 182, 182)

#define kCommonHighLightRedColor                                    [UIColor colorWithRed:1.00f green:0.49f blue:0.65f alpha:1.00f]

#define kButtonNotEnableColor                                       [UIColor colorWithHexString:@"e0acb0"]







/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]
/***  粗体 */
#define kBoldFont(size) [UIFont boldSystemFontOfSize:size]







/**    通知     **/
#define kLocationViewDidChooseCityNotification                @"kLocationViewDidChooseCityNotification"     //选择完城市



/**    文件     **/
#define XMGCustomCacheFile                  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"]
#define TJPSEARCH_HISTORY_CACHE_PATH        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"TJPSearchHistories.plist"] // 搜索历史存储路径


#define KCURRENTCITYINFODEFAULTS            [NSUserDefaults standardUserDefaults]
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define KCurrentVersion                     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#define User_Token                          @"user_token"
#define User_Info                           @"user_info"
#define Last_Login_Username                 @"lastLogin_username"
#define BDUser_Current_Location             @"baidu_user_current_location" //保存详细地址
#define System_User_Current_Location        @"system_user_current_location" //保存地址
#define System_User_Current_Coordinate      @"system_user_current_coordinate" //保存经纬度
#define This_Version                        @"this_version"
#define First_Login                         @"first_login"

#define FENGYOU_APP_STORE_URL               @"https://itunes.apple.com/cn/app/id1191266436?mt=8"






/**    SDK     **/
#define Handle_OAuth_URL                    @"http://sns.whalecloud.com/sina2/callback"
#define Umeng_Appkey                        @"58a127e98f4a9d6d44001485"
//微博
#define Sina_App_Key                        @"2717897104"
#define Sina_App_Secret                     @"0c25efa35a2a9127f00e0c53fd77ecab"
//腾讯
#define Tencent_App_ID                      @"1105910079"
#define Tencent_App_Key                     @"8eHaJXHo9xE5vD7U"
//微信
#define WeChat_App_Key                      @"wx49317ae877957a9a"
#define WeChat_App_Secret                   @"06a5c31a6f5ea62565b4e9f19a7df422"




#define BD_Map_Key                          @"Mfube25UutbQXObf4tWYvVSq01gk24Yc"








#endif /* PublicHeader_h */
