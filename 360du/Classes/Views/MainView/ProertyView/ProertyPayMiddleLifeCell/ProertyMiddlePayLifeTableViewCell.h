//
//  ProertyMiddlePayLifeTableViewCell.h
//  360du
//
//  Created by linghang on 15/11/27.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
@class ProertyMiddlePayAddressListModel;
@interface ProertyMiddlePayLifeTableViewCell : BaseTableViewCell
-(void)refreshModel:(ProertyMiddlePayAddressListModel *)model andRow:(NSInteger)row;

@end
