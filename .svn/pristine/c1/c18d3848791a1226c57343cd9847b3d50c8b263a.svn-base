

#import <Foundation/Foundation.h>
#import "WXUtil.h"
#import "ApiXml.h"
/*
 // 签名实例
 // 更新时间：2015年3月3日
 // 负责人：李启波（marcyli）
 // 该Demo用于ios sdk 1.4
 
 //微信支付服务器签名支付请求请求类
 //============================================================================
 //api说明：
 //初始化商户参数，默认给一些参数赋值，如cmdno,date等。
 -(BOOL) init:(NSString *)app_id (NSString *)mch_id;
 
 //设置商户API密钥
 -(void) setKey:(NSString *)key;
 
 //生成签名
 -(NSString*) createMd5Sign:(NSMutableDictionary*)dict;
 
 //获取XML格式的数据
 -(NSString *) genPackage:(NSMutableDictionary*)packageParams;
 
 //提交预支付交易，获取预支付交易会话标识
 -(NSString *) sendPrepay:(NSMutableDictionary *);
 
 //签名实例测试
 - ( NSMutableDictionary *)sendPay_demo;
 
 //获取debug信息日志
 -(NSString *) getDebugifo;
 
 //获取最后返回的错误代码
 -(long) getLasterrCode;
 //============================================================================
 */

// 账号帐户资料
//更改商户把相关参数后可测试

#define APP_ID          @"wx2d68ffd4a68e1f0b"               //APPID
#define APP_SECRET      @"3cfffa9562dbe4ece0ddcf7fca0a8135" //appsecret
//商户号，填写商户对应参数
#define MCH_ID          @"1251806001"
//商户API密钥，填写相应参数3cfffa9562dbe4ece0ddcf7fca0a8135
//#define PARTNER_ID      @"af03bb0afbe587391d78192f9dedc3e6"
#define PARTNER_ID      @"af03bb0afbe587391d78192f9dedc3e6"

//#define APP_ID          @"wx54baf8e8ec20efeb"               //APPID
//#define APP_SECRET      @"c4be450fc78aa7a0313041bb686d5bfb" //appsecret
////商户号，填写商户对应参数
//#define MCH_ID          @"1273942901"
////商户API密钥，填写相应参数
//#define PARTNER_ID      @"hunanhuitengkejigongshi200706128"
//支付结果回调页面
#define NOTIFY_URL      @"http://www.360duang.net/360duang/wxpay.do"

//#define NOTIFY_URL      @"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"
//获取服务器端支付数据地址（商户自定义）（到时候你要你们后台写这些东西）
#define SP_URL          @"http://192.168.1.109:8080/WeiXinpay/weixin/test.do"


@interface payRequsestHandler : NSObject{
	//预支付网关url地址
    NSString *payUrl;

    //lash_errcode;
    long     last_errcode;
	//debug信息
    NSMutableString *debugInfo;
    NSString *appid,*mchid,*spkey;
}
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *body;
@property(nonatomic,copy)NSString *money;
//初始化函数
-(BOOL) init:(NSString *)app_id mch_id:(NSString *)mch_id andName:(NSString *)name andMoney:(NSString *)money;
-(NSString *) getDebugifo;
-(long) getLasterrCode;
//设置商户密钥
-(void) setKey:(NSString *)key;
//创建package签名
-(NSString*) createMd5Sign:(NSMutableDictionary*)dict;
//获取package带参数的签名包
-(NSString *)genPackage:(NSMutableDictionary*)packageParams;
//提交预支付
-(NSString *)sendPrepay:(NSMutableDictionary *)prePayParams;
//签名实例测试
- ( NSMutableDictionary *)sendPay_demo;

@end