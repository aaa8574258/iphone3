//
//  RentListModel.h
//  360du
//
//  Created by 利美 on 16/6/21.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface RentListModel : BaseModel
@property (nonatomic ,copy)NSString *apartment;
@property (nonatomic ,copy)NSString *distinct;//距离
@property (nonatomic ,copy)NSString *homeType;
@property (nonatomic ,copy)NSString *houseArea;
@property (nonatomic ,copy)NSString *houseId;
@property (nonatomic ,copy)NSString *houseName;
@property (nonatomic ,copy)NSString *image;
@property (nonatomic ,copy)NSString *CodeValue;
@property (nonatomic ,copy)NSString *qyName;
@property (nonatomic ,copy)NSString *rent;
@property (nonatomic ,copy)NSString *roommateType;
@property (nonatomic ,copy)NSString *xqName;
@property (nonatomic ,copy)NSString *memberId;

@end
