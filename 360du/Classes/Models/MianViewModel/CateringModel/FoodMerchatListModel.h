//
//  FoodMerchatListModel.h
//  360du
//
//  Created by linghang on 15/5/16.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface FoodMerchatListModel : BaseModel
@property(nonatomic,copy)NSString *cid;
@property(nonatomic,copy)NSString *catalog;
@property(nonatomic,strong)NSArray *item;
@end

@interface FoodMerchatListItemModel : BaseModel
@property(nonatomic,copy)NSString *pid ,*detailDesc;
@property(nonatomic,copy)NSString *indeximg;
@property(nonatomic,copy)NSString *requrl;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *sendCount;
@property(nonatomic,copy)NSString *tuijianCount;
@property(nonatomic,copy)NSNumber *price,*unitPrice;
@property(nonatomic,copy)NSString *typeCount;
@property(nonatomic,copy)NSString *imgurl;
@property(nonatomic,copy)NSString *inventory;
@property(nonatomic,strong)NSArray *rule;
@property(nonatomic,copy)NSString *buyCount;
@property (nonatomic ,copy) NSString *goodsNum;

@end
