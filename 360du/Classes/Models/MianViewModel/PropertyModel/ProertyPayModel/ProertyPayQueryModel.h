//
//  ProertyPayQueryModel.h
//  360du
//
//  Created by linghang on 16/3/17.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface ProertyPayQueryModel : BaseModel
@property(nonatomic,copy)NSString *carid;//购物车id
@property(nonatomic,copy)NSString *houserName;// 户主姓名
@property(nonatomic,copy)NSString *cleaningFee;// 保洁费
@property(nonatomic,copy)NSString *safeFee;// 治安费
@property(nonatomic,copy)NSString *rubbishFee;// 垃圾清运费
@property(nonatomic,copy)NSString *wyFee;// 物业费
@property(nonatomic,copy)NSString *area;// 房屋面积
@property(nonatomic,copy)NSString *startDate;//缴费起始日
@property(nonatomic,copy)NSString *endDate;//缴费结束日
@property(nonatomic,copy)NSString *totalMoney;// 总金额

@property (nonatomic ,copy) NSString *resultPropor,*proportion,*coupons,*topLimit,*paid;

@end
