//
//  NetWork.m
//  MyAFNetwork
//
//  Created by linghang on 15-1-19.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "NetWork.h"
@implementation NetWork

-(void)getNSUrl:(NSString *)url andFinishedBlock:(GetBLOCK)getBlock{
    self.getBlock = getBlock;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReturnCacheDataElseLoad  timeoutInterval:10];
    self.getConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    [self.getConnection start];
}
-(void)postUrl:(NSString *)url andKeyArr:(NSArray *)keyArr andVauleArr:(NSArray *)valueArr andFinishedBlock:(PostBlock)postBlock{
    self.postBlock = postBlock;
    NSMutableString *paStr = [NSMutableString stringWithCapacity:0];
    for (NSInteger i = 0; i < keyArr.count; i++) {
        [paStr appendFormat:@"%@=%@",keyArr[i],valueArr[i]];
        if (i < keyArr.count - 1) {
            [paStr appendString:@"&"];
        }
    }
    NSData *paData = [paStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
    [req setHTTPBody:paData];
    [req setHTTPMethod:@"POST"];
    self.postConnecton = [NSURLConnection connectionWithRequest:req delegate:self];
    [self.postConnecton start];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
    if (self.getConnection == connection) {
        self.getBlock(nil);
    }else{
        self.postBlock(nil);
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    if (!self.data) {
        self.data = [NSMutableData dataWithCapacity:0];
    }
    else{
        [self.data resetBytesInRange:NSMakeRange(0, self.data.length)];
        [self.data setLength:0];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.data appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    id temp = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableLeaves error:nil];
    if (connection == self.getConnection) {
        if (self.getBlock) {
            self.getBlock(temp);
             
        }
    }
    else{
        if (self.postBlock) {
            self.postBlock(temp);
        }
    }
}
@end
