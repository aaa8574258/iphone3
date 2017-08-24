//
//  PublishTwoModel.m
//  360du
//
//  Created by 利美 on 16/4/26.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "PublishTwoModel.h"

@implementation PublishTwoModel
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.pid forKey:@"pid"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.pid = [aDecoder decodeObjectForKey:@"pid"];
    }
    return self;
}
@end
