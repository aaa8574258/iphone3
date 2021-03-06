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
#import "StoreageMessage.h"
#import "APOpenApi.h"
//APP端签名相关头文件
#import "payRequsestHandler.h"
//服务端签名只需要用到下面一个头文件
//#import "ApiXml.h"
#import <QuartzCore/QuartzCore.h>
#import "ProertyPayCostViewController.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import "PropertyNoticeViewController.h"
#import "ProertyMendDeatilViewController.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#define PUSHKEY @"e209a4ca6263efefb16d0935"
#import "RobOrderCenterViewController.h"
#import "FixMasterViewController.h"
#import "FixMasterOneViewController.h"
#import "FixMasterTwoViewController.h"
#import "FixMasterThreeViewController.h"
//ProertyNoticeDeatilViewController
#import "ProertyNoticeDeatilViewController.h"
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



@interface AppDelegate ()<CLLocationManagerDelegate,JPUSHRegisterDelegate>
@property(nonatomic) CLLocationManager *locationManager;
@end

@implementation AppDelegate
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) { // 判断手机版本
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:setting];
    }
    
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        // 这里添加处理代码
    }

    
    
    // apn 内容获取：
    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //iOS10以上
#ifdef  NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //iOS8以上可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //iOS8以下categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    BOOL isProduction = NO;// NO为开发环境，YES为生产环境
    //广告标识符
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //Required(2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    [JPUSHService setupWithOption:launchOptions appKey:PUSHKEY
                          channel:nil
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
//    return YES;
    
    
//    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
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


// 程序没有被杀死（处于前台或后台），点击通知后会调用此程序
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    // 这里添加处理代码
}
//void UncaughtExceptionHandler(NSException *exception) {
//    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
//    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
//    NSString *name = [exception name];//异常类型
//    NSLog(@"exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr);
//    NSString *crashLogInfo = [NSString stringWithFormat:@"exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr];
//    [StoreageMessage getErrorMessage:crashLogInfo fromUrl:@"zhuyebengkuichuxianwenti"];
//}
//-(void)VersionButton{
//    //获取发布版本的Version
//    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=1060289940"] encoding:NSUTF8StringEncoding error:nil];
//    if (string != nil && [string length] > 0 && [string rangeOfString:@"version"].length == 7) {
//        [self checkAppUpdate:string];
//    }
//
//}

//-(void)judgeAPPVersion
//{
//    //    https://itunes.apple.com/lookup?id=1060289940
//    
//    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://itunes.apple.com/lookup?id=1060289940"] encoding:NSUTF8StringEncoding error:nil];
//    if (string != nil && [string length] > 0 && [string rangeOfString:@"version"].length == 7) {
//        [self checkAppUpDate:string];
//    }
//}
//
//-(void) checkAppUpDate:(NSString *)appInfo{
//    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//    NSString *version = [infoDic objectForKey:@"CFBundleShortVersionString"];
//    NSString *appInfo1 = [appInfo substringFromIndex:[appInfo rangeOfString:@"\"version\":"].location + 10];
//    appInfo1 = [[appInfo1 substringToIndex:[appInfo1 rangeOfString:@","].location] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//    if (![appInfo1 isEqualToString:version]) {
//        NSLog(@"新版本:%@,当前版本:%@",appInfo1,version);
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"商店有最新版本了" delegate:self.class cancelButtonTitle:@"知道了" otherButtonTitles:nil];
//        alert.delegate = self;
//        [alert addButtonWithTitle:@"前往更新"];
//        [alert show];
//        alert.tag = 20;
//    }else{
////        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"已经是最高版本了" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
////        [alert show];
//    
//    }
//}

