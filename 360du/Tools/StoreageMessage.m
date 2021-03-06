//
//  StoreageMessage.m
//  XiaomiIOs
//
//  Created by linghang on 15-3-20.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "StoreageMessage.h"
#import "JPUSHService.h"
#import "WXApi.h"
#import "WXApiObject.h"

#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WeChantViewViewController.h"
#import "SendMessage.h"


@implementation StoreageMessage
+(BOOL)isStoreMessage{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (username.length != 0) {
        return YES;
    }
    return NO;
}


+(void)giveYZM:(NSString *)yzm{
    [[NSUserDefaults standardUserDefaults] setObject:yzm forKey:@"yzm"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}



+(NSString *)getYZM{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"yzm"];

}



//token是userId
+(void)storeMessageUsername:(NSString *)username andPassword:(NSString *)password andToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)ac:(id)sender{
    NSLog(@"%@",sender);
}

+(NSArray *)getMessage{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//    if (<#condition#>) {
//        <#statements#>
//    }
    NSLog(@"%@--%@--%@",username,password,token);
    if (!token) {
        return NULL;
    }
    return @[username,password,token];
}
+(void)storeAddress:(NSString *)address{
    [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"address"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getStoreAddress{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
}
//判读用户推送消息
//储存推送用户消息
+ (void)storePersonalPushMessage:(BOOL)message{
    if (message) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"personalPushMessage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"personalPushMessage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    }
}
//先判断用户是否储存
+ (BOOL)jugePersonalStoreMessage{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"personalPushMessage"];
    if (username.length != 0) {
        return YES;
    }
    return NO;

}
//返回用户状态推送
+ (BOOL)jugePersonalStoreMessageState{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"personalPushMessage"];
    if (username.length != 0) {
        return YES;
    }
    return NO;

}
//退出用户登录
+ (void)clearPersonalLogin{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//存储城市
+(void) storeCity:(NSString *)cityName{
    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"city"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//存储小区
+(void) storeCommuntity:(NSString *)communtityName{
    [[NSUserDefaults standardUserDefaults] setObject:communtityName forKey:@"communtity"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



//存取城市ID
+ (void)storeCityId:(NSString *)communtityId{
    [[NSUserDefaults standardUserDefaults] setObject:communtityId forKey:@"thecity"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获取城市ID
+ (NSString *)getCityId{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"thecity"];
    
}

//获取城市
+(NSString *) getCity{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];

}

//+(NSString *) getCityID{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"qycode"];
//    
//}

//获取小区
+(NSString *)getCommuntity{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"communtity"];

}
//存储经纬度
+ (void)storeLatAndLong:(NSString *)latAndLong{
    [[NSUserDefaults standardUserDefaults] setObject:latAndLong forKey:@"latAndLong"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获取经纬度
+ (NSString *)getLatAndLong{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"latAndLong"];

}

+(void)storeValue:(NSString *)value andTeacher:(NSString *)teacher{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:teacher];
}


//判断是否有经纬度，或者小区，以及小区ID
+ (BOOL)isStoreMessageLatAndLong{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"latAndLong"];
    if (username.length != 0) {
        return YES;
    }
    return NO;
}
//存取小区ID
+ (void)storeCommuntityId:(NSString *)communtityId{
    [[NSUserDefaults standardUserDefaults] setObject:communtityId forKey:@"communtityID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获取小区ID
+ (NSString *)getCommuntityId{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"communtityID"];

}
//判断是否有商家管理
+(BOOL)isMerchantStoreMesssage{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"merchantUsername"];
    if (username.length != 0) {
        return YES;
    }
    return NO;

}
//储存商家账号和密码
+(void)storeMerchantUserName:(NSString *)userName andPassWord:(NSString *)password andMemerId:(NSString *)merchantId{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"merchantUsername"];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"merchantPassword"];
    [[NSUserDefaults standardUserDefaults] setObject:merchantId forKey:@"merchantMemerId"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
//获取商家账号和密码
+(NSArray *)gainMerchantUserNameAndPasswordAndMemerId{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"merchantUsername"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"merchantPassword"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"merchantMemerId"];
    return @[username,password,token];
}
//清空账号和密码
+(void)clearMerchantUserNameAndPassword{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"merchantUsername"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"merchantPassword"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"merchantMemerId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//储存推送商家消息
+ (void)storePushMessage:(BOOL)message{
    if (message) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"merchantPushMessage"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"merchantPushMessage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
 
    }

}
//先判断商家是否储存
+ (BOOL)jugeMerchantStoreMessage{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"merchantPushMessage"];
    if (username.length != 0) {
        return YES;
    }
    return NO;

}
//返回商家状态推送
+ (BOOL)jugeMerchantStoreMessageState{
    if ([StoreageMessage jugeMerchantStoreMessage]) {
        NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"merchantPushMessage"];
        if([username isEqual:@"1"]){
            return YES;
        }else{
            return NO;
        }

    }else{
        [StoreageMessage storePushMessage:YES];
    }
    return YES;
}



