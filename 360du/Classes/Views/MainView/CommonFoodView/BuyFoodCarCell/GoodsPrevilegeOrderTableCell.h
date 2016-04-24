//
//  GoodsPrevilegeOrderTableCell.h
//  360du
//
//  Created by linghang on 15/12/22.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
@class MinePrivilageModel;
@interface GoodsPrevilegeOrderTableCell : BaseTableViewCell
@property(nonatomic,strong)MinePrivilageModel *model;
@property(nonatomic,copy)NSString *userStatus;
@end
