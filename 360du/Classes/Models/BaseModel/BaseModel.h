//
//  BaseModel.h
//  XiaomiIOs
//
//  Created by linghang on 15-3-3.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property(nonatomic,copy)NSString *descriptionComapny;
-(id)initWithDictionary:(NSDictionary *)dict;

//-(id)initWithArray:(NSArray *)arr;


-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
