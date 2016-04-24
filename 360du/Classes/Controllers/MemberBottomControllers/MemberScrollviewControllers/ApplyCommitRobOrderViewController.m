//
//  ApplyCommitRobOrderViewController.m
//  360du
//
//  Created by linghang on 15/8/15.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ApplyCommitRobOrderViewController.h"
#import "AutoRobOrderCell.h"
#import "AtOnceRobModel.h"
#import "ApplyCommitRobOrderModel.h"
#import "AFNetworkTwoPackaging.h"
#import "StoreageMessage.h"
#define APPLYCOMMITROBORDERCELL @"applyCommitRobOrderCell"
@interface ApplyCommitRobOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation ApplyCommitRobOrderViewController
- (id)init{
    self = [super init];
    if (self) {
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        [self makeNav];
        [self loadData];
        [self makeTable];
        [self makeHUd];
    }
    return self;
}
- (void)loadData{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    //116.420461,40.016373&memberId=26227
    [twoPack getUrl:[NSString stringWithFormat:APPLYCOMMOTROBORDER,@"116.420461,40.016373",[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        if(![getResult[@"code"] isEqual:@"000000"]){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据请求失败,请重新再试!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alertView show];
            return ;
        }
        for (id temp in getResult[@"datas"]) {
            AutoRobModel *model = [[AutoRobModel alloc] initWithDictionary:temp];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
    }];
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"小区抢单"];
}
- (void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:[AutoRobOrderCell class] forCellReuseIdentifier:APPLYCOMMITROBORDERCELL];
    self.tableView = tableView;
}
#pragma mark tableview的协议代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73 * self.numSingleVesion;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //StudyDetailTableViewCell *cell = nil;
        AutoRobOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:APPLYCOMMITROBORDERCELL forIndexPath:indexPath];
        AutoRobModel *model = self.dataArr[indexPath.row];
        [cell refeshModel:model andSection:2];
        return cell;
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
