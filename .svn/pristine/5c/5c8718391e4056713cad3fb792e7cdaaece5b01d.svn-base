//
//  ProertyMendSeverViewController.m
//  360du
//
//  Created by linghang on 15/7/18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ProertyMendSeverViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "PropertyListModel.h"
#import "ProertyMendAndQuestionCell.h"
#import "ProertyMendAndServerListViewController.h"
#import "ProertyAddMendAndServerViewController.h"
#import "StoreageMessage.h"

#define PROERTYMENDANDQUESTIONCELL @"proertyMendAndQuestionCell"
@interface ProertyMendSeverViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)NSInteger classId;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)UILabel *navTitle;
@property(nonatomic,strong)NSString *titleStr;
@end

@implementation ProertyMendSeverViewController
-(id)initWithClassId:(NSInteger)classId{
    self = [super init];
    if (self) {
        self.classId = classId;
        if (classId == 0) {
            self.titleStr = @"维修服务";
        }else{
            self.titleStr = @"问题反馈";
        }
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        [self loadData];
        [self makeNav];
        [self makeTable];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
-(void)loadData{
    NSString *url = nil;
    if (self.classId == 0) {
        url = [NSString stringWithFormat:PEOERTYLISTMENDANDSERVEANDQUESTONCOMMIT,self.classId + 1];
    }else{
        url = [NSString stringWithFormat:PEOERTYLISTMENDANDSERVEANDQUESTONCOMMIT,self.classId + 1];
    }
    [self makeHUd];
    AFNetworkTwoPackaging *twoPage = [[AFNetworkTwoPackaging alloc] init];
    [twoPage getUrl:url andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        for (id temp in getResult[@"datas"]) {
            PropertyListModel *model = [[PropertyListModel alloc] initWithDictionary:temp];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
    }];
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = self.titleStr;
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navTitle = lable;
    self.navigationItem.titleView = view;
}
-(void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:[ProertyMendAndQuestionCell class] forCellReuseIdentifier:PROERTYMENDANDQUESTIONCELL];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
#pragma mark tableView的协议dail 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProertyMendAndQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:PROERTYMENDANDQUESTIONCELL forIndexPath:indexPath];
    cell.target = self;
    PropertyListModel *model = self.dataArr[indexPath.row];
    [cell refreshModel:model andRow:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60 * self.numSingleVesion;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *url = [NSString stringWithFormat:PEOERTYMENDANDSERVEANDQUESTUIONLIST,self.classId,indexPath.row,[StoreageMessage getMessage][2]];
        PropertyListModel *model = self.dataArr[indexPath.row];
    ProertyMendAndServerListViewController *mendAndServer = [[ProertyMendAndServerListViewController alloc] initWithUrl:url andNavTitle:model.name];
    mendAndServer.classId = self.classId;
    mendAndServer.tag = indexPath.row;
    [self.navigationController pushViewController:mendAndServer animated:YES];
}
#pragma maek 添加进入下一个
-(void)returnNextBtn:(NSInteger)tag{
    ProertyAddMendAndServerViewController *proertyAddMendAndServer = [[ProertyAddMendAndServerViewController alloc] initWithNavTitle:@"维修列表"];
    proertyAddMendAndServer.classification = [NSString stringWithFormat:@"%ld",self.classId];
    proertyAddMendAndServer.baseType = [NSString stringWithFormat:@"%ld",tag];
    [self.navigationController pushViewController:proertyAddMendAndServer animated:YES];
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
