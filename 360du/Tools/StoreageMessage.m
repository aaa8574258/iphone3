//
//  StoreageMessage.m
//  XiaomiIOs
//
//  Created by linghang on 15-3-20.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "StoreageMessage.h"

@implementation StoreageMessage
+(BOOL)isStoreMessage{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (username.length != 0) {
        return YES;
    }
    return NO;
}
//token是userId
+(void)storeMessageUsername:(NSString *)username andPassword:(NSString *)password andToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSArray *)getMessage{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//    if (<#condition#>) {
//        <#statements#>
//    }
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
//获取城市
+(NSString *) getCity{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];

}
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
@end
