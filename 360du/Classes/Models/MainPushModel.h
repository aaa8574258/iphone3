//
//  MainPushModel.h
//  360du
//
//  Created by 利美 on 16/10/31.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface MainPushModel : BaseModel
@property (nonatomic ,copy) NSString *actionType;
@property (nonatomic ,copy) NSString *arid;
@property (nonatomic ,copy) NSString *goodsName;
@property (nonatomic ,copy) NSString *goodsPrice;
@property (nonatomic ,copy) NSString *controller;
@property (nonatomic ,strong) NSArray *params;
@property (nonatomic ,copy) NSString *picturePath;

@end
