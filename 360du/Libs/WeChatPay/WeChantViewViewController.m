//
//  WeChantViewViewController.m
//  360du
//
//  Created by linghang on 15/10/18.
//  Copyright © 2015年 wangjian. All rights reserved.
//


#ifndef AliPayNeedDEF_h
#define AliPayNeedDEF_h
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
////合作身份者id，以2088开头的16位纯数字（客户给）
//#define AliPartnerID @"合作者身份id"
//
////收款支付宝账号
//#define AliSellerID  @"这里一般填写客户的企业级支付宝收款账号"

//合作身份者id，以2088开头的16位纯数字（客户给）
#define AliPartnerID @"2088411427598120"   //快快猫的合作者
//#define AliPartnerID @"2088221899157152"

//收款支付宝账号
#define AliSellerID  @"605898888@qq.com"    //快快猫支付宝账号
//#define AliSellerID  @"13910100599@139.com"

//商户私钥，自助生成（这个私钥需要自己手动生成，具体生成方法可以看支付宝的官方文档，下面给出大体格式）

//#define AliPartnerPrivKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANi2IdvSERyhKBJ7/tz9lY3v+Xgt+Zhq+hvXWHzH3JytbIk4Be0ktJZ/VVB2v/DzqgrnW/VWDtnfpI4c5rs+k7I4Wn8qfMjDoSB5k1OwwKyCVWwU7qC9rYpPjx8A6S3um8c5Gnj8aFsj4j/3E+FxDn40B4dbiVnAPyPwRR0/cn0hAgMBAAECgYEAw+mLnH1BCP/MCUHdew0o2cM7ZWEyxo7XgrngfhX0pBPIDhj+io9nTrLYfsCL7xlo/SiBIr7k+CRNUEhicp40x/v6pqnZLzU2DXrHjziFDcDQys2Y4Xt9SObgj4LLfEpLm3gjMVFG/EhyEqXSVo+NqWB8nU0nzFUPeCDInc45YNECQQD3KzQW4YJTpfhZwPwVpMOVGqsbhZL5d64pBBf99yu33+nslTSPinrrWCfw1J5AmN/gHhKzjOTLt36SzmG/iQr9AkEA4HRXuvbM0eDh+a5Sv7XLAmZHohuqjYR8TuBqS6PcT9az2YRiRIRSqqB0PcrSRHxfUMeB4Q5cS+UWuzYFKbat9QJBAO1zI+eXXYzetWgEbiic0Qg9RoR6HmhrAXWF6UaiXe2XvzL5ZDVB5DSTzEsg96c3Nlwoh+7WPDc5YO/INT+8eEECQFDR050grNONtBChcm5RWU394iE+8QSQBeqo591gnT2qQ4w5HOEq/FEwAWsWkuvSFMgTbnLJJva1AKBcbTN98dkCQCObVz9dHk2jxhCVQlcHJtwzQpvaLrnlZ7eC5HCCwtKJQIwcjSeMb/u5zpEqStxGpjIwBNrabA7DA9mEi185NSg="


//#define AliPartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAOiKRejOi2IWposb5RTgln66f099EDEpHkY1K87HcYmhmMnC3SmCGcc0TRwyubD8uYjB2yx7DN8seDOR6X+cUoE+r4o4AR7hB6z5pqUffmhND6jvg7i9dzNAfsphX+r4pGfI2QyHMk2IYJWBg81Qt2roVx04DmmUJeZ2+sTPyoZJAgMBAAECgYA3BbjC/FRIsllX4xLSXM3fUJudIFd7emI6dIxYEiMQUNdJLj2Me8dDtmFkgbAka7gu3sfQf5EtIWWTtjvMwR1YGgWmp3rA4Amn4/hPmJMxCcL6gBoVm4JaiDkIqAEAAXGGfto/A54AcHOqodkxWgla6RsMmO78spkCPxT+Tc+CjQJBAP0IrVRAgvsiIsWgY/QQ/yxlpwSXAO5ckqMF6bZS8YzR3EfMEeuZa7BxideLHB04STlcVd3SuiJZ7d+y5OVISUsCQQDrRBjH7bRu8WC040eklopHHM3ycWcrvB1UIZ1g0R0bCWd+ER/z4qRbknrkEYBdXhDJm9edIhYipHwha9+r8aY7AkEA9WuOGjK8F/KDAWXQrLAzn4800HnZ2FeHjoE0rreCO5Bs9GJVW0siLS/if2IYsaqfMviA/DbgfGL3Gkp8Qnq7QwJAdn8RADoQxERdUh6bqiGMui6e6HsH3PZdy083BlmtED4XW17iuiMwZ1MLBK5v+hbz26fb3LAbeA1i3C6KNP98mwJAadQN6ONzlRoPN5DQRKPKMyB4eQ8kK0oyQsTRSKUd4OJz9ikWpW3wSXmSgTEaZKL2a3tS5ZoNMBp+hNY2wSfj0Q=="


