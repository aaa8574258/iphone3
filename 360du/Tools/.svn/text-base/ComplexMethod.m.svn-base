//
//  ComplexMethod.m
//  360du
//
//  Created by linghang on 15/8/28.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ComplexMethod.h"

@implementation ComplexMethod
//返回评价每一行的高度
+ (CGFloat)returnEverRowHeightStr:(NSString *)heightStr andWith:(CGFloat)width andFont:(CGFloat)font{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGRect rect = [heightStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.height;
}
@end
