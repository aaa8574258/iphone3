//
//  FoodMerchantGoodsDeatilViewController.h
//  360du
//
//  Created by linghang on 15/9/2.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
@class FoodMerchatListItemModel;
@interface FoodMerchantGoodsDeatilViewController : BaseViewController
@property(nonatomic,copy)NSString *merchantId;
@property(nonatomic,assign)id target;
@property(nonatomic,copy)NSString *startPrice;
@property(nonatomic,copy)NSString *disPrice;
- (id)initWithItemModel:(FoodMerchatListItemModel *)model andPrudctId:(NSString *)produceId;
@end
