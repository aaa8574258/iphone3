//
//  CWHDetialModel.h
//  360du
//
//  Created by 利美 on 16/9/23.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface CWHDetialModel : BaseModel

@property (nonatomic ,copy) NSString *Name;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *did;
@property (nonatomic ,copy) NSString *marketPrice;
@property (nonatomic ,copy) NSString *orderId;
@property (nonatomic ,copy) NSString *orderTime;
@property (nonatomic ,copy) NSString *payMoney;
@property (nonatomic ,copy) NSString *payStatus;
@property (nonatomic ,copy) NSString *payStatusName;
@property (nonatomic ,copy) NSString *phone;
@property (nonatomic ,copy) NSString *price;
@property (nonatomic ,copy) NSString *sendPrice;
@property (nonatomic ,copy) NSString *sex;
@property (nonatomic ,copy) NSString *shopName;
@property (nonatomic ,copy) NSString *shopType;
@property (nonatomic ,copy) NSString *status;
@property (nonatomic ,copy) NSString *statusName;
@property (nonatomic ,copy) NSString *youhuiMoney;
@property (nonatomic ,strong) NSArray *itemArray;


@property (nonatomic ,copy) NSString *beforePrice;
@property (nonatomic ,copy) NSString *cpid;
@property (nonatomic ,copy) NSString *proCount;
@property (nonatomic ,copy) NSString *proId;
@property (nonatomic ,copy) NSString *proName;
@property (nonatomic ,copy) NSString *proPic;
@property (nonatomic ,copy) NSString *proPrice;


@end
