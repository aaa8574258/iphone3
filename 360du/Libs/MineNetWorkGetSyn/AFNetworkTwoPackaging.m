//
//  AFNetworkTwoPackaging.m
//  XiaomiIOs
//
//  Created by linghang on 15-4-2.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "AFNetworkTwoPackaging.h"
#import "StoreageMessage.h"
@implementation AFNetworkTwoPackaging
-(void)getUrl:(NSString *)url andFinishBlock:(GetBlock)getBlock{
    [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

    self.getBlock = getBlock;
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
    manger.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    //NSString *url = [NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,22];
    // manger.operationQueue addOperation:<#(NSOperation *)#>
    [manger GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

#warning message responseObject
      // NSLog(@"%@",str);
        NSData *backData = [str dataUsingEncoding:NSUTF8StringEncoding];
        id temp = [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableLeaves error:nil];
#warning message responseObject
        //NSLog(@"%@",temp);
        if (self.getBlock) {
            self.getBlock(temp);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //[[NSURLCache sharedURLCache] removeAllCachedResponses];
        NSLog(@"%@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return ;
    }];
    
    
}
-(void)postUrl:(NSString *)url andKeyArr:(NSArray *)keyArrAndValueArr andFinishedBlock:(PostBlock)postBlock{
    self.postBlock = postBlock;
    [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manger POST:url parameters:keyArrAndValueArr success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *backData = [str dataUsingEncoding:NSUTF8StringEncoding];
        id temp = [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableLeaves error:nil];
        if (self.postBlock) {
            self.postBlock(temp);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",[error description]);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return ;
    }];
}

@end
