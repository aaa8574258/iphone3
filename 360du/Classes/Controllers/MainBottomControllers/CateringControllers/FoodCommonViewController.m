//
//  FoodCommonViewController.m
//  360du
//
//  Created by linghang on 15-4-18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "FoodCommonViewController.h"
#import "CommomFoodModel.h"
#import "CommonFoodCell.h"
#import "AFNetworkTwoPackaging.h"
#import "NSString+URLEncoding.h"
#import "FoodListCategoryModel.h"
#import "FoodMerchantListViewController.h"
#import "CommonFoodFourBtnHead.h"
#import "LocationModel.h"
#import "NSString+URLEncoding.h"
#import "FileOperation.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeaderView.h"
#import "MJRefreshBaseView.h"
#import "FoodBussinessListCollectionViewController.h"
#import "StoreageMessage.h"
#import "JSDropDownMenu.h"

#import "UIView+Toast.h"
#import "LogInViewController.h"
#define COMMOMFOODCELL @"commonFoodCell"
@interface FoodCommonViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,JSDropDownMenuDataSource,JSDropDownMenuDelegate>
{
    MJRefreshHeaderView *_header;
    MJRefreshBaseView *_baseView;
    NSMutableArray *_categoryData1;//分类
    NSMutableArray *_sortData2;//排序
    NSMutableArray *_wefareData3;//福利
    NSMutableArray *_communtityData4;//附近小区

    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    NSInteger _currentData4Index;

    NSInteger _currentData1SelectedIndex;
    JSDropDownMenu *menu;


}
@property(nonatomic,copy)NSString *titleName;
@property(nonatomic,copy)NSString *urlString;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *itemArr;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign)NSInteger allHeight;
@property(nonatomic,copy)NSString *communtityId;//小区Id
@property(nonatomic,assign)NSInteger sortNum;//默认排序
@property(nonatomic,assign)NSInteger categoryId;//分类Id
@property(nonatomic,strong)NSMutableArray *stateArr;
//上边四个按钮
@property(nonatomic,strong)NSMutableArray *fourHeadBtnArr;
@property(nonatomic,copy)NSString *category;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *welfare;
@property(nonatomic,copy)NSString *communtity;
@property(nonatomic,strong)CommonFoodFourBtnHead *fourBtnHead;
@property(nonatomic,strong)NSMutableArray *fourHeadStateArr;//表示四种状态
@property(nonatomic,strong)NSArray *communtityArr;//小区总数
@property(nonatomic,copy)NSString *loactionCommuntity;//经纬度
@property(nonatomic,strong)AFHTTPSessionManager *rom;
@property(nonatomic,copy)NSString *cityName;//城市名称
@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,strong)NSMutableArray *cateAndSortAndWefAndCommArr;
@property(nonatomic,assign)NSInteger jdropInt;//表示第几个,主要用于加载数据，判断是不是第一次，第一次不加载，第二次才加载
//@property(nonatomic,strong)MBProgressHUD *hudProgress;
@end

@implementation FoodCommonViewController
//-(id)initWithTitleName:(NSString *)titleName andNSString:(NSString *)urlString andCommuntityId:(NSString *)communtityId andSortNum:(NSInteger)sortNum andCatergoryId:(NSInteger)categoryId andCommuntityArr:(NSArray *)communtityArr andLoaction:(NSString *)locationStr andCityName:(NSString *)cityName{
//    self = [super init];
//    if (self) {
//        self.titleName = titleName;
////        self.urlString = urlString;
//        self.sortNum = sortNum;
//        self.communtity = communtityId;
//        self.categoryId = categoryId;
//        self.cityName = cityName;
//        self.loactionCommuntity = locationStr;
//        
//        
////        if (communtityArr.count != 0) {
////            [self regainReguestXqid];
////            self.communtityArr = communtityArr;
////        }else{
////            [self loadCommuntity];
////        }
//        //[self loadCommuntity];
//        [self makeInit];
//
//       [self loadData];
//        //1&xqid=86420010000004&sort=1&gotoPage=1&pageSize=2
//               [self makeUI];
//        [self makeHUd];
//        [self loadJSDrop];
//
//        //
//        //self hudWasHidden:<#(MBProgressHUD *)#>
//    }
//    return self;
//}

-(void)viewWillAppear:(BOOL)animated{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _currentData1Index = 0;
    _currentData2Index = 0;
    _currentData3Index = 0;
    _currentData4Index = 0;
    self.category = @"";
    
    NSLog(@"%@",self.dicParams);
    self.loactionCommuntity = [StoreageMessage getLatAndLong];
    self.communtity = [StoreageMessage getCommuntityId];
    self.cityName = [StoreageMessage getCommuntity];
    self.categoryId = 0;
    self.titleName = @"便利店";
    //        self.urlString = urlString;
    self.sortNum = 1;
    
    [self makeNav];
    
    [self makeInit];
    [self loadData];

    //1&xqid=86420010000004&sort=1&gotoPage=1&pageSize=2
    [self makeUI];
    [self makeHUd];
    [self loadJSDrop];
}


