//
//  OrderDetialViewController.h
//  360du
//
//  Created by 利美 on 16/6/12.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "MIneGroupModel.h"
@interface OrderDetialViewController : BaseViewController
@property (nonatomic ,strong) MIneGroupModel *model;
- (instancetype)initWithModel:(MIneGroupModel *)model;
@end
