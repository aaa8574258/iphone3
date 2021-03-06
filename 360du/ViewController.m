//
//  ViewController.m
//  360du
//
//  Created by linghang on 15-4-6.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ViewController.h"
#import "VersionTranlate.h"
#import "MainTableViewCell.h"
#import "MainBottomView.h"
#import "MainViewLoadData.h"
#import "NSString+URLEncoding.h"
#import "ExceptViewController.h"
#import "MainModel.h"
#import "LocationCommunityViewController.h"
#import "SearchViewController.h"
#import "FoodCommonViewController.h"
#import "GainLocationLatiguateAndLongtitute.h"
#import "AFNetworkTwoPackaging.h"
#import "FileOperation.h"
#import "PartyBuildDetialViewController.h"
#import "UIButton+WebCache.h"
#import "UIButton+WebCache.h"
#import "LocationModel.h"
#import "StoreageMessage.h"
#import <CoreLocation/CoreLocation.h>
#import "MenberViewController.h"
#import "MenberOrderViewController.h"
#import "MemberFavoriteViewController.h"
#import "MemberMessageViewController.h"
#import "MemberSettingViewController.h"
#import "PropertyListViewController.h"
#import "StudyMainBottomView.h"
//#import "AlipayViewController.h"
#import "RegisterViewController.h"
#import "LogInViewController.h"
#import "FirstScrTimerViewController.h"
#import "FoodMerchantListViewController.h"
#import "LocationModel.h"
#import "WeChantViewViewController.h"
#import "UIView+Toast.h"
#import "PrivilegeCenterViewController.h"
#import "UIImage+RTTint.h"
#import "GroupPurchaseCenterViewController.h"
#import "ParkingChargeViewController.h"
#import "WeChantViewViewController.h"
#import "RentViewController.h"
#import "FoodBussinessListCollectionViewController.h"
//#import <MBProgressHUD/MBProgressHUD.h>
#import "GroupRobGoodsDetialViewController.h"
#import "CleanerViewController.h"
#import "SDCycleScrollView.h"
#import "JSCartViewController.h"
#import "JPUSHService.h"
#import "GroupWMPageViewController.h"
#import "MineGroupViewController.h"
#import "MineGroupTwoViewController.h"
#import "MineGroupThreeViewController.h"
#import "MineOneViewController.h"
#import "PersonalFeedbackViewController.h"
#import "GroupRobGoodsDetialViewController.h"
#import "GroupPurchaseModel.h"
#import "MomentsViewController.h"
#import "PartyBuildViewController.h"

NSString * const HUDDismissNotification = @"HUDDismissNotification";

#define MAINVIEWCELL @"mainViewCell"
@interface ViewController ()<UITextFieldDelegate,UIScrollViewDelegate,CLLocationManagerDelegate,MBProgressHUDDelegate,SDCycleScrollViewDelegate,WMPageControllerDelegate,WMPageControllerDelegate,UIAlertViewDelegate>
//{
//    
//    CLLocationManager *_locationManager;
//}
@property( nonatomic ,strong)    CLLocationManager *locationManager;

@property(nonatomic,assign)CGFloat versionTralate;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic ,strong) NSMutableArray *dataArr1;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)AFHTTPSessionManager *rom;
@property(nonatomic,copy)NSString *communtityId;//小区的Id
@property(nonatomic,strong)MBProgressHUD *hudProgress;
@property(nonatomic,weak)UILabel *commuityName;//小区
@property(nonatomic,copy)NSString *cityName;//城市名称
@property(nonatomic,copy)NSString *latAndlongTitude;//经纬度
@property(nonatomic,strong)NSMutableArray *communtityArr;//经纬度
@property(nonatomic,assign)CGFloat scrHeight;
@property(nonatomic,weak)UIScrollView *timeScr;//时间滚动图
@property(nonatomic,weak)UIPageControl *pageCon;//页面控制器
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger timerCount;
@property(nonatomic,assign)NSInteger arrCount;
@property(nonatomic,strong)NSArray *timerArr;
@property(nonatomic,strong)UIImageView *pullDownImg;//导航条下三角
@property(nonatomic,strong)UIButton *selectCityBtn;//更换城市按钮
@property(nonatomic,weak)UIView *selectNavView;//上边的View
@property(nonatomic,assign)CGFloat nameWidth;//快快猫距离
@property(nonatomic,weak)UIScrollView *mainScr;
@property (nonatomic ,weak) UIScrollView *Scro;
@property (nonatomic ,assign) CGFloat ScroHeight;
@property (nonatomic ,weak) UIView *topView;
@property (nonatomic ,strong) NSMutableArray *imageArr;

@property (nonatomic ,strong) UILabel *NaviAdddLab;
@property (nonatomic ,strong) UIImageView *naviImage1;
@property (nonatomic ,strong) UIButton *naviBtn2;

@property (nonatomic ,strong) NSArray *midImageArr;
@property (nonatomic ,strong) NSArray *midTitleArr;
@property (nonatomic ,strong) NSArray *midMoneyArr;
@property (nonatomic ,strong) NSArray *midControllersArr;
@property (nonatomic ,strong) NSArray *midParamsArr;
@property (nonatomic ,strong) NSArray *midUrl;

@property (nonatomic ,strong) NSArray *lastImageArr;
@property (nonatomic ,strong) NSArray *lastTitleArr;
@property (nonatomic ,strong) NSArray *lastMoneyArr;
@property (nonatomic ,strong) NSArray *lastControllersArr;
@property (nonatomic ,strong) NSArray *lastParamsArr;


@property (nonatomic ,assign) NSInteger timesss;


@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self makeNav] ;
//    [self makeScro];
    
//    [self makeLastViewWithCount:nil andTitles:nil andMoneys:nil andImages:nil];
    self.navigationController.navigationBarHidden = NO;
    [self loadScrTime];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBarType];

   
    [self makeUI];

//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
}



-(void)viewWillDisappear:(BOOL)animated{
    self.Scro.contentOffset = CGPointMake(0, 0);
    
    [self.timer invalidate];
    


}

//-(void)viewDidAppear:(BOOL)animated{
//    _locationManager = [[CLLocationManager alloc] init];
//    _locationManager.delegate = self;
//    [_locationManager startUpdatingLocation];
//    if(![CLLocationManager locationServicesEnabled]){
//        NSLog(@"请开启定位:设置 > 隐私 > 位置 > 定位服务");
//        UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位服务当前可能尚未打开，请设置打开!" delegate:sef cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
//        alertView1.tag = 151150;
//        [alertView1 show];
//    }else{
//        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
//            NSLog(@"定位失败，请开启定位:设置 > 隐私 > 位置 > 定位服务 下 XX应用");
//            UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位服务当前可能尚未打开，请设置打开!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
//            alertView2.tag = 151151;
//
//            [alertView2 show];
//            
//        }else{
//            [self makeLocation];
//            [self makeInit];
//
//        }
//    }
//}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 151151) {
        if (buttonIndex == 0) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
                
            }
        }else{
            [self makeLocation];
        }
    }
}
//监控用户会否授权
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusNotDetermined) {
        if (status == kCLAuthorizationStatusDenied){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"为了您更好的使用，请在设置中打开位置服务" delegate:self cancelButtonTitle:@"去设置" otherButtonTitles:@"确定", nil];
            alertView.tag = 151151;
            [alertView show];
        }
    
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    [self pushOver];
//    [StoreageMessage getErrorMessage:@"123334" fromUrl:@"www.baidu.com"];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self laodData];
    self.versionTralate = [VersionTranlate returnVersionRateAnyIphone:WIDTH_CONTROLLER];
    //self.view.backgroundColor = [UIColor whiteColor];
//    [self makeHUd];
    [self makeInit];
    [self makeScro];

}


-(void)pushOver{
    
//    UILocalNotification *localNote = [[UILocalNotification alloc] init];
//    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    NSDate *myDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"2017-03-06 17:27:05"]];
//    NSLog(@"%@",myDate);
//    // 1.1.设置通知发出的时间
//    localNote.fireDate = myDate;
//    
//    // 1.2.设置通知内容
//    localNote.alertTitle = @"1111";
//    localNote.alertBody = @"2222";
//
////    localNote.alertTitle = dic[@"tipsName"];
////    localNote.alertBody = dic[@"tipsContent"];
//    
//    // 1.3.设置锁屏时,字体下方显示的一个文字
//    localNote.alertAction = @"赶紧!!!!!";
//    localNote.hasAction = YES;
//    
//    // 1.4.设置启动图片(通过通知打开的)
//    localNote.alertLaunchImage = @"11";
//    
//    // 1.5.设置通过到来的声音
//    localNote.soundName = UILocalNotificationDefaultSoundName;
//    
//    // 1.6.设置应用图标左上角显示的数字
//    localNote.applicationIconBadgeNumber += 1;
//    
//    // 1.7.设置一些额外的信息
//    localNote.userInfo = @{@"ky" : @"kkmbdts1"};
//    
//    // 2.执行通知
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:PUSHNOW,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);

        if ([getResult[@"datas"] count] > 0) {
            NSMutableArray *idsArr = [NSMutableArray arrayWithCapacity:0];
            NSArray *dataArr = getResult[@"datas"];
            for (NSDictionary *dic in dataArr) {
                [idsArr addObject:dic[@"id"]];
                // 1.创建一个本地通知
                
               [self dateTimeDifferenceWithStartTime:[NSString stringWithFormat:@"%@",DateTime] endTime:dic[@"tipsTime"]];
                NSLog(@"%ld",(long)self.timesss);
//                if (self.timesss > 0) {
                    // 1.创建一个本地通知
                    UILocalNotification *localNote = [[UILocalNotification alloc] init];
                
                    // 1.1.设置通知发出的时间
                    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.timesss];//五秒后通知
                
                    // 1.2.设置通知内容
                    localNote.alertTitle = dic[@"tipsName"];
                    localNote.alertBody = dic[@"tipsContent"];
                
                    // 1.3.设置锁屏时,字体下方显示的一个文字
                    localNote.alertAction = @"赶紧!!!!!";
                    localNote.hasAction = YES;
                
                    // 1.4.设置启动图片(通过通知打开的)
                    localNote.alertLaunchImage = @"11";
                
                    // 1.5.设置通过到来的声音
                    localNote.soundName = UILocalNotificationDefaultSoundName;
                    
                    // 1.6.设置应用图标左上角显示的数字
                    localNote.applicationIconBadgeNumber += 1;
                    
                    // 1.7.设置一些额外的信息
                    localNote.userInfo = @{@"ky" : @"704711253"};
                    
                    // 2.执行通知 
                    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
//                }
            }
            NSString *string = [idsArr componentsJoinedByString:@","];
            NSLog(@"%@",string);
            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
            [twoPacking getUrl:[NSString stringWithFormat:PUSHOVERNOW,string] andFinishBlock:^(id getResult) {
                NSLog(@"%@",getResult);
            }];

        }
        
        
        
    }];
    
    


}

