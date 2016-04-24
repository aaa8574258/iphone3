//
//  PrivilegeCenterViewController.m
//  360du
//
//  Created by linghang on 15/12/8.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "PrivilegeCenterViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "UIView+Toast.h"
#import "PrivilegeCenterModel.h"
#import "PrivilegeTableViewCell.h"
#import "StoreageMessage.h"
#import "GainPrivilageSuccessViewController.h"
#define PRIVILEGETABLEVIEWCELL @"privilegeTableCell"
@interface PrivilegeCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation PrivilegeCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    [self makeNav];
    [self loadData];
    [self makeTable];
    
    // Do any additional setup after loading the view.
}
- (void)makeNav{

    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    [self setNavTitleItemWithName:@"领券中心"];
}
- (void)loadData{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:GETPRIVEILAGECENTER andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqual:@"000000"]) {
            for (NSDictionary *temp in getResult[@"datas"]) {
                PrivilegeCenterModel *model = [[PrivilegeCenterModel alloc] initWithDictionary:temp];
                [self.dataArr addObject:model];
            }
            [self.tableView reloadData];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
}
- (void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    tableView.separatorStyle = NO;
}
#pragma mark tableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 175 * self.numSingleVesion + 30 * self.numSingleVesion;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrivilegeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PRIVILEGETABLEVIEWCELL];
    if (!cell) {
        cell = [[PrivilegeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PRIVILEGETABLEVIEWCELL];
    }
    PrivilegeCenterModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PrivilegeCenterModel *model = self.dataArr[indexPath.row];
//领取券
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:GAINMINEPRIVEILAGE,[StoreageMessage getMessage][2],model.pcid,[StoreageMessage getLatAndLong]] andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqual:@"000000"]) {
            GainPrivilageSuccessViewController *gainPri = [[GainPrivilageSuccessViewController alloc] initWithArr:getResult];
            [self.navigationController pushViewController:gainPri animated:YES];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
}
//领取券

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