-(void)viewDidAppear:(BOOL)animated{

}
////加载图片
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
//初始化JSDropview
- (void)makeJSDropView{
//    NSArray *array1 = @[@"",@"",@"",@"",@"",@"",@""];
    
    _categoryData1 = [NSMutableArray arrayWithCapacity:0];
    [_categoryData1 addObject:@"分类"];
    _sortData2 = [NSMutableArray arrayWithCapacity:0];
    [_sortData2 addObject:@"排序"];
    _wefareData3 = [NSMutableArray arrayWithCapacity:0];
    [_wefareData3 addObject:@"福利"];
    _communtityData4 = [NSMutableArray arrayWithCapacity:0];
    [_communtityData4 addObject:@"附近小区"];
    self.cateAndSortAndWefAndCommArr = [NSMutableArray arrayWithCapacity:0];
    [self.cateAndSortAndWefAndCommArr addObject:_categoryData1];
    [self.cateAndSortAndWefAndCommArr addObject:_sortData2];
    [self.cateAndSortAndWefAndCommArr addObject:_wefareData3];
    [self.cateAndSortAndWefAndCommArr addObject:_communtityData4];
    menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:40 * self.numSingleVesion];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
//    menu.indicatorColor = [UIColor redColor];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
//    menu.separatorColor = [UIColor whiteColor];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.backgroundColor = [UIColor whiteColor];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self.view addSubview:menu];
    
}
- (void)loadJSDrop{
    for (NSInteger i = 0; i < 4; i++) {
        //[self makeHUd];
        [self requestHeadJSDropView:i];
    }

}
#pragma mark 先加载小区
-(void)loadCommuntity{
    self.rom = [AFHTTPSessionManager manager];
    self.rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"text/plain",@"application/json",nil];
    NSString *url = [[NSString stringWithFormat:COMMUNITYDATA,self.cityName,self.loactionCommuntity,self.pageNum,self.pageSize] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //url = @"http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=2&xqid=86420010000004&sort=1&gotoPage=1&pageSize=5";
    [self.rom GET: url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
        [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

        for (NSDictionary *temp in responseObject[@"buzdata"]) {
            LocationModel *model = [[LocationModel alloc] initWithDictionary:temp];
            [tempArr addObject:model];
        }
        if ([responseObject[@"buzdata"] count] != 0) {
            self.communtityArr = tempArr;
        }
        //[self loadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //[[NSURLCache sharedURLCache] removeAllCachedResponses];
#warning message
        NSLog(@"%@",error);
    }];

}
//-(void)viewWillAppear:(BOOL)animated{
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}
-(void)makeInit{
    self.jdropInt = 0;
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.itemArr = [NSMutableArray arrayWithCapacity:0];
    self.stateArr = [NSMutableArray arrayWithCapacity:0];
    self.fourHeadBtnArr = [NSMutableArray arrayWithCapacity:0];
    self.fourHeadStateArr = [NSMutableArray arrayWithCapacity:0];
    NSArray *titleArr = @[@"分类",@"排序",@"福利",@""];
    for (NSInteger i = 0; i < 4; i++) {
        [self.fourHeadBtnArr addObject:@"0"];
        [self.fourHeadStateArr addObject:@"0"];
    }
   // Xqid:@"86420010000004" andCodeName:@"1" andSort:@"1"
    self.category = @"";
    self.sort = @"1";
    self.welfare = @"1";
    NSLog(@"1212%@",self.communtity);
    if (!self.communtity) {
        self.communtity = [StoreageMessage getCommuntityId];
    }
    NSLog(@"3434%@",self.communtity);

    self.pageNum = 1;
    self.pageSize = 10;
    
    //[self requestHead:3];
}
-(void)loadData{
#warning message 测试四个按钮btn
    //[self requestHead:0];
    //[self requestHead:1];
    //[self requestHead:2];

    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    manger.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    //NSString *url = [NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,22];
//    NSString *urlStr = [NSString stringWithFormat:MERCHANTLIST,self.category,self.communtity.integerValue,self.sort.integerValue,self.pageNum,self.pageSize,@"1",self.welfare];
    NSString *urlStr = [NSString stringWithFormat:NEWMERCHANTLIST,self.dicParams[@"classfnId"],self.communtity.integerValue,self.sort.integerValue,self.pageNum,self.pageSize,self.category];
// manger.operationQueue addOperation:<#(NSOperation *)#>
//    @"http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=2&xqid=86420010000004&sort=1&gotoPage=1&pageSize=5"
    NSLog(@"%@",urlStr);
    [manger GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [StoreageMessage getErrorMessage:@"NULL" fromUrl:urlStr];

        [self hudWasHidden:self.hudProgress];
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
          NSLog(@"%@",str);
        NSData *backData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        
        NSDictionary *tempStr = [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",tempStr);
        if (error) {
            NSLog(@"%@",error);
        }
#warning message responseObject
//        NSLog(@"%@",tempStr);
//NSLog(@"%@",tempStr[@"buzdata"]);
//        NSLog(@"%@",self.dataArr);
        for (NSDictionary *temp in tempStr[@"buzdata"]) {
            CommomFoodModel *model = [[CommomFoodModel alloc] initWithDictionary:temp]
            ;
            NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *itemTemp in temp[@"yhdetail"]) {
                CommomDetailFoodModel *detailFood = [[CommomDetailFoodModel alloc] initWithDictionary:itemTemp];
                [itemArr addObject:detailFood];
            }
            [self.itemArr addObject:itemArr];
            [self.dataArr addObject:model];
        }
        for (NSInteger i = 0; i < self.dataArr.count; i++) {
            [self.stateArr addObject:@"0"];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [[NSURLCache sharedURLCache] removeAllCachedResponses];
                [self hudWasHidden:self.hudProgress];
        NSLog(@"%@",[error description]);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return ;
    }];
}
-(void)makeNav{
    [self setNavBarImage:@"0.png"];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 20) / 2, 15, 15);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    //self.navigationItem.leftBarButtonItem = leftSecondItem;
    //[self setBackgroud:@"lantiao x.png"];
    //[self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = self.titleName;
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor blackColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    //self.navigationItem.titleView = view;
    self.navigationItem.leftBarButtonItems = @[leftSecondItem,centerBar];
    