- (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *endD = [date dateFromString:endTime];
    NSLog(@"%@----%@",startD,endD);
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = end - start;
    
    int second = (int)value %60;//秒
    
    int minute = (int)value /60%60;
    
    int house = (int)value / (24 * 3600)%3600;
    
    int day = (int)value / (24 * 3600);
    
    NSString *str;
    
    if (day != 0) {
        
        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
        self.timesss = day * 86400 + house * 3600 + minute * 60 + second;
    }else if (day==0 && house != 0) {
        
        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
        self.timesss =  house * 3600 + minute * 60 + second;

    }else if (day== 0 && house== 0 && minute!=0) {
        
        str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
        self.timesss = minute * 60 + second;

    }else{
        
        str = [NSString stringWithFormat:@"耗时%d秒",second];
        self.timesss = second;

    }

    return str;
    
}
//获取位置

//- (void)networkDidReceiveMessage:(NSNotification *)notification {
//    NSDictionary *userInfo = [notification userInfo];
//    NSString *title = [userInfo valueForKey:@"title"];
//    NSString *content = [userInfo valueForKey:@"content"];
//    NSDictionary *extra = [userInfo valueForKey:@"extras"];
//    NSLog(@"%@,%@,%@",title,content,extra);
//}

-(void) makeScro{
    UIScrollView *Scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, HEIGHT_CONTENTVIEW)];
    Scro.contentSize = CGSizeMake(WIDTH_CONTENTVIEW, 1000);
    Scro.backgroundColor = [UIColor colorWithRed:241/255.0 green:242/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:Scro];
    self.Scro = Scro;
    self.Scro.delegate = self;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, 20)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    self.topView = view;
}



-(void)makeInit{
    
    /**
     不确定                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
     */
    
    LocationModel *model = [[LocationModel alloc]init];
//    self.cityName = [StoreageMessage getCity];
//    NSLog(@"%@",self.cityName);
    NSLog(@"%@--%@",[StoreageMessage getCommuntityId],[StoreageMessage getCommuntity]);
    if ([[StoreageMessage getCommuntityId] length] == 0 ) {
        [StoreageMessage storeLatAndLong:@"116.444442,39.862788"];
        [StoreageMessage storeCity:@"北京市"];
        [StoreageMessage storeCommuntity: @"方安苑小区"];
        [StoreageMessage storeCommuntityId:@"86420010000013"];
//        [self returnCommuityId:@"86420010000004"];
        [StoreageMessage storeCityId:@"11000000"];
        model.xqid = @"86420010000013";
        model.xqname = @"方安苑小区";
        [self returnCommuityId:model];
        
    }else{
////    [StoreageMessage storeCity:@"北京市"];
//    self.communtityId = [StoreageMessage getCommuntityId];
////    self.commuityName.text = [StoreageMessage getCommuntity];
//        
//    self.cityName = [StoreageMessage getCity];
//        NSLog(@"%@",self.cityName);
//        
////    self.latAndlongTitude = [StoreageMessage getLatAndLong];
////    self.communtityArr = [NSMutableArray arrayWithCapacity:0];
//    [StoreageMessage storeCity:self.cityName];
//        
    model.xqid = [StoreageMessage getCommuntityId];
//        NSLog(@"%@",model.xqid);
    model.xqname = [StoreageMessage getCommuntity];
//        NSLog(@"%@",model.xqname);
    [self returnCommuityId:model];

        
        [self makeLocation];

        
        
    }
    
}
//加载图片
-(void)makeHUd{
    self.hudProgress = [[MBProgressHUD alloc] initWithView:self.view];
    self.hudProgress.delegate = self;
    //self.hudProgress.color = [UIColor clearColor];
    self.hudProgress.labelText = @"loading";
    //self.hudProgress.dimBackground = YES;
    //self.hudProgress.margin = 80.f;
    //self.hudProgress.yOffset = 150.f;
    [self.view addSubview:self.hudProgress];
    [self.hudProgress showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}


//-(void)laodData{
//    self.dataArr = [NSMutableArray arrayWithCapacity:0];
//    self.rom = [AFHTTPSessionManager manager];
//    self.rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
//    [self.rom GET:MAINUIDATA parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [StoreageMessage getErrorMessage:@"NULL" fromUrl:MAINUIDATA];
//
//        [self hudWasHidden:self.hudProgress];
//        [StoreageMessage getErrorMessage:[NSString stringWithFormat:@"%@",responseObject] fromUrl:MAINUIDATA];
//        NSLog(@"%@",responseObject);
//        for (NSDictionary *temp in responseObject) {
//            MainModel *model = [[MainModel alloc] initWithDictionary:temp];
//            [self.dataArr addObject:model];
//        }
//        [self makeScrollView];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [StoreageMessage getErrorMessage:[NSString stringWithFormat:@"%@",error] fromUrl:MAINUIDATA];
//  //        [self hudWasHidden:self.hudProgress];
////        NSLog(@"%@",[error description]);
////        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
////        [alertView show];
////        return ;
//    }];
//  // UISearchBar *searchBar = nil;
//    //searchBar.searchBarStyle =
////    searchBar.
////    searchBar.backgroundColor = [UIColor blueColor];
//}


-(void) loadMainData{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:MAINGOHOME,self.communtityId] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        NSLog(@"%@",getResult);
        NSMutableArray *arr1 =[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr2 =[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr3 =[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr4 =[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr5 =[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr6 =[NSMutableArray arrayWithCapacity:0];

        for (NSDictionary *dic in getResult[@"datas"]) {
            [arr1 addObject:dic[@"IconName"]];
            [arr2 addObject:dic[@"IconPath"]];
            [arr3 addObject:dic[@"isWait"]];
            if ([[dic[@"guideAction"][@"ios"] allKeys] containsObject:@"controller"]) {
//                [dic setValue:@"" forKey:dic[@"guideAction"][@"ios"][@"controller"]];
//                [dic setValue:@"" forKey:dic[@"guideAction"][@"ios"][@"params"]];
                [arr4 addObject:dic[@"guideAction"][@"ios"][@"controller"]];
                [arr5 addObject:dic[@"guideAction"][@"ios"][@"params"]];
            }else{
                [arr4 addObject:[NSDictionary dictionaryWithObject:@"" forKey:@"controller"]];
                [arr5 addObject:[NSDictionary dictionaryWithObject:@"" forKey:@"params"]];

            }
            if ([[dic[@"guideAction"][@"ios"] allKeys] containsObject:@"url"]){
                [arr6 addObject:dic[@"guideAction"][@"ios"][@"url"]];

//                [dic setValue:@"" forKey:dic[@"guideAction"][@"ios"][@"url"]];
            }else{
                [arr6 addObject:@"88557744"];

            }
//            [dic setValue:@"1" forUndefinedKey:dic[@"guideAction"][@"ios"][@"controller"]];
//            [dic setValue:@"1" forUndefinedKey:dic[@"guideAction"][@"ios"][@"params"]];
//            [dic setValue:@"1" forUndefinedKey:dic[@"guideAction"][@"ios"][@"url"]];
            
//            [arr4 addObject:dic[@"guideAction"][@"ios"][@"controller"]];
//            [arr5 addObject:dic[@"guideAction"][@"ios"][@"params"]];
//            [arr6 addObject:dic[@"guideAction"][@"ios"][@"url"]];
        }
        NSLog(@"%@",arr6);
        self.midTitleArr = arr1.mutableCopy;
        self.midImageArr = arr2.mutableCopy;
        self.midMoneyArr = arr3.mutableCopy;
        self.midControllersArr = arr4.mutableCopy;
        self.midParamsArr = arr5.mutableCopy;
        self.midUrl = arr6.mutableCopy;
        [self makeScrollView];
        
        [self lastDataLoat];

    }];

}
//选择小区
- (void)loadDataMain:(NSString *)commititutyAddress{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.rom = [AFHTTPSessionManager manager];
    self.rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    NSString *url = [NSString stringWithFormat:MAINVIEWCOMMINUTITADDRESS,commititutyAddress];
    [self makeHUd];
    [self.rom GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [StoreageMessage getErrorMessage:[NSString stringWithFormat:@"%@",responseObject]  fromUrl:url];
        [self hudWasHidden:self.hudProgress];
        [self.dataArr removeAllObjects];
        NSLog(@"mianT::%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"000000"]) {
            for (NSDictionary *temp in responseObject[@"datas"]) {
                MainModel *model = [[MainModel alloc] initWithDictionary:temp];
                [self.dataArr addObject:model];
            }
        }else{
            [self.view makeToast:@"系统问题，请等待"];
        }
        [self makeScrollView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [StoreageMessage getErrorMessage:[NSString stringWithFormat:@"%@",error] fromUrl:url];

//        [[NSURLCache sharedURLCache] removeAllCachedResponses];
//        [self hudWasHidden:self.hudProgress];
        //        NSLog(@"%@",[error description]);
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        //        [alertView show];
        //        return ;
    }];
}
-(void)makeUI{
    [self makeBottom];
}
//加载滚动图的
- (void)loadScrTime{
    self.rom = [AFHTTPSessionManager manager];
    self.rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    [self makeHUd];
    NSString *url = [NSString stringWithFormat:MAINSCRFIRSR,[StoreageMessage getCommuntityId]];
    NSLog(@"%@",url);
    [self.rom GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hudWasHidden:self.hudProgress];
        [StoreageMessage getErrorMessage:[NSString stringWithFormat:@"%@",responseObject] fromUrl:url];
        if ([responseObject[@"code"] isEqualToString:@"000000"]) {
            self.timerArr = responseObject[@"datas"];
            [self make1TimeScr:self.timerArr.count andTimeArr:self.timerArr];
        }else{
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [StoreageMessage getErrorMessage:[NSString stringWithFormat:@"%@",error] fromUrl:url];

//        [[NSURLCache sharedURLCache] removeAllCachedResponses];
//        NSLog(@"error:%@",error);
       // [self hudWasHidden:self.hudProgress];
        //        NSLog(@"%@",[error description]);
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        //        [alertView show];
        //        return ;
    }];
}


- (void)make1TimeScr:(NSInteger)count andTimeArr:(NSArray *)timeArr{
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER, 215 * self.versionTralate) imageURLStringsGroup:nil];
    cycleScrollView2.backgroundColor = [UIColor whiteColor];
    [self.Scro addSubview:cycleScrollView2];
    cycleScrollView2.delegate = self;
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        //    cycleScrollView2.delegate = self;
    cycleScrollView2.dotColor = [UIColor whiteColor];
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
        //       [self.LBSuperView addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//       cycleScrollView2.imageURLStringsGroup = timeArr[@"picturePath"];
        self.imageArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i < count; i++) {
            NSLog(@"%ld--%@",count,[NSURL URLWithString:timeArr[i][@"picturePath"]]);
            [self.imageArr addObject:timeArr[i][@"picturePath"]];
            [arr1 addObject:timeArr[i][@"description"]];
        }
        cycleScrollView2.imageURLStringsGroup = self.imageArr;
        cycleScrollView2.titlesGroup = arr1;
    });

}



- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self timerDown1:[NSString stringWithFormat:@"%ld",(long)index]];
}

-(void) GroupPurchaseCenterViewControllerWithPrams1:(NSString *)Prams{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:CWHMODEL,Prams] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        GroupPurchaseModel *model = [[GroupPurchaseModel alloc] initWithDictionary:getResult[@"datas"]];
        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GroupRobGoodsDetialViewController *robGoods = [cleanerSB instantiateViewControllerWithIdentifier:@"RobDetial"];
        robGoods.model = model;
        [self.navigationController pushViewController:robGoods animated:YES];
    }];
}

- (void)timerDown1:(NSString *)tag{
//    NSLog(@"%ld",(long)timerDown.tag);
    NSDictionary *dict = self.timerArr[tag.integerValue];
    NSInteger type = [dict[@"actionType"] integerValue];
    NSLog(@"1%ld",type);
    BaseViewController *ctrl = nil;
    NSLog(@"2%@----%@",dict,dict[@"guideAction"][@"ios"][@"controller"]);
    if ([dict[@"guideAction"][@"ios"][@"controller"] isEqualToString:@"PartyBuildDetialViewController"]) {
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
//        NSLog(@"%@",self.lastParamsArr[center.view.tag - 100086][@"url"]);
        
        [twoPacking getUrl:[NSString stringWithFormat:@"%@",dict[@"guideAction"][@"ios"][@"params"][@"url"]] andFinishBlock:^(id getResult) {
            NSLog(@"%@",getResult);
            PartyBuildDetialViewController *detial = [[PartyBuildDetialViewController alloc] initWithTittle:getResult[@"datas"][0][@"anTitle"] andDetial:getResult[@"datas"][0][@"anContent"] andTime:getResult[@"datas"][0][@"anTime"]];
            [self.navigationController pushViewController:detial animated:YES];
            
            
        }];
        return;
    }
    
    switch (type) {
        case 1:{
            ctrl = [[FirstScrTimerViewController alloc] initWithArr:dict];
            break;
        }
        case 2:{
            if ([dict[@"guideAction"][@"ios"][@"controller"] isEqualToString:@"GroupRobGoodsDetialViewController"]) {
                [self GroupPurchaseCenterViewControllerWithPrams1:dict[@"guideAction"][@"ios"][@"params"][@"cpid"]];
            }else{
            BaseViewController *controller = [[NSClassFromString(dict[@"guideAction"][@"ios"][@"controller"]) alloc] init];
            controller.dicParams = dict[@"guideAction"][@"ios"][@"params"];
            [self.navigationController pushViewController:controller animated:YES];
            }
            break;
        }
        case 3:{
            NSDictionary *tempDict =  dict[@"guideAction"];
            NSInteger typeInt = [tempDict[@"type"] intValue];
            if (typeInt == 1 ) {
                ctrl = [[FoodCommonViewController alloc] initWithTitleName:tempDict[@"categoryName"] andNSString:@"" andCommuntityId:self.communtityId andSortNum:1 andCatergoryId:[tempDict[@"categoryID"] intValue] andCommuntityArr:self.communtityArr andLoaction:self.latAndlongTitude andCityName:self.cityName];
            }else if (typeInt == 2){
                ctrl = [[FoodBussinessListCollectionViewController alloc] initWithId:tempDict[@"merchantId "] andSendPrice:tempDict[@"sendPrice"] andDistributionPrice:tempDict[@"startSendPrice"]];
            }else if (typeInt == 3){
                //            FoodMerchantGoodsDeatilViewController *goodsMerchant = [[FoodMerchantGoodsDeatilViewController alloc] initWithItemModel:model andPrudctId:model.pid];
            }else if (typeInt == 4){
                //                GroupPurchaseModel *model = self.dataArr[indexPath.row];
                
                GroupRobGoodsDetialViewController *robGoods = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RobDetial"];
                //    cleanerViewController.target = self;
                //    [self.navigationController pushViewController:cleanerViewController animated:YES];    GroupRobGoodsDetialViewController *robGoods = [[GroupRobGoodsDetialViewController alloc] initWithModel:model];;
                //                robGoods.model = model;
                GroupPurchaseModel *model = [[GroupPurchaseModel alloc] initWithDictionary:dict[@"guideAction"]];
                robGoods.model = model;
                //                robGoods.model.cpid = tempDict[@"categoryID"];
                [self.navigationController pushViewController:robGoods animated:YES];
            }
            break;
        }
        default:
            break;
    }
    [self.navigationController pushViewController:ctrl animated:YES];
}



