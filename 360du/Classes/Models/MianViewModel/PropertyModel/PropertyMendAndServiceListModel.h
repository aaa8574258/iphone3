//
//  PropertyMendAndServiceListModel.h
//  360du
//
//  Created by linghang on 15/7/19.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface PropertyMendAndServiceListModel : BaseModel
@property(nonatomic,copy)NSString *pbID;
@property(nonatomic,copy)NSString *RepairContent;
@property(nonatomic,copy)NSString *repairTime;
@property(nonatomic,copy)NSString *uuid;
//@property(nonatomic,strong)NSMutableArray *url;
@property(nonatomic,strong)NSArray *images;
@property(nonatomic,strong)NSArray *videos;
@property(nonatomic,strong)NSArray *voices;


@property (nonatomic ,copy) NSString *pbid,*repairContent,*can_accept;
@property (nonatomic ,assign) NSInteger totalRows;
@end