//    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    searchBtn.frame = CGRectMake(WIDTH_CONTROLLER - 50 * self.numSingleVesion, (44 - 34 * self.numSingleVesion) / 2, 40 * self.numSingleVesion, 34 * self.numSingleVesion);
//    [searchBtn setImage:[UIImage imageNamed:@"chazhao.png"] forState:UIControlStateNormal];
//    [searchBtn addTarget:self action:@selector(serachBtnDown) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
}

//-(void) setBack1 {
//    if ([self.target isKindOfClass:[FoodBussinessListCollectionViewController class]]) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//}

-(void) serachBtnDown{
    
}
-(void)makeUI{
    //[self makeFourBtn];
    [self makeJSDropView];
    //[self makeFourBtnMenu];
    [self makeTable];
    [self addFooter];
}
-(void)makeTable{
    self.allHeight = 40 * self.numSingleVesion + 64;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.allHeight + 1 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - self.allHeight) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:[CommonFoodCell class] forCellReuseIdentifier:COMMOMFOODCELL];
//    tableView
    self.tableView = tableView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    tableView.separatorStyle = NO;
    //上拉下拉刷新
    //实例化header和footer
    
    _header = [MJRefreshHeaderView header];
    [self.tableView addFooterWithTarget:self action:@selector(addFooter)];
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"正在加载，请稍后";
    [self.tableView addHeaderWithTarget:self action:@selector(addHeader)];
    self.tableView.headerRefreshingText = @"正在帮你刷新";
//    _baseView = [MJRefreshBaseView ]
}
-(void)makeFourBtn{
    NSArray *btnTitleArr = @[@"分类",@"排序",@"福利",@"附近小区"];
//    [UIImage imageNamed:@"xing01"];
    CGFloat everWidth = (WIDTH_CONTROLLER - 3 * self.numSingleVesion)/ 4;
    for (NSInteger i = 0; i < btnTitleArr.count; i++) {
        UIButton *btnCategory = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCategory.frame = CGRectMake((everWidth + 1 * self.numSingleVesion) * i, 64, everWidth, 40 * self.numSingleVesion);
        [btnCategory setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        [btnCategory addTarget:self action:@selector(fourBtnTitleDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnCategory];
        [btnCategory setTitleColor:COMMONFOODTITLEBTNCOLOR forState:UIControlStateNormal];
        btnCategory.titleLabel.textAlignment = NSTextAlignmentCenter;
        btnCategory.tag = 1300 + i;
        
        UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(everWidth + (everWidth + 1 * self.numSingleVesion) * i, 64, 1 * self.numSingleVesion, 40 * self.numSingleVesion)];
        lineImg.image = [UIImage imageNamed:@"line.jpg"];
        [self.view addSubview:lineImg];
    }
//    UIImageView *horineLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion)];
//    [self.view addSubview:horineLine];
//    horineLine.image = [UIImage imageNamed:@"line_1"];
    
    UIImageView *btnImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion)];
    btnImg.image = [UIImage imageNamed:@"landi"];
    [self.view addSubview:btnImg];
