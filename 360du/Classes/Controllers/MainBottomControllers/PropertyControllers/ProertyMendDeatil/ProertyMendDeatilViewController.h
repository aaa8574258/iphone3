//
//  ProertyMendDeatilViewController.h
//  360du
//
//  Created by linghang on 15/11/18.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "BaseViewController.h"

@interface ProertyMendDeatilViewController : BaseViewController
- (id)initWithProertyMendId:(NSString *)proertyMendId;
@property (nonatomic ,assign) id target;
@property(nonatomic ,strong) NSMutableArray *array;
@property (nonatomic ,copy) NSString *pbid;
@property (nonatomic ,copy) NSString *title1;
@end
