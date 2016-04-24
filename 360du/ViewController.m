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
#import "MainModel.h"
#import "LocationCommunityViewController.h"
#import "SearchViewController.h"
#import "FoodCommonViewController.h"
#import "GainLocationLatiguateAndLongtitute.h"
#import "AFNetworkTwoPackaging.h"
#import "FileOperation.h"
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
#import "AlipayViewController.h"
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
//#import <MBProgressHUD/MBProgressHUD.h>
#import "CleanerViewController.h"
NSString * const HUDDismissNotification = @"HUDDismissNotification";

#define MAINVIEWCELL @"mainViewCell"
@interface ViewController ()<UITextFieldDelegate,UIScrollViewDelegate,CLLocationManagerDelegate,MBProgressHUDDelegate>{
CLLocationManager *_locationManager;
}

@property(nonatomic,assign)CGFloat versionTralate;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)AFHTTPRequestOperationManager *rom;
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
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [self makeNav];
    self.navigationController.navigationBarHidden = NO;

    if (self.timerArr.count != 0) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scheduleTime) userInfo:nil repeats:YES];

    }
    
   // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self makeInit];
    //[self laodData];
    [self loadScrTime];
    [self makeLocation];
    self.versionTralate = [VersionTranlate returnVersionRateAnyIphone:WIDTH_CONTROLLER];
    NSLog(@"%f",self.versionTralate); 
    //self.view.backgroundColor = [UIColor whiteColor];
    [self makeUI];
    [self makeHUd];
    // Do any additional setup after loading the view, typically from a nib.
}
//获取位置