//    CGFloat imgHeight = [VersionTranlate returnImageHeightImgname:@"wenzi.png" andWidth:WIDTH_CONTROLLER - (10 + 50) * self.numSingleVesion];
//    UIImageView *btnLableImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, (60 - imgHeight) / 2, WIDTH_CONTROLLER - (10 + 50) * self.numSingleVesion, imgHeight)];
//    btnLableImg.image = [UIImage imageNamed:@"wenzi.png"];
//    [btnImg addSubview:btnLableImg];
    
    self.allHeight = 64 + 40 * self.numSingleVesion + 1 * self.numSingleVesion;
}
-(void)fourBtnTitleDown:(UIButton *)fourBtnTitle{
    for (id temp in self.fourBtnHead.subviews) {
        [temp removeFromSuperview];
    }
    [self.fourBtnHead removeFromSuperview];
    if ([self.fourHeadStateArr[fourBtnTitle.tag - 1300] isEqualToString:@"0"]) {
        for (NSInteger i = 0; i < self.fourHeadStateArr.count; i++) {
            [self.fourHeadStateArr replaceObjectAtIndex:i withObject:@"0"];
        }
        [self requestHead:fourBtnTitle.tag - 1300];
        [self.fourHeadStateArr replaceObjectAtIndex:fourBtnTitle.tag - 1300 withObject:@"1"];
    }else{
        //[self requestHead:fourBtnTitle.tag - 1300];
        [self.fourHeadStateArr replaceObjectAtIndex:fourBtnTitle.tag - 1300 withObject:@"0"];
    }
    
    
}
#pragma mark tableview的协议代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommomFoodModel *model = self.dataArr[indexPath.row];
//    if (model.yhdetail.count != 0) {
//        if ([self.stateArr[indexPath.row] isEqualToString:@"0"]) {
//            return 111 * self.numSingleVesion;
//        }else{
//            return model.yhdetail.count * 30 * self.numSingleVesion + 80 * self.numSingleVesion + 5 * self.numSingleVesion;
//        }
//        
//    }
    return 80 * self.numSingleVesion;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:COMMOMFOODCELL forIndexPath:indexPath];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell init];
    if (self.dataArr.count != 0) {
         CommomFoodModel *model = self.dataArr[indexPath.row];
        cell.target = self;
        cell.row = indexPath.row;
//        if (model.yhdetail.count != 0) {
//            //self.itemArr
//            cell.privilegeArr = model.yhdetail;
//#warning message 
//            NSLog(@"%@",model.yhdetail);
//        }
        if([self.stateArr[indexPath.row] isEqualToString:@"1"]){
            cell.privilegeBtnState = YES;
        }else{
            cell.privilegeBtnState = NO;
        }
        [cell makeUI];
        

       
        [cell refreshUI:model];
    }
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![StoreageMessage isStoreMessage]) {
        [self.view makeToast:@"请先登录!"];
        LogInViewController *logIn = [[LogInViewController alloc] init];
        [self.navigationController pushViewController:logIn animated:YES];
        return;
    }
    CommomFoodModel *model = self.dataArr[indexPath.row];
#warning message
    NSLog(@"%@--%@--%@--%@--%@",model.did,model.startSendPrice,model.sendPrice,model.name,model.desc);
//    FoodMerchantListViewController *merchant = [[FoodMerchantListViewController alloc] initWithId:model.did];
//    [self.navigationController pushViewController:merchant animated:YES];
    FoodBussinessListCollectionViewController *merchant = [[FoodBussinessListCollectionViewController alloc] initWithId:model.did andSendPrice:model.startSendPrice andDistributionPrice:model.sendPrice ];
    merchant.shopName = model.name;
    merchant.shopDesc = model.desc;
    [self.navigationController pushViewController:merchant animated:YES];
}
#pragma mark //tableviewCell返回的按钮的东西
-(void)returnTicketAndPay:(NSString *)payAndTicket{
    
}
//点击优惠详情
-(void)returnPrivilege:(NSInteger)row{
    if ([self.stateArr[row] isEqualToString:@"0"]) {
        [self.stateArr replaceObjectAtIndex:row withObject:@"1"];
    }else{
        [self.stateArr replaceObjectAtIndex:row withObject:@"0"];
    }
    [self.tableView reloadData];
}

