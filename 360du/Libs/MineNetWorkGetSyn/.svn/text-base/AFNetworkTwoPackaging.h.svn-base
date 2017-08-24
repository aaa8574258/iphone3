//
//  AFNetworkTwoPackaging.h
//  XiaomiIOs
//
//  Created by linghang on 15-4-2.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^GetBlock) (id getResult);
typedef void(^PostBlock) (id postResult);
@interface AFNetworkTwoPackaging : NSObject
@property(nonatomic,copy)GetBlock getBlock;
@property(nonatomic,copy)PostBlock postBlock;
-(void)getUrl:(NSString *)url andFinishBlock:(GetBlock)getBlock;
-(void)postUrl:(NSString *)url andKeyArr:(NSArray *)keyArrAndValueArr andFinishedBlock:(PostBlock)postBlock;
@end
