//
//  hy_DataDownloadTools.m
//  UILesson17_imageDownloader
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 hy. All rights reserved.
//

#import "hy_DataDownloadTools.h"

@implementation hy_DataDownloadTools
+(void)downloadDataWithURL:(NSString *)urlString andMethod:(NSString *)method andBody:(NSString *)body andBlock:(optionBlock)block{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    //有没有更好的方式 忽略大小写进行比较
//    if ([method isEqualToString:@"POST"] || [method isEqualToString:@"post"]) {
    if ([[method uppercaseString] isEqualToString:@"POST"]) {
        //这里添加POST方式需要设置的东西
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        block(data);
    }];
}

@end
