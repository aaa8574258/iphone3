//
//  BuyFoodCarViewController.h
//  360du
//
//  Created by linghang on 15/7/6.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
@class AddressModel;
@interface BuyFoodCarViewController : BaseViewController
@property(nonatomic,copy)NSString *shopName;//店铺名称
@property(nonatomic,copy)NSString *shopDesc;//店铺描述
-(id)initWithArr:(NSArray *)array andPrice:(CGFloat)price andFoodTypeArr:(NSArray *)typeArr andMerchantId:(NSString *)merchantId andSendPrice:(NSString *)sendPrice andDistrutionPrice:(NSString *)distrutionPrice;
//返回配送配注内容
-(void)returnSendDeatil:(NSString *)detail;
//返回发票信息
- (void)retunDebitDeatil:(NSString *)detail;
//获取默认地址
- (void)gainDefaultAddress:(AddressModel *)model;
//返回优惠钱数
- (void)retunMoney:(NSString *)money;
@end
