//
//  NSString+NSString.m
//  360du
//
//  Created by linghang on 15/11/27.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "NSString+NSString.h"

@implementation NSString (NSString)
//判断是不是手机号
- (BOOL)jugeTel{
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    //(13|17)[0-9]
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
//返回长度和高度，默认为屏幕宽度
- (CGSize)returnSizeFont:(CGFloat )font andWidth:(CGFloat)width{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGRect rect ;
    if (width == WIDTH_CONTENTVIEW) {
        rect = [self boundingRectWithSize:CGSizeMake(WIDTH_CONTENTVIEW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];

    }else{
        rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
 
    }
    return rect.size;
}
//判断邮箱
- (BOOL)jugeEamil{
    NSString *phoneRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    //(13|17)[0-9]
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];

}
@end
