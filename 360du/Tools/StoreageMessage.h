//
//  StoreageMessage.h
//  XiaomiIOs
//
//  Created by linghang on 15-3-20.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreageMessage : NSObject
+(BOOL)isStoreMessage;
+(void)storeMessageUsername:(NSString *)username andPassword:(NSString *)password andToken:(NSString *)token;
+(NSArray *)getMessage;
+(void)storeAddress:(NSString *)address;
+(NSString *)getStoreAddress;
//判读用户推送消息开启
//储存推送用户消息
+ (void)storePersonalPushMessage:(BOOL)message;
//先判断用户是否储存
+ (BOOL)jugePersonalStoreMessage;
//返回用户状态推送
+ (BOOL)jugePersonalStoreMessageState;
//退出用户登录
+ (void)clearPersonalLogin;
//是否定位小区
//+(BOOL)isLocationCommuntity;
//存储城市
+(void) storeCity:(NSString *)cityName;
//存储小区
+(void) storeCommuntity:(NSString *)communtityName;
//获取城市
+(NSString *) getCity;
//获取小区
+(NSString *)getCommuntity;
//存储经纬度
+ (void)storeLatAndLong:(NSString *)latAndLong;
//获取经纬度
+ (NSString *)getLatAndLong;
//判断是否有经纬度，或者小区，以及小区ID
+ (BOOL)isStoreMessageLatAndLong;
//存取小区ID
+ (void)storeCommuntityId:(NSString *)communtityId;
//获取小区ID
+ (NSString *)getCommuntityId;
//判断是否有商家管理
+(BOOL)isMerchantStoreMesssage;
//储存商家账号和密码
+(void)storeMerchantUserName:(NSString *)userName andPassWord:(NSString *)password andMemerId:(NSString *)merchantId;
//获取商家账号和密码
+(NSArray *)gainMerchantUserNameAndPasswordAndMemerId;
//清空账号和密码
+(void)clearMerchantUserNameAndPassword;
//储存推送商家消息
+ (void)storePushMessage:(BOOL)message;
//先判断商家是否储存
+ (BOOL)jugeMerchantStoreMessage;
//返回商家状态推送
+ (BOOL)jugeMerchantStoreMessageState;

@end
