//
//  AppDelegate.m
//  360du
//
//  Created by linghang on 15-4-6.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialQQHandler.h"

#import "IQKeyboardManager.h"
#import <CoreLocation/CoreLocation.h>
#import "UIFontShareInstance.h"
#import <AlipaySDK/AlipaySDK.h>
//APP端签名相关头文件
#import "payRequsestHandler.h"

//服务端签名只需要用到下面一个头文件
//#import "ApiXml.h"
#import <QuartzCore/QuartzCore.h>


//--------------下边是测试
/**
 *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
//NSString * const WXAppId = @"wxe2c244c0243fbb50";

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
//NSString * const WXAppKey = @"yePd1EMqjBHtkIrdraJs0sGtaEjtzbfH8SBuzGqkyBnSZNI5kuu93lSwLO41ctT8RPNi5IPjid9lsjfVP2oRKei4KEZdidxtk41oTRoljCKdhYyhIFieWBw8r4ZLDuqu";

/**
 * 微信开放平台和商户约定的密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
//NSString * const WXAppSecret = @"ac41b7eddd9482594feedca01ae9940d";

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
//NSString * const WXPartnerKey = @"a2067c2e1a0327a3aa437d76f59b3ac3";

/**
 *  微信公众平台商户模块生成的ID
 */
//NSString * const WXPartnerId = @"1220892901";



@interface AppDelegate ()<CLLocationManagerDelegate>
@property(nonatomic) CLLocationManager *locationManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [IQKeyboardManager sharedManager];
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        self.viewController = [[WeChantViewViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
//    } else {
//        self.viewController = [[WeChantViewViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
//    }
//    self.viewController = [[WeChantViewViewController alloc] init];
//    self.viewController.delegate = self;
    NSNotificationCenter *cneter = [NSNotificationCenter defaultCenter];
    [cneter addObserver:self selector:@selector(sendPay_demo) name:@"weChant" object:nil];
    if (![CLLocationManager locationServicesEnabled]) {
        // location services is disabled, alert user
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DisabledTitle", @"DisabledTitle")
                                                                        message:NSLocalizedString(@"DisabledMessage", @"DisabledMessage")
                                                                       delegate:nil
                                                              cancelButtonTitle:NSLocalizedString(@"OKButtonTitle", @"OKButtonTitle")
                                                              otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
    UIFontShareInstance *shareInstance = [UIFontShareInstance shareInstance];
    shareInstance.width = self.window.frame.size.width;
//下边是分享
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
    
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxdc1e388c3822c80b" appSecret:@"a393c1527aaccb95f3a4c88d6d1455f6" url:@"http://www.360duang.net/360duang/Shop/purchase/introduction/jicai.jsp?cpid=20151200003"];
    
    // 打开新浪微博的SSO开关
    // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //
    //    //打开腾讯微博SSO开关，设置回调地址，只支持32位
    //        [UMSocialWechatHandler openSSOWithRedirectUrl:@"http://sns.whalecloud.com/tencent2/callback"];
    //
    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.360duang.net/360duang/Shop/purchase/introduction/jicai.jsp?cpid=20151200003"];

//    [UIApplication sharedApplication].idleTimerDisabled = TRUE;
//    self.locationManager = [[CLLocationManager alloc] init];
//    
//    self.locationManager.delegate = self;
    // Override point for customization after application launch.
    [WXApi registerApp:APP_ID withDescription:@"demo 2.0"];

    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    NSURL * myURL_APP_A = [NSURL URLWithString:@"alipay:"];
//    if (![[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
//        //如果没有安装支付宝客户端那么需要安装
//        UIAlertView *message = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"点击确定安装支付宝钱包!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [message show];
//        return NO;
//    }
    //如果极简SDK不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    BOOL result =  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    if (result != FALSE) {
        //调用其他SDK，例如支付宝SDK等
        return result;

    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            NSNotification *notify = [NSNotification notificationWithName:@"back" object:resultDic];
            [center postNotification:notify];
        }];
        return YES;
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            NSNotification *notify = [NSNotification notificationWithName:@"back" object:resultDic];
            [center postNotification:notify];
        }];
        return YES;
    }
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)onResp:(BaseResp *)resp
{
//    if ([resp isKindOfClass:[PayResp class]]) {
//        
//        NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
//        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
//                                                        message:strMsg
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:HUDDismissNotification object:nil userInfo:nil];
//    }
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//微信支付成功调用回调
//-
@end
