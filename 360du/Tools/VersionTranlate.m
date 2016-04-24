//
//  VersionTranlate.m
//  XiaomiIOs
//
//  Created by linghang on 15-3-10.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "VersionTranlate.h"
#import "UIFontShareInstance.h"
@implementation VersionTranlate

+(CGFloat)returnWidth{
    if (IPHONE5 || IPHONE4) {
        return 320 / (CGFloat)375;
    }
    else if(IPHONE6PLUS){

        return 414 / (CGFloat)375;
    }
    return 1;
}
+(CGFloat)returnHeight{
    if (IPHONE5 || IPHONE4) {
        
        return 320 / 375;
    }
    else if(IPHONE6PLUS){
        return 736 / 667;
    }
    return 1;
    
}
+(CGFloat)returnImageHeightImgname:(NSString*)stringName andWidth:(CGFloat)width {
    
    CGFloat tempHeight = 0;

    UIImage *image = [UIImage imageNamed:stringName];
    CGFloat rate = (CGFloat)width / image.size.width;
    tempHeight += image.size.height * rate;
//    CGFloat numVersion = [VersionTranlate returnWidth];
//    height += (6 + 12 + 12 + 5 + 15 + 15 + 10) * numVersion;
    return tempHeight;
}
//根据是哪一个手机，确定比例
+(CGFloat)returnIphone6PVersionRate{
    if (IPHONE5 || IPHONE4) {
        return 320 / (CGFloat)414;
    }
    else if(IPHONE6PLUS){
        
        return 375 / (CGFloat)414;
    }
    return 1;
}
//根据是iPhone5
+(CGFloat)returnIphone5AndIphone4PVersionRate{
    if (IPHONE6PLUS) {
        return 414 / 320;
    }
    else if(IPHONE6){
        return 375 / 320;
    }
    return 1;
}
//返回具体的比例
+(CGFloat)returnVersionRateAnyIphone:(NSInteger)phoneNum{
    UIFontShareInstance *shareIn = [UIFontShareInstance shareInstance];
    //CGFloat
    return shareIn.width / 375.0;
//    CGFloat numSingleVesion;
//    if (phoneNum == 6) {
//        numSingleVesion = [VersionTranlate returnWidth];
//    }else if(phoneNum == 7){
//        numSingleVesion = [VersionTranlate returnIphone6PVersionRate];
//    }else{
//        numSingleVesion = [VersionTranlate returnIphone5AndIphone4PVersionRate];
//    }
//    return numSingleVesion;
}
@end
