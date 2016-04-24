//
//  MainViewLoadData.m
//  360du
//
//  Created by linghang on 15-4-11.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//
#import "MainViewLoadData.h"
#import "MainModel.h"
@implementation MainViewLoadData
+(NSArray *)returnMianData{
    NSArray *jsonArr =  @[@{@"id":@"110", @"name": @"物业",@"requrl": @"001.png",@"indeximg": @"http: //www.baidu.com/1.jpg"},@{@"id":@"110", @"name": @"外卖餐饮",@"requrl": @"002.png",@"indeximg": @"http: //www.baidu.com/1.jpg"},@{@"id":@"110", @"name": @"烟酒食品",@"requrl": @"003.png",@"indeximg": @"http: //www.baidu.com/1.jpg"},@{@"id":@"110", @"name": @"送水",@"requrl": @"004.png",@"indeximg": @"http: //www.baidu.com/1.jpg"},@{@"id":@"110", @"name": @"保姆保洁",@"requrl": @"005.png",@"indeximg": @"http: //www.baidu.com/1.jpg"},@{@"id":@"110", @"name": @"药店",@"requrl": @"006.png",@"indeximg": @"http: //www.baidu.com/1.jpg"},@{@"id":@"110", @"name": @"美容美甲",@"requrl": @"007.png",@"indeximg": @"http: //www.baidu.com/1.jpg"},@{@"id":@"110", @"name": @"洗衣",@"requrl": @"008.png",@"indeximg": @"http: //www.baidu.com/1.jpg"},@{@"id":@"110", @"name": @"二手物品",@"requrl": @"009.png",@"indeximg": @"http: //www.baidu.com/1.jpg"},@{@"id":@"110", @"name": @"传递物流",@"requrl": @"010.png",@"indeximg": @"http: //www.baidu.com/1.jpg"},@{@"id":@"110", @"name": @"粮油蔬菜",@"requrl": @"011.png",@"indeximg": @"http: //www.baidu.com/1.jpg"},@{@"id":@"110", @"name": @"水果干果",@"requrl": @"012.png",@"indeximg": @"http: //www.baidu.com/1.jpg"}];
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *temp in jsonArr) {
        MainModel *model = [[MainModel alloc] initWithDictionary:temp];
        [tempArr addObject:model];
    }
    return tempArr;
}
@end
