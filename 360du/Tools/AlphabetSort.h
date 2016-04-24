//
//  AlphabetSort.h
//  XiaomiIOs
//
//  Created by linghang on 15-3-31.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlphabetSort : NSObject
//返回排好序的数组
+(NSArray *)returnSortArr:(NSArray *)sortArr;
//返回选好城市排好序的数组
+(NSArray *)returnCitySortArr:(NSArray *)sortArr;
@end
