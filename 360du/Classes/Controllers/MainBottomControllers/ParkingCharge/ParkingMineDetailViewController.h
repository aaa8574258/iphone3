//
//  ParkingMineDetailViewController.h
//  360du
//
//  Created by linghang on 16/1/8.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
@class ParkingQueryModel;
@interface ParkingMineDetailViewController : BaseViewController
- (id)initWithModel:(ParkingQueryModel *)model;
//返回付钱的参数
- (void)getPayMoneyTime:(NSInteger)payTime andPayTimeType:(NSString *)payTimeType andOrderId:(NSString *)orderId andCarName:(NSString *)carName andCarAddress:(NSString *)carAddress andPayMoney:(NSString *)money andPayType:(NSInteger)payType;
@end
