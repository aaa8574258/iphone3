//
//  AddrModel.m
//  360du
//
//  Created by 利美 on 16/4/25.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "AddrModel.h"

@implementation AddrModel

#pragma mark 实现协议里的两个方法
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.code forKey:@"code"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
    }
    return self;
}

@end
