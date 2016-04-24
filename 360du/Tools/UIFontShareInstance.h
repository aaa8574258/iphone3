//
//  UIFontShareInstance.h
//  MBXiaoYuanProject
//
//  Created by linghang on 14-12-22.
//  Copyright (c) 2014年 linghang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFontShareInstance : NSObject
@property(nonatomic,strong)NSString *fontSize;
@property(nonatomic,assign)CGFloat width;

+(id)shareInstance;
@end
