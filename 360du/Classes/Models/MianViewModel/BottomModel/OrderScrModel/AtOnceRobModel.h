//
//  AtOnceRobModel.h
//  360du
//
//  Created by linghang on 15/8/15.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface AtOnceRobModel : BaseModel

@end
@interface AutoRobModel : BaseModel
@property(nonatomic,copy)NSString *DID;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *shopName;
@property(nonatomic,copy)NSString *companyAddress;
//小区抢单
@property(nonatomic,copy)NSString *xqid;
@property(nonatomic,copy)NSString *xqname;
@property(nonatomic,copy)NSString *xqAddress;
@property(nonatomic,copy)NSString *sqStatusName;
@property(nonatomic,copy)NSString *sqStatus;
@end
