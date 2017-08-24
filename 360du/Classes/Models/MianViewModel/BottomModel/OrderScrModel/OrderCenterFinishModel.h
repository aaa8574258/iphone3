//
//  OrderCenterFinishModel.h
//  360du
//
//  Created by linghang on 15/8/14.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface OrderCenterFinishModel : BaseModel
@property(nonatomic,copy)NSString *businessAddress;
@property(nonatomic,copy)NSString *consignee;
@property(nonatomic,copy)NSString *expressId;
@property(nonatomic,copy)NSString *goalAddress;
@property(nonatomic,copy)NSString *isSendedName;
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *totalPrice;
@property(nonatomic,copy)NSString *sendStatus,*sendStatusName;
@end
