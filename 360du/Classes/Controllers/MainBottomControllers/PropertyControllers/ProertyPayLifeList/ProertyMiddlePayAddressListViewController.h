//
//  ProertyMiddlePayAddressListViewController.h
//  360du
//
//  Created by linghang on 15/11/27.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "BaseViewController.h"

@interface ProertyMiddlePayAddressListViewController : BaseViewController
@property(nonatomic,assign)id target;
- (id)initWithAddressListArr:(NSArray *)addressListArr;
-(void)returnRow:(NSInteger)row;//点击第几个，返回
- (void)addAddress;//添加地址
@end