#pragma mark 返回每一行的高度
//-(CGFloat)retunRowHeight:(NSInteger)num{
//    
//    
//}
#pragma mark 头标各种分类
-(void)requestHead:(NSInteger)num{
    NSLog(@"%ld",num);
    if (![self.fourHeadBtnArr[num] isEqual:@"0"]) {
        self.fourBtnHead = [[CommonFoodFourBtnHead alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER, 40 * self.numSingleVesion * [self.fourHeadBtnArr[num] count]) andNSArray:self.fourHeadBtnArr[num] andNum:num];
        self.fourBtnHead.target = self;
        [self.view addSubview:self.fourBtnHead];
        return;
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    AFNetworkTwoPackaging *twoPackaging = [[AFNetworkTwoPackaging alloc] init];
    
    switch (num) {
        case 0:{
#warning message
//            NSLog(@"%@",MERCHANTLISTCATEGORY);
            [twoPackaging getUrl: MERCHANTLISTCATEGORY andFinishBlock:^(id getResult) {
#warning message
//                NSLog(@"head0:%@",getResult);
                for (NSInteger i = [getResult count] - 1; i >= 0; i--) {
                    FoodListCategoryModel *model = [[FoodListCategoryModel alloc] initWithDictionary:getResult[i]];
                    [tempArr addObject:model];
                }
                [self.fourHeadBtnArr replaceObjectAtIndex:num withObject:tempArr];
                [self createFourHeadUI:num andNSArray:self.fourHeadBtnArr[num]];
                
            }];
            break;
        }
        case 1:{
           // [self loadJson];
            AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
            manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
            manger.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
            manger.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            //NSString *url = [NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,22];
            // manger.operationQueue addOperation:<#(NSOperation *)#>
            NSString *url = MERCHANTLISTSORT;
            //url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [manger GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                NSArray *tempStr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                for (NSInteger i = 0; i < [tempStr count]; i++) {
                    FoodListCategoryModel *model = [[FoodListCategoryModel alloc] initWithDictionary:tempStr[i]];
                    [tempArr addObject:model];
                }

                [self.fourHeadBtnArr replaceObjectAtIndex:num withObject:tempArr];
                [self createFourHeadUI:num andNSArray:self.fourHeadBtnArr[num]];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               // [[NSURLCache sharedURLCache] removeAllCachedResponses];
                NSLog(@"%@",[error description]);
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
                return ;
            }];
           break;
        }
        case 2:{
            [twoPackaging getUrl: MERCHANTLISTWELFARE andFinishBlock:^(id getResult) {
                for (NSInteger i = 0; i < [getResult count]; i++) {
                    FoodListCategoryModel *model = [[FoodListCategoryModel alloc] initWithDictionary:getResult[i]];
                    [tempArr addObject:model];
                }
                [self.fourHeadBtnArr replaceObjectAtIndex:num withObject:tempArr];
                [self createFourHeadUI:num andNSArray:self.fourHeadBtnArr[num]];
            }];
            break;
        }
        case 3:{
            AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
            manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
            manger.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
            manger.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            //NSString *url = [NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,22];
            // manger.operationQueue addOperation:<#(NSOperation *)#>
            NSString *url = [NSString stringWithFormat:COMMUNITYDATA,[StoreageMessage getCity],[StoreageMessage getLatAndLong],(long)1,(long)4];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [manger GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *tempStr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                for (NSDictionary *temp in tempStr[@"buzdata"]) {
                    LocationModel *model = [[LocationModel alloc] initWithDictionary:temp];
                    [tempArr addObject:model];
                }
                [self.fourHeadBtnArr replaceObjectAtIndex:num withObject:tempArr];
                [self createFourHeadUI:num andNSArray:self.fourHeadBtnArr[num]];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //[[NSURLCache sharedURLCache] removeAllCachedResponses];
                NSLog(@"%@",[error description]);
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
                return ;
            }];

            break;
        }
        default:
            break;
    }
}
//创建四个界面
- (void)createFourHeadUI:(NSInteger)num andNSArray:(NSArray *)array{
    for (id temp in self.fourBtnHead.subviews) {
        [temp removeFromSuperview];
    }
    [self.fourBtnHead removeFromSuperview];
    self.fourBtnHead = [[CommonFoodFourBtnHead alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER, 40 * self.numSingleVesion * array.count) andNSArray:self.fourHeadBtnArr[num] andNum:num];
    self.fourBtnHead.target = self;
    self.fourBtnHead.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.fourBtnHead];
}
//请求数据
-(void)regainReguestXqid{
    self.pageNum = 0;
    self.pageSize = 20;
    AFNetworkTwoPackaging *twoPackaging = [[AFNetworkTwoPackaging alloc] init];
//    "serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=%@&xqid=%d&sort=%d&gotoPage=%d&pageSize=%d"
//    NSString *url = [NSString stringWithFormat:MERCHANTLIST,self.category,self.communtity.integerValue,self.sort.integerValue,self.pageNum,self.pageSize,@"1",self.welfare];

    NSString *url = [NSString stringWithFormat:NEWMERCHANTLIST,self.dicParams[@"classfnId"],self.communtity.integerValue,self.sort.integerValue,self.pageNum,self.pageSize,self.category];
    //url = @"http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=2&xqid=86420010000004&sort=1&gotoPage=1&pageSize=5";
    NSLog(@"%@",url);
    [twoPackaging getUrl:url andFinishBlock:^(id getResult) {
        [self.tableView headerEndRefreshing];
        [self.dataArr removeAllObjects];
        [self.itemArr removeAllObjects];
        [self.stateArr removeAllObjects];
        //先清空，后者刷新
        NSLog(@"%@",getResult);
        for (NSDictionary *temp in getResult[@"buzdata"]) {
            CommomFoodModel *model = [[CommomFoodModel alloc] initWithDictionary:temp]
            ;
            NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *itemTemp in temp[@"yhdetail"]) {
                CommomDetailFoodModel *detailFood = [[CommomDetailFoodModel alloc] initWithDictionary:itemTemp];
                [itemArr addObject:detailFood];
            }
            [self.itemArr addObject:itemArr];
            [self.dataArr addObject:model];
        }
        for (NSInteger i = 0; i < self.dataArr.count; i++) {
            [self.stateArr addObject:@"0"];
        }
        [self.tableView reloadData];

    }];
    
}
#pragma mark 下拉刷新
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if (self.tableView.contentOffset.y < -20) {
//        [self.dataArr removeAllObjects];
//        [self.itemArr removeAllObjects];
//        self.pageNum = 1;
//        self.pageSize = 5;
//        [self makeHUd];
//        [self.tableView addHeaderWithTarget:self action:@selector(regainReguestXqid)];
//        self.tableView.headerRefreshingText = @"正在帮你刷新";
//        [self.tableView headerBeginRefreshing];
//    }
//    if (self.tableView.contentOffset.y > self.tableView.contentSize.height + 40) {
//        self.pageSize++;
//        [self.tableView addFooterWithTarget:self action:@selector(regainReguestXqid)];
//        self.tableView.footerRefreshingText = @"正在加载";
//        [self.tableView footerBeginRefreshing];
//    }
}
//加载更多
- (void)addHeader{
    __unsafe_unretained typeof(self) vc = self;
    [vc.tableView addHeaderWithCallback:^{
        vc.pageNum = 1;
        vc.pageSize = 20;
        AFNetworkTwoPackaging *twoPackaging = [[AFNetworkTwoPackaging alloc] init];
        NSLog(@"%@",self.category);
        //    "serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=%@&xqid=%d&sort=%d&gotoPage=%d&pageSize=%d"
        NSString *url = [NSString stringWithFormat:NEWMERCHANTLIST,self.dicParams[@"classfnId"],self.communtity.integerValue,self.sort.integerValue,self.pageNum,self.pageSize,self.category];
        //url = @"http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=2&xqid=86420010000004&sort=1&gotoPage=1&pageSize=5";
        [twoPackaging getUrl:url andFinishBlock:^(id getResult) {
            [vc.tableView headerEndRefreshing];
            [vc hudWasHidden:vc.hudProgress];
            [vc.dataArr removeAllObjects];
            [vc.itemArr removeAllObjects];
            [vc.stateArr removeAllObjects];
            //先清空，后者刷新
            for (NSDictionary *temp in getResult[@"buzdata"]) {
                CommomFoodModel *model = [[CommomFoodModel alloc] initWithDictionary:temp]
                ;
                NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *itemTemp in temp[@"yhdetail"]) {
                    CommomDetailFoodModel *detailFood = [[CommomDetailFoodModel alloc] initWithDictionary:itemTemp];
                    [itemArr addObject:detailFood];
                }
                [vc.itemArr addObject:itemArr];
                [vc.dataArr addObject:model];
            }
            for (NSInteger i = 0; i < self.dataArr.count; i++) {
                [vc.stateArr addObject:@"0"];
            }
            [vc.tableView reloadData];
            
        }];
    }];
}
- (void)addFooter
{
    //[self makeHUd];
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [vc.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        self.pageNum++;
        AFNetworkTwoPackaging *twoPackaging = [[AFNetworkTwoPackaging alloc] init];
        //    "serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=%@&xqid=%d&sort=%d&gotoPage=%d&pageSize=%d"
        NSString *url = [NSString stringWithFormat:NEWMERCHANTLIST,self.dicParams[@"classfnId"],self.communtity.integerValue,self.sort.integerValue,self.pageNum,self.pageSize,self.category];
        [twoPackaging getUrl:url andFinishBlock:^(id getResult) {
            [vc.tableView footerEndRefreshing];
            [vc hudWasHidden:vc.hudProgress];
            if ([getResult[@"buzdata"] count] == 0) {
                return ;
            }
            //先清空，后者刷新
            for (NSDictionary *temp in getResult[@"buzdata"]) {
                CommomFoodModel *model = [[CommomFoodModel alloc] initWithDictionary:temp]
                ;
                NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *itemTemp in temp[@"yhdetail"]) {
                    CommomDetailFoodModel *detailFood = [[CommomDetailFoodModel alloc] initWithDictionary:itemTemp];
                    [itemArr addObject:detailFood];
                }
                [vc.itemArr addObject:itemArr];
                [vc.dataArr addObject:model];
            }
            
            for (NSInteger i = 0; i < [getResult[@"buzdata"] count]; i++) {
                [vc.stateArr addObject:@"0"];
            }
            [vc.tableView reloadData];
            
        }];
    }];
}
- (void)loadMoreData{
    
}
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

