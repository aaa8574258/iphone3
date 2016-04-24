//
//  ParkingMineDetailViewController.m
//  360du
//
//  Created by linghang on 16/1/8.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ParkingMineDetailViewController.h"
#import "ParkingQueryModel.h"
#import "ParkingMineDetailCarView.h"
#import "AlipayViewController.h"
#import "StoreageMessage.h"
#import "UIView+Toast.h"
#import "WeChantViewViewController.h"
@interface ParkingMineDetailViewController ()

@end

@implementation ParkingMineDetailViewController
- (id)initWithModel:(ParkingQueryModel *)model{
    self = [super init];
    if (self) {
        [self createNav];
        [self createScrollView:model];
    }
    return self;
}

- (void)createNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"我要停车"];
}
- (void)createScrollView:(ParkingQueryModel *)model{
    ParkingMineDetailCarView *detailView = [[ParkingMineDetailCarView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_VIEW, HEIGHT_CONTROLLER - 64) andModel:model];
    detailView.target = self;
    [self.view addSubview:detailView];
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 49 * self.numSingleVesion)];
//    scrollView.showsVerticalScrollIndicator = NO;
//    [self.view addSubview:scrollView];
//    scrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER,  HEIGHT_CONTROLLER - 64 - 49 * self.numSingleVesion);
}
//付款信息
//返回付钱的参数
- (void)getPayMoneyTime:(NSInteger)payTime andPayTimeType:(NSString *)payTimeType andOrderId:(NSString *)orderId andCarName:(NSString *)carName andCarAddress:(NSString *)carAddress andPayMoney:(NSString *)money andPayType:(NSInteger)payType{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSString *url = [NSString stringWithFormat:PARKINGPAY,orderId,[NSString stringWithFormat:@"%ld",payTime],payTimeType,[StoreageMessage getMessage][2],[StoreageMessage getCommuntityId]];
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqual:@"000000"]) {
            if (payType == 0) {//支付宝支付
                [self payWithMoney:money andTitle:carName andDesc:carAddress andOrderId:getResult[@"cb_id"]];
            }else{//1微信支付
                [WeChantViewViewController payName:carName andMoney:[NSString stringWithFormat:@"%lf",money.floatValue * 100]];
                //[self.view makeToast:@"请选择支付宝支付，暂不支持微信支付!"];
            }
            
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
}
- (void)payWithMoney:(NSString *)payMoney andTitle:(NSString *)carName andDesc:(NSString *)address andOrderId:(NSString *)orderId{
    AlipayViewController *aliPay = [[AlipayViewController alloc] initPrice:payMoney andDescMerchant:address andTitle:carName andMerOrder:orderId];
    [self.navigationController pushViewController:aliPay animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view from its nib.
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
