//
//  PrivilegeCenterModel.h
//  360du
//
//  Created by linghang on 15/12/9.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface PrivilegeCenterModel : BaseModel
@property(nonatomic,copy)NSString *pcid;
@property(nonatomic,copy)NSString *yhName;
@property(nonatomic,copy)NSString *haveGeted;
@property(nonatomic,copy)NSString *photo;
@property(nonatomic,copy)NSString *ysMoney;
@property(nonatomic,copy)NSString *startMoney;
@property(nonatomic,copy)NSString *userScope;
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *endTime;
@end