-(void)makeInit{
    if (![StoreageMessage isStoreMessageLatAndLong]) {
        [StoreageMessage storeLatAndLong:@"116.453250,39.867688"];
        [StoreageMessage storeCity:@"北京市"];
        [StoreageMessage storeCommuntity: @"京瑞大厦"];
        [StoreageMessage storeCommuntityId:@"86420010000004"];
    }
//    [StoreageMessage storeCity:@"北京市"];
    self.communtityId = [StoreageMessage getCommuntityId];
    self.commuityName.text = [StoreageMessage getCommuntity];
    self.cityName = [StoreageMessage getCity];
    self.latAndlongTitude = [StoreageMessage getLatAndLong];
    self.communtityArr = [NSMutableArray arrayWithCapacity:0];
    [StoreageMessage storeCity:self.cityName];

//    [StoreageMessage storeLatAndLong:@"120.2453250,37.867688"];
//    [StoreageMessage storeCity:@"河北省"];
//    [StoreageMessage storeCommuntity: @"金海岸1号"];
//    [StoreageMessage storeCommuntityId:@"86420010000004"];
    
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


-(void)laodData{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.rom = [AFHTTPRequestOperationManager manager];
    self.rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
    [self.rom GET:MAINUIDATA parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hudWasHidden:self.hudProgress];
        for (NSDictionary *temp in responseObject) {
            MainModel *model = [[MainModel alloc] initWithDictionary:temp];
            [self.dataArr addObject:model];
        }
        [self makeScrollView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [self hudWasHidden:self.hudProgress];
//        NSLog(@"%@",[error description]);
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
//        [alertView show];
//        return ;
    }];
  // UISearchBar *searchBar = nil;
    //searchBar.searchBarStyle =
//    searchBar.
//    searchBar.backgroundColor = [UIColor blueColor];
}
//选择小区
- (void)loadDataMain:(NSString *)commititutyAddress{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.rom = [AFHTTPRequestOperationManager manager];
    self.rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    NSString *url = [NSString stringWithFormat:MAINVIEWCOMMINUTITADDRESS,commititutyAddress];
   // [self makeHUd];
       [self.rom GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hudWasHidden:self.hudProgress];
           [self.dataArr removeAllObjects];
        for (NSDictionary *temp in responseObject) {
            MainModel *model = [[MainModel alloc] initWithDictionary:temp];
            [self.dataArr addObject:model];
        }
        [self makeScrollView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [self hudWasHidden:self.hudProgress];
        //        NSLog(@"%@",[error description]);
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        //        [alertView show];
        //        return ;
    }];
}
-(void)makeUI{
//    [self makeNav];
   // [self makeTitleImg];
    //[self makeTimeScr:6 andTimeArr:nil];
    //[self makeScrollView];
    [self makeBottom];
    
}
//加载滚动图的
- (void)loadScrTime{
    self.rom = [AFHTTPRequestOperationManager manager];
    self.rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    //[self makeHUd];
    NSString *url = [NSString stringWithFormat:MAINSCRFIRSR,[StoreageMessage getCommuntityId]];
    [self.rom GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[self hudWasHidden:self.hudProgress];
        NSLog(@"%@",[NSString stringWithFormat:MAINSCRFIRSR,@"86420010000004"]);
        if ([responseObject[@"code"] isEqualToString:@"000000"]) {
            self.timerArr = responseObject[@"datas"];
            [self makeTimeScr:self.timerArr.count andTimeArr:self.timerArr];
        }else{
            
        }
//        for (NSDictionary *temp in responseObject) {
//            MainModel *model = [[MainModel alloc] initWithDictionary:temp];
//            [self.dataArr addObject:model];
//        }
//        [self makeScrollView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[[NSURLCache sharedURLCache] removeAllCachedResponses];
        NSLog(@"error:%@",error);
       // [self hudWasHidden:self.hudProgress];
        //        NSLog(@"%@",[error description]);
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        //        [alertView show];
        //        return ;
    }];
}
//定时滚动条
- (void)makeTimeScr:(NSInteger)count andTimeArr:(NSArray *)timeArr{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, 60 * self.versionTralate)];
    [self.view addSubview:scrollView];
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
        UIButton *scrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [scrBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:timeArr[i][@"picturePath"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"banner"]];
        //[scrBtn sd_setImageWithURL:[NSURL URLWithString:timeArr[i][@"picturePath"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"banner"]];
        [scrollView addSubview:scrBtn];
        scrBtn.frame = CGRectMake(WIDTH_CONTROLLER * i, 0, WIDTH_CONTROLLER, scrollView.frame.size.height);
        scrBtn.tag = 1850 + i;
        [scrBtn addTarget:self action:@selector(timerDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIPageControl *pageCon = [[UIPageControl alloc] initWithFrame:CGRectMake(20 * self.versionTralate, scrHeight - 20 * self.versionTralate, WIDTH_CONTROLLER - 40 * self.versionTralate, 15 * self.versionTralate)];
    pageCon.numberOfPages = count;
    [self.view addSubview:pageCon];
    pageCon.pageIndicatorTintColor = [UIColor lightGrayColor];

    //pageCon.backgroundColor = [UIColor blackColor];
    self.pageCon = pageCon;
    self.timerCount = 0;
    self.arrCount = count;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scheduleTime) userInfo:nil repeats:YES];
}
- (void)scheduleTime{
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
    
    NSDictionary *dict = self.timerArr[timerDown.tag - 1850];
    NSInteger type = [dict[@"actionType"] integerValue];
    BaseViewController *ctrl = nil;
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
                
                ctrl = [[FoodCommonViewController alloc] initWithTitleName:tempDict[@"categoryName"] andNSString:@"" andCommuntityId:self.communtityId andSortNum:1 andCatergoryId:                [tempDict[@"categoryID"] intValue] andCommuntityArr:self.communtityArr andLoaction:self.latAndlongTitude andCityName:self.cityName];
            }else if (typeInt == 2){
                ctrl = [[FoodMerchantListViewController alloc] initWithId:tempDict[@"merchantId"]];
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"landi.png"] forBarMetrics:UIBarMetricsDefault];

    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    self.selectNavView = view;
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"快快猫";
    lable.font = [UIFont systemFontOfSize:18 * self.versionTralate];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(-15 * self.versionTralate, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    //竖线
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(-5 * self.versionTralate + lable.frame.size.width + 1 * self.versionTralate, (44 - 15) / 2, 1 * self.versionTralate, 15)];
    lineLab.backgroundColor = SMSColor(252, 192, 191);
    [view addSubview:lineLab];
    //小区名称
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectZero];
    lable1.text = [StoreageMessage getCommuntity];
    lable1.font = [UIFont systemFontOfSize:16 * self.versionTralate];
    lable1.textColor = SMSColor(252, 192, 191);
    [lable1 sizeToFit];
    lable1.frame = CGRectMake(0 * self.versionTralate + lable.frame.size.width ,  (44 - 15) / 2 - 2, lable1.frame.size.width, 15);
    [view addSubview:lable1];
    self.commuityName = lable1;
    
    self.nameWidth = lable.frame.size.width;
    view.frame = CGRectMake(0, 0, lable.frame.size.width + 0 * self.versionTralate + lable1.frame.size.width, 44);
    self.pullDownImg = [[UIImageView alloc] initWithFrame:CGRectMake(lable.frame.size.width + 0 * self.versionTralate + lable1.frame.size.width + 4 * self.versionTralate, (44 - 15) / 2 - 2, 10 * self.versionTralate, 10)];
    self.pullDownImg.image = [UIImage imageNamed:@"下拉.png"];
    UIImage *tint1 = [self.pullDownImg.image rt_tintedImageWithColor: SMSColor(252, 192, 191)];
    [self.pullDownImg setImage:tint1];
    [view addSubview:self.pullDownImg];
    
    view.frame = CGRectMake(0, 0, lable.frame.size.width + 0 * self.versionTralate + lable1.frame.size.width + 35 * self.versionTralate, 44);
    self.selectCityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectCityBtn.frame = view.bounds;
    [view addSubview:self.selectCityBtn];
    [self.selectCityBtn setTitle:@"" forState:UIControlStateNormal];
    [self.selectCityBtn addTarget:self action:@selector(backDown:) forControlEvents:UIControlEventTouchUpInside];
    self.selectCityBtn.tag = 1000;
