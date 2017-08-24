//
//  GoodsPrivilegeViewController.m
//  360du
//
//  Created by linghang on 15/12/22.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "GoodsPrivilegeViewController.h"
#import "GoodsPrevilegeOrderTableCell.h"
#import "AFNetworkTwoPackaging.h"
#import "StoreageMessage.h"
#import "MinePrivilageModel.h"
#import "UIView+Toast.h"
#import "MinePrivilageModel.h"
#import "BuyFoodCarViewController.h"
#define MINEPRIVILAGETABCELL @"minePrivilageTabCell"

@interface GoodsPrivilegeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)CGFloat money;

@end

@implementation GoodsPrivilegeViewController
- (id)initWithMerchantId:(NSString *)merchantId andMoney:(CGFloat )money{
    self = [super init];
    if(self){
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        [self loadData:merchantId];
        self.money = money;
        [self makeUI];
        [self makeNav];
    }
    return self;
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"优惠券";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
}
- (void)loadData:(NSString *)merchantId{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
  
    [twoPack getUrl:[NSString stringWithFormat:CONFIRMORDERPRIVEILAGEQUERY,[StoreageMessage getMessage][2],merchantId] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        if ([getResult[@"code"] isEqual:@"000000"]) {
            for (id temp in getResult[@"datas"]) {
                MinePrivilageModel *model = [[MinePrivilageModel alloc] initWithDictionary:temp];
                [self.dataArr addObject:model];
            }
            [self.tableView reloadData];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
-(void)makeUI{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTENTVIEW, HEIGHT_CONTENTVIEW - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    [self.view addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    //[tableView registerClass:[MinePrivilegeTabCell class] forCellReuseIdentifier:MINEPRIVILAGETABCELL];
    //[tableView registerClass:[StudyDetailTableViewCell class] forCellReuseIdentifier:STUDYD_EATILTABVIEWCELL];
    self.tableView = tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150 * self.numSingleVesion;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //StudyDetailTableViewCell *cell = nil;
    GoodsPrevilegeOrderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:MINEPRIVILAGETABCELL];
    if (!cell) {
        cell = [[GoodsPrevilegeOrderTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MINEPRIVILAGETABCELL];
    }
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell init];
    cell.model = self.dataArr[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MinePrivilageModel *model = self.dataArr[indexPath.row];
    NSInteger isExipred = model.isExpired.integerValue;
    if (isExipred == 2) {
        [self.view makeToast:@"此优惠券已过期，请选择其他优惠券"];
        
    }else {
        CGFloat startMoney = model.startMoney.floatValue;
        if (startMoney > self.money) {
            [self.view makeToast:[NSString stringWithFormat:@"此优惠券必须满足%0.2f使用，请选择其他优惠券",startMoney]];

        }else{
            if ([self.target isKindOfClass:[BuyFoodCarViewController class]]) {
                [self.target retunMoney:model.ysMoney];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }

    }
//    if (self.num == 0) {
//        MinePrivilageModel *model = self.tempArr[indexPath.row];
//        if ([self.target isKindOfClass:[MinePrivilageViewController class]]) {
//            [self.target returnPrivilageModel:model];
//        }
//    }
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
