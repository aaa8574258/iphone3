//
//  UIFontShareInstance.m
//  MBXiaoYuanProject
//
//  Created by linghang on 14-12-22.
//  Copyright (c) 2014年 linghang. All rights reserved.
//

#import "UIFontShareInstance.h"
static UIFontShareInstance *fontShare;

@implementation UIFontShareInstance
+(id)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fontShare = [[UIFontShareInstance alloc] init];
        //mbpHUD = [[MBProgressHUD alloc] initWithView:self];
    });
    return fontShare;
}


@end