//    UIButton *pullDown = [UIButton buttonWithType:UIButtonTypeCustom];
//    pullDown.frame = CGRectMake(lable.frame.size.width + 0 * self.versionTralate + lable1.frame.size.width - 10 * self.versionTralate, (44 - 15) / 2, 20 * self.versionTralate, 15);
//    pullDown.clipsToBounds = YES;
//    [pullDown setImage:[UIImage imageNamed:@"下拉.png"] forState:UIControlStateNormal];
//    [pullDown addTarget:self action:@selector(backDown:) forControlEvents:UIControlEventTouchUpInside];
//    pullDown.tag = 1000;
//    
//    view.frame = CGRectMake(0, 0, lable.frame.size.width + 0 * self.versionTralate + lable1.frame.size.width + 25 * self.versionTralate, 44);
//    
//    [view addSubview:pullDown];
    
    UIBarButtonItem *left1 = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
    //UIBarButtonItem *left2 = [[UIBarButtonItem alloc] initWithCustomView:pullDown];
    //left2.tag = 1100;
    self.navigationItem.leftBarButtonItems = @[left1];
    
    CGFloat height = 150 * self.versionTralate / 606 * 84;
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(WIDTH_CONTROLLER + 30 , 2,40, 40);
    [searchBtn setImage:[UIImage imageNamed:@"kkmlogo108.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(backDown:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.tag = 1001;
    //searchBtn.userInteractionEnabled = NO;
    searchBtn.userInteractionEnabled = NO;
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = right1;
}
-(void)backDown:(UIBarButtonItem *)navBtn{
    if (navBtn.tag == 1000) {
        LocationCommunityViewController *location = [[LocationCommunityViewController alloc] init];
        location.target = self;
        [self.navigationController pushViewController:location animated:YES];
    }else{
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
    [self.view addSubview:btnImg];
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
    [self.mainScr.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.mainScr = nil;
    UIImage *image = [UIImage imageNamed:@"banner.png"];

    CGFloat height = WIDTH_CONTROLLER / image.size.width  * image.size.height;
    if(IPHONE4){
        self.scrHeight = 60 * self.versionTralate + 64;
        
    }else{
        self.scrHeight = height + 64;
    }
    self.scrHeight += 10 * self.versionTralate;
    UIScrollView *mainScr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.scrHeight, self.view.frame.size.width, HEIGHT_CONTROLLER - self.scrHeight - 49 * self.versionTralate)];
    mainScr.pagingEnabled = YES;
    mainScr.delegate = self;
    mainScr.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    CGFloat iconWidth = (WIDTH_CONTROLLER - 10 * self.versionTralate * 3 - 40 * self.versionTralate) / 4;
    CGFloat iconHeight = (iconWidth + 20 + 20 * self.versionTralate);
    if (self.dataArr.count > 12) {
        mainScr.contentSize = CGSizeMake(WIDTH_CONTROLLER * 2, iconHeight * 2 + iconWidth + 20);
        [self makePageContro];
    }else{
        mainScr.contentSize = CGSizeMake(WIDTH_CONTROLLER, iconHeight * 2 + iconWidth + 20);
    }
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        MainModel *model = self.dataArr[i];
        UILabel *iconTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
        iconTitle.text = model.name;
        iconTitle.font = [UIFont systemFontOfSize:14 * self.versionTralate];
        iconTitle.textColor = MAINVIEICONCOLOR;
        [iconTitle sizeToFit];
        [mainScr addSubview:iconTitle];
        iconTitle.center = CGPointMake(20 * self.versionTralate + iconWidth / 2 + (iconWidth + 10 * self.versionTralate ) * (i % 4), iconWidth +  iconHeight * (i / 4) + 10);
        UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        iconBtn.frame = CGRectMake(20 * self.versionTralate + (iconWidth + 10 * self.versionTralate) * (i % 4) , iconHeight * (i / 3), iconWidth, iconWidth);
        if (i >= 12) {
            iconBtn.center = CGPointMake(20 * self.versionTralate + iconWidth / 2 + (iconWidth + 10 * self.versionTralate ) * (i % 4) + WIDTH_CONTROLLER, iconWidth / 2 +  iconHeight * ((i - 12) / 4));
            iconTitle.center = CGPointMake(20 * self.versionTralate + iconWidth / 2 + (iconWidth + 10 * self.versionTralate ) * (i % 4) + WIDTH_CONTROLLER, iconWidth +  iconHeight * ((i - 12) / 4) + 10);
            
        }else{
            iconBtn.center = CGPointMake(20 * self.versionTralate + iconWidth / 2 + (iconWidth + 10 * self.versionTralate ) * (i % 4), iconWidth / 2 +  iconHeight * (i / 4));
        }
        //MainModel *model = self.dataArr[i];
        [iconBtn sd_setImageWithURL:[NSURL URLWithString:model.indeximg] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"001.png"]];
        [iconBtn addTarget:self action:@selector(scrBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        iconBtn.tag = 1200 + i;
        [mainScr addSubview:iconBtn];
        self.mainScr = mainScr;
        
    }
//    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT - 49 - 20, WIDTH, 20)];
//    page.numberOfPages = 2;
//    page.userInteractionEnabled = NO;
//    page.tag = 12000;
//    page.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:page];
}
-(void)makePageContro{
    UIPageControl *pageContro = [[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER - 49 * self.versionTralate - 15 * self.versionTralate, WIDTH_CONTROLLER, 10 * self.versionTralate)];
    pageContro.numberOfPages = 2;
    pageContro.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageContro.currentPageIndicatorTintColor = [UIColor blueColor];
    [self.view addSubview:pageContro];
    //pageContro.backgroundColor = [UIColor lightGrayColor];
    pageContro.userInteractionEnabled = NO;
    pageContro.tag = 12000;
    
}
-(void)scrBtnDown:(UIButton *)scrBtn{
    //1.物业2.便利店3.美酒美食4.送水5.保姆保洁6.药店7.美容美甲8.洗衣9.二手物品10.快递11.粮油蔬菜12.干果水果13.超市14.居家15团购预定16.领劵中心
    MainModel *model = self.dataArr[scrBtn.tag - 1200];

    if ([model.id isEqual:@"1"]) {//物业
        if (![StoreageMessage isStoreMessage]) {
            [self.view makeToast:@"请先登录!"];
            LogInViewController *logIn = [[LogInViewController alloc] init];
            [self.navigationController pushViewController:logIn animated:YES];
            return;
        }

        PropertyListViewController *proList = [[PropertyListViewController alloc] init];
        [self.navigationController pushViewController:proList animated:YES];
    }else if([model.id isEqual:@"2"]){//便利店
        MainModel *model = self.dataArr[scrBtn.tag - 1200];
        FoodCommonViewController *common = [[FoodCommonViewController alloc] initWithTitleName:model.name andNSString:model.requrl andCommuntityId:self.communtityId andSortNum:1 andCatergoryId:model.id.integerValue andCommuntityArr:self.communtityArr andLoaction:self.latAndlongTitude andCityName:self.cityName];
        [self.navigationController pushViewController:common animated:YES];

    }else if ([model.id isEqual:@"16"]){//领劵中心
        PrivilegeCenterViewController *privileageCenter = [[PrivilegeCenterViewController alloc] init];
        [self.navigationController pushViewController:privileageCenter animated:YES];
    }else if ([model.id isEqual:@"15"]){//团购预定
        GroupPurchaseCenterViewController *groupPurchaseCenter = [[GroupPurchaseCenterViewController alloc] init];
        [self.navigationController pushViewController:groupPurchaseCenter animated:YES];
    }else if ([model.id isEqual:@"17"]){//停车收费
        if (![StoreageMessage isStoreMessage]) {
            [self.view makeToast:@"请先登录!"];
            LogInViewController *logIn = [[LogInViewController alloc] init];
            [self.navigationController pushViewController:logIn animated:YES];
            return;
        }
        ParkingChargeViewController *parkingCharge = [[ParkingChargeViewController alloc] init];
        [self.navigationController pushViewController:parkingCharge animated:YES];
    }else if ([model.id isEqual:@"5"]){//保姆保洁
        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
        
        CleanerViewController *cleanerViewController = [cleanerSB instantiateViewControllerWithIdentifier:@"cleaner"];

        [self.navigationController showViewController:cleanerViewController sender:nil];
    }
    
}
//bottom
-(void)makeBottom{
    NSArray *imgArr = @[@"main_myspace_n.png",@"main_order_n.png",@"main_shoucang_n.png",@"main_shezhi_n.png"];
    NSArray *lightArr = @[@"main_myspace_p.png",@"main_order_p.png",@"main_shoucang_p.png",@"main_shezhi_p.png"];
    NSArray *titleArr = @[@"个人中心",@"订单",@"收藏",@"设置"];
    
    MainBottomView *bottomView = [[MainBottomView alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER - 49 * self.versionTralate, WIDTH_CONTROLLER, 49 * self.versionTralate) andImgArr:imgArr andTitleArr:titleArr andBgImg:@"" andHeilightImg:lightArr];
    bottomView.target = self;
    bottomView.backgroundColor = SMSColor(55, 50, 51);
    //bottomView.userInteractionEnabled = NO;
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
            //            LogInViewController *logIn = [[LogInViewController alloc] init];
//            [self.navigationController pushViewController:logIn animated:YES];
            ctrl = [[MenberViewController alloc] init];
            break;
        }
        case 1:{
            
            ctrl = [[MenberOrderViewController alloc] init];
            break;
        }
        case 2:{
            ctrl = [[MemberFavoriteViewController alloc] init];
            break;
        }
            //消息设置
//        case 3:{
//            ctrl = [[MemberMessageViewController alloc] init];
//            break;
//        }
        case 3:{
            ctrl = [[MemberSettingViewController alloc] init];
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
    [self loadDataMain:self.communtityId];
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
            _locationManager.delegate=self;
            //设置定位精度
            _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            //定位频率,每隔多少米定位一次
            CLLocationDistance distance=10.0;//十米定位一次
            _locationManager.distanceFilter=distance;
            
        }
        [_locationManager startUpdatingLocation];

    }else{
        //启动跟踪定位
        [_locationManager startUpdatingLocation];

    }
}
#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
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
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
   
}
#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反编码不行，以后处理
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
#warning message
        NSLog(@"address%@",placemark.addressDictionary);
        for (id temp in [placemark.addressDictionary allKeys]) {
            if([temp isEqual:@"FormattedAddressLines"]){
                for (id temp2 in placemark.addressDictionary[temp]) {
                    NSLog(@"FormattedAddressLines:%@",temp2);
                }
            }
            NSLog(@"key:%@,value:%@",temp,placemark.addressDictionary[temp]);
        }
        NSString *nameAdd = [placemark.addressDictionary objectForKey:@"Name"];
       // [StoreageMessage storeAddress:nameAdd];
        if (![self.commuityName.text isEqualToString:placemark.addressDictionary[@"SubLocality"]]) {
            //self.commuityName.text = placemark.addressDictionary[@"SubLocality"];
            //[self gainCommuntity];
        }else{
            //[self gainCommuntity];
        }
