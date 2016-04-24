//
//  FoodEverDeatilModel.h
//  360du
//
//  Created by linghang on 15/7/4.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface FoodEverDeatilModel : BaseModel
@property(nonatomic,copy)NSString *pid;
@property(nonatomic,copy)NSString *imgurl;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *sendCount;
@property(nonatomic,copy)NSString *tuijianCount;
@property(nonatomic,copy)NSString *inventory;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,strong)NSArray *rule;
@end