#pragma mark 检查更新
//- (void)checkUpdate{
//    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
//    NSString *nowVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
//    
//    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
//    NSString *url = @"http://itunes.apple.com/lookup?id=1060289940";
//    @weakify(self);
//    [twoPack getUrl:url andFinishBlock:^(id getResult) {
//        @strongify(self);
//        NSArray *resultArr = [getResult objectForKey:@"results"];
//        if([resultArr count]){
//            NSDictionary *resDict = [resultArr objectAtIndex:0];
//            NSString *newVersion = [resDict objectForKey:@"version"];
//            NSLog(@"%@--%@",newVersion,nowVersion);
//            [StoreageMessage storeValue:newVersion andTeacher:@"versionStr"];
//            if(newVersion.floatValue > nowVersion.floatValue){
//                UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"检测版本更新" message:@"现在有新的版本，是否要更新！"   delegate:self     cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil ];
//                alert.delegate = self;
//                [alert show];
//            }else{
//                
//            }
//        }
//    }];
//    
//    
//}
#pragma mark 版本更新
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 151150 || alertView.tag == 151151) {
        if (buttonIndex == 1) {
            RobOrderCenterViewController *controller =[[RobOrderCenterViewController alloc] init];
            UINavigationController *_nav = (UINavigationController*) (self.window.rootViewController);
//            TFMyViewController *_vc = [[TFMyViewController alloc]init];
            [_nav pushViewController:controller animated:YES];

        }
    }else{
    
    
//    if (buttonIndex == 1) {
//        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/kuai-kuai-mao/id1060289940?mt=8"];
//        [[UIApplication sharedApplication] openURL:url];
//    }
    }
}


//-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 1 &alertView.tag == 20) {
//        NSString *url = @"https://itunes.apple.com/cn/app/kuai-kuai-mao/id1060289940?mt=8";
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
//    }
//}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //            NSLog(@"result = %@",resultDic);
            NSLog(@"%@---%@---%@",app,url,resultDic);
            

            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            NSNotification *notify = [NSNotification notificationWithName:@"back" object:resultDic];
            [center postNotification:notify];
        }];
        return YES;
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //            NSLog(@"result = %@",resultDic);
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            NSNotification *notify = [NSNotification notificationWithName:@"back" object:resultDic];
            [center postNotification:notify];
        }];
        return YES;
        
    }
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
  return  [WXApi handleOpenURL:url delegate:self];
}
- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation

{
    NSLog(@"%@",url);
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
            //            NSLog(@"result = %@",resultDic);
        
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            NSNotification *notify = [NSNotification notificationWithName:@"back" object:resultDic];
            [center postNotification:notify];
        }];
        return YES;
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //            NSLog(@"result = %@",resultDic);
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
//    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
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
//                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
            default:
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler
{
//    if ([StoreageMessage jugeMerchantStoreMessageState]) {
//        return;
//    }
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    [StoreageMessage setBadge:[NSString stringWithFormat:@"%@",badge]];
    NSLog(@"123123123iOS10 收到远程通知:%@",userInfo);
    
    
    
//    [StoreageMessage storePushMessage:userInfo fromMemberId:[StoreageMessage getMessage][2]];
//    [StoreageMessage storePushMessage1:userInfo];
    
    
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    
    
    
//    UNNotificationRequest *request = notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content;
//    
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    [StoreageMessage setBadge:[NSString stringWithFormat:@"%@",badge]];
//    NSLog(@"%@",badge);
//    [dic1 setDictionary:userInfo];
//    NSLog(@"%@",content.title);
    //    if (content.title.length == 0) {
    //        [dic1 setObject:@"" forKey:@"title"];
    //
    //    }else{
    //    [dic1 setObject:content.title forKey:@"title"];
    //    }
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"MM/dd"];
    NSString *DateTime = [formatter stringFromDate:date];
    [dic1 setObject:@"1" forKey:@"flag"];
    [dic1 setObject:DateTime forKey:@"time"];
    [StoreageMessage storePushMessage1:dic1];
    
    
    
    
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {  //此时app在前台运行，我的做法是弹出一个alert，告诉用户有一条推送，用户可以选择查看或者忽略
//        //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"推送消息"
//        //                                                         message:@"您有一条新的推送消息!"
//        //                                                        delegate:self
//        //                                               cancelButtonTitle:@"取消"
//        //                                               otherButtonTitles:@"查看",nil];
//        //        alert.tag = 151151;
//        //
//        //        [alert show];
//        //

    }else {
        NSLog(@"%@",userInfo[@"goal"]);
        if (userInfo[@"xqid"] == nil) {
            
        }else{
        [StoreageMessage storeCommuntity:userInfo[@"xqname"]];
        [StoreageMessage storeCommuntityId:userInfo[@"xqid"]];
        }
        UINavigationController *_nav = (UINavigationController*) (self.window.rootViewController);
        if ([userInfo[@"goal"] isEqualToString:@"3"]) {
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"5"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"4"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"1"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"13"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"6"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"5"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"2"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"6"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"3"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"7"]){
            
            
            ProertyNoticeDeatilViewController *controller = [[ProertyNoticeDeatilViewController alloc] initWithTittle:userInfo[@"anTitle"] andDetial:userInfo[@"anContent"] andTime:userInfo[@"anTime"]];
            [_nav pushViewController:controller animated:YES];
//            PropertyNoticeViewController *property = [[PropertyNoticeViewController alloc] init];
//            [_nav pushViewController:property animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"8"]){
            ProertyMendDeatilViewController *mendDetail = [[ProertyMendDeatilViewController alloc] initWithProertyMendId:userInfo[@"pbid"]];
            [_nav pushViewController:mendDetail animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"9"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"4"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"1"]){
            RobOrderCenterViewController *controller = [[RobOrderCenterViewController alloc] init];
            [_nav pushViewController:controller animated:YES];

        }else if ([userInfo[@"goal"] isEqualToString:@"10"]){
            FixMasterViewController *pageVC = [[FixMasterViewController alloc] initWithViewControllerClasses:@[[FixMasterOneViewController class],[FixMasterTwoViewController class],[FixMasterThreeViewController class]] andTheirTitles:@[@"未完成",@"已完成",@"未委派任务"]];
            pageVC.pageAnimatable = YES;
            pageVC.menuItemWidth = self.window.frame.size.width/3;
            pageVC.menuHeight = 45;
            pageVC.postNotification = YES;
            //                    pageVC.menuView.frame.origin.y == 200;
            //                    pageVC.menuBGColor = [UIColor whiteColor];
            pageVC.bounces = YES;
            //                    pageVC.menuView.frame = CGRectMake(20, 200, self.view.frame.size.width, 45 *self.numSingleVesion);
            pageVC.title = @"维修师傅";
            [_nav pushViewController:pageVC animated:YES];
        }

        
    }
    //判断app是不是在前台运行，有三个状态(如果不进行判断处理，当你的app在前台运行时，收到推送时，通知栏不会弹出提示的)
    // UIApplicationStateActive, 在前台运行
    // UIApplicationStateInactive,未启动app
    //UIApplicationStateBackground    app在后台
    
    
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [JPUSHService registerDeviceToken:deviceToken];
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
-(void)jpushNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSLog(@"333333iOS10 收到远程通知:%@",userInfo);
    NSLog(@"3333333iOS10 收到远程通知:%@",notification);
