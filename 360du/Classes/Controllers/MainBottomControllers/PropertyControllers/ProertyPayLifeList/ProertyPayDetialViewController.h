//
//  ProertyPayDetialViewController.h
//  360du
//
//  Created by 利美 on 16/10/23.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "ProertyPayModel.h"
@interface ProertyPayDetialViewController : BaseViewController
@property (nonatomic ,strong) ProertyPayModel *model;
@property (nonatomic ,copy) NSString *tag;
@property (nonatomic ,copy) NSString *wxTag,*zfbTag;
@end