//获取崩溃数据
+(void)getErrorMessage:(NSString *)message fromUrl:(NSString *)url{
    NSLog(@"message:%@",url);
    if([url rangeOfString:@"serviceName="].location != NSNotFound)//_roaldSearchText
    {
    
        NSString *string = url;
        NSRange startRange = [string rangeOfString:@"serviceName="];
        NSRange endRange = [string rangeOfString:@"&medthodName"];
        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
        NSString *result = [string substringWithRange:range];
    
    
//    NSRange startRange1 = [string rangeOfString:@"medthodName="];
//    NSRange endRange1 = [string rangeOfString:@"&"];
//    NSRange range1 = NSMakeRange(startRange1.location + startRange1.length, endRange1.location - startRange1.location - startRange1.length);
//    NSString *result1 = [string substringWithRange:range1];
    
        NSArray *array = [string componentsSeparatedByString:@"medthodName="];
        NSArray *arr = [array[1] componentsSeparatedByString:@"&"];
        NSString *result1 = arr[0];
        NSLog(@"%@---%@",result,result1);
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    //传入的参数  十八里店横街子
//    [manager POST:TEST parameters:@{@"requestUrl":url,@"getedParams":message} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////        NSLog(@"rerererer%@",responseObject);
//        //        if ([responseObject[@"code"] isEqualToString:@"000000"]) {
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
////        NSLog(@"%@",error);
//    }];
    NSString *memberId =  [NSString stringWithFormat:@"%@",[StoreageMessage getMessage][2]];
    NSString *xqid =  [NSString stringWithFormat:@"%@",[StoreageMessage getCommuntityId]];
    NSString *location =  [NSString stringWithFormat:@"%@",[StoreageMessage getLatAndLong]];
    NSString *serviece_name =  [NSString stringWithFormat:@"%@",result];
    NSString *medthod_name =  [NSString stringWithFormat:@"%@",result1];
    if (memberId.length == 0) {
        memberId = @"NULL";
    }else if (xqid.length == 0){
        xqid = @"NULL";
    }else if (location.length == 0){
        location = @"NULL";
    }else if (serviece_name.length == 0){
        serviece_name = @"NULL";
    }else if (medthod_name.length == 0){
        medthod_name =@"NULL";
    
    }else{
        NSLog(@"%@",[NSString stringWithFormat:GETHISTROTH,memberId,xqid,location,serviece_name,medthod_name]);
    
    
        [manager GET:[NSString stringWithFormat:GETHISTROTH,memberId,xqid,location,serviece_name,medthod_name] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        }];
    }
        
        
    }
    else
    {
        NSLog(@"no");
    }
}


