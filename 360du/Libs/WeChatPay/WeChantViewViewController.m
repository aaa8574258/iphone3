//
//  WeChantViewViewController.m
//  360du
//
//  Created by linghang on 15/10/18.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "WeChantViewViewController.h"
//APP端签名相关头文件
#import "payRequsestHandler.h"

//服务端签名只需要用到下面一个头文件
//#import "ApiXml.h"
#import <QuartzCore/QuartzCore.h>
@interface WeChantViewViewController ()

@end

@implementation WeChantViewViewController

//- (void)sendPay_demo
//{
//    if (_delegate) {
//       // [_delegate sendPay_demo];
//    }
//}
//- (id)initWithName:(NSString *)name andMoney:(NSString *)money{
//    self = [super init];
//    if (self) {
//        [self sendPay_demo1Name:name andMoney:money];
//    }
//    return self;
//}
+ (void)payName:(NSString *)name andMoney:(NSString *)money{
    [WeChantViewViewController sendPay_demo1Name:name andMoney:money];
}
+ (void)sendPay_demo1Name:(NSString *)name andMoney:(NSString *)money
{
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //    req.name = @"你好";
    //    req.money = @"1";
    
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID andName:name andMoney:[NSString stringWithFormat:@"%ld",money.integerValue]];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    //}}}
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [WeChantViewViewController alert:@"提示信息" msg:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
}
//客户端提示信息
+ (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//   // [self sendPay_demo];
//    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [btn3 setTitle:@"微信支付测试签名" forState:UIControlStateNormal];
//    btn3.titleLabel.font = [UIFont systemFontOfSize:14];
//    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn3 setFrame:CGRectMake(10, 130, 145, 40)];
//    [btn3 addTarget:self action:@selector(sendPay_demo) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn3];
//    // Do any additional setup after loading the view.
//}
//- (void)sendPay_demo
//{
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    NSNotification *notification = [NSNotification notificationWithName:@"weChant" object:nil];
//    [center postNotification:notification];
////    //{{{
////    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
////    
////    //创建支付签名对象
////    payRequsestHandler *req = [[payRequsestHandler alloc] autorelease];
////    //初始化支付签名对象
////    [req init:APP_ID mch_id:MCH_ID];
////    //设置密钥
////    [req setKey:PARTNER_ID];
////    
////    //}}}
////    
////    //获取到实际调起微信支付的参数后，在app端调起支付
////    NSMutableDictionary *dict = [req sendPay_demo];
////    
////    if(dict == nil){
////        //错误提示
////        NSString *debug = [req getDebugifo];
////        
////        [self alert:@"提示信息" msg:debug];
////        
////        NSLog(@"%@\n\n",debug);
////    }else{
////        NSLog(@"%@\n\n",[req getDebugifo]);
////        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
////        
////        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
////        
////        //调起微信支付
////        PayReq* req             = [[[PayReq alloc] init]autorelease];
////        req.openID              = [dict objectForKey:@"appid"];
////        req.partnerId           = [dict objectForKey:@"partnerid"];
////        req.prepayId            = [dict objectForKey:@"prepayid"];
////        req.nonceStr            = [dict objectForKey:@"noncestr"];
////        req.timeStamp           = stamp.intValue;
////        req.package             = [dict objectForKey:@"package"];
////        req.sign                = [dict objectForKey:@"sign"];
////        
////        [WXApi sendReq:req];
////        //NSLog(@"req:%d",[WXApi sendReq:req]);
////    }
//}
//-(void) onResp:(BaseResp*)resp
//{
//    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//    NSString *strTitle;
//    
//    if([resp isKindOfClass:[SendMessageToWXResp class]])
//    {
//        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
//    }
//    if([resp isKindOfClass:[PayResp class]]){
//        //支付返回结果，实际支付结果需要去微信服务器端查询
//        strTitle = [NSString stringWithFormat:@"支付结果"];
//        
//        switch (resp.errCode) {
//            case WXSuccess:
//                strMsg = @"支付结果：成功！";
//                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
//                break;
//                
//            default:
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
//                break;
//        }
//    }
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