//        if (![self.cityName isEqualToString:placemark.addressDictionary[@"State"]]) {
//            self.cityName = placemark.addressDictionary[@"State"];
//        }
        //self.commuityName.text = nameAdd;
        //[StoreageMessage storeCity:[placemark.addressDictionary objectForKey:@"City"]];
        //self.cityName = [StoreageMessage getCity];
        //[StoreageMessage storeCommuntity:[placemark.addressDictionary objectForKey:@"Name"]];
}];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}
#pragma mark 获取附近小区
-(void)gainCommuntity{
    self.rom = [AFHTTPRequestOperationManager manager];
    self.rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"text/plain",@"application/json",nil];
    NSString *url = [[NSString stringWithFormat:COMMUNITYDATA,[StoreageMessage getCity],self.latAndlongTitude,(long)1,(long)5] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.rom GET: url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

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
            self.pullDownImg.frame = CGRectMake( self.nameWidth + 0 * self.versionTralate + self.commuityName.frame.size.width + 2 * self.versionTralate, (44 - 15) / 2  + 2,  15* self.versionTralate, 15);
           // [[UIImageView alloc] initWithFrame:CGRectMake(self.nameWidth + 0 * self.versionTralate + self.commuityName.frame.size.width + 4 * self.versionTralate, (44 - 10) / 2, 10 * self.versionTralate, 10)];
            self.selectNavView.frame = CGRectMake(0, 0, self.nameWidth + 0 * self.versionTralate + self.commuityName.frame.size.width + 35 * self.versionTralate, 44);
        [self loadDataMain:self.communtityId];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       // [[NSURLCache sharedURLCache] removeAllCachedResponses];
#warning message
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

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskAll);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)viewWillDisappear:(BOOL)animated{
    //self.navigationController.navigationBarHidden = NO;
    [self.timer invalidate];
   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end