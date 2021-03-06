//
//  TranlateTime.m
//  MBXiaoYuanProject
//
//  Created by linghang on 15-1-21.
//  Copyright (c) 2015年 linghang. All rights reserved.
//

#import "TranlateTime.h"

@implementation TranlateTime
+(NSString *)tranlayeTime:(NSString *)time{
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:time.floatValue];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *formater  = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString *formatDate = [formater stringFromDate:localeDate];
    return formatDate;
}
+(NSString *)returnNowYear{
    NSDate *date1 = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *formatDate = [formatter stringFromDate:date1];
    return formatDate;
}
+(NSString *)tranlayeNewStyleTime:(NSString *)time{
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:time.floatValue];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *formater  = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yy/MM/dd"];
    NSString *formatDate = [formater stringFromDate:localeDate];
    return formatDate;
}
+(NSString *)tranlayeYearMothDateTime:(NSString *)time{
    NSDate *todayDate = [NSDate date];
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:time.floatValue];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *formater  = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyMMdd"];
    NSString *formatDate = [formater stringFromDate:localeDate];
    NSString *formatTodayDate = [formater stringFromDate:todayDate];
    if (formatDate.integerValue > formatTodayDate.integerValue) {
        return @"1";
    }
    return @"0";
}
+(NSString *)jugeCourseIsOnCourseStartDate:(NSString *)startDate andEndDate:(NSString *)endDate{
    if ([[TranlateTime tranlayeNewStyleTime:startDate] isEqualToString:@"0"]) {
        if ([[TranlateTime tranlayeNewStyleTime:endDate] isEqualToString:@"0"]) {
            return @"2";
        }
        return @"1";
    }
    return @"0";
}
//返回时分秒
+(NSString *)returnImageNameDate{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *formater  = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyMMddHHmmss"];
    NSString *formatDate = [formater stringFromDate:todayDate];
//    NSLog(@"%@",formatDate);
    return formatDate;
}
//获取当前时间戳
+(NSString *)gainTimeStamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)a];
    return timeString;
}
//把当前时间转为yy/MM/dd格式
+(NSString *)tranlateTimeYYMMDD{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *formater  = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy/MM/dd/HH/mm/ss"];
    NSString *formatDate = [formater stringFromDate:todayDate];
//    NSLog(@"%@",formatDate);
    return formatDate;
}
//返回小时和分钟
+(NSString *)returnHourAndMinuate{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *formater  = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"HH:mm"];
    NSString *formatDate = [formater stringFromDate:todayDate];
//    NSLog(@"%@",formatDate);
    return formatDate;
}
//返回时间戳
+ (NSString *)returnTimeStamp:(NSString *)time{
//    NSDate *dateNoew = [NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:time];
//    NSDate *localDate = [dateNoew dateByAddingTimeInterval:interval];
//    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localDate timeIntervalSince1970]];
//    NSString *nowTime = [NSString stringWithFormat:@"%ld",(long)[dateNoew timeIntervalSince1970]];
//
//    return [NSString stringWithFormat:@"%ld", (timeSp.integerValue - nowTime.integerValue)];
    
    
//    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    
//    NSInteger interval = [zone secondsFromGMTForDate:datenow];
//    
//    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
//    
//    
    
    NSString* timeStr = time;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //[formatter setTimeZone:];
    
    NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
    
    NSDate *datenow1 = [NSDate date];//现在时间,你可以输出来看下是什么格式
   // NSString *str1  = [formatter stringFromDate:datenow1];
   // NSString *nowtimeStr = [formatter stringFromDate:date];//----------将nsdate按formatter格式转成nsstring
   // 时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSString *nowTimeSp = [NSString stringWithFormat:@"%ld", (long)[datenow1 timeIntervalSince1970]];

//    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    return [NSString stringWithFormat:@"%ld",(timeSp.integerValue - nowTimeSp.integerValue)];
}
@end
