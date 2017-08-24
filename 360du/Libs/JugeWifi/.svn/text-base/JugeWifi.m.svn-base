//
//  JugeWifi.m
//  XiaomiIOs
//
//  Created by linghang on 15-3-3.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "JugeWifi.h"

@implementation JugeWifi
+(NSString *)jugeWiFi{
    NSString *temp = nil;;
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            temp = @"0";
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            temp = @"2";
            // NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            temp = @"1";
            //NSLog(@"3G");
            break;
    }
    
    return temp;
}
@end
