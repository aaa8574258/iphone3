//
//  FoodsYHQModel.h
//  360du
//
//  Created by 利美 on 17/8/17.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface FoodsYHQModel : BaseModel
@property (nonatomic ,copy) NSString *businessName;
@property (nonatomic ,copy) NSString *endTime;
@property (nonatomic ,copy) NSString *expiredDay;
@property (nonatomic ,copy) NSString *isExpired;
@property (nonatomic ,copy) NSString *startMoney;
@property (nonatomic ,copy) NSString *startTime;
@property (nonatomic ,copy) NSString *yhCode;
@property (nonatomic ,copy) NSString *yhName;
@property (nonatomic ,copy) NSString *ysMoney;
@property (nonatomic ,copy) NSString *ysTypeName;

@end
