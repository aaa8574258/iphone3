//
//  CWHOrderDetialViewController.h
//  360du
//
//  Created by 利美 on 16/9/23.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseViewController.h"

@interface CWHOrderDetialViewController : BaseViewController
@property (nonatomic ,copy) NSString *orderId;
- (instancetype)initWithOrderId:(NSString *)orderId;

@end