//    if ([StoreageMessage jugeMerchantStoreMessageState]) {
//        return;
//    }
//    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//    {  //此时app在前台运行，我的做法是弹出一个alert，告诉用户有一条推送，用户可以选择查看或者忽略
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"推送消息"
//                                                         message:@"您有一条新的推送消息!"
//                                                        delegate:self
//                                               cancelButtonTitle:@"取消"
//                                               otherButtonTitles:@"查看",nil];
//        alert.tag = 151150;
//
//        [alert show];
//        
//    }else {
////        NSLog(@"AAA");
////        RobOrderCenterViewController *controller =[[RobOrderCenterViewController alloc] init];
////        UINavigationController *_nav = (UINavigationController*) (self.window.rootViewController);
////        //            TFMyViewController *_vc = [[TFMyViewController alloc]init];
////        [_nav pushViewController:controller animated:YES];
//        
//    }
//    [StoreageMessage storePushMessage:userInfo fromMemberId:[StoreageMessage getMessage][2]];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithCapacity:0];
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content;
    NSNumber *badge = content.badge;  // 推送消息的角标
    [StoreageMessage setBadge:[NSString stringWithFormat:@"%@",badge]];
    NSLog(@"%@",badge);
    [dic1 setDictionary:userInfo];
    NSLog(@"%@",content.title);