#pragma mark 下载json
-(void)loadJson{
    AFNetworkTwoPackaging *twoPackaging = [[AFNetworkTwoPackaging alloc] init];
    //    "serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=%@&xqid=%d&sort=%d&gotoPage=%d&pageSize=%d"
    NSString *url = [NSString stringWithFormat:MERCHANTLIST,[NSString stringWithFormat:@"%ld",(long)self.categoryId],(long)self.communtity.integerValue,self.sortNum,self.pageNum,self.pageSize];
    [twoPackaging getUrl:url andFinishBlock:^(id getResult) {
#warning message
        NSLog(@"%@",getResult);
        [self.tableView headerEndRefreshing];
        [self hudWasHidden:self.hudProgress];
        //[self.dataArr removeAllObjects];
        //[self.itemArr removeAllObjects];
        //先清空，后者刷新
        for (NSDictionary *temp in getResult[@"buzdata"]) {
            CommomFoodModel *model = [[CommomFoodModel alloc] initWithDictionary:temp]
            ;
            NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *itemTemp in temp[@"yhdetail"]) {
                CommomDetailFoodModel *detailFood = [[CommomDetailFoodModel alloc] initWithDictionary:itemTemp];
                [itemArr addObject:detailFood];
            }
            [self.itemArr addObject:itemArr];
            [self.dataArr addObject:model];
        }
        for (NSInteger i = 0; i < self.dataArr.count; i++) {
            [self.stateArr addObject:@"0"];
        }
        [self.tableView reloadData];
        
    }];

}

