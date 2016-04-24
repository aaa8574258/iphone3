//
//  ParkingPayHistoryViewController.m
//  360du
//
//  Created by linghang on 16/1/7.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ParkingPayHistoryViewController.h"
#import "ParkingHistoryModel.h"
#import "ParkingHositoryTableViewCell.h"
#import "AFNetworkTwoPackaging.h"
#import "StoreageMessage.h"
#import "UIView+Toast.h"
#import "MJRefresh.h"
#define PARKINGHOSITORYTABLEVIEWCELL    @"parkingHositoryTableViewCell"
@interface ParkingPayHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *historyArr;
@property(nonatomic,strong)NSMutableArray *headArr;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger headType;//0，为关，1，开
@property(nonatomic,assign)NSInteger questNum;//请求几个
@property(nonatomic,weak)UIView *headView;
@end

@implementation ParkingPayHistoryViewController
- (id)init{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;

        self.page = 1;
        self.headType = 1;
        self.historyArr = [NSMutableArray arrayWithCapacity:0];
        self.headArr = [NSMutableArray arrayWithCapacity:0];
        [self createNav];
        [self requestHeadData];
        [self requestHistoryData];
        [self createTableView];
        [self makeHUd];
    }
    return self;
}
- (void)createNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"缴费记录"];

}
//请求历史数据
- (void)requestHistoryData{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    //payCarPaymentList&memberID=26298&xqID=86420010000004&pageSize=10&pageNum=1

    NSString *url = [NSString stringWithFormat:PARKINGPAYHOSTIORY,[StoreageMessage getMessage][2],[StoreageMessage getCommuntityId],self.page];
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        self.questNum++;
        if (self.questNum == 2) {
            [self hudWasHidden:self.hudProgress];

        }
        if([getResult[@"code"] isEqual:@"000000"]){
            if ([getResult[@"datas"] count] == 0) {
                [self.view makeToast:@"没有历史记录"];
            }
            for (NSInteger i = 0; i < [getResult[@"datas"] count]; i++) {
                ParkingHistoryModel *model = [[ParkingHistoryModel alloc] initWithDictionary:getResult[@"datas"][i]];
                [self.historyArr addObject:model];
            }
            [self.tableView reloadData];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
        
    }];
}
//请求头部数据
- (void)requestHeadData{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    //payCarPaymentList&memberID=26298&xqID=86420010000004&pageSize=10&pageNum=1
    
    NSString *url = [NSString stringWithFormat:PARKINGPAYHEAD,[StoreageMessage getMessage][2],[StoreageMessage getCommuntityId]];
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        self.questNum++;
        if (self.questNum == 2) {
            [self hudWasHidden:self.hudProgress];
            
        }
        if([getResult[@"code"] isEqual:@"000000"]){
            if ([getResult[@"datas"] count] == 0) {
                [self.view makeToast:@"没有历史记录"];
            }
            for (NSInteger i = 0; i < [getResult[@"datas"] count]; i++) {
                ParkingHistoryModel *model = [[ParkingHistoryModel alloc] initWithDictionary:getResult[@"datas"][i]];
                [self.headArr addObject:model];
            }
            [self.tableView reloadData];
        }else{
            [self.view makeToast:@"数据请求失败"];
        }
        
    }];

}
//创建tableview
- (void)createTableView{
    UITableView *historyTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64) style:UITableViewStyleGrouped];
    historyTab.separatorStyle = NO;
    historyTab.dataSource = self;
    historyTab.delegate = self;
    [self.view addSubview:historyTab];
    self.tableView = historyTab;
    historyTab.showsVerticalScrollIndicator = NO;
    [self.tableView addFooterWithTarget:self action:@selector(addFooter)];
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"正在加载，请稍后";
    [self.tableView headerBeginRefreshing];
    self.tableView.headerRefreshingText = @"正在刷新";
    //loadData
    //[self.dataArr removeAllObjects];
    [self.tableView addHeaderWithTarget:self action:@selector(addHeader)];

}
- (void)addHeader{
    __unsafe_unretained typeof(self) vc = self;
    [vc.tableView addHeaderWithCallback:^{
        vc.page = 1;
        AFNetworkTwoPackaging *twoPackaging = [[AFNetworkTwoPackaging alloc] init];
        //    "serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=%@&xqid=%d&sort=%d&gotoPage=%d&pageSize=%d"
        NSString *url = [NSString stringWithFormat:PARKINGPAYHOSTIORY,[StoreageMessage getMessage][2],[StoreageMessage getCommuntityId],vc.page];

        //url = @"http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=2&xqid=86420010000004&sort=1&gotoPage=1&pageSize=5";
        [twoPackaging getUrl:url andFinishBlock:^(id getResult) {
            [vc.tableView headerEndRefreshing];
            
            if (self.questNum == 2) {
                [self hudWasHidden:self.hudProgress];
                
            }
            if([getResult[@"code"] isEqual:@"000000"]){
                if ([getResult[@"datas"] count] == 0) {
                    [self.view makeToast:@"没有历史记录"];
                }
                [self.historyArr removeAllObjects];
                for (NSInteger i = 0; i < [getResult[@"datas"] count]; i++) {
                    ParkingHistoryModel *model = [[ParkingHistoryModel alloc] initWithDictionary:getResult[@"datas"][i]];
                    [vc.historyArr addObject:model];
                }
                [vc.tableView reloadData];
            }else{
                [vc.view makeToast:getResult[@"message"]];
            }
            
        }];
    }];
}