//后台给的接口网址
#define AliNotifyURL @"http://www.360duang.net/360duang/Shop/pay/notify_url.jsp"

#define kAliPayURLScheme @"du36019920210"

//通知的名字及参数
#define ALI_PAY_RESULT   @"Ali_pay_result_isSuccessed"
#define ALIPAY_SUCCESSED    @"Ali_pay_isSuccessed"
#define ALIPAY_FAILED       @"Ali_pay_isFailed"

#endif

#import "WeChantViewViewController.h"
//APP端签名相关头文件
#import "payRequsestHandler.h"

//服务端签名只需要用到下面一个头文件
//#import "ApiXml.h"
#import <QuartzCore/QuartzCore.h>
@interface WeChantViewViewController ()

@end

@implementation WeChantViewViewController


+ (void)payName:(NSString *)name andMoney:(NSString *)money andOder:(NSString *)oder{
    [WeChantViewViewController sendPay_demo1Name:name andMoney:money andOder:oder];
}
+ (void)sendPay_demo1Name:(NSString *)name andMoney:(NSString *)money andOder:(NSString *)oder
{
    
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID andName:name andMoney:[NSString stringWithFormat:@"%ld",money.integerValue] andOder:oder];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    //}}}
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo];
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        [WeChantViewViewController alert:@"提示信息" msg:debug];
        
//        NSLog(@"%@\n\n",debug);
    }else{
//        NSLog(@"%@\n\n",[req getDebugifo]);
        
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:@"weixin_pay_result" object:nil];
        
        [WXApi sendReq:req];
    }
}


+ (void)sendPay_demo1Name:(NSString *)name andMoney:(NSString *)money andOder:(NSString *)oder andPartnerId:(NSString *)partnerId andMchId:(NSString *)mchId
{
    
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    
    //初始化支付签名对象
    [req init:APP_ID mch_id:mchId andName:name andMoney:[NSString stringWithFormat:@"%ld",money.integerValue] andOder:oder];
    //设置密钥
    [req setKey:partnerId];
    
    //}}}
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo];
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        [WeChantViewViewController alert:@"提示信息" msg:debug];
        
        //        NSLog(@"%@\n\n",debug);
    }else{
        //        NSLog(@"%@\n\n",[req getDebugifo]);
        
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:@"weixin_pay_result" object:nil];
        
        [WXApi sendReq:req];
    }
}

//微信付款成功失败
-(void)noti:(NSNotification *)noti{
//    NSLog(@"%@",noti);
    if ([[noti object] isEqualToString:@"成功"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WX_PAY_RESULT object:IS_SUCCESSED];
        
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:WX_PAY_RESULT object:IS_FAILED];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weixin_pay_result" object:nil];
}
//客户端提示信息
+ (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}




+(void)payTHeMoneyUseAliPayWithOrderId:(NSString *)orderId totalMoney:(NSString *)totalMoney payTitle:(NSString *)payTitle
{
    NSMutableString *orderString = [NSMutableString string];
    [orderString appendFormat:@"service=\"%@\"", @"mobile.securitypay.pay"]; //
    [orderString appendFormat:@"&partner=\"%@\"", AliPartnerID];          //
    [orderString appendFormat:@"&_input_charset=\"%@\"", @"utf-8"];    //
    [orderString appendFormat:@"&notify_url=\"%@\"", AliNotifyURL];       //
    [orderString appendFormat:@"&out_trade_no=\"%@\"", orderId];   //
    [orderString appendFormat:@"&subject=\"%@\"", payTitle];        //
    [orderString appendFormat:@"&payment_type=\"%@\"", @"1"];          //
    [orderString appendFormat:@"&seller_id=\"%@\"", AliSellerID];         //
    [orderString appendFormat:@"&total_fee=\"%@\"", totalMoney];         //
    [orderString appendFormat:@"&body=\"%@\"", payTitle];              //
    [orderString appendFormat:@"&showUrl =\"%@\"", @"m.alipay.com"];
    id<DataSigner> signer = CreateRSADataSigner(AliPartnerPrivKey);
    NSString *signedString = [signer signString:orderString];
    NSLog(@"%@",signedString);
    
    [orderString appendFormat:@"&sign=\"%@\"",signedString];
    [orderString appendFormat:@"&sign_type=\"%@\"", @"RSA"];
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:kAliPayURLScheme callback:^(NSDictionary *resultDic)
     {
//         NSLog(@"reslut = %@",resultDic);
         if ([[resultDic objectForKey:@"resultStatus"] isEqual:@"9000"]) {
             //支付成功
             [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_SUCCESSED];
         }else{
             [[NSNotificationCenter defaultCenter] postNotificationName:ALI_PAY_RESULT object:ALIPAY_FAILED];
         }
     }];
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
//    NSString *strTitle = nil;
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
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
