//
//  AutoRobOrderCell.h
//  360du
//
//  Created by linghang on 15/8/15.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
@class AutoRobModel;
@interface AutoRobOrderCell : BaseTableViewCell
- (void)refeshModel:(AutoRobModel *)model andSection:(NSInteger)section;
@end