//点击头部按钮返回的
- (void)returnHeadBtn:(NSInteger)headNum andHeadString:(NSString *)headTypeString{
    //self.category = @"1";
    //self.sort = @"1";
    //self.welfare = @"";
    //self.communtity = @"86420010000004";
    NSLog(@"%ld-%@",headNum,headTypeString);
    switch (headNum) {
        case 0:{
            self.category = headTypeString;
            break;
        }
        case 1:{
            self.sort = headTypeString;
            break;
        }
        case 2:{
            self.welfare = headTypeString;
            break;
        }
        case 3:{
            self.communtity = headTypeString;
            break;
        }
        default:
            break;
    }
    [self regainReguestXqid];
//    [self.fourBtnHead.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.fourBtnHead removeFromSuperview];
}
#pragma mark jsopMenu
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return self.cateAndSortAndWefAndCommArr.count;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
//    if (column==2) {
//        
//        return YES;
//    }
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
//    if (column==0) {
//        return YES;
//    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
//    if (column==0) {
//        return 0.3;
//    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentData1Index;
        
    }
    if (column==1) {
        
        return _currentData2Index;
    }
    
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
//    NSArray *headArr = @[@"分类",@"排序",@"福利",@"附近小区"];
//    if ([self.cateAndSortAndWefAndCommArr[column] count] == 0) {
//        [self makeHUd];
//        [self requestHeadJSDropView:column];
//        return 0;
//    }
    return [self.cateAndSortAndWefAndCommArr[column] count];
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    NSLog(@"%ld----%@",column,self.cateAndSortAndWefAndCommArr);
    switch (column) {
        case 0: return [self.cateAndSortAndWefAndCommArr[column] objectAtIndex:_currentData1Index];
            break;
        case 1: return [self.cateAndSortAndWefAndCommArr[column] objectAtIndex:_currentData2Index];
            break;
        case 2: return [self.cateAndSortAndWefAndCommArr[column] objectAtIndex:_currentData3Index];
            break;
        case 3: return [self.cateAndSortAndWefAndCommArr[column] objectAtIndex:_currentData4Index];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {

//    if (self.jdropInt != 0) {
//        if ([self.cateAndSortAndWefAndCommArr[indexPath.column] count] == 1) {
//            [self requestHeadJSDropView:indexPath.column];
//        }
//    }
//    self.jdropInt++;
    if (indexPath.column == 3) {
        LocationModel *model = self.cateAndSortAndWefAndCommArr[indexPath.column][indexPath.row];
        return model.xqname;
    }
    

    FoodListCategoryModel *model = self.cateAndSortAndWefAndCommArr[indexPath.column][indexPath.row];
    return model.name;
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        _currentData1Index = indexPath.row;
     
    } else if(indexPath.column == 1){
        
        _currentData2Index = indexPath.row;
        
    } else if(indexPath.column == 2){
        
        _currentData3Index = indexPath.row;
    }else{
        _currentData4Index = indexPath.row;
    }
    if (indexPath.column == 3) {
        LocationModel *model = self.cateAndSortAndWefAndCommArr[indexPath.column][indexPath.row];
        [self returnHeadBtn:indexPath.column andHeadString:model.xqid];
    }else{
        FoodListCategoryModel *model = self.cateAndSortAndWefAndCommArr[indexPath.column][indexPath.row];
        [self returnHeadBtn:indexPath.column andHeadString:model.id];
    }
    
    
    }
