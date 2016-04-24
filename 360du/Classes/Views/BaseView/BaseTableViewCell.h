//
//  BaseTableViewCell.h
//  XiaomiIOs
//
//  Created by linghang on 15-3-27.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
@property(nonatomic,assign)id target;
@property(nonatomic,assign)CGFloat numSingleVersion;
@property(nonatomic,assign)CGFloat allWidth;
@end
