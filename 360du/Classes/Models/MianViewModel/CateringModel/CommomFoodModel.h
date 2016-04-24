//
//  CommomFoodModel.h
//  360du
//
//  Created by linghang on 15-4-18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface CommomFoodModel : BaseModel
//@property(nonatomic,copy)NSString *did;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *indeximg;
@property(nonatomic,copy)NSString *evaluate;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *sendCount;
@property(nonatomic,copy)NSString *startSendPrice;
@property(nonatomic,copy)NSString *sendPrice;
@property(nonatomic,strong)NSArray *yhdetail;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,assign)BOOL isFu;
@property(nonatomic,assign)BOOL isFa;
@property(nonatomic,assign)BOOL peisong;
@property(nonatomic,copy)NSString *xqid;
@property(nonatomic,copy)NSString *did;
@property(nonatomic,copy)NSString *soldcount;
//@property(nonatomic,copy)NSString *xqid;
@end
@interface CommomDetailFoodModel : BaseModel
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *yhrul;
@end
