//
//  ProertyPayModel.h
//  360du
//
//  Created by 利美 on 16/10/21.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface ProertyPayModel : BaseModel
@property (nonatomic ,copy) NSString *beforeValue;
@property (nonatomic ,copy) NSString *endTime, *endDate;
@property (nonatomic ,copy) NSString *feeTypeName;
@property (nonatomic ,copy) NSString *houseInfo;
@property (nonatomic ,copy) NSString *nowValue;
@property (nonatomic ,copy) NSString *payStatus;
@property (nonatomic ,copy) NSString *preid;
@property (nonatomic ,copy) NSString *startTime;
@property (nonatomic ,copy) NSString *totalMoney;
@property (nonatomic ,copy) NSString *unitPrice;
@property (nonatomic ,copy) NSString *userName;
@property (nonatomic ,copy) NSString *wyName;
@property (nonatomic ,copy) NSString* xqName;
@property (nonatomic ,copy) NSString *xqname;

@property (nonatomic ,copy) NSString *fee,*fee_name;
@property (nonatomic ,copy) NSArray  *payItem;
@property (nonatomic ,copy) NSString *thirdPayNo;
@property (nonatomic ,copy) NSString *paytime;
@property (nonatomic ,copy) NSString *payerPhone;
@property (nonatomic ,copy) NSString *payAccount;
@property (nonatomic ,copy) NSString *payMoney;
@property (nonatomic ,copy) NSString *wyfId,*qnfId,*wyid ,*ThirdPaymentID ,*tcfId;
@property (nonatomic ,copy) NSString *phone,*payTime;

@property (nonatomic ,copy) NSString *parkingNo;
@property (nonatomic ,copy) NSString *carNo;
@property (nonatomic ,copy) NSString *freeDays;
@property (nonatomic ,copy) NSString *breachPercentage;
@property (nonatomic ,copy) NSString *startDate;
@property (nonatomic ,copy) NSString *breachMoney ,* real_pay;

@property (nonatomic ,copy) NSString *prompt,*promptTime;

@property (nonatomic ,copy) NSString *resultPropor,*proportion,*coupons,*topLimit,*paid;




@end
