//
//  OrderCenterFinishAndUnFinishCell.h
//  360du
//
//  Created by linghang on 15/8/14.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
@class OrderCenterFinishModel;
@interface OrderCenterFinishAndUnFinishCell : BaseTableViewCell
//@property (nonatomic ,assign) id target;
@property(nonatomic,strong)UIButton *statusBtn;//状态按钮

- (void)refreshUI:(OrderCenterFinishModel *)model andRow:(NSInteger)row andSection:(NSInteger)section;
@end
