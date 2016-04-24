//
//  ScrOrderCenterViewController.m
//  360du
//
//  Created by linghang on 15/8/14.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ScrOrderCenterViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "OrderCenterFinishModel.h"
#import "OrderCenterFinishAndUnFinishCell.h"
#import "StoreageMessage.h"
#import "ScrOrderCenterDeatilViewController.h"
#define ORDERCENTERFINISHANDUNFINISHCELL @"orderCenterFinishAndUnFinishCell"
@interface ScrOrderCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UILabel *statusBtnLab;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *allOrderArr;//全部快单
@property(nonatomic,strong)NSMutableArray *finishOrderArr;//我的快单，完成的
@property(nonatomic,strong)NSMutableArray *unFinishOrderArr;//我的快单，没有完成的
@property(nonatomic,strong)UIView *finishAndUnFinishView;//完成和未完成的View
@property(nonatomic,assign)NSInteger statusNum;//点击第几个
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation ScrOrderCenterViewController
-(id)init{
    self = [super init];
    if (self) {
        [self makeInit];
        [self loadData];
        [self makeNav];
        [self makeUI];
        [self makeHUd];

    }
    return self;
}
-(void)makeInit{
    self.statusNum = 0;
    self.allOrderArr = [NSMutableArray arrayWithCapacity:0];
    self.finishOrderArr = [NSMutableArray arrayWithCapacity:0];
    self.unFinishOrderArr = [NSMutableArray arrayWithCapacity:0];
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"我的订单"];
}
- (void)loadData{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:MINEORDERCENTER,[StoreageMessage getMessage][2],@"2"] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        self.statusNum = 0;
        for (NSDictionary *temp in getResult[@"datas"]) {
            OrderCenterFinishModel *model = [[OrderCenterFinishModel alloc] initWithDictionary:temp];
            [self.unFinishOrderArr addObject:model];
        }
        self.dataArr = [self.unFinishOrderArr mutableCopy];
        [self.tableView reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
-(void)makeUI{
    [self makeTwoBtn];
    //[self makeFinishAndUnFinished];
    [self makeTable];
}
-(void)makeTwoBtn{
    NSArray *statusArr = @[@"未完成",@"已完成"];
    CGFloat width = WIDTH_CONTROLLER / statusArr.count;
    for (NSInteger i = 0; i < statusArr.count; i++) {
        UIButton *statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statusBtn.frame = CGRectMake(width * i, 64, width - 0.5 * self.numSingleVesion, 40 * self.numSingleVesion);
        [statusBtn setTitle:statusArr[i] forState:UIControlStateNormal];
        statusBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        statusBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [statusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [statusBtn addTarget:self action:@selector(statusBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:statusBtn];
        statusBtn.tag = 1200 + i;
        if (i == 1) {
            UILabel *verticalLine = [[UILabel alloc] initWithFrame:CGRectMake(width - 0.5 * self.numSingleVesion, 64, 1 * self.numSingleVesion, 40 * self.numSingleVesion)];
            verticalLine.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:verticalLine];
        }
    }
    UILabel *bottomLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 39 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion)];
    bottomLab.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bottomLab];
    //按钮下边的颜色
    self.statusBtnLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 39 * self.numSingleVesion, width, 1 * self.numSingleVesion)];
    self.statusBtnLab.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.statusBtnLab];
}
-(void)statusBtnDown:(UIButton *)statusBtn{
    //清空颜色
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *twoBtn = (UIButton*)[self.view viewWithTag:1200 + i];
        //[twoBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    if (statusBtn.tag == 1200) {
//        for (id temp in self.finishAndUnFinishView.subviews) {
//            [temp removeFromSuperview];
//        }
//        [self makeFinishAndUnFinished];
        self.tableView.frame = CGRectMake(0, 64 + 40 * self.numSingleVesion + 0 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - (64 + 40 * self.numSingleVesion + 0 * self.numSingleVesion));
    }else if (statusBtn.tag == 1201){
        for (id temp in self.finishAndUnFinishView.subviews) {
            [temp removeFromSuperview];
        }
        self.tableView.frame = CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 40 * self.numSingleVesion);
    }
    if (statusBtn.tag == 1200) {
        self.statusNum = 0;
        self.statusBtnLab.frame = CGRectMake(0, 64 + 39 * self.numSingleVesion, WIDTH_CONTROLLER / 2, 1 * self.numSingleVesion);
        if (self.unFinishOrderArr.count == 0) {
            [self requestData:0];
        }else{
            self.dataArr = [self.unFinishOrderArr mutableCopy];
            [self.tableView reloadData];
        }
    }else if(statusBtn.tag == 1201){
        self.statusNum = 2;
        self.statusBtnLab.frame = CGRectMake(WIDTH_CONTROLLER / 2, 64 + 39 * self.numSingleVesion, WIDTH_CONTROLLER / 2, 1 * self.numSingleVesion);
        if (self.allOrderArr.count == 0) {
            [self requestData:2];
        }else{
            self.dataArr = [self.allOrderArr mutableCopy];
            [self.tableView reloadData];
        }
    }else if (statusBtn.tag == 1300){//未完成
        self.statusNum = 0;
        if (self.unFinishOrderArr.count == 0) {
            [self requestData:0];
        }else{
            self.dataArr = [self.unFinishOrderArr mutableCopy];
            [self.tableView reloadData];
        }
    }else{//完成
        self.statusNum = 1;
        if (self.finishOrderArr.count == 0) {
            [self requestData:1];
        }else{
            self.dataArr = [self.finishOrderArr mutableCopy];
            [self.tableView reloadData];
        }
    }
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *tempBtn = (UIButton *)[self.view viewWithTag:1300 + i];
        [tempBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    if (statusBtn.tag == 1301|| statusBtn.tag == 1300) {
        [statusBtn setBackgroundColor:[UIColor redColor]];
    }else if (statusBtn.tag == 1200){
        UIButton *tempStatusBtn = (UIButton *)[self.view viewWithTag:1300];
        [tempStatusBtn setBackgroundColor:[UIColor redColor]];
    }
}
//设置完成的和未完成的
//- (void)makeFinishAndUnFinished {
//    self.finishAndUnFinishView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER, 60 * self.numSingleVesion)];
//    [self.view addSubview:self.finishAndUnFinishView];
//    NSArray *statusArr = @[@"未完成",@"完成"];
//    CGFloat width = WIDTH_CONTROLLER / statusArr.count;
//    for (NSInteger i = 0; i < statusArr.count; i++) {
//        UIButton *statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        statusBtn.frame = CGRectMake(width  - 100 * self.numSingleVesion - 10 * self.numSingleVesion, 20 * self.numSingleVesion, 100 * self.numSingleVesion, 40 * self.numSingleVesion);
//        [statusBtn setTitle:statusArr[i] forState:UIControlStateNormal];
//        statusBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//        statusBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [statusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [statusBtn addTarget:self action:@selector(statusBtnDown:) forControlEvents:UIControlEventTouchUpInside];
//        statusBtn.layer.borderWidth = 1 * self.numSingleVesion;
//        [self.finishAndUnFinishView addSubview:statusBtn];
//        if(i == 0){
//            [statusBtn setBackgroundColor:[UIColor redColor]];
//        }else{
//            [statusBtn setBackgroundColor:[UIColor lightGrayColor]];
//            statusBtn.frame = CGRectMake(width  + 10 * self.numSingleVesion, 20 * self.numSingleVesion, 100 * self.numSingleVesion, 40 * self.numSingleVesion);
//        }
//        statusBtn.tag = 1300 + i;
//    }
//    
//}
- (void)makeTable{
    //UITableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion + 0 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - (64 + 40 * self.numSingleVesion + 0 * self.numSingleVesion)) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    [tableView registerClass:[OrderCenterFinishAndUnFinishCell class] forCellReuseIdentifier:ORDERCENTERFINISHANDUNFINISHCELL];
}
#pragma mark tableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85 * self.numSingleVesion;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCenterFinishAndUnFinishCell *cell = [tableView dequeueReusableCellWithIdentifier:ORDERCENTERFINISHANDUNFINISHCELL forIndexPath:indexPath];
    OrderCenterFinishModel *model = self.dataArr[indexPath.row];
    [cell refreshUI:model andRow:indexPath.row andSection:self.statusNum];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCenterFinishModel *model = self.dataArr[indexPath.row];
    ScrOrderCenterDeatilViewController *orderCenterDetail = [[ScrOrderCenterDeatilViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:orderCenterDetail animated:YES];
}
#pragma mark 请求数据
- (void)requestData:(NSInteger)num{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    switch (num) {
        case 0:{
            [twoPack getUrl:[NSString stringWithFormat:MINEORDERCENTER,[StoreageMessage getMessage][2],@"2"] andFinishBlock:^(id getResult) {
                [self hudWasHidden:self.hudProgress];
                self.statusNum = 0;
                for (NSDictionary *temp in getResult[@"datas"]) {
                    OrderCenterFinishModel *model = [[OrderCenterFinishModel alloc] initWithDictionary:temp];
                    [self.unFinishOrderArr addObject:model];
                }
                self.dataArr = [self.unFinishOrderArr mutableCopy];
                [self.tableView reloadData];
            }];
            break;
        }
        case 2:{
            [twoPack getUrl:[NSString stringWithFormat:MINEORDERCENTER,[StoreageMessage getMessage][2],@"1"] andFinishBlock:^(id getResult) {
                [self hudWasHidden:self.hudProgress];
                self.statusNum = 1;
                for (NSDictionary *temp in getResult[@"datas"]) {
                    OrderCenterFinishModel *model = [[OrderCenterFinishModel alloc] initWithDictionary:temp];
                    [self.finishOrderArr addObject:model];
                }
                self.dataArr = [self.finishOrderArr mutableCopy];
                [self.tableView reloadData];
            }];
            break;
        }
        case 1:{
            [twoPack getUrl:ORDERCENTERALL andFinishBlock:^(id getResult) {
                [self hudWasHidden:self.hudProgress];
                self.statusNum = 2;
                for (NSDictionary *temp in getResult[@"datas"]) {
                    OrderCenterFinishModel *model = [[OrderCenterFinishModel alloc] initWithDictionary:temp];
                    [self.allOrderArr addObject:model];
                }
                self.dataArr = [self.allOrderArr mutableCopy];
                [self.tableView reloadData];
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