//定时滚动条
- (void)makeTimeScr:(NSInteger)count andTimeArr:(NSArray *)timeArr{
    
//    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, self.scrHeight, self.view.frame.size.width, HEIGHT_CONTROLLER - self.scrHeight - 49 * self.versionTralate) imageURLStringsGroup:nil];
//    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    //    cycleScrollView2.delegate = self;
//    cycleScrollView2.dotColor = [UIColor yellowColor];
//    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
//    //    [self.LBSuperView addSubview:cycleScrollView2];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        for (NSInteger i = 0; i < self.dataArr.count; i++) {
//            MainModel *model = self.dataArr[i];
//            //            NSArray *arr = [NSArray ]
//            NSMutableArray *arrImage = [NSMutableArray arrayWithCapacity:0];
//            [arrImage addObject:model.indeximg];
//            cycleScrollView2.imageURLStringsGroup = arrImage;
//            
//        }
//        
//        //        cycleScrollView2.imageURLStringsGroup = self.imageData;
//    });
    NSLog(@"LBT:%@",timeArr);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, 160 * self.versionTralate)];
    [self.Scro addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    self.timeScr = scrollView;
    UIImage *image = [UIImage imageNamed:@"banner.png"];

    CGFloat height = WIDTH_CONTROLLER / image.size.width  * image.size.height;
    CGFloat scrHeight = 0;
    if(IPHONE4){
        scrHeight = 60 * self.versionTralate + 64;
        scrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER * count, 60 * self.versionTralate);
    }else{
        scrHeight = height + 64;
        scrollView.frame = CGRectMake(0, 64, WIDTH_CONTROLLER, height);
        scrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER * count, height);
    }
    for (NSInteger i = 0; i < count; i++) {
        NSLog(@"%ld--%@",count,[NSURL URLWithString:timeArr[i][@"picturePath"]]);

        UIButton *scrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [scrBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:timeArr[i][@"picturePath"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"banner"]];
        [scrollView addSubview:scrBtn];
        scrBtn.frame = CGRectMake(WIDTH_CONTROLLER * i, 0, WIDTH_CONTROLLER, scrollView.frame.size.height);
        scrBtn.tag = 1850 + i;
        [scrBtn addTarget:self action:@selector(timerDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIPageControl *pageCon = [[UIPageControl alloc] initWithFrame:CGRectMake(20 * self.versionTralate, scrHeight - 20 * self.versionTralate, WIDTH_CONTROLLER - 40 * self.versionTralate, 15 * self.versionTralate)];
    pageCon.numberOfPages = count;
    [self.Scro addSubview:pageCon];
    pageCon.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageCon = pageCon;
    self.timerCount = 0;
    self.arrCount = count;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(scheduleTime) userInfo:nil repeats:YES];
}



- (void)scheduleTime{
    NSLog(@"%ld---%ld",(long)self.timerCount,(long)self.arrCount);
    self.pageCon.currentPage = self.timerCount;
    self.timeScr.contentOffset = CGPointMake(WIDTH_CONTROLLER * self.timerCount, 0);
    if (self.timerCount == self.arrCount - 1) {
        self.timerCount = 0;
        return;
    }
    self.timerCount++;
}




#pragma mark timerDown
- (void)timerDown:(UIButton *)timerDown{
    NSLog(@"%ld",(long)timerDown.tag);
    NSDictionary *dict = self.timerArr[timerDown.tag - 1850];
    NSInteger type = [dict[@"actionType"] integerValue];
    NSLog(@"1%ld",type);
    BaseViewController *ctrl = nil;
    NSLog(@"2%@",dict);
    switch (type) {
        case 1:{
            ctrl = [[FirstScrTimerViewController alloc] initWithArr:dict];
            break;
        }
        case 2:{
            
            break;
        }
        case 3:{
            NSDictionary *tempDict =  dict[@"guideAction"];
            NSInteger typeInt = [tempDict[@"type"] intValue];
            if (typeInt == 1 ) {
                ctrl = [[FoodCommonViewController alloc] initWithTitleName:tempDict[@"categoryName"] andNSString:@"" andCommuntityId:self.communtityId andSortNum:1 andCatergoryId:[tempDict[@"categoryID"] intValue] andCommuntityArr:self.communtityArr andLoaction:self.latAndlongTitude andCityName:self.cityName];
            }else if (typeInt == 2){
                ctrl = [[FoodBussinessListCollectionViewController alloc] initWithId:tempDict[@"merchantId "] andSendPrice:tempDict[@"sendPrice"] andDistributionPrice:tempDict[@"startSendPrice"]];
            }else if (typeInt == 3){
//            FoodMerchantGoodsDeatilViewController *goodsMerchant = [[FoodMerchantGoodsDeatilViewController alloc] initWithItemModel:model andPrudctId:model.pid];
            }else if (typeInt == 4){
//                GroupPurchaseModel *model = self.dataArr[indexPath.row];
                GroupRobGoodsDetialViewController *robGoods = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RobDetial"];
                //    cleanerViewController.target = self;
                //    [self.navigationController pushViewController:cleanerViewController animated:YES];    GroupRobGoodsDetialViewController *robGoods = [[GroupRobGoodsDetialViewController alloc] initWithModel:model];;
//                robGoods.model = model;
                GroupPurchaseModel *model = [[GroupPurchaseModel alloc] initWithDictionary:dict[@"guideAction"]];
                robGoods.model = model;
//                robGoods.model.cpid = tempDict[@"categoryID"];

                [self.navigationController pushViewController:robGoods animated:YES];
            }
            break;
        }
        default:
            break;
    }
    [self.navigationController pushViewController:ctrl animated:YES];
}
//导航条
-(void)makeNav{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    self.selectNavView = view;
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectZero];
    lable1.text = [StoreageMessage getCommuntity];
    lable1.font = [UIFont systemFontOfSize:16 * self.versionTralate];
//    lable1.textColor = SMSColor(252, 192, 191);
    lable1.textColor = [UIColor whiteColor];
    [lable1 sizeToFit];
    lable1.frame = CGRectMake(0,  (44 - 15) / 2 *self.versionTralate - 2 *self.versionTralate, lable1.frame.size.width, 15 *self.versionTralate);
    [view addSubview:lable1];
    self.commuityName = lable1;
    
//    self.nameWidth = lable.frame.size.width;
    view.frame = CGRectMake(0, 0,  0 * self.versionTralate + lable1.frame.size.width, 44);
    self.pullDownImg = [[UIImageView alloc] initWithFrame:CGRectMake( 0 * self.versionTralate + lable1.frame.size.width + 4 * self.versionTralate, (44 - 15) / 2 *self.versionTralate - 2 * self.versionTralate, 10 * self.versionTralate, 10 * self.versionTralate)];
    self.pullDownImg.image = [UIImage imageNamed:@"xl.png"];
//    UIImage *tint1 = [self.pullDownImg.image rt_tintedImageWithColor: SMSColor(252, 192, 191)];
//    [self.pullDownImg setImage:tint1];
    [view addSubview:self.pullDownImg];
    
    
    view.frame = CGRectMake(0, 0,  0 * self.versionTralate + lable1.frame.size.width + 35 * self.versionTralate, 44 *self.versionTralate);
    self.selectCityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectCityBtn.frame = view.bounds;
    [view addSubview:self.selectCityBtn];
    [self.selectCityBtn setTitle:@"" forState:UIControlStateNormal];
    [self.selectCityBtn addTarget:self action:@selector(backDown:) forControlEvents:UIControlEventTouchUpInside];
    self.selectCityBtn.tag = 1000;
    UIBarButtonItem *left1 = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
    //UIBarButtonItem *left2 = [[UIBarButtonItem alloc] initWithCustomView:pullDown];
    //left2.tag = 1100;
    self.navigationItem.leftBarButtonItems = @[left1];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(WIDTH_CONTROLLER + 30 *self.versionTralate , 0,20 * self.versionTralate, 20 * self.versionTralate);
    [searchBtn setImage:[UIImage imageNamed:@"xiao.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(backDown:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.tag = 1001;
    self.naviBtn2 = searchBtn;
    //searchBtn.userInteractionEnabled = NO;
    searchBtn.userInteractionEnabled = YES;
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = right1;
    

}


-(void) setNavigationBarType{
    self.navigationController.navigationBar.translucent = YES;
    UIColor *color = [UIColor clearColor];
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    
}

-(void)backDown:(UIBarButtonItem *)navBtn{
    if (navBtn.tag == 1000) {
        LocationCommunityViewController *location = [[LocationCommunityViewController alloc] init];
        location.target = self;
        [self.navigationController pushViewController:location animated:YES];
    }else{
        if (![StoreageMessage isStoreMessage]) {
            [self.view makeToast:@"请先登录!"];
            LogInViewController *logIn = [[LogInViewController alloc] init];
            [self.navigationController pushViewController:logIn animated:YES];
            return;
        }
        PersonalFeedbackViewController *personalFeedBack = [[PersonalFeedbackViewController alloc] init];
        [self.navigationController pushViewController:personalFeedBack animated:YES];
//        WeChantViewViewController *wechant = [[WeChantViewViewController alloc] initWithName:@"qq" andMoney:@"1"];
//        [self.navigationController pushViewController:wechant animated:YES];
        //[WeChantViewViewController payName:@"你好" andMoney:@"1"];

        //登陆
        //LogInViewController *logIn = [[LogInViewController alloc] init];
        //[self.navigationController pushViewController:logIn animated:YES];
        //注册
//        RegisterViewController *registerView = [[RegisterViewController alloc] init];
//        [self.navigationController pushViewController:registerView animated:YES];
        //支付宝
//        AlipayViewController *aliPay = [[AlipayViewController alloc] initPrice:@"0.01" andDescMerchant:@"22" andTitle:@"33" andMerOrder:@"55"];
//        [self.navigationController pushViewController:aliPay animated:YES];
//        return;
        //微信支付

//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideHUD) name:HUDDismissNotification object:nil];
//        [[WXPayClient shareInstance] payProduct];

        //SearchViewController *search = [[SearchViewController alloc] init];
        //[self.navigationController pushViewController:search animated:YES];
//        //微信支付
//        WeChantViewViewController *weChant = [[WeChantViewViewController alloc] init];
//        [self.navigationController pushViewController:weChant animated:YES];
    }
}
- (void)hideHUD
{
    //    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)makeTitleImg{
    UIImageView *btnImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, 60 * self.versionTralate)];
    btnImg.image = [UIImage imageNamed:@"banner.png"];
    [self.Scro addSubview:btnImg];
   CGFloat height = WIDTH_CONTROLLER / btnImg.image.size.width  * btnImg.image.size.height;
    self.scrHeight = height + 64;
    if(IPHONE4){
        self.scrHeight = 60 * self.versionTralate + 64;
        
    }else{
        btnImg.frame = CGRectMake(0, 64, WIDTH_CONTROLLER, height);
    }
//    CGFloat imgHeight = [VersionTranlate returnImageHeightImgname:@"wenzi.png" andWidth:WIDTH_CONTROLLER - (10 + 50) * self.versionTralate];
//    UIImageView *btnLableImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.versionTralate, (60 - imgHeight) / 2, WIDTH_CONTROLLER - (10 + 50) * self.versionTralate, imgHeight)];
//    btnLableImg.image = [UIImage imageNamed:@"wenzi.png"];
//    [btnImg addSubview:btnLableImg];
}




