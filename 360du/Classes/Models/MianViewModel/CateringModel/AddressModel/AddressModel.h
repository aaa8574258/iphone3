//
//  AddressModel.h
//  360du
//
//  Created by linghang on 15/11/14.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *isDefault;
@property(nonatomic,copy)NSString *memberID;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *xqLocation;
@property(nonatomic,copy)NSString *xqName;

@end