//    if (content.title.length == 0) {
//        [dic1 setObject:@"" forKey:@"title"];
//
//    }else{
//    [dic1 setObject:content.title forKey:@"title"];
//    }
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"MM/dd"];
    NSString *DateTime = [formatter stringFromDate:date];
    [dic1 setObject:@"0" forKey:@"flag"];

    [dic1 setObject:DateTime forKey:@"time"];
    [StoreageMessage storePushMessage1:dic1];

    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {  //此时app在前台运行，我的做法是弹出一个alert，告诉用户有一条推送，用户可以选择查看或者忽略
//        //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"推送消息"
//        //                                                         message:@"您有一条新的推送消息!"
//        //                                                        delegate:self
//        //                                               cancelButtonTitle:@"取消"
//        //                                               otherButtonTitles:@"查看",nil];
//        //        alert.tag = 151151;
//        //
        
//        //        [alert show];
//        //
//        [self checkUpdate];
//        [application setApplicationIconBadgeNumber:0];
//        [JPUSHService setBadge:0];
//        [application cancelAllLocalNotifications];
    }else {
        NSLog(@"%@",userInfo[@"goal"]);
        if (userInfo[@"xqid"] == nil) {
            
        }else{
            [StoreageMessage storeCommuntity:userInfo[@"xqname"]];
            [StoreageMessage storeCommuntityId:userInfo[@"xqid"]];
        }
        UINavigationController *_nav = (UINavigationController*) (self.window.rootViewController);
        if ([userInfo[@"goal"] isEqualToString:@"3"]) {
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"5"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"4"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"1"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"13"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"6"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"5"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"2"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"6"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"3"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"7"]){
            ProertyNoticeDeatilViewController *controller = [[ProertyNoticeDeatilViewController alloc] initWithTittle:userInfo[@"anTitle"] andDetial:userInfo[@"anContent"] andTime:userInfo[@"anTime"]];
            [_nav pushViewController:controller animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"8"]){
            ProertyMendDeatilViewController *mendDetail = [[ProertyMendDeatilViewController alloc] initWithProertyMendId:userInfo[@"pbid"]];
            [_nav pushViewController:mendDetail animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"9"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"4"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"1"]){
            RobOrderCenterViewController *controller = [[RobOrderCenterViewController alloc] init];
            [_nav pushViewController:controller animated:YES];
            
        }else if ([userInfo[@"goal"] isEqualToString:@"10"]){
            FixMasterViewController *pageVC = [[FixMasterViewController alloc] initWithViewControllerClasses:@[[FixMasterOneViewController class],[FixMasterTwoViewController class],[FixMasterThreeViewController class]] andTheirTitles:@[@"未完成",@"已完成",@"未委派任务"]];
            pageVC.pageAnimatable = YES;
            pageVC.menuItemWidth = self.window.frame.size.width/3;
            pageVC.menuHeight = 45;
            pageVC.postNotification = YES;
            //                    pageVC.menuView.frame.origin.y == 200;
            //                    pageVC.menuBGColor = [UIColor whiteColor];
            pageVC.bounces = YES;
            //                    pageVC.menuView.frame = CGRectMake(20, 200, self.view.frame.size.width, 45 *self.numSingleVesion);
            pageVC.title = @"维修师傅";
            [_nav pushViewController:pageVC animated:YES];
        }
        //            TFMyViewController *_vc = [[TFMyViewController alloc]init];
        
    }
//    [self.navigationController pushViewController: proerty animated:YES];

//    UNNotificationRequest *request = notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  //  推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self logDic:userInfo];

    }
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
}
//
-(void)jpushNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
//    if ([StoreageMessage jugeMerchantStoreMessageState]) {
//        return;
//    }
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"2222iOS10 收到远程通知:%@",userInfo);
    NSLog(@"222222iOS10 收到远程通知:%@",response);
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithCapacity:0];
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content;
    [dic1 setDictionary:userInfo];
    NSLog(@"%@",content.title);

//    if (content.title.length == 0) {
//        [dic1 setObject:@"" forKey:@"title"];
//        
//    }else{
//        [dic1 setObject:content.title forKey:@"title"];
//    }
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"MM/dd"];
    NSString *DateTime = [formatter stringFromDate:date];
    [dic1 setObject:@"0" forKey:@"flag"];

    [dic1 setObject:DateTime forKey:@"time"];
    [StoreageMessage storePushMessage1:dic1];