//tableview
-(void)makeScrollView{
    NSLog(@"%@",self.midImageArr);
    [self.mainScr.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.mainScr = nil;
    CGFloat height = 215 * self.versionTralate;
    self.scrHeight = height;
    UIScrollView *mainScr;
    if (self.midImageArr.count >5) {
        mainScr= [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.scrHeight , self.view.frame.size.width, 210 * self.versionTralate)];
    }else{
        mainScr= [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.scrHeight , self.view.frame.size.width, 110 * self.versionTralate)];
        mainScr.scrollEnabled = NO;
    }
    mainScr.backgroundColor = [UIColor whiteColor];
    mainScr.pagingEnabled = YES;
    mainScr.delegate = self;
    mainScr.showsHorizontalScrollIndicator = NO;
    [self.Scro addSubview:mainScr];
//    CGFloat iconWidth = (WIDTH_CONTROLLER - 10 * self.versionTralate * 3 - 40 * self.versionTralate) / 4;
//    CGFloat iconHeight = (iconWidth + 20 + 20 * self.versionTralate);
    CGFloat iconWidth;
    CGFloat iconHeight;
    iconWidth = iconHeight = 50 *self.versionTralate;
    if (self.midImageArr.count > 10) {
        mainScr.contentSize = CGSizeMake(WIDTH_CONTROLLER * 2, iconHeight * 2 + iconWidth + 20);
        [self makePageContro];
    }else {
        
        mainScr.contentSize = CGSizeMake(WIDTH_CONTROLLER, iconHeight * 2 + iconWidth + 20);
    }
    for (NSInteger i = 0; i < self.midImageArr.count; i++) {
//        MainModel *model = self.dataArr[i];
        UILabel *iconTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
        iconTitle.text = _midTitleArr[i];
        iconTitle.font = [UIFont systemFontOfSize:13 * self.versionTralate];
        iconTitle.textColor = MAINVIEICONCOLOR;
        [iconTitle sizeToFit];
        [mainScr addSubview:iconTitle];
        iconTitle.center = CGPointMake(17 * self.versionTralate + iconWidth / 2 + (iconWidth + 23 * self.versionTralate ) * (i % 5), iconWidth +  (iconHeight + 43 * self.versionTralate) * (i / 5) + 35 *self.versionTralate);
        UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        iconBtn.frame = CGRectMake(20 * self.versionTralate + (iconWidth + 10 * self.versionTralate) * (i % 5) , iconHeight * (i / 2), iconWidth , iconWidth );
        if (i >= 10) {
            iconBtn.center = CGPointMake(17 * self.versionTralate + iconWidth / 2 + (iconWidth + 23 * self.versionTralate ) * (i % 5) + WIDTH_CONTROLLER, iconWidth / 2 + (iconHeight + 43* self.versionTralate) * ((i - 10) / 5) + 20 *self.versionTralate);
            iconTitle.center = CGPointMake(17 * self.versionTralate + iconWidth / 2 + (iconWidth + 23 * self.versionTralate ) * (i % 5) + WIDTH_CONTROLLER, iconWidth +  (iconHeight + 43 * self.versionTralate) * ((i - 10) / 5) + 35 * self.versionTralate);
            
        }else{
            iconBtn.center = CGPointMake(17 * self.versionTralate + iconWidth / 2 + (iconWidth + 23 * self.versionTralate ) * (i % 5), iconWidth / 2 +( 43 * self.versionTralate +  iconHeight) * (i / 5) + 20 * self.versionTralate);
        }
        //MainModel *model = self.dataArr[i];
        [iconBtn sd_setImageWithURL:[NSURL URLWithString:_midImageArr[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"001.png"]];
        [iconBtn addTarget:self action:@selector(scrBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        iconBtn.tag = 1200 + i;
        [mainScr addSubview:iconBtn];
        self.mainScr = mainScr;

    }
    
//    [self lastDataLoat];

//    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT - 49 - 20, WIDTH, 20)];
//    page.numberOfPages = 2;
//    page.userInteractionEnabled = NO;
//    page.tag = 12000;
//    page.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:page];
}
-(void)makePageContro{
    UIPageControl *pageContro = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 429 * self.versionTralate, WIDTH_CONTROLLER, 10 * self.versionTralate)];
    pageContro.numberOfPages = 2;
    pageContro.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageContro.currentPageIndicatorTintColor = [UIColor redColor];
    [self.Scro addSubview:pageContro];
    //pageContro.backgroundColor = [UIColor lightGrayColor];
    pageContro.userInteractionEnabled = NO;
    pageContro.tag = 12000;
    if (self.dataArr.count < 10) {
        [pageContro removeFromSuperview];
    }
    
}


//主页图标点击

