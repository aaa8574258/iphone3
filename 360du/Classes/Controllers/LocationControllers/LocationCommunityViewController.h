//
//  LocationCommunityViewController.h
//  360du
//
//  Created by linghang on 15-4-11.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
@class SelectCityModel;
@interface LocationCommunityViewController : BaseViewController
@property(nonatomic,assign)id target;
//返回城市名称
-(void) returnCityName:(SelectCityModel *)cityModel;
@end
