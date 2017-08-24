//
//  LoadStudyMainData.h
//  XiaomiIOs
//
//  Created by linghang on 15-3-13.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^loadDataBlock) (NSMutableArray *result);
@interface LoadStudyMainData : NSObject
@property(nonatomic,strong)dispatch_queue_t queue;
@property(nonatomic,copy)loadDataBlock loadStudyMainTableBlock;
-(void)returnLoadDataArr:(NSInteger)num andFinishedBlock:(loadDataBlock)loadBlock;
-(void)returnAllLoadDataArrFinishedBlock:(loadDataBlock)loadAllBlock;

//返回课堂笔记的内容
-(void)returnNoteDataArr:(NSArray *)noteArr andCourseId:(NSString *)courseId andFinishedBlock:(loadDataBlock)loadAllBlock;
-(void)noUse;
@end
