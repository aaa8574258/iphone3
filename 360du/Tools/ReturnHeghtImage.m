//
//  ReturnHeghtImage.m
//  MBXiaoYuanProject
//
//  Created by linghang on 15-1-27.
//  Copyright (c) 2015年 linghang. All rights reserved.
//

#import "ReturnHeghtImage.h"

@implementation ReturnHeghtImage
+(CGFloat)imageHeight:(NSInteger)height andWidth:(NSInteger)allWidth{
    
        CGFloat rate = (CGFloat)allWidth / (CGFloat)320;
        return rate * height;
}
+(CGFloat)returnNSStringHeight:(NSString *)str andFont:(NSInteger)font andWidth:(CGFloat)width{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGRect rect = [str boundingRectWithSize: CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}
@end