- (void)addFooter
{
    
    self.page++;
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
        NSString *url = [NSString stringWithFormat:PARKINGPAYHOSTIORY,[StoreageMessage getMessage][2],[StoreageMessage getCommuntityId],self.page];

        [twoPack getUrl:url andFinishBlock:^(id getResult) {
            [vc.tableView footerEndRefreshing];
            if (self.questNum == 2) {
                [self hudWasHidden:self.hudProgress];
                
            }
            if([getResult[@"code"] isEqual:@"000000"]){
                if ([getResult[@"datas"] count] == 0) {
                    [self.view makeToast:@"没有历史记录"];
                }
                for (NSInteger i = 0; i < [getResult[@"datas"] count]; i++) {
                    ParkingHistoryModel *model = [[ParkingHistoryModel alloc] initWithDictionary:getResult[@"datas"][i]];
                    [vc.historyArr addObject:model];
                }
                [vc.tableView reloadData];
            }else{
                [vc.view makeToast:getResult[@"message"]];
            }

        }];
    }];
}

#pragma mark tableView的协议代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.historyArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ParkingHositoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PARKINGHOSITORYTABLEVIEWCELL];
    if (!cell) {
        cell = [[ParkingHositoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PARKINGHOSITORYTABLEVIEWCELL];
    }
    cell.backgroundColor = SMSColor(246, 246, 246);
    ParkingHistoryModel *model = self.historyArr[indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.headArr.count == 0) {
        return 0;
    }
    if(self.headType == 1)
        return 100 * self.numSingleVesion;
    else{
        return 30 * self.numSingleVesion;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.headArr.count == 0) {
        return nil;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = SMSColor(246, 246, 246);
        UIButton *unfoldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        unfoldBtn.frame = CGRectMake(0, 0, 50 * self.numSingleVesion, 30 * self.numSingleVesion);
        [unfoldBtn setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
        [unfoldBtn addTarget:self action:@selector(unflodBtnOrNot:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:unfoldBtn];
        self.headView = view;
        UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        lineImg.image = [UIImage imageNamed:@"line_xuxian"];
        [view addSubview:lineImg];
        view.tag = 3000;
        if(self.headType == 1){//展开时候
            view.frame = CGRectMake(0, 0, WIDTH_CONTROLLER, 100 * self.numSingleVesion);
            [self makeScrollViewHeadArr:self.headArr];
    }else{//闭合时候
        view.frame = CGRectMake(0, 0, WIDTH_CONTROLLER, 30 * self.numSingleVesion);
        [self removeScrollView];
        [unfoldBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];

        
    }
        lineImg.frame = CGRectMake(0, view.frame.size.height - 1 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion);
        unfoldBtn.center = CGPointMake(WIDTH_CONTROLLER / 2, view.frame.size.height - 16 * self.numSingleVesion);
        return view;

    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 225 * self.numSingleVesion;
}
- (void)unflodBtnOrNot:(UIButton *)unflodBtn{
    if (self.headType == 0) {
        self.headType = 1;
        [unflodBtn setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];

        [self makeScrollViewHeadArr:self.headArr];
    }else{
        [unflodBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
        self.headType = 0;
        [self removeScrollView];
    }
    [self.tableView reloadData];
}
- (void)makeScrollViewHeadArr:(NSArray *)headArr{
    UIView *view = self.headView;

    for (id temp in view.subviews) {
        if([temp isKindOfClass:[UIScrollView class]]){
            [[(UIScrollView *)temp subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [temp removeFromSuperview];
        }
    }
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 1 * self.numSingleVesion, WIDTH_CONTROLLER, 70 * self.numSingleVesion)];
    [view addSubview:scrollView];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(0, headArr.count * 60 * self.numSingleVesion);
    for (NSInteger i = 0; i < headArr.count; i++) {
        ParkingHistoryModel *model = headArr[i];
        //车牌名称
        UILabel *carImgLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 10 * self.numSingleVesion, 120 * self.numSingleVesion, 40 * self.numSingleVesion)];
        carImgLab.font = [UIFont systemFontOfSize:24];
        carImgLab.textColor = [UIColor whiteColor];
        carImgLab.backgroundColor = SMSColor(11, 82, 168);
        [scrollView addSubview:carImgLab];
        carImgLab.text = model.cb_Pai;
        carImgLab.layer.borderColor = [SMSColor(157, 188, 219) CGColor];
        carImgLab.layer.borderWidth = 1 * self.numSingleVesion;
        carImgLab.textAlignment = NSTextAlignmentCenter;
        //到期时间
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(140 * self.numSingleVesion, 10 * self.numSingleVesion, WIDTH_CONTROLLER - 150 * self.numSingleVesion, 40 * self.numSingleVesion)];
        lable.textColor = SMSColor(51, 51, 51);
        lable.font = [UIFont systemFontOfSize:14];
        [scrollView addSubview:lable];
        lable.numberOfLines = 2;
        lable.text = [NSString stringWithFormat:@"套餐到期时间\n%@",model.cb_EndDate];
    }
}
- (void)removeScrollView{
    UIView *view = self.headView;
    for (id temp in view.subviews) {
        if([temp isKindOfClass:[UIScrollView class]]){
            [[(UIScrollView *)temp subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [temp removeFromSuperview];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Do any additional setup after loading the view.
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