-(void)scrBtnDown:(UIButton *)scrBtn{
//    1.物业2.便利店3.美酒美食4.送水5.保姆保洁6.药店7.美容美甲8.洗衣9.二手物品10.快递11.粮油蔬菜12.干果水果13.超市14.居家15团购预定16.领劵中心
    
    NSLog(@"%@",self.midControllersArr[scrBtn.tag - 1200]);
//    if (self.midControllersArr[scrBtn.tag - 1200]) {
//        if (![StoreageMessage isStoreMessage]) {
//                [self.view makeToast:@"请先登录!"];
//                LogInViewController *logIn = [[LogInViewController alloc] init];
//                [self.navigationController pushViewController:logIn animated:YES];
//                return;
//        }
    
    if (![self.midUrl[scrBtn.tag - 1200] isEqualToString:@"88557744"]) {
        NSLog(@"%@",self.midUrl[scrBtn.tag - 1200]);
        
        BaseViewController *controller = [[FirstScrTimerViewController alloc] init];
        controller.strParams = self.midUrl[scrBtn.tag - 1200];
//        NSLog(@"%@",controller.strParams);
        [self.navigationController pushViewController:controller animated:YES];
        
        return;
    }
    
    if ([self.midControllersArr[scrBtn.tag - 1200] isEqualToString:@"MomentsViewController"]) {
        MomentsViewController* vc = [[MomentsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([self.midControllersArr[scrBtn.tag - 1200] isEqualToString:@"GroupPurchaseCenterViewController"]) {
//        GroupWMPageViewController *pageVC = [[GroupWMPageViewController alloc] initWithViewControllerClasses:@[[MineGroupViewController class],[MineOneViewController class],[MineGroupTwoViewController class],[MineGroupThreeViewController class]] andTheirTitles:@[@"全部",@"待付款",@"待收货",@"已收货"]];
//        pageVC.pageAnimatable = YES;
//        pageVC.menuItemWidth = 85;
//        pageVC.menuHeight = 45 * self.versionTralate;
//        pageVC.postNotification = YES;
//        pageVC.bounces = YES;
//        // 默认
//        pageVC.title = @"我的订单";
//        //            pageVC.preloadPolicy = WMPageControllerPreloadPolicyNeighbour;
//        //            pageVC.keys = [@[@"statue",@"statue",@"statue"]mutableCopy];
//        //            pageVC.values = [@[@"1",@"2",@"3"] mutableCopy];
//        [self.navigationController pushViewController:pageVC animated:YES];
        
        [self loadInfo];
        return;
    }
    
    
    if ([self.midMoneyArr[scrBtn.tag - 1200] isEqualToString:@"2"]) {
        ExceptViewController *Except = [[ExceptViewController alloc] initWithName:self.midTitleArr[scrBtn.tag - 1200]];
        [self.navigationController pushViewController:Except animated:YES];
        return;
    }
    if ([self.midControllersArr[scrBtn.tag - 1200] isEqualToString:@"PartyBuildViewController"]) {
//        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"PartyBuild" bundle:nil];
//        PartyBuildViewController *cleanerViewController = [cleanerSB instantiateViewControllerWithIdentifier:@"PartyBuild"];
//        cleanerViewController.target = self;
        PartyBuildViewController *cleanerViewController = [[PartyBuildViewController alloc] init];
        [self.navigationController pushViewController:cleanerViewController animated:YES];
    }else if ([self.midControllersArr[scrBtn.tag - 1200] isEqualToString:@"CleanerViewController"]) {
        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
        CleanerViewController *cleanerViewController = [cleanerSB instantiateViewControllerWithIdentifier:@"cleaner"];
        cleanerViewController.target = self;
        [self.navigationController pushViewController:cleanerViewController animated:YES];
    }else{
        BaseViewController *controller = [[NSClassFromString(self.midControllersArr[scrBtn.tag - 1200]) alloc] init];
        controller.dicParams = self.midParamsArr[scrBtn.tag - 1200];
        [self.navigationController pushViewController:controller animated:YES];
    }

    
    
    
    
//    MainModel *model = self.dataArr[scrBtn.tag - 1200];
//
//    if ([model.id isEqual:@"1"]) {//物业
//        [self makeHUd];
//        if ([model.isWait isEqualToString:@"2"]) {
//            ExceptViewController *Except = [[ExceptViewController alloc] initWithName:model.name];
//            [self.navigationController pushViewController:Except animated:YES];
//            return;
//        }
//        if (![StoreageMessage isStoreMessage]) {
//            [self.view makeToast:@"请先登录!"];
//            LogInViewController *logIn = [[LogInViewController alloc] init];
//            [self.navigationController pushViewController:logIn animated:YES];
//            return;
//        }
//        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
//        [twoPacking getUrl:[NSString stringWithFormat:PROERTYLISTFIRST,[StoreageMessage getMessage][2],[StoreageMessage getCommuntityId]] andFinishBlock:^(id getResult) {
//            [self hudWasHidden:self.hudProgress];
//            [StoreageMessage getErrorMessage:[NSString stringWithFormat:@"%@",getResult] fromUrl:[NSString stringWithFormat:PROERTYLISTFIRST,[StoreageMessage getMessage][2],[StoreageMessage getCommuntityId]]];
//            if ([getResult[@"code"] isEqualToString:@"000000"]) {
//                PropertyListViewController *proList = [[PropertyListViewController alloc] init];
//                [self.navigationController pushViewController:proList animated:YES];
//            }else{
//                [self.view makeToast:getResult[@"message"]];
//            }
//            
//        }];
//        
//    }else if([model.id isEqual:@"2"]){//便利店
//        if ([model.isWait isEqualToString:@"2"]) {
//            ExceptViewController *Except = [[ExceptViewController alloc] initWithName:model.name];
//            [self.navigationController pushViewController:Except animated:YES];
//            return;
//        }
//        MainModel *model = self.dataArr[scrBtn.tag - 1200];
//        NSLog(@"%@--%@--%@--%ld--%@--%@--%@",model.name,model.requrl,self.communtityId,model.id.integerValue,self.communtityArr,self.latAndlongTitude,self.cityName);
//        FoodCommonViewController *common = [[FoodCommonViewController alloc] initWithTitleName:model.name andNSString:model.requrl andCommuntityId:self.communtityId andSortNum:1 andCatergoryId:model.id.integerValue andCommuntityArr:self.communtityArr andLoaction:self.latAndlongTitude andCityName:self.cityName];
//        [self.navigationController pushViewController:common animated:YES];
    //    FoodCommonViewController *common = [[FoodCommonViewController alloc] initWithTitleName:model.name andNSString:model.requrl andCommuntityId:model.xqid andSortNum:1 andCatergoryId:model.id.integerValue andCommuntityArr:self.communtityArr andLoaction:self.latAndlongTitude andCityName:self.cityName];
//    [self.navigationController pushViewController:common animated:YES];
//    }else if ([model.id isEqual:@"16"]){//领劵中心
//        if ([model.isWait isEqualToString:@"2"]) {
//            ExceptViewController *Except = [[ExceptViewController alloc] initWithName:model.name];
//            [self.navigationController pushViewController:Except animated:YES];
//            return;
//        }
//        if (![StoreageMessage isStoreMessage]) {
//            [self.view makeToast:@"请先登录!"];
//            LogInViewController *logIn = [[LogInViewController alloc] init];
//            [self.navigationController pushViewController:logIn animated:YES];
//            return;
//        }
//    PrivilegeCenterViewController
//        PrivilegeCenterViewController *privileageCenter = [[PrivilegeCenterViewController alloc] init];
//        [self.navigationController pushViewController:privileageCenter animated:YES];
//    }else if ([model.id isEqual:@"15"]){//团购预定
//        if ([model.isWait isEqualToString:@"2"]) {
//            ExceptViewController *Except = [[ExceptViewController alloc] initWithName:model.name];
//            [self.navigationController pushViewController:Except animated:YES];
//            return;
//        }
//        if (![StoreageMessage isStoreMessage]) {
//            [self.view makeToast:@"请先登录!"];
//            LogInViewController *logIn = [[LogInViewController alloc] init];
//            [self.navigationController pushViewController:logIn animated:YES];
//            return;
//        }
////        for (UIViewController *viewController in self.navigationController.viewControllers) {
////            NSStringFromClass(viewController class);
////            NSLog(@"%@",viewController);
//        NSLog(@"%@",NSClassFromString(@"GroupPurchaseCenterViewController"));
//        UIViewController *controller = [[NSClassFromString(@"GroupPurchaseCenterViewController") alloc] init];
//        [self.navigationController pushViewController:controller animated:YES];
////        controller = NSClassFromString(@"GroupPurchaseCenterViewController");
////            if ([NSStringFromClass([GroupPurchaseCenterViewController class]) isEqualToString:@"GroupPurchaseCenterViewController"]) {
////                
////                
////            }
////            if ([viewController isKindOfClass:[GroupPurchaseCenterViewController class]] ) {
////
//////                UIViewController *contro = [[UIViewController alloc] init];
//////                contro = viewController;
////                [self.navigationController pushViewController:viewController animated:YES];
////            }
////        }
////        GroupPurchaseCenterViewController *groupPurchaseCenter = [[GroupPurchaseCenterViewController alloc] init];
////        [self.navigationController pushViewController:groupPurchaseCenter animated:YES];
//    }else if ([model.id isEqual:@"17"]){//停车收费
//        if ([model.isWait isEqualToString:@"2"]) {
//            ExceptViewController *Except = [[ExceptViewController alloc] initWithName:model.name];
//            [self.navigationController pushViewController:Except animated:YES];
//            return;
//        }
//        if (![StoreageMessage isStoreMessage]) {
//            [self.view makeToast:@"请先登录!"];
//            LogInViewController *logIn = [[LogInViewController alloc] init];
//            [self.navigationController pushViewController:logIn animated:YES];
//            return;
//        }
//        ParkingChargeViewController *parkingCharge = [[ParkingChargeViewController alloc] init];
//        [self.navigationController pushViewController:parkingCharge animated:YES];
//    }else if ([model.id isEqual:@"5"]){//保姆保洁
//        if ([model.isWait isEqualToString:@"2"]) {
//            ExceptViewController *Except = [[ExceptViewController alloc] initWithName:model.name];
//            [self.navigationController pushViewController:Except animated:YES];
//            return;
//        }
//        if (![StoreageMessage isStoreMessage]) {
//            [self.view makeToast:@"请先登录!"];
//            LogInViewController *logIn = [[LogInViewController alloc] init];
//            [self.navigationController pushViewController:logIn animated:YES];
//            return;
//        }
//        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
//        CleanerViewController *cleanerViewController = [cleanerSB instantiateViewControllerWithIdentifier:@"cleaner"];
//        cleanerViewController.target = self;
//        [self.navigationController pushViewController:cleanerViewController animated:YES];
//    }else if ([model.id isEqualToString:@"4"]){//房屋出租
//        if ([model.isWait isEqualToString:@"2"]) {
//            ExceptViewController *Except = [[ExceptViewController alloc] initWithName:model.name];
//            [self.navigationController pushViewController:Except animated:YES];
//            return;
//        }
//        RentViewController *controller = [[RentViewController alloc] init];
//        [self.navigationController pushViewController:controller animated:YES];
//    }else if ([model.id isEqualToString:@"18"]){//戴尔商店
//        if ([model.isWait isEqualToString:@"2"]) {
//            ExceptViewController *Except = [[ExceptViewController alloc] initWithName:model.name];
//            [self.navigationController pushViewController:Except animated:YES];
//            return;
//        }
//        MainModel *model = self.dataArr[scrBtn.tag - 1200];
//        FoodCommonViewController *common = [[FoodCommonViewController alloc] initWithTitleName:model.name andNSString:model.requrl andCommuntityId:model.xqid andSortNum:1 andCatergoryId:model.id.integerValue andCommuntityArr:self.communtityArr andLoaction:self.latAndlongTitude andCityName:self.cityName];
//        [self.navigationController pushViewController:common animated:YES];
//    }else if ([model.id isEqualToString:@"11"]){
//        if ([model.isWait isEqualToString:@"2"]) {
//            ExceptViewController *Except = [[ExceptViewController alloc] initWithName:model.name];
//            [self.navigationController pushViewController:Except animated:YES];
//            return;
//        }
//        if (![StoreageMessage isStoreMessage]) {
//            [self.view makeToast:@"请先登录!"];
//            LogInViewController *logIn = [[LogInViewController alloc] init];
//            [self.navigationController pushViewController:logIn animated:YES];
//            return;
//        }
//        PersonalFeedbackViewController *personalFeedBack = [[PersonalFeedbackViewController alloc] init];
//        [self.navigationController pushViewController:personalFeedBack animated:YES];
//    }else if ([model.id isEqualToString:@"19"]){
//        
//    }
//    
}

-(void)loadInfo{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    
    [twoPacking getUrl:CWHFL andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *dic in getResult[@"datas"]) {
            [arr1 addObject:dic[@"Name"]];
            [arr2 addObject:dic[@"ID"]];
        }
        NSMutableArray *clasArr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < [arr1.mutableCopy count]; i ++) {
            GroupPurchaseCenterViewController *group = [[GroupPurchaseCenterViewController alloc]init];
            group.Id = [NSString stringWithFormat:@"%@",arr2[i]];
//            [group class];
            [clasArr addObject:[group class]];
        }
        NSLog(@"%@",clasArr);
        GroupWMPageViewController *pageVC = [[GroupWMPageViewController alloc] initWithViewControllerClasses:clasArr andTheirTitles:arr1.mutableCopy];
        pageVC.pageAnimatable = YES;
        pageVC.menuItemWidth = 85;
        pageVC.menuHeight = 45 ;
        pageVC.postNotification = YES;
        pageVC.bounces = YES;
        pageVC.delegate = self;
        pageVC.ids = arr2.mutableCopy;
//        pageVC.dataSource = self;
//        pageVC.selectIndex = 0;
        pageVC.title = @"村味汇";
        [self.navigationController pushViewController:pageVC animated:YES];
    }];
    
}




