//
//  GroupPurchaseCenterViewController.m
//  360du
//
//  Created by linghang on 15/12/19.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "GroupPurchaseCenterViewController.h"
#import "StoreageMessage.h"
#import "GroupPurchaseCenterTableViewCell.h"
#import "AFNetworkTwoPackaging.h"
#import "GroupPurchaseModel.h"
#import "UIView+Toast.h"
#import "GroupPurchaseModel.h"
#import "TranlateTime.h"
#import "GroupRobGoodsViewController.h"
#define GROUPPURCHASECENTERTABCELL  @"groupPurchaseCenterTabCell"
@interface GroupPurchaseCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,weak)UIView *headView;

@end

@implementation GroupPurchaseCenterViewController
- (void)viewWillAppear:(BOOL)animated{
    [self loadData];
    [self makeHUd];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    [self makeNav];
    [self makeTable];
//    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:[StoreageMessage getCity]];
}
- (void)loadData{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSLog(@"url:%@",GROUPPURCHASECENTER);
    [twoPack getUrl:GROUPPURCHASECENTER andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        if ([getResult[@"code"] isEqual:@"000000"]) {
            [self.dataArr removeAllObjects];
            for (id temp in getResult[@"datas"]) {
                GroupPurchaseModel *model = [[GroupPurchaseModel alloc] initWithDictionary:temp];
                [self.dataArr addObject:model];
            }

            [self.tableView reloadData];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
}
- (void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 0 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
   
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
    //return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupPurchaseCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GROUPPURCHASECENTERTABCELL];
    if (!cell) {
        cell = [[GroupPurchaseCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GROUPPURCHASECENTERTABCELL];
        
    }
    GroupPurchaseModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    cell.time = model.stopTime;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220 * self.numSingleVesion;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40 * self.numSingleVesion;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0,0, WIDTH_CONTROLLER, 40 * self.numSingleVesion)];
      headView.backgroundColor = SMSColor(241, 241, 241);
//    headView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:headView];
//    self.headView = headView;
    //底线
//    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 39 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion)];
//    lineLab.backgroundColor = SMSColor(151, 151, 151);
//    [headView addSubview:lineLab];
    //左边红色
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10 * self.numSingleVesion, 40 * self.numSingleVesion)];
    leftLab.backgroundColor = SMSColor(230, 26, 27);
    [headView addSubview:leftLab];
    //goodsName
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLab.textColor = SMSColor(151, 151, 151);
    nameLab.text = @"精美商品疯狂抢购中,再不抢就没了";
    nameLab.font = [UIFont systemFontOfSize:15];
    [nameLab sizeToFit];
    nameLab.center = CGPointMake(15 * self.numSingleVesion + nameLab.frame.size.width / 2, 20 * self.numSingleVesion);
    [headView addSubview:nameLab];
    return headView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupPurchaseModel *model = self.dataArr[indexPath.row];
    GroupRobGoodsViewController *robGoods = [[GroupRobGoodsViewController alloc] initWithModel:model];;
    [self.navigationController pushViewController:robGoods animated:YES];
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
