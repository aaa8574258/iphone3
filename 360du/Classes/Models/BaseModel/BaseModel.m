//
//  BaseModel.m
//  XiaomiIOs
//
//  Created by linghang on 15-3-3.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

//-(id)initWithArray:(NSArray *)arr{
//    self = [super init];
//    if (self) {
//        for (int i = 0; i < arr.count; i++) {
//            self
//        }
//    }
//    return self;
//}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.descriptionComapny = key;
    }

//    NSLog(@"%@",key);
    
}


@end
