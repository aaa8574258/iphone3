//
//  UniversalViewController.h
//  360du
//
//  Created by 利美 on 16/6/15.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "RentPublishViewController.h"
@interface UniversalViewController : BaseViewController
- (instancetype)initWithUrl:(NSString *)url;
@property (nonatomic ,strong) UITableView *tabelView;
@property (nonatomic, assign) id target;
@end
