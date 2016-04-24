//
//  GetSynUrl.m
//  XiaomiIOs
//
//  Created by linghang on 15-3-10.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "GetSynUrl.h"

@implementation GetSynUrl
+(id )returnRequestUrl:(NSString *)url{
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
#warning message
    NSLog(@"%@",url);
    NSError *error = nil;
    NSData *backData = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:&error];
    if (error) {
#warning message
        NSLog(@"%@",error);
        return nil;
    }
    NSString *str = [[NSString alloc] initWithData:backData encoding:NSUTF8StringEncoding];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
#warning message
    if (error) {
         NSLog(@"%@",error);
        return nil;
    }
   
    return dict;
}
@end