//
+(void)AlipayfromAlipartnerId:(NSString *)aliPartnerID andAliSellerID:(NSString *)aliSellerID andOrderID:(NSString *)orderId andMoney:(NSString *)money andPayTitle:(NSString *)titleString{
    NSMutableString *orderString = [NSMutableString string];
    [orderString appendFormat:@"service=\"%@\"", @"mobile.securitypay.pay"]; //
    [orderString appendFormat:@"&partner=\"%@\"", aliPartnerID];          //
    [orderString appendFormat:@"&_input_charset=\"%@\"", @"utf-8"];    //
    [orderString appendFormat:@"&notify_url=\"%@\"", AliNotifyURL];       //
    [orderString appendFormat:@"&out_trade_no=\"%@\"", orderId];   //
    [orderString appendFormat:@"&subject=\"%@\"", titleString];        //
    [orderString appendFormat:@"&payment_type=\"%@\"", @"1"];          //
    [orderString appendFormat:@"&seller_id=\"%@\"", aliSellerID];         //
    [orderString appendFormat:@"&total_fee=\"%@\"", money];         //
    [orderString appendFormat:@"&body=\"%@\"", titleString];              //
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

+(void)WeChatfromMchId:(NSString *)mchId andPartnerId:(NSString *)partnerId andOrderID:(NSString *)orderId andMoney:(NSString *)money andPayTitle:(NSString *)titleString{
    [WeChantViewViewController sendPay_demo1Name:titleString andMoney:money andOder:orderId andPartnerId:partnerId andMchId:mchId];

}

////存储推送
+(void) storePushMessage1:(NSDictionary *)message {
    
    if([[message allKeys] containsObject:@"ky"]){
        return;
    }
    
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",docPath);
    NSString *dataPath = [docPath stringByAppendingString:@"/dataText.dat"];
    
    
    
    
    


    //将data存到文件中
    
    
    
    NSData *data2 = [NSData dataWithContentsOfFile:dataPath];
    
    //2.创建出饭反归档类
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data2];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    NSLog(@"%@",[unarchiver decodeObjectForKey:[StoreageMessage getMessage][2]]);
//    if ([unarchiver decodeObjectForKey:[StoreageMessage getMessage][2]] != nil) {
    for (NSDictionary *dic in [unarchiver decodeObjectForKey:[StoreageMessage getMessage][2]]) {
        [arr addObject:dic];
    }
    
    
//    [arr addObject:[unarchiver decodeObjectForKey:[StoreageMessage getMessage][2]]];
//    arr = [unarchiver decodeObjectForKey:[StoreageMessage getMessage][2]];
    NSLog(@"%@",message);
    [arr addObject:message];
//    }
    NSLog(@"%@",arr);
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    
    [archiver encodeObject:arr forKey:[StoreageMessage getMessage][2]];
    
    
    
    //告诉工具所有的对象已经归档好
    [archiver finishEncoding];
    
    [data writeToFile:dataPath atomically:YES];
    
}
//+(void) storePushMessageArr:(NSMutableArray *)messageArr fromMemberId:(NSString *)memberId{
//    [messageArr addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"23333333"]];
//    [[NSUserDefaults standardUserDefaults] setObject:messageArr forKey:memberId];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//+(NSMutableArray *)getPushMessageFromMemberId1:(NSString *)memberId{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:memberId];
//}

//获取推送
+(NSMutableArray *)getPushMessageFromMemberId:(NSString *)memberId{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",docPath);
    NSString *dataPath = [docPath stringByAppendingString:@"/dataText.dat"];

    NSData *data2 = [NSData dataWithContentsOfFile:dataPath];
    
    //2.创建出饭反归档类
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data2];
    
    //③拿到对象

    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    arr = [unarchiver decodeObjectForKey:[StoreageMessage getMessage][2]];
    
    //④关闭
    [unarchiver finishDecoding];
    NSLog(@"%@",arr);
    return arr;

}

+(void) clearPushMessage{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",docPath);
    NSString *dataPath = [docPath stringByAppendingString:@"/dataText.dat"];
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    [archiver encodeObject:nil forKey:[StoreageMessage getMessage][2]];
    
    
    
    //告诉工具所有的对象已经归档好
    [archiver finishEncoding];
    
    [data writeToFile:dataPath atomically:YES];

}



+ (void)setBadge:(NSString *)badge{
    [[NSUserDefaults standardUserDefaults] setObject:badge forKey:@"badgee"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)clearBadge{

    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"badgee"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *) getBadge{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"badgee"];
    
}
@end