//bottom
-(void)makeBottom{
    NSArray *imgArr = @[@"gr-pretermit.png",@"gw-pretermit",@"ding-pretermit.png",@"sc-pretermit.png",@"sz.png"];
    NSArray *lightArr = @[@"gr-pretermit.png",@"gw-pretermit",@"ding-pretermit.png",@"sc-pretermit.png",@"sz.png"];
    NSArray *titleArr = @[@"个人中心",@"购物车",@"订单",@"收藏",@"设置"];
    
    MainBottomView *bottomView = [[MainBottomView alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER - 49 * self.versionTralate, WIDTH_CONTROLLER, 49 * self.versionTralate) andImgArr:imgArr andTitleArr:titleArr andBgImg:@"" andHeilightImg:lightArr];
    bottomView.target = self;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];

}
//返回底部点击哪一个
-(void)returnBottomTag:(NSInteger)numbottomBtn{
    if (numbottomBtn != 0 && numbottomBtn != 4) {
        if (![StoreageMessage isStoreMessage]) {
            [self.view makeToast:@"请先登录!"];
            LogInViewController *logIn = [[LogInViewController alloc] init];
            [self.navigationController pushViewController:logIn animated:YES];
            return;
        }
    }
    BaseViewController *ctrl = nil;
    switch (numbottomBtn) {
        case 0:{
            ctrl = [[MenberViewController alloc] init];
            break;
        }
        case 1:{
            ctrl = (BaseViewController *)[[JSCartViewController alloc] init];
            break;
        }
        case 2:{
            if (![StoreageMessage isStoreMessage]) {
                [self.view makeToast:@"请先登录!"];
                LogInViewController *logIn = [[LogInViewController alloc] init];
                [self.navigationController pushViewController:logIn animated:YES];
                return;
            }
            GroupWMPageViewController *pageVC = [[GroupWMPageViewController alloc] initWithViewControllerClasses:@[[MineGroupViewController class],[MineOneViewController class],[MineGroupTwoViewController class],[MineGroupThreeViewController class]] andTheirTitles:@[@"全部",@"待付款",@"待收货",@"已收货"]];
            pageVC.pageAnimatable = YES;
            pageVC.menuItemWidth = 85;
            pageVC.menuHeight = 45 ;
            pageVC.postNotification = YES;
            pageVC.bounces = YES;
            pageVC.title = @"我的订单";
            [self.navigationController pushViewController:pageVC animated:YES];
            break;
        }
        case 3:{
            ctrl = [[MemberFavoriteViewController alloc] init];
            break;
        }
        case 4:{
            if (![StoreageMessage isStoreMessage]) {
                [self.view makeToast:@"请先登录!"];
                LogInViewController *logIn = [[LogInViewController alloc] init];
                [self.navigationController pushViewController:logIn animated:YES];
                return;
            }else{
            ctrl = [[MemberSettingViewController alloc] init];
            }
            break;
        }
        default:
            break;
    }
    [self.navigationController pushViewController:ctrl animated:YES];
}
#pragma mark 返回小区的Id
-(void)returnCommuityId:(LocationModel *)locationModel{
    self.communtityId = locationModel.xqid;
    self.commuityName.text = locationModel.xqname;
    [StoreageMessage storeCommuntity:locationModel.xqname];
    [StoreageMessage storeCommuntityId:locationModel.xqid];
    
    [self.commuityName sizeToFit];
    self.pullDownImg.frame = CGRectMake( self.nameWidth + 0 * self.versionTralate + self.commuityName.frame.size.width + 8 * self.versionTralate, (44 - 15) / 2 + 5, 20 * self.versionTralate, 15);
    self.selectNavView.frame = CGRectMake(0, 0, self.nameWidth + 0 * self.versionTralate + self.commuityName.frame.size.width + 35 * self.versionTralate, 44);
    [self loadMainData];
}
#pragma mark 定位
-(void)makeLocation{
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位服务当前可能尚未打开，请设置打开!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        [self gainCommuntity];
        return;
    }
    //如果没有授权则请求用户授权
    if (IOS8) {
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
            [_locationManager requestWhenInUseAuthorization];
        }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
            //设置代理
            _locationManager.delegate = self;
            //设置定位精度
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            //定位频率,每隔多少米定位一次
            CLLocationDistance distance = 10.0;//十米定位一次
            _locationManager.distanceFilter = distance;
        }
        //设置代理
        _locationManager.delegate = self;
        //设置定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance = 10.0;//十米定位一次
        _locationManager.distanceFilter = distance;
        [_locationManager requestAlwaysAuthorization];//添加这句
        [_locationManager startUpdatingLocation];

    }else{
        //启动跟踪定位
        
        [_locationManager requestAlwaysAuthorization];//添加这句
        [_locationManager startUpdatingLocation];
    }
}
#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
//    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    NSString *altAndlongitude =  [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
    if (![altAndlongitude isEqualToString:[StoreageMessage getLatAndLong]]) {
        self.latAndlongTitude = altAndlongitude;
        [StoreageMessage storeLatAndLong:altAndlongitude];
        [self gainCommuntity];//不相等，直接请求小区

    }else{
        if (self.communtityArr.count == 0) {
            [self gainCommuntity];
        }
    }
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
//    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
   
}
#pragma mark 根据坐标取得地名
//-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
//    //反编码不行，以后处理
//    //反地理编码
//    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
//    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
//    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        CLPlacemark *placemark=[placemarks firstObject];
//#warning message
//        NSLog(@"address%@",placemark.addressDictionary);
//        for (id temp in [placemark.addressDictionary allKeys]) {
//            if([temp isEqual:@"FormattedAddressLines"]){
//                for (id temp2 in placemark.addressDictionary[temp]) {
//                    NSLog(@"FormattedAddressLines:%@",temp2);
//                }
//                
//            }
//            NSLog(@"key:%@,value:%@",temp,placemark.addressDictionary[temp]);
//        }
////        NSString *nameAdd = [placemark.addressDictionary objectForKey:@"Name"];
//       // [StoreageMessage storeAddress:nameAdd];
//        if (![self.commuityName.text isEqualToString:placemark.addressDictionary[@"SubLocality"]]) {
//            NSLog(@"%@",placemark.addressDictionary[@"SubLocality"]);
//            //self.commuityName.text = placemark.addressDictionary[@"SubLocality"];
////            [self gainCommuntity];
//        }else{
//            //[self gainCommuntity];
//        }
//        
////        if (![self.cityName isEqualToString:placemark.addressDictionary[@"State"]]) {
////            self.cityName = placemark.addressDictionary[@"State"];
////        }
//        //self.commuityName.text = nameAdd;
//        //[StoreageMessage storeCity:[placemark.addressDictionary objectForKey:@"City"]];
//        //self.cityName = [StoreageMessage getCity];
//        //[StoreageMessage storeCommuntity:[placemark.addressDictionary objectForKey:@"Name"]];
//    }];
//}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}
#pragma mark 获取附近小区
-(void)gainCommuntity{
    self.rom = [AFHTTPSessionManager manager];
    self.rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"text/plain",@"application/json",nil];
    NSString *url = [[NSString stringWithFormat:COMMUNITYDATA,[StoreageMessage getCity],self.latAndlongTitude,(long)1,(long)20] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.rom GET: url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [StoreageMessage getErrorMessage:[NSString stringWithFormat:@"%@",responseObject] fromUrl:url];
        [self.communtityArr removeAllObjects];
        for (NSDictionary *temp in responseObject[@"buzdata"]) {
            LocationModel *model = [[LocationModel alloc] initWithDictionary:temp];
            [self.communtityArr addObject:model];
            NSLog(@"xqname:%@",model.xqname);
        }
        if ([responseObject[@"buzdata"] count] != 0) {
            self.communtityId = responseObject[@"buzdata"][0][@"xqid"];
            self.commuityName.text = responseObject[@"buzdata"][0][@"xqname"];
            [self.commuityName sizeToFit];
            [StoreageMessage storeCommuntityId:self.communtityId];
            [StoreageMessage storeCommuntity:responseObject[@"buzdata"][0][@"xqname"]];
            LocationModel *model = [[LocationModel alloc]init];
            
            [StoreageMessage storeLatAndLong:responseObject[@"buzdata"][0][@"location"]];
//            [StoreageMessage storeCity:@"北京市"];

//                    [self returnCommuityId:@"86420010000004"];
            [StoreageMessage storeCityId:@"11000000"];
            model.xqid = responseObject[@"buzdata"][0][@"xqid"];
            model.xqname = responseObject[@"buzdata"][0][@"xqname"];
//            [self returnCommuityId:model];
            
            self.pullDownImg.frame = CGRectMake( self.nameWidth + 0 * self.versionTralate + self.commuityName.frame.size.width + 2 * self.versionTralate, (44 - 15) / 2  + 2,  15* self.versionTralate, 15 *self.versionTralate);
           // [[UIImageView alloc] initWithFrame:CGRectMake(self.nameWidth + 0 * self.versionTralate + self.commuityName.frame.size.width + 4 * self.versionTralate, (44 - 10) / 2, 10 * self.versionTralate, 10)];
            self.selectNavView.frame = CGRectMake(0, 0, self.nameWidth + self.commuityName.frame.size.width + 35 * self.versionTralate, 44);
            [self returnCommuityId:model];

//            [self loadDataMain:self.communtityId];
//            [self loadMainData];
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [StoreageMessage getErrorMessage:[NSString stringWithFormat:@"%@",error] fromUrl:url];

       // [[NSURLCache sharedURLCache] removeAllCachedResponses];
        NSLog(@"%@",error);
    }];
}
#pragma mark HUD的代理方法,关闭HUD时执行
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}
-(void) myProgressTask{
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        self.hudProgress.progress = progress;
        usleep(50000);
    }
    
}
#pragma mark scrollview的delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.timeScr) {
        NSInteger num = scrollView.contentOffset.x / WIDTH_CONTROLLER;
        self.pageCon.currentPage = num;
        return;
    }
    NSInteger num = scrollView.contentOffset.x / WIDTH_CONTROLLER;
    UIPageControl *pageCon = (UIPageControl *)[self.view viewWithTag:12000];
    pageCon.currentPage = num;
}
#pragma mark 自动旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskAll);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)lastDataLoat{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:RECOMMEND,[StoreageMessage getCommuntityId]] andFinishBlock:^(id getResult) {
        NSLog(@"12121212ppppp：%@",getResult);
        NSMutableArray *arr1 =[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr2 =[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr3 =[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr4 =[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *arr5 =[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            [arr1 addObject:dic[@"picturePath"]];
            [arr2 addObject:dic[@"goodsName"]];
            [arr3 addObject:dic[@"goodsPrice"]];
            if ([dic[@"actionType"] isEqualToString:@"1"]) {
                [arr4 addObject:dic[@"guideAction"]];
                [arr5 addObject:@"kong"];
            }else{
                [arr4 addObject:dic[@"guideAction"][@"ios"][@"controller"]];
                [arr5 addObject:dic[@"guideAction"][@"ios"][@"params"]];
            }
        }
        self.lastImageArr = arr1.mutableCopy;
        self.lastMoneyArr = arr3.mutableCopy;
        self.lastTitleArr = arr2.mutableCopy;
        self.lastControllersArr = arr4.mutableCopy;
        self.lastParamsArr = arr5.mutableCopy;
        //每行显示两个
//        [self makeLastViewWithCount:self.lastTitleArr.count andTitles:self.lastTitleArr andMoneys:self.lastMoneyArr andImages:self.lastImageArr];
        //每行显示一个
        [self make1LastViewWithCount:self.lastTitleArr.count andTitles:self.lastTitleArr andMoneys:self.lastMoneyArr andImages:self.lastImageArr];
    }];
}

-(void)make1LastViewWithCount:(NSInteger )count andTitles:(NSArray *)titleArr andMoneys:(NSArray *)moneyArr andImages:(NSArray *)imageArr{
    NSLog(@"%@",titleArr);
    NSInteger height;
    if (self.midImageArr.count >5) {
        height = 430;
    }else{
        height = 330;
    }
    self.Scro.contentSize = CGSizeMake(WIDTH_CONTENTVIEW,height * self.versionTralate+ count * 160 * self.versionTralate );

    NSLog(@"%ld",(long)height);
    for (NSInteger i = 0; i < count ; i ++) {
        for (UIView *view in self.Scro.subviews) {
            if (view.tag == 100086+i) {
                [view removeFromSuperview];
            }
        }
    }
    for (NSInteger i = 0; i < count ; i ++) {
            
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,height * self.versionTralate+ i * 136 * self.versionTralate, WIDTH_CONTENTVIEW, 131 * self.versionTralate)];
        view.tag = 100086 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:tap];
