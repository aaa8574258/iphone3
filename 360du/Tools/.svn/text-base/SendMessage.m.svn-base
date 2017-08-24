//
//  SendMessage.m
//  360du
//
//  Created by 利美 on 16/5/16.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "SendMessage.h"

@implementation SendMessage




static SendMessage * _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}


-(id) init
{
    if (self = [super init]) {
        self.singleValue = [[NSString alloc] init];
        self.singleCode = [[NSString alloc] init];
        self.did = [[NSString alloc] init];
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}



@end