//    [StoreageMessage storePushMessage:userInfo fromMemberId:[StoreageMessage getMessage][2]];
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        
        //此时app在前台运行，我的做法是弹出一个alert，告诉用户有一条推送，用户可以选择查看或者忽略
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"推送消息"
//                                                         message:@"您有一条新的推送消息!"
//                                                        delegate:self
//                                               cancelButtonTitle:@"取消"
//                                               otherButtonTitles:@"查看",nil];
//        alert.tag = 151151;
//        [alert show];
//
        
    }else {
        NSLog(@"%@",userInfo[@"goal"]);
        if (userInfo[@"xqid"] == nil) {
            
        }else{
            [StoreageMessage storeCommuntity:userInfo[@"xqname"]];
            [StoreageMessage storeCommuntityId:userInfo[@"xqid"]];
        }
        UINavigationController *_nav = (UINavigationController*) (self.window.rootViewController);
        if ([userInfo[@"goal"] isEqualToString:@"3"]) {
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"5"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"4"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"1"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"13"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"6"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"5"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"2"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"6"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"3"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"7"]){
            ProertyNoticeDeatilViewController *controller = [[ProertyNoticeDeatilViewController alloc] initWithTittle:userInfo[@"anTitle"] andDetial:userInfo[@"anContent"] andTime:userInfo[@"anTime"]];
            [_nav pushViewController:controller animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"8"]){
            ProertyMendDeatilViewController *mendDetail = [[ProertyMendDeatilViewController alloc] initWithProertyMendId:userInfo[@"pbid"]];
            [_nav pushViewController:mendDetail animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"9"]){
            ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
            proerty.tag = [NSString stringWithFormat:@"4"];
            [_nav pushViewController:proerty animated:YES];
        }else if ([userInfo[@"goal"] isEqualToString:@"1"]){
            RobOrderCenterViewController *controller = [[RobOrderCenterViewController alloc] init];
            [_nav pushViewController:controller animated:YES];
            
        }else if ([userInfo[@"goal"] isEqualToString:@"10"]){
            FixMasterViewController *pageVC = [[FixMasterViewController alloc] initWithViewControllerClasses:@[[FixMasterOneViewController class],[FixMasterTwoViewController class],[FixMasterThreeViewController class]] andTheirTitles:@[@"未完成",@"已完成",@"未委派任务"]];
            pageVC.pageAnimatable = YES;
            pageVC.menuItemWidth = self.window.frame.size.width/3;
            pageVC.menuHeight = 45;
            pageVC.postNotification = YES;
            //                    pageVC.menuView.frame.origin.y == 200;
            //                    pageVC.menuBGColor = [UIColor whiteColor];
            pageVC.bounces = YES;
            //                    pageVC.menuView.frame = CGRectMake(20, 200, self.view.frame.size.width, 45 *self.numSingleVesion);
            pageVC.title = @"维修师傅";
            [_nav pushViewController:pageVC animated:YES];
        }

        
    }
    
    
//    UNNotificationRequest *request1 = response.notification.request; // 收到推送的请求
//    
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//
    NSNumber *badge = content.badge;  // 推送消息的角标
    [StoreageMessage setBadge:[NSString stringWithFormat:@"%@",badge]];
    NSLog(@"%@",badge);

//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self logDic:userInfo];
        NSLog(@"222222iOS10 收到远程通知:%@",response);
    }
    completionHandler();  // 系统要求执行这个方法
    

}
#endif



- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    
//    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    
//    NSString *currentContent = [NSString
//                                stringWithFormat:
//                                @"收到自定义消息:%@\ntitle:%@\ncontent:%@\nextra:%@\n",
//                                [NSDateFormatter localizedStringFromDate:[NSDate date]
//                                                               dateStyle:NSDateFormatterNoStyle
//                                                               timeStyle:NSDateFormatterMediumStyle],
//                                title, content, [self logDic:extra]];
//    NSLog(@"%@", currentContent);
    
//    [_messageContents insertObject:currentContent atIndex:0];
    
//    NSString *allContent = [NSString
//                            stringWithFormat:@"%@收到消息:\n%@\nextra:%@",
//                            [NSDateFormatter
//                             localizedStringFromDate:[NSDate date]
//                             dateStyle:NSDateFormatterNoStyle
//                             timeStyle:NSDateFormatterMediumStyle],
//                            [_messageContents componentsJoinedByString:nil],
//                            [self logDic:extra]];
//    
//    _messageContentView.text = allContent;
//    _messageCount++;
//    [self reloadMessageCountLabel];
//}

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
    [application setApplicationIconBadgeNumber:[StoreageMessage getBadge].integerValue];
//    [JPUSHService setBadge:0];
    if ([StoreageMessage getBadge].integerValue == 0) {
        [JPUSHService setBadge:0];

        [application cancelAllLocalNotifications];

    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:[StoreageMessage getBadge].integerValue];
    if ([StoreageMessage getBadge].integerValue == 0) {
        [JPUSHService setBadge:0];

        [application cancelAllLocalNotifications];
        
    }
//    [JPUSHService setBadge:0];
//    [application cancelAllLocalNotifications];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//微信支付成功调用回调
//-
@end
