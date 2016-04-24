//
//  GroupRobGoodsViewController.h
//  360du
//
//  Created by linghang on 15/12/24.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
@class GroupPurchaseModel;
@interface GroupRobGoodsViewController : BaseViewController
- (id)initWithModel:(GroupPurchaseModel *)model;
//1,为确定，0为取消
- (void)cancelOrNot:(NSInteger)cancelOrConfirm andArr:(NSArray *)infoArr;
@end
