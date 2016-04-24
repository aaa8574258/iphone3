//
//  LoadStudyMainData.m
//  XiaomiIOs
//
//  Created by linghang on 15-3-13.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "LoadStudyMainData.h"
#import "GetSynUrl.h"
//#import "StudyMianModel.h"
#import "StoreageMessage.h"
#import "FileOperation.h"
//#import "StudyChapterModel.h"
@implementation LoadStudyMainData
//加载某一个table的页面时
-(void)returnLoadDataArr:(NSInteger)num andFinishedBlock:(loadDataBlock)loadBlock{
//    NSString *username = nil;
//    NSString *password = nil;
//    NSString *token = nil;
//    if ([StoreageMessage isStoreMessage]) {
//        username = [StoreageMessage getMessage][0];
//        token = [StoreageMessage getMessage][2];
//    }else{
//       username = @"";
//        password = @"";
//    }
//    self.loadStudyMainTableBlock = loadBlock;
//    self.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//    NSMutableArray *waitAndNowArr = [NSMutableArray arrayWithCapacity:0];
//    NSMutableArray *waitArr = [NSMutableArray arrayWithCapacity:0];
//    NSMutableArray *nowArr = [NSMutableArray arrayWithCapacity:0];
//     NSMutableArray *historyArr = [NSMutableArray arrayWithCapacity:0];
//    NSMutableArray *courseArr = [NSMutableArray arrayWithCapacity:0];
//    
//    NSMutableArray *newArr = [NSMutableArray arrayWithCapacity:0];
//    NSMutableArray *hotArr = [NSMutableArray arrayWithCapacity:0];
//    NSMutableArray *recomendArr = [NSMutableArray arrayWithCapacity:0];
//    //存已学和正在审核的课程
//    NSMutableArray *storeArr = [NSMutableArray arrayWithCapacity:0];
//   __block NSArray *storeNowArr = nil;
//    __block NSArray *storeFinishedArr = nil;
//    switch (num) {
//        case 0:{
//#warning message 以下为正在学课程和正在审核课程
//            dispatch_group_async(group, self.queue, ^{
//                NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_NOW,username,token]];
//                storeNowArr = array;
//                if (array == nil) {
//                    [nowArr addObject:@""];
//                }else{
//                    for (NSDictionary *dict in array) {
//                        StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
//                        [nowArr addObject:model];
//                    }
//                }
//            });
//            dispatch_group_async(group, self.queue, ^{
//                NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_WAIT,username,token]];
//                storeFinishedArr = array;
//                if (array == nil) {
//                    [waitArr addObject:@""];
//                }else{
//                    for (NSDictionary *dict in array) {
//                        StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
//                        [waitArr addObject:model];
//                    }
//                }
//            });
//            break;
//        }
//        case 1:{
//#warning message 以下为已学课程
//           
//            dispatch_group_async(group, self.queue, ^{
//                NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_HOSTORY,[StoreageMessage getMessage][0],[StoreageMessage getMessage][2]]];
//                if (array == nil) {
//                    [historyArr addObject:@""];
//                }else{
//                    for (NSDictionary *dict in array) {
//                        StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
//                        [historyArr addObject:model];
//                    }
//                }
//            });
//#warning message 以上为已学课程
//            break;
//        }
//        case 2:{
//#warning message 以下为库内课程
//            
//            //最新课程
//            dispatch_group_async(group, self.queue, ^{
//                NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_NEW,2]];
//                
//                if (array == nil) {
//                    [newArr addObject:@""];
//                }else{
//                    for (NSDictionary *dict in array) {
//                        StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
//                        [newArr addObject:model];
//                    }
//                   
//                }
//            });
//            //最热课程
//            dispatch_group_async(group, self.queue, ^{
//                NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_HOT,1,2]];
//                
//                if (array == nil) {
//                    [hotArr addObject:@""];
//                }else{
//                    for (NSDictionary *dict in array) {
//                        StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
//                        [hotArr addObject:model];
//                    }
//                   
//                }
//            });
//            //推荐课程
//            dispatch_group_async(group, self.queue, ^{
//                NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_RECOMEND,1,2]];
//                
//                if (array == nil) {
//                    [recomendArr addObject:@""];
//                }else{
//                    for (NSDictionary *dict in array) {
//                        StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
//                        [recomendArr addObject:model];
//                    }
//                    
//                }
//            });
//#warning message 以上为库内课程
//            break;
//        }
//        default:
//            break;
//    }
//    NSMutableArray *array = nil;
//    dispatch_group_notify(group, self.queue, ^{
//        switch (num) {
//            case 0:{
//                
//                if (self.loadStudyMainTableBlock) {
//                    for (id temp in storeNowArr) {
//                        [storeArr addObject:temp];
//                    }
//                    for (id temp in storeFinishedArr) {
//                        [storeArr addObject:temp];
//                    }
//                    [FileOperation clearFile:@"FinishedStudy" andPath:@"Study"];
//                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:storeArr];
//#warning message data
//                    NSLog(@"%@",data);
//                    [FileOperation storeDataFile:@"FinishedStudy" andPath:@"Study" andFileData:data];
//                    
//                    NSMutableArray *nowAndHistoryArr = [NSMutableArray arrayWithCapacity:0];
//                    for (id temp in nowArr) {
//                        [nowAndHistoryArr addObject:temp];
//                    }
//                    for (id temp in waitArr) {
//                        [nowAndHistoryArr addObject:temp];
//                    }
//                    self.loadStudyMainTableBlock(nowAndHistoryArr);
//                }
//                
//                break;
//            }
//            case 1:{
//                if (self.loadStudyMainTableBlock) {
//                    self.loadStudyMainTableBlock(historyArr);
//                }
//                break;
//            }
//            case 2:{
//                if (self.loadStudyMainTableBlock) {
//                     [courseArr addObject:hotArr];
//                     [courseArr addObject:newArr];
//                    [courseArr addObject:recomendArr];
//                    self.loadStudyMainTableBlock(courseArr);
//                }
//                break;
//            }
//            default:
//                break;
//        }
//    });
//}
////加载所有数据时
//-(void)returnAllLoadDataArrFinishedBlock:(loadDataBlock)loadAllBlock{
//    self.loadStudyMainTableBlock = loadAllBlock;
//    self.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//    NSMutableArray *waitAndNowArr = [NSMutableArray arrayWithCapacity:0];
//    NSMutableArray *waitArr = [NSMutableArray arrayWithCapacity:0];
//    NSMutableArray *nowArr = [NSMutableArray arrayWithCapacity:0];
//    NSMutableArray *historyArr = [NSMutableArray arrayWithCapacity:0];
//    NSMutableArray *courseArr = [NSMutableArray arrayWithCapacity:0];
//#warning message 以下为正在学课程和正在审核课程
//    //存已学和正在审核的课程
//    NSMutableArray *storeArr = [NSMutableArray arrayWithCapacity:0];
//    __block NSArray *storeNowArr = nil;
//    __block NSArray *storeFinishedArr = nil;
//    dispatch_group_async(group, self.queue, ^{
//        NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_NOW,[StoreageMessage getMessage][0],[StoreageMessage getMessage][2]]];
//        storeNowArr = array;
//#warning message array
//        NSLog(@"%@",[NSString stringWithFormat:STUDY_NOW,[StoreageMessage getMessage][0],[StoreageMessage getMessage][2]]);
//        NSLog(@"%@",array);
//        if (array == nil) {
//            [nowArr addObject:@""];
//        }else{
//            for (NSDictionary *dict in array) {
//                StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
//                [nowArr addObject:model];
//            }
//
//        }
//    });
//    dispatch_group_async(group, self.queue, ^{
//        NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_WAIT,[StoreageMessage getMessage][0],[StoreageMessage getMessage][2]]];
//        storeFinishedArr = array;
//#warning message array
//        NSLog(@"%@",array);
//        if (array == nil) {
//            [waitArr addObject:@""];
//        }else{
//            for (NSDictionary *dict in array) {
//                StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
//                [waitArr addObject:model];
//            }
//
//        }
//    });
//#warning message 以下为已学课程
//    
//    dispatch_group_async(group, self.queue, ^{
//        NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_HOSTORY,[StoreageMessage getMessage][0],[StoreageMessage getMessage][2]]];
//        if (array == nil) {
//            [historyArr addObject:@""];
//        }else{
//            for (NSDictionary *dict in array) {
//                StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
//                [historyArr addObject:model];
//            }
//        }
//    });
//#warning message 以上为已学课程
//    
//    
//#warning message 以下为库内课程
//    NSMutableArray *newArr = [NSMutableArray arrayWithCapacity:0];
//     NSMutableArray *hotArr = [NSMutableArray arrayWithCapacity:0];
//    NSMutableArray *recomendArr = [NSMutableArray arrayWithCapacity:0];
//    dispatch_group_async(group, self.queue, ^{
//        NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_NEW,2]];
//        
//#warning message recomendArrUrl
//        NSLog(@"%@",[NSString stringWithFormat:STUDY_NEW,2]);
//        if (array == nil) {
//            [newArr addObject:@""];
//        }else{
//            for (NSDictionary *dict in array) {
//                StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
//                [newArr addObject:model];
//            }
//            
//#warning message newArr
//            NSLog(@"%@",newArr);
//        }
//    });
//  
//    dispatch_group_async(group, self.queue, ^{
//        NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_HOT,1,2]];
//#warning message recomendArrUrl
//        NSLog(@"%@",[NSString stringWithFormat:STUDY_HOT,1,2]);
//       
//        if (array == nil) {
//            [hotArr addObject:@""];
//        }else{
//            for (NSDictionary *dict in array) {
//                StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
//                [hotArr addObject:model];
//            }
//            
//#warning message newArr
//            NSLog(@"%@",hotArr);
//        }
//    });
//   
//    //推荐课程
//    dispatch_group_async(group, self.queue, ^{
//        NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_RECOMEND,1,2]];
//        
//#warning message recomendArrUrl
//        NSLog(@"%@",[NSString stringWithFormat:STUDY_RECOMEND,1,2]);
//        if (array == nil) {
//            [recomendArr addObject:@""];
//        }else{
//            for (NSDictionary *dict in array) {
//                StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
//                [recomendArr addObject:model];
//            }
//          
//#warning message newArr
//            NSLog(@"%@",recomendArr);
//        }
//    });
//    
//#warning message 以上为库内课程
//    
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
//    
//    dispatch_group_notify(group, self.queue, ^{
//        //储存数据
//        for (id temp in storeNowArr) {
//            [storeArr addObject:temp];
//        }
//        for (id temp in storeFinishedArr) {
//            [storeArr addObject:temp];
//        }
//        [FileOperation clearFile:@"FinishedStudy" andPath:@"Study"];
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:storeArr];
//#warning message data
//        NSLog(@"%@",data);
//        [FileOperation storeDataFile:@"FinishedStudy" andPath:@"Study" andFileData:data];
//        
//        for (id temp in nowArr) {
//            [waitAndNowArr addObject:temp];
//        }
//        for (id temp in waitArr) {
//            [waitAndNowArr addObject:temp];
//        }
//#warning message waitAndNowArr
//        NSLog(@"%lu",(unsigned long)waitAndNowArr.count);
//        [courseArr addObject:hotArr];
//        [courseArr addObject:newArr];
//        [courseArr addObject:recomendArr];
//        [array addObject:waitAndNowArr];
//        [array addObject:historyArr];
//        [array addObject:courseArr];
//        if (self.loadStudyMainTableBlock) {
//            self.loadStudyMainTableBlock(array);
//        }
//    });
//    
//    
//}
////返回课堂笔记的内容
//-(void)returnNoteDataArr:(NSArray *)noteArr andCourseId:(NSString *)courseId  andFinishedBlock:(loadDataBlock)loadAllBlock{
//    self.loadStudyMainTableBlock = loadAllBlock;
//    self.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//    NSMutableArray *allArr = [NSMutableArray arrayWithCapacity:0];
//    for (NSInteger i = 0; i < noteArr.count; i++) {
//        NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
//        for (NSInteger j = 0; j < [noteArr[i] count]; j++) {
//            StudyChapterItemModel *model = noteArr[i][j];
//            //q=get_course_item_notes&course_id=%@&mid=%@&item_id=%@&username=%@&token=%@"
//            dispatch_group_async(group, self.queue, ^{
//#warning message url
//                NSLog(@"%@",[NSString stringWithFormat:STUDY_NOTE,courseId,model.mid,model.item_id,[StoreageMessage getMessage][0],[StoreageMessage getMessage][2]]);
//                NSArray *temp = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_NOTE,courseId,model.mid,model.item_id,[StoreageMessage getMessage][0],[StoreageMessage getMessage][2]]];
//                if (temp.count == 0) {
//                    [itemArr addObject:@"0"];
//                }else{
//                    [itemArr addObject:temp];
//                }
//            });
//        }
//        [allArr addObject:itemArr];
//    }
//    dispatch_group_notify(group, self.queue, ^{
//        if (self.loadStudyMainTableBlock) {
//            self.loadStudyMainTableBlock(allArr);
//        }
//    });
}
-(void)noUse{
    //    self.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_group_t group = dispatch_group_create();
    //#warning message 以下为库内课程
    //    NSMutableArray *courseArr = [NSMutableArray arrayWithCapacity:0];
    //    //最新课程
    //    dispatch_group_async(group, self.queue, ^{
    //        NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_NEW,2]];
    //        NSMutableArray *newArr = [NSMutableArray arrayWithCapacity:0];
    //        if (array == nil) {
    //            [newArr addObject:@""];
    //        }else{
    //            for (NSDictionary *dict in array) {
    //                StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
    //                [newArr addObject:model];
    //            }
    //            [courseArr addObject:newArr];
    //        }
    //    });
    //    //最热课程
    //    dispatch_group_async(group, self.queue, ^{
    //        NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_HOT,1,2]];
    //        NSMutableArray *hotArr = [NSMutableArray arrayWithCapacity:0];
    //        if (array == nil) {
    //            [hotArr addObject:@""];
    //        }else{
    //            for (NSDictionary *dict in array) {
    //                StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
    //                [hotArr addObject:model];
    //            }
    //            [courseArr addObject:hotArr];
    //        }
    //    });
    //    //推荐课程
    //    dispatch_group_async(group, self.queue, ^{
    //        NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_RECOMEND,1,2]];
    //        NSMutableArray *recomendArr = [NSMutableArray arrayWithCapacity:0];
    //        if (array == nil) {
    //            [recomendArr addObject:@""];
    //        }else{
    //            for (NSDictionary *dict in array) {
    //                StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
    //                [recomendArr addObject:model];
    //            }
    //            [courseArr addObject:recomendArr];
    //        }
    //    });
    //#warning message 以上为库内课程
    //
    //#warning message 以下为已学课程
    //    NSMutableArray *historyArr = [NSMutableArray arrayWithCapacity:0];
    //    dispatch_group_async(group, self.queue, ^{
    //        NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_HOSTORY,@"even",@"4425862c2fa481bf9f8385e322d8a7dd"]];
    //        if (array == nil) {
    //            [historyArr addObject:@""];
    //        }else{
    //            for (NSDictionary *dict in array) {
    //                StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
    //                [historyArr addObject:model];
    //            }
    //        }
    //    });
    //#warning message 以上为已学课程
    //
    //#warning message 以下为正在学课程和正在审核课程
    //    NSMutableArray *waitAndNowArr = [NSMutableArray arrayWithCapacity:0];
    //    NSMutableArray *waitArr = [NSMutableArray arrayWithCapacity:0];
    //    NSMutableArray *nowArr = [NSMutableArray arrayWithCapacity:0];
    //    dispatch_group_async(group, self.queue, ^{
    //        NSArray *array = [GetSynUrl returnRequestUrl:[NSString stringWithFormat:STUDY_NOW,@"even",@"4425862c2fa481bf9f8385e322d8a7dd"]];
    //        if (array == nil) {
    //            [nowArr addObject:@""];
    //        }else{
    //            for (NSDictionary *dict in array) {
    //                StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:dict];
    //                [nowArr addObject:model];
    //            }
    //        }
    //    });
    //#warning message 以上为正在学课程
    //    dispatch_group_notify(group, self.queue, ^{
    //        [self.collectionView headerEndRefreshing];
    //        [self.allDataArr addObject:nowArr];
    //        [self.allDataArr addObject:historyArr];
    //        [self.allDataArr addObject:courseArr];
    //        [self.collectionView reloadData];
    //    });
}
@end