- (void)requestHeadJSDropView:(NSInteger)colum{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    AFNetworkTwoPackaging *twoPackaging = [[AFNetworkTwoPackaging alloc] init];
    
    switch (colum) {
        case 0:{
            [twoPackaging getUrl:[NSString stringWithFormat:NEWMERCHANTLISTCATEGORY,self.dicParams[@"classfnId"]] andFinishBlock:^(id getResult) {
                NSLog(@"%@",getResult);
//                for (NSInteger i = 0; i < [getResult count]; i++) {
//                    FoodListCategoryModel *model = [[FoodListCategoryModel alloc] initWithDictionary:getResult[i]];
//                    [tempArr addObject:model];
//                }
                for (NSDictionary *dic in getResult[@"datas"]) {
                    NSLog(@"%@",dic);
//                    for (NSDictionary *dic1 in dic) {
//                        NSLog(@"%@",dic1);
                        FoodListCategoryModel *model = [[FoodListCategoryModel alloc] initWithDictionary:dic];
                        [tempArr addObject:model];
//                    }
                }
                [self.cateAndSortAndWefAndCommArr replaceObjectAtIndex:colum withObject:tempArr];
                //_currentData1Index = colum;
//                [self.fourHeadBtnArr replaceObjectAtIndex:num withObject:tempArr];
//                [self createFourHeadUI:num andNSArray:self.fourHeadBtnArr[num]];
                
            }];
            break;
        }
        case 1:{
            // [self loadJson];
            AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
            manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
            manger.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
            manger.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            //NSString *url = [NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,22];
            // manger.operationQueue addOperation:<#(NSOperation *)#>
            NSString *url = MERCHANTLISTSORT;
            //url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [manger GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self hudWasHidden:self.hudProgress];
                [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                NSArray *tempStr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                for (NSInteger i = 0; i < [tempStr count]; i++) {
                    FoodListCategoryModel *model = [[FoodListCategoryModel alloc] initWithDictionary:tempStr[i]];
                    [tempArr addObject:model];
                }
                
                [self.cateAndSortAndWefAndCommArr replaceObjectAtIndex:colum withObject:tempArr];
               // _currentData2Index = colum;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                // [[NSURLCache sharedURLCache] removeAllCachedResponses];
                NSLog(@"%@",[error description]);
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
                return ;
            }];
            break;
        }
        case 2:{
            [twoPackaging getUrl: MERCHANTLISTWELFARE andFinishBlock:^(id getResult) {
                for (NSInteger i = 0; i < [getResult count]; i++) {
                    FoodListCategoryModel *model = [[FoodListCategoryModel alloc] initWithDictionary:getResult[i]];
                    [tempArr addObject:model];
                }
                [self.cateAndSortAndWefAndCommArr replaceObjectAtIndex:colum withObject:tempArr];
                //_currentData3Index = colum;
            }];
            break;
        }
        case 3:{
            AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
            manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
            manger.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
            manger.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            //NSString *url = [NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,22];
            // manger.operationQueue addOperation:<#(NSOperation *)#>
            NSString *url = [NSString stringWithFormat:COMMUNITYDATA,[StoreageMessage getCity],[StoreageMessage getLatAndLong],(long)1,(long)20];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"%@",url);
            [manger GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *tempStr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                for (NSDictionary *temp in tempStr[@"buzdata"]) {
                    LocationModel *model = [[LocationModel alloc] initWithDictionary:temp];
                    [tempArr addObject:model];
                }
                [self.cateAndSortAndWefAndCommArr replaceObjectAtIndex:colum withObject:tempArr];
                //_currentData4Index = colum;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",[error description]);
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alertView show];
                return ;
            }];
            
            break;
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
