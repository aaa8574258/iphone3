//
//  AlphabetSort.m
//  XiaomiIOs
//
//  Created by linghang on 15-3-31.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "AlphabetSort.h"
#import "LocationModel.h"
#import "SelectCityModel.h"
@implementation AlphabetSort
+(NSArray *)returnSortArr:(NSArray *)sortArr{
    NSMutableArray *alapterArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 'A'; i < 'Z' + 1; i++) {
        [alapterArr addObject:[NSString stringWithFormat:@"%c",i]];
    }
    NSMutableArray *allArr = [NSMutableArray arrayWithCapacity:0];
    
    for(NSInteger i = 0;i < 26;i++){
       // Register1Model *model = sortArr[i];
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger j = 0; j < sortArr.count; j++) {
            LocationModel *model = sortArr[j];
            if ([[[model.pyname uppercaseString] substringToIndex:1] isEqualToString:alapterArr[i]] || [[[model.pyname lowercaseString] substringToIndex:1] isEqualToString:alapterArr[i]]) {
                [tempArr addObject:model];
                
            }
        }
        [allArr addObject:tempArr];
    }
    return allArr;
    
}
//返回选好城市排好序的数组
+(NSArray *)returnCitySortArr:(NSArray *)sortArr{
    NSMutableArray *alapterArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 'A'; i < 'Z' + 1; i++) {
        [alapterArr addObject:[NSString stringWithFormat:@"%c",i]];
    }
    NSMutableArray *allArr = [NSMutableArray arrayWithCapacity:0];
    
    for(NSInteger i = 0;i < 26;i++){
        // Register1Model *model = sortArr[i];
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger j = 0; j < sortArr.count; j++) {
            SelectCityModel *model = sortArr[j];
            if ([[[model.pyname uppercaseString] substringToIndex:1] isEqualToString:alapterArr[i]] || [[[model.pyname lowercaseString] substringToIndex:1] isEqualToString:alapterArr[i]]) {
                [tempArr addObject:model];
                
            }
        }
        [allArr addObject:tempArr];
    }
    return allArr;

}
@end
