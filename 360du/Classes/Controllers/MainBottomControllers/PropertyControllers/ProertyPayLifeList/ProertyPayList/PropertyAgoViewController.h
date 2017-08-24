//
//  PropertyAgoViewController.h
//  360du
//
//  Created by 利美 on 16/6/12.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "ProertyMiddlePayAddressListModel.h"
@interface PropertyAgoViewController : BaseViewController
- (void)gainDefaultAddress:(ProertyMiddlePayAddressListModel *)model;
@property (nonatomic ,strong) ProertyMiddlePayAddressListModel *model;
@end
