//
//  ScrOrderCenterDeatilViewController.m
//  360du
//
//  Created by linghang on 16/3/9.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ScrOrderCenterDeatilViewController.h"
#import "OrderCenterFinishModel.h"
@interface ScrOrderCenterDeatilViewController ()
@property(nonatomic,strong)UILabel *nameLab;//姓名
@property(nonatomic,strong)UILabel *telLab;//手机号
@property(nonatomic,strong)UILabel *beginLab;//开始地点
@property(nonatomic,strong)UILabel *endLab;//结束地点

@end

@implementation ScrOrderCenterDeatilViewController
- (id)initWithModel:(OrderCenterFinishModel *)model{
    self = [super init];
    if (self) {
        [self createNav];
        [self createView:model];
    }
    return self;
}
- (void)createNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"我的订单详情"];

}
- (void)createView:(OrderCenterFinishModel *)model{
    CGFloat width = WIDTH_CONTROLLER;
    CGFloat height = 64 + 10 * self.numSingleVesion;
    UILabel *orderDetailLab = [[UILabel alloc] initWithFrame:CGRectMake(40 * self.numSingleVesion, height , width - 80 * self.numSingleVesion, 40 * self.numSingleVesion)];
    orderDetailLab.backgroundColor = [UIColor redColor];
    orderDetailLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:orderDetailLab];
    orderDetailLab.textAlignment = NSTextAlignmentLeft;
    orderDetailLab.text = [NSString stringWithFormat:@"  订单编号:%@",model.orderId];
    
    height += 40 * self.numSingleVesion;

    //姓名
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, height + 10 * self.numSingleVesion, 50 * self.numSingleVesion, 15 * self.numSingleVesion)];
    self.nameLab.font = [UIFont systemFontOfSize:18];
    self.nameLab.textColor = [UIColor blackColor];
    [self.view addSubview:self.nameLab];
    //电话
    UIView *telView = [[UIView alloc] initWithFrame:CGRectMake(70 * self.numSingleVesion, 5 * self.numSingleVesion + height, 100 * self.numSingleVesion, 20 * self.numSingleVesion)];
    telView.layer.borderWidth = 1 * self.numSingleVesion;
    telView.layer.borderColor = [SMSColor(153, 153, 153) CGColor];
    [self.view addSubview:telView];
    
    self.telLab = [[UILabel alloc] initWithFrame:telView.bounds];
    self.telLab.textAlignment = NSTextAlignmentCenter;
    [telView addSubview:self.telLab];
    self.telLab.font = [UIFont systemFontOfSize:14];
        //源地
    self.beginLab = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, 30 * self.numSingleVesion + height, width - 5 * self.numSingleVesion - 50 * self.numSingleVesion, 17 * self.numSingleVesion)];
    self.beginLab.font = [UIFont systemFontOfSize:14];
    self.beginLab.textColor = [UIColor redColor];
    [self.view addSubview:self.beginLab];
    //目的地
    self.endLab = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, 55 * self.numSingleVesion + height, width - 5 * self.numSingleVesion - 50 * self.numSingleVesion, 17 * self.numSingleVesion)];
    self.endLab.font = [UIFont systemFontOfSize:14];
    self.endLab.textColor = [UIColor redColor];
    [self.view addSubview:self.endLab];

//
    //名称
    self.nameLab.text = model.consignee;
    //电话
    self.telLab.text = model.phone;
    //起始地
    self.beginLab.text = [NSString stringWithFormat:@"从:%@",model.businessAddress];
    //目的地
    self.endLab.text = [NSString stringWithFormat:@"到:%@",model.goalAddress];
    //起始地
    NSMutableAttributedString *beginStr = [[NSMutableAttributedString alloc] initWithString:self.beginLab.text];
    [beginStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
    self.beginLab.attributedText = beginStr;
    //目的地
    NSMutableAttributedString *destationStr = [[NSMutableAttributedString alloc] initWithString:self.endLab.text];
    [destationStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
    self.endLab.attributedText = destationStr;
   

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
