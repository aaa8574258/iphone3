//
//  WeChantViewViewController.h
//  360du
//
//  Created by linghang on 15/10/18.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
@protocol sendMsgToWeChatViewDelegate <NSObject>
//- (void) changeScene:(NSInteger)scene;
//- (void) sendTextContent;
//- (void) sendImageContent;
//- (void) sendPay;
//- (void) sendPay_demo;
@end

@interface WeChantViewViewController : BaseViewController<WXApiDelegate>
@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate,NSObject> delegate;
//- (id)initWithName:(NSString *)name andMoney:(NSString *)body;
//- (id)initWithName:(NSString *)name andMoney:(NSString *)money;
+ (void)payName:(NSString *)name andMoney:(NSString *)money andOder:(NSString *)oder;
//-(void) onResp:(BaseResp*)resp;
+(void)payTHeMoneyUseAliPayWithOrderId:(NSString *)orderId totalMoney:(NSString *)totalMoney payTitle:(NSString *)payTitle;



+ (void)sendPay_demo1Name:(NSString *)name andMoney:(NSString *)money andOder:(NSString *)oder andPartnerId:(NSString *)partnerId andMchId:(NSString *)mchId;
@end