//        int R = (arc4random() % 256) ;
//        int G = (arc4random() % 256) ;
//        int B = (arc4random() % 256) ;
        view.backgroundColor = [UIColor whiteColor];
        [self.Scro addSubview:view];
//        self.Scro.backgroundColor = [UIColor cyanColor];
        [self  makeView1WithTitle:titleArr[i] andMoney:moneyArr[i] andImageUrl:imageArr[i] InView:view];
    }
}

-(void)makeLastViewWithCount:(NSInteger )count andTitles:(NSArray *)titleArr andMoneys:(NSArray *)moneyArr andImages:(NSArray *)imageArr{
    NSInteger height;
    if (self.midImageArr.count >5) {
        height = 430;
    }else{
        height = 330;
    }
    self.Scro.contentSize = CGSizeMake(WIDTH_CONTENTVIEW,height * self.versionTralate+ (count /2) * 136 * self.versionTralate );
    for (NSInteger i = 0; i < count ; i ++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW/2 * (i%2),height * self.versionTralate+ (i /2) * 136 * self.versionTralate, WIDTH_CONTENTVIEW/2, 131 * self.versionTralate)];
        view.tag = 100086 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:tap];
        view.backgroundColor = [UIColor whiteColor];
        [self.Scro addSubview:view];
        [self  makeViewWithTitle:titleArr[i] andMoney:moneyArr[i] andImageUrl:imageArr[i] InView:view];
    }
}

-(void) makeView1WithTitle:(NSString *)title andMoney:(NSString *)money andImageUrl:(NSString *)image InView:(UIView *)view{
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.versionTralate, view.frame.size.height - 20 * self.versionTralate, view.frame.size.width/2, 30 * self.versionTralate)];
    titLab.text = title;
    titLab.textColor = [UIColor colorWithRed:51/255.0 green :51/255.0 blue:51/255.0 alpha:1];
    [titLab sizeToFit];
    titLab.font = [UIFont systemFontOfSize:15 *self.versionTralate];
    [view addSubview:titLab];
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width - 75 * self.versionTralate, view.frame.size.height - 20 * self.versionTralate, view.frame.size.width/2, 30 * self.versionTralate)];
    if (money.floatValue == 0) {
        moneyLab.text = @"";
    }else{
        moneyLab.text = [NSString stringWithFormat:@"限时减¥%@",money];
    }
    moneyLab.textColor = [UIColor colorWithRed:255/255.0 green:39/255.0 blue:80/255.0 alpha:1];
    [moneyLab sizeToFit];
    moneyLab.font = [UIFont systemFontOfSize:11 *self.versionTralate];
    [view addSubview:moneyLab];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( 12 * self.versionTralate,0, view.frame.size.width - 24 * self.versionTralate, 105 * self.versionTralate)];
    NSLog(@"%f--%f",view.frame.size.width - 24 * self.versionTralate, 105 * self.versionTralate);
    imageView.backgroundColor = [UIColor cyanColor];
//    imageView.center = CGPointMake(view.frame.size.width /3 * 2 + 20 * self.versionTralate, view.frame.size.height/2);
    [imageView sd_setImageWithURL:[NSURL URLWithString:image]];
    [view addSubview:imageView];
}

-(void) makeViewWithTitle:(NSString *)title andMoney:(NSString *)money andImageUrl:(NSString *)image InView:(UIView *)view{
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.versionTralate,50 * self.versionTralate, view.frame.size.width/2, 30 * self.versionTralate)];
    titLab.text = title;
    titLab.textColor = [UIColor colorWithRed:51/255.0 green :51/255.0 blue:51/255.0 alpha:1];
    [titLab sizeToFit];
    titLab.font = [UIFont systemFontOfSize:15 *self.versionTralate];
    [view addSubview:titLab];
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.versionTralate,70 * self.versionTralate, view.frame.size.width/2, 30 * self.versionTralate)];
    if (money.floatValue == 0) {
    moneyLab.text = @"";
    }else{
    moneyLab.text = [NSString stringWithFormat:@"限时减¥%@",money];
    }
    moneyLab.textColor = [UIColor colorWithRed:255/255.0 green:39/255.0 blue:80/255.0 alpha:1];
    [moneyLab sizeToFit];
    moneyLab.font = [UIFont systemFontOfSize:11 *self.versionTralate];
    [view addSubview:moneyLab];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 71 * self.versionTralate, 48 * self.versionTralate)];
    imageView.backgroundColor = [UIColor cyanColor];
    imageView.center = CGPointMake(view.frame.size.width /3 * 2 + 20 * self.versionTralate, view.frame.size.height/2);
    [imageView sd_setImageWithURL:[NSURL URLWithString:image]];
    [view addSubview:imageView];
}

-(void)doTap:(UITapGestureRecognizer *)center{
    //ExceptViewController 敬请期待

//    if ([self.lastParamsArr[center.view.tag - 100086] isEqualToString:@"kong"]) {
    
    NSLog(@"%@---%@",self.lastParamsArr[center.view.tag - 100086],self.lastControllersArr[center.view.tag - 100086]);
    if ([self.lastControllersArr[center.view.tag - 100086] isEqualToString:@"PartyBuildDetialViewController"]) {
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        NSLog(@"%@",self.lastParamsArr[center.view.tag - 100086][@"url"]);

        [twoPacking getUrl:[NSString stringWithFormat:@"%@",self.lastParamsArr[center.view.tag - 100086][@"url"]] andFinishBlock:^(id getResult) {
            NSLog(@"%@",getResult);
            PartyBuildDetialViewController *detial = [[PartyBuildDetialViewController alloc] initWithTittle:getResult[@"datas"][0][@"anTitle"] andDetial:getResult[@"datas"][0][@"anContent"] andTime:getResult[@"datas"][0][@"anTime"]];
            [self.navigationController pushViewController:detial animated:YES];
            
            
        }];
        return;
    }
    
    
    if ([self.lastParamsArr[center.view.tag - 100086] isKindOfClass:[NSString class]]) {
        BaseViewController *controller = [[FirstScrTimerViewController alloc] init];
        controller.strParams = self.lastControllersArr[center.view.tag - 100086];
        NSLog(@"%@",controller.strParams);
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([self.lastControllersArr[center.view.tag - 100086] isEqualToString:@"GroupRobGoodsDetialViewController"]) {
        [self GroupPurchaseCenterViewControllerWithPrams1:self.lastParamsArr[center.view.tag - 100086][@"cpid"]];
    }else{
        BaseViewController *controller = [[NSClassFromString(self.lastControllersArr[center.view.tag - 100086]) alloc] init];
        controller.dicParams = self.lastParamsArr[center.view.tag - 100086];
        [self.navigationController pushViewController:controller animated:YES];
    }
}


//导航栏颜色渐变

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.topView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:self.Scro.contentOffset.y / 300 * self.versionTralate];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:self.Scro.contentOffset.y / 300 * self.versionTralate]] forBarMetrics:UIBarMetricsDefault];
}


-(UIImage *)imageWithBgColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



//-(void)viewWillDisappear:(BOOL)animated{
//    //self.navigationController.navigationBarHidden = NO;
//   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
