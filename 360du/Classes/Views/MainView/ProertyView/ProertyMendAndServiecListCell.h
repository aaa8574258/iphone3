//
//  ProertyMendAndServiecListCell.h
//  360du
//
//  Created by linghang on 15/7/19.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
@class PropertyMendAndServiceListModel;
@interface ProertyMendAndServiecListCell : BaseTableViewCell

-(void)makeUI:(PropertyMendAndServiceListModel *)model andImageAndVoiceAndVideo:(NSArray *)imageAndVoiceAndVideoArr;
@end
