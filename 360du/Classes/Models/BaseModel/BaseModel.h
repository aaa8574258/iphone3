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
@property(nonatomic,copy)NSString *rule1;
-(id)initWithDictionary:(NSDictionary *)dict;



-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
