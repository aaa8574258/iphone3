//
//  CommonHeader.h
//  XiaomiIOs
//
//  Created by linghang on 15-3-11.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#ifndef XiaomiIOs_CommonHeader_h
#define XiaomiIOs_CommonHeader_h
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

//请求数据
/*
_rom = [AFHTTPRequestOperationManager manager];
_rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
//NSString *url = [NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,22];
[_rom GET:[NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,1] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self.tableView headerEndRefreshing];
    if (self.num == 0) {
        [self.dataArr removeAllObjects];
        for (NSDictionary *temp in responseObject) {
            StudyMianModel *model = [[StudyMianModel alloc] initWithDictionary:temp];
            [self.dataArr addObject:model];
        }
    }
    
    
    [self.tableView reloadData];
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //[[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSLog(@"%@",[error description]);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    [alertView show];
    return ;
}];
 
 //_rom.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
 //_rom.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
 //            NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
 //#warning message
 //            NSLog(@"%@",str);
 //            NSData *backData = [str dataUsingEncoding:NSUTF8StringEncoding];
 //            NSArray *array = [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableLeaves error:nil];
 //            NSLog(@"%@",array);
 
 
 */
//转码
//[self.dataArr[1] urlEncodeString]
//储存数据
/*
(NSString *)password andToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSArray *)getMessage{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    return @[username,password,token]
 */
//随机函数
//NSLog(@"%d",arc4random() % 9);
//导航条背景图
/*
 [self setNavBarImage:@"topbg.gif"];
 [self setBackImageStateName:@"nav_back@2x.png" AndHighlightedName:@"nav_back@2x.png"];
 [self setNavTitleItemWithName:@"登陆"];
 
 
 
 */
//文件存取数据
//[FileOperation storeDataFile:@"FinishedStudy" andPath:@"Study" andFileData:data];
//读取数据
//[NSKeyedUnarchiver unarchiveObjectWithData:[FileOperation readDataFile:@"FinishedStudy" andPath:@"Study"]]
//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//NSString *cachePath = [paths objectAtIndex:0];
//self.cachePath = cachePath;
//加载图

/*
 //加载图片
-(void)makeHUd{
    self.hudProgress = [[MBProgressHUD alloc] initWithView:self.view];
    self.hudProgress.delegate = self;
    //self.hudProgress.color = [UIColor clearColor];
    self.hudProgress.labelText = @"loading";
    self.hudProgress.dimBackground = YES;
    //self.hudProgress.margin = 80.f;
    //self.hudProgress.yOffset = 150.f;
    [self.view addSubview:self.hudProgress];
    [self.hudProgress showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}
 */
/*
#pragma mark HUD的代理方法,关闭HUD时执行
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}
*/
/*
 -(void) myProgressTask{
 float progress = 0.0f;
 while (progress < 1.0f) {
 progress += 0.01f;
 self.hudProgress.progress = progress;
 usleep(50000);
 }
 
 }
 
 */
//刷新操作
//新增地址
//放在cache中address文件中
//BOOL cacheBool = [FileOperation jugeFileExist:@"address" andPath:@"address" andDocument:cache];
//if (cacheBool) {
//    NSData *data = [FileOperation readCacheDataFile:@"address" andPath:@"address" andDocument:cache];
//    NSArray *tempArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    
//}
//加载图片
//-(void)makeHUd{
//    self.hudProgress = [[MBProgressHUD alloc] initWithView:self.view];
//    self.hudProgress.delegate = self;
//    //self.hudProgress.color = [UIColor clearColor];
//    self.hudProgress.labelText = @"loading";
//    self.hudProgress.dimBackground = YES;
//    //self.hudProgress.margin = 80.f;
//    //self.hudProgress.yOffset = 150.f;
//    [self.view addSubview:self.hudProgress];
//    [self.hudProgress showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
//}

//#pragma mark HUD的代理方法,关闭HUD时执行
//-(void)hudWasHidden:(MBProgressHUD *)hud
//{
//    [hud removeFromSuperview];
//    hud = nil;
//}
//-(void) myProgressTask{
//    float progress = 0.0f;
//    while (progress < 1.0f) {
//        progress += 0.01f;
//        self.hudProgress.progress = progress;
//        usleep(50000);
//    }
//    
//}
//memberId:26227
#endif