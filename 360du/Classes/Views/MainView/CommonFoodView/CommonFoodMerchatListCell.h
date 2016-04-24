//
//  CommonFoodMerchatListCell.h
//  360du
//
//  Created by linghang on 15/5/16.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
@class FoodMerchatListItemModel;
@interface CommonFoodMerchatListCell : BaseTableViewCell
-(void)refeshModel:(FoodMerchatListItemModel *)model andNum:(NSInteger)num andSection:(NSInteger)section;
@end
