//
//  ProertyGotoPayViewController.m
//  360du
//
//  Created by linghang on 16/3/14.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ProertyGotoPayViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "UIView+Toast.h"
#import "StoreageMessage.h"
#import "WeChantViewViewController.h"
#import "AlipayViewController.h"
#import "ProertyPayQueryModel.h"
@interface ProertyGotoPayViewController ()
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,copy)NSString *money;
@property(nonatomic,weak)UILabel *moneyLab;
@property(nonatomic,assign)NSInteger selectPay;//1、支付宝 2、微信
@property(nonatomic,copy)NSString *xhid;
@property(nonatomic,strong)ProertyPayQueryModel *model;

@end

@implementation ProertyGotoPayViewController
- (id)init{
    self = [super init];
    if (self) {
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        [self createNav];
        [self requestData];
        [self createUI];
    }
    return self;
}
- (void)createNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"缴费信息";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(WIDTH_CONTROLLER - 60 * self.numSingleVesion, 5, 80 * self.numSingleVesion, 34 * self.numSingleVesion);
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"历史账单" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnDown) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    

}
//历史账单
- (void)rightBtnDown{

}

- (void)requestData{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSString *url = [NSString stringWithFormat:PROERTYPAYQUERY,[StoreageMessage getMessage][2]];
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            self.model = getResult[@"datas"];
            self.moneyLab.text = [self.model.totalMoney stringValue];
            self.money = [self.model.totalMoney stringValue];
            [self createMainView];
        }else{
            self.moneyLab.text = getResult[@"message"];
        }
    }];
}
- (void)createUI{
    [self createHeadView];
    [self createPayView];
}
- (void)createHeadView{
    CGFloat height = 64;
    //缴费图
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(0, height, WIDTH_CONTROLLER, 100 * self.numSingleVesion)];
    self.moneyLab = moneyLab;
    [self.view addSubview:self.moneyLab];
    self.moneyLab.text = @"暂时没有缴费信息";
    self.moneyLab.backgroundColor = SMSColor(20, 153, 234);
    self.moneyLab.textColor = [UIColor blackColor];
    self.moneyLab.textAlignment = NSTextAlignmentCenter;
    self.moneyLab.font = [UIFont systemFontOfSize:18];
    height += 100 * self.numSingleVesion;
    
    self.height = height;
}
- (void)createMainView{
    CGFloat everHeight = 60 * self.numSingleVesion;
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, everHeight * 7, everHeight)];
    mainView.backgroundColor = SMSColor(246, 246, 246);
    [self.view addSubview:mainView];
    //缴费明细
    UILabel *payDetail = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, self.height + 10 * self.numSingleVesion, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
    payDetail.font = [UIFont systemFontOfSize:16];
    payDetail.text = @"缴费明细";
    [mainView addSubview:payDetail];
    payDetail.textColor = SMSColor(51, 51, 51);
    
    //房屋面积
    UILabel *areaHouse = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, self.height + 10 * self.numSingleVesion, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
    areaHouse.font = [UIFont systemFontOfSize:16];
    areaHouse.text = [NSString stringWithFormat:@"房屋面积:%@M²",self.model.wyFee];
    [mainView addSubview:areaHouse];
    areaHouse.textColor = [UIColor redColor];
    
    
    
}
- (void)createPayView{
    CGFloat height = self.height;
    NSArray *moneyArr = @[@"支付方式",@"支付宝支付",@"微信支付"];
    for (NSInteger i = 0; i < 3; i++) {
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectZero];
        lineLab.backgroundColor = SMSColor(202, 202, 202);
        [self.view addSubview:lineLab];
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:view];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, (40 - 15) / 2 * self.numSingleVesion, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
        titleLab.text = moneyArr[i];
        titleLab.font = [UIFont systemFontOfSize:16];
        [view addSubview:titleLab];
        titleLab.font = [UIFont systemFontOfSize:14];
        
        if(i == 0){
            view.frame = CGRectMake(0, height, WIDTH_CONTROLLER, 39 * self.numSingleVesion);
            view.backgroundColor = SMSColor(246, 246, 246);
            
        }else{
            view.frame = CGRectMake(0, height + 40 * self.numSingleVesion + 50 * self.numSingleVesion * (i - 1), WIDTH_CONTROLLER, 49 * self.numSingleVesion);
            view.backgroundColor = SMSColor(255, 255,255);
            //view.backgroundColor = [UIColor grayColor];
            titleLab.frame = CGRectMake(10 * self.numSingleVesion, 0 * self.numSingleVesion + 10 * self.numSingleVesion, 100 * self.numSingleVesion, 15 * self.numSingleVesion);
            UIImageView *cicreImage = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER - 50 * self.numSingleVesion, 10 * self.numSingleVesion , 30 * self.numSingleVesion, 30 * self.numSingleVesion)];
            cicreImage.image = [UIImage imageNamed:@"圆"];
            cicreImage.clipsToBounds = YES;
            [view addSubview:cicreImage];
            cicreImage.tag = 2000 + i;
            if (i == 1) {
                cicreImage.image = [UIImage imageNamed:@"确认"];
            }
            //详情
            UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 0 * self.numSingleVesion + 30 * self.numSingleVesion, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
            detailLab.textColor = [UIColor redColor];
            detailLab.text = moneyArr[i];
            detailLab.font = [UIFont systemFontOfSize:13];
            [view addSubview:detailLab];
            
            
        }
        switch (i) {
            case 0:{
                lineLab.frame = CGRectMake(0, height - 1 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion);
                break;
            }
            case 1:{
                lineLab.frame = CGRectMake(0, height - 1 * self.numSingleVesion + 90 * self.numSingleVesion + 0 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion);
                
                break;
            }
            case 2:{
                lineLab.frame = CGRectMake(0, height - 1 * self.numSingleVesion + 90 * self.numSingleVesion  + 50 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion);
                
                break;
            }
            default:
                break;
        }
        UIButton *viewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        viewBtn.frame = view.bounds;
        [self.view addSubview:viewBtn];
        [viewBtn setTitle:@"" forState:UIControlStateNormal];
        [viewBtn addTarget:self action:@selector(nextBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:viewBtn];
        viewBtn.tag = 1200 + i;
        
        
    }
    height += 140 * self.numSingleVesion;
    height += 10 * self.numSingleVesion;
    UIButton *viewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    viewBtn.frame = CGRectMake(10 * self.numSingleVesion, height, WIDTH_CONTROLLER - 20 * self.numSingleVesion, 40 * self.numSingleVesion);
    [self.view addSubview:viewBtn];
    [viewBtn setTitle:@"缴费" forState:UIControlStateNormal];
    viewBtn.backgroundColor = [UIColor redColor];
    viewBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [viewBtn addTarget:self action:@selector(nextBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    viewBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:viewBtn];
    viewBtn.tag = 1200 + 3;
}
- (void)nextBtnDown:(UIButton *)nextBtn{
    NSInteger tag = nextBtn.tag - 1200;
    switch (tag) {
            //缴费单位
        case 0:{
            
            break;
        }
            //支付宝
        case 1:{
            UIImageView *aliPayBtn = (UIImageView *)[self.view viewWithTag:2001];
            aliPayBtn.image = [UIImage imageNamed:@"确认"];
            UIImageView *wechantPayBtn = (UIImageView *)[self.view viewWithTag:2002];
            wechantPayBtn.image = [UIImage imageNamed:@"圆"];
            self.selectPay = 1;
            break;
        }
            //微信
        case 2:{
            UIImageView *aliPayBtn = (UIImageView *)[self.view viewWithTag:2002];
            aliPayBtn.image = [UIImage imageNamed:@"确认"];
            UIImageView *wechantPayBtn = (UIImageView *)[self.view viewWithTag:2001];
            wechantPayBtn.image = [UIImage imageNamed:@"圆"];
            
            
            self.selectPay = 2;
            break;
        }
            //去交费
        case 3:{
            if (self.money.length == 0) {
                [self.view makeToast:@"暂时没有缴费情况"];
                break;
            }
            if (self.selectPay == 0) {
                [self.view makeToast:@"请选择缴费情况"];
                break;
                
            }
            if (self.selectPay == 2){
                [WeChantViewViewController payName:self.xhid andMoney:[NSString stringWithFormat:@"%0.2f",[self.money  floatValue] * 100 ] ];
            }else{
                AlipayViewController *aliPay = [[AlipayViewController alloc] initPrice:[NSString stringWithFormat:@"%0.2f",[self.money floatValue]] andDescMerchant:self.xhid andTitle:self.xhid andMerOrder:self.xhid];
                [self.navigationController pushViewController:aliPay animated:YES];
                
                
            }
            break;
        }
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
