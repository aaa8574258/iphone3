//
//  NetWork.h
//  MyAFNetwork
//
//  Created by linghang on 15-1-19.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^GetBLOCK) (id getResult);
typedef void(^PostBlock) (id postResult);
@interface NetWork : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
@property(nonatomic,copy)GetBLOCK getBlock;
@property(nonatomic,copy)PostBlock postBlock;
@property(nonatomic,strong)NSMutableData *data;
@property(nonatomic,strong)NSURLConnection *getConnection;
@property(nonatomic,strong)NSURLConnection *postConnecton;
-(void)getNSUrl:(NSString *)url andFinishedBlock:(GetBLOCK)getBlock;
-(void)postUrl:(NSString *)url andKeyArr:(NSArray *)keyArr andVauleArr:(NSArray *)valueArr andFinishedBlock:(PostBlock)postBlock;
@end
