//
//  OrderDetialViewController.m
//  360du
//
//  Created by 利美 on 16/6/12.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "OrderDetialViewController.h"
#import "UIImageView+WebCache.h"
#import "WeChantViewViewController.h"

@interface OrderDetialViewController ()
@property(nonatomic,strong)UILabel *payLab;//待付款
@property(nonatomic,strong)UILabel *buyTime;//下单时间
@property(nonatomic,strong)UIImageView *leftImg;//左边图片
@property(nonatomic,strong)UILabel *nameLab;//名称
@property(nonatomic,strong)UILabel *deatilLab;//介绍
@property(nonatomic,strong)UILabel *prePriceLab;//原先价格
@property(nonatomic,strong)UILabel *nowPiceLab;//现在价格
@property(nonatomic,strong)UILabel *countLab;//数量
@property(nonatomic,strong)UILabel *totoalPriceLab;//总价
@property(nonatomic,strong)UIButton *payBtn;//付款按钮
@property (nonatomic ,strong) UIButton *shouHuoBtn;


@end

@implementation OrderDetialViewController{
    CGFloat _heigth;
    CGFloat _allHeight;
}

- (instancetype)initWithModel:(MIneGroupModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        [self makeUIAndGiveInfo];
    }
    return self;
}

- (void)viewDidLoad {
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    [super viewDidLoad];
}

-(void)makeUIAndGiveInfo{
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 73 *self.numSingleVesion, self.view.frame.size.width, 30*self.numSingleVesion)];
    nameLabel.text = [NSString stringWithFormat:@" 收货人:%@   电话:%@",self.model.userName,self.model.phone];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:nameLabel];
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 105*self.numSingleVesion, self.view.frame.size.width, 30)];
    addressLabel.font = [UIFont systemFontOfSize:16];
    addressLabel.text = [NSString stringWithFormat:@" 收货地址:%@",self.model.address];
    [self.view addSubview:addressLabel];
    
    UILabel *line1label = [[UILabel alloc] initWithFrame:CGRectMake(0, 140*self.numSingleVesion, self.view.frame.size.width, 1*self.numSingleVesion)];
    line1label.backgroundColor = SMSColor(241, 241, 241);
    [self.view addSubview:line1label];
    
//    _payLab = [[UILabel alloc] initWithFrame:CGRectMake(30*self.numSingleVesion, 143*self.numSingleVesion, 165*self.numSingleVesion, 30*self.numSingleVesion)];
//    _payLab.text = @"待付款";
//    [self.view addSubview:_payLab];
//    _payLab.font = [UIFont systemFontOfSize:15];
//    _payLab.textColor = [UIColor redColor];
    
    
    _buyTime = [[UILabel alloc] initWithFrame:CGRectMake(230*self.numSingleVesion, 143*self.numSingleVesion, 165*self.numSingleVesion, 30*self.numSingleVesion)];
        _buyTime.text = self.model.ordertime;

    [self.view addSubview:_buyTime];
    _buyTime.font = [UIFont systemFontOfSize:15];
    _buyTime.textColor = SMSColor(51, 51, 51);
    
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 39 * self.numSingleVesion, WIDTH_VIEW, 1 * self.numSingleVesion)];
    lineLab.backgroundColor = SMSColor(241, 241, 241);
    [self.view addSubview:lineLab];
    
    
    CGFloat allHeight = 140 * self.numSingleVesion;
    allHeight = allHeight;
    CGFloat height = 140 * self.numSingleVesion;
    _heigth = height;
    _leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 30 * self.numSingleVesion + height, 80 * self.numSingleVesion, 80 * self.numSingleVesion)];
    [self.view addSubview:_leftImg];
    allHeight += 100 * self.numSingleVesion;
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(100 * self.numSingleVesion, 20 * self.numSingleVesion + 50 * i + height, WIDTH_CONTENTVIEW - 130 * self.numSingleVesion, 40 * self.numSingleVesion)];
        nameLable.tag = 2200 + i;
        if (i == 0) {
            nameLable.font = [UIFont systemFontOfSize:15];
            nameLable.textColor = SMSColor(51, 51, 51);
        }else{
            nameLable.font = [UIFont systemFontOfSize:13];
            nameLable.textColor = SMSColor(151, 151, 151);
        }
        
        nameLable.numberOfLines= 2;
        [self.view addSubview:nameLable];
        
    }
    NSArray *colorArr = @[SMSColor(51, 51, 51),SMSColor(151, 151, 151),SMSColor(151, 151, 151)];
    
    for (NSInteger i = 0; i < 3; i++) {
        UILabel *beforeMoneyLable = [[UILabel alloc] initWithFrame:CGRectZero];
        beforeMoneyLable.textColor = colorArr[i];
        //beforeMoneyLable.text = priceArr[i];
        beforeMoneyLable.tag = 2300 + i;
        beforeMoneyLable.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:beforeMoneyLable];
        
        if (i == 1) {
            UILabel *lineMoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1 * self.numSingleVesion)];
            lineMoney.backgroundColor = SMSColor(121,121,121);
            lineMoney.tag = 2400;
            //lineMoney.backgroundColor = [UIColor redColor];
            //self.lineMoney.font = [UIFont systemFontOfSize:18];
            [self.view addSubview:lineMoney];
        }
    }
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, allHeight + 39 * self.numSingleVesion * i , WIDTH_VIEW, 1 * self.numSingleVesion)];
        bottomLine.backgroundColor = SMSColor(241, 241, 241);
        [self.view addSubview:bottomLine];
        
    }
    _totoalPriceLab = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_totoalPriceLab];
    _totoalPriceLab.font = [UIFont systemFontOfSize:16];
    _totoalPriceLab.textColor = [UIColor redColor];
    
    
    _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _payBtn.frame = CGRectMake(WIDTH_VIEW - 50 * self.numSingleVesion, 300* self.numSingleVesion, 50 * self.numSingleVesion, 40 * self.numSingleVesion);
    [_payBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:_payBtn];
    
    UILabel *orderNumberLab = [[UILabel alloc] initWithFrame:CGRectMake(8*self.numSingleVesion, 280* self.numSingleVesion, 200 * self.numSingleVesion, 40 * self.numSingleVesion)];
    orderNumberLab.textColor = [UIColor redColor];
    orderNumberLab.font = [UIFont systemFontOfSize:15];
    orderNumberLab.text = [NSString stringWithFormat:@"订单编号:%@",_model.ccpo];
    [self.view addSubview:orderNumberLab];
    //    _payBtn.backgroundColor = [UIColor cyanColor];
    _payBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _shouHuoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shouHuoBtn.frame = CGRectMake(WIDTH_VIEW - 70 * self.numSingleVesion, 180* self.numSingleVesion, 65 * self.numSingleVesion, 40 * self.numSingleVesion);
    [_shouHuoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:_payBtn];
    
    //    _shouHuoBtn.backgroundColor = [UIColor cyanColor];
    _shouHuoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.shouHuoBtn];
//    [_payBtn setTitle:@"付款" forState:UIControlStateNormal];
//    [_payBtn addTarget:self action:@selector(payBtnDown:) forControlEvents:UIControlEventTouchUpInside];
//    
    [_leftImg sd_setImageWithURL:[NSURL URLWithString:self.model.cppicture]];
    NSArray *textArr = @[self.model.pname,[NSString stringWithFormat:@"%@",self.model.name]];
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *nameLable = (UILabel *)[self.view viewWithTag:2200 + i];
        nameLable.text = textArr[i];
        
    }
    NSArray *priceArr = @[[NSString stringWithFormat:@"￥%@",_model.marketPrice],[NSString stringWithFormat:@"￥%@",_model.unitPrice],[NSString stringWithFormat:@"x%@",_model.preCount]];
    for (NSInteger i = 0; i < priceArr.count; i++) {
        UILabel *beforeMoneyLable = (UILabel *)[self.view viewWithTag:2300 + i];
        beforeMoneyLable.text = priceArr[i];
        [beforeMoneyLable sizeToFit];
        beforeMoneyLable.frame = CGRectMake(WIDTH_VIEW - beforeMoneyLable.frame.size.width - 5 * self.numSingleVesion, 25 * self.numSingleVesion + 30 * self.numSingleVesion * i + _heigth, beforeMoneyLable.frame.size.width, 15 * self.numSingleVesion);
        
        if (i == 1) {
            UILabel *lineMoney = (UILabel *)[self.view viewWithTag:2400];
            lineMoney.frame =  CGRectMake(WIDTH_VIEW - beforeMoneyLable.frame.size.width - 5 * self.numSingleVesion, 25 * self.numSingleVesion + 30 * self.numSingleVesion * i + 7.5 * self.numSingleVesion + _heigth, beforeMoneyLable.frame.size.width, 1 * self.numSingleVesion);
            
        }
    }
    
    _totoalPriceLab.text = [NSString stringWithFormat:@"合计:%@",_model.totalPrice];
    [_totoalPriceLab sizeToFit];
    _totoalPriceLab.center = CGPointMake(WIDTH_VIEW - 20 * self.numSingleVesion - _totoalPriceLab.frame.size.width / 2, 260 * self.numSingleVesion);
    
    
    

}
- (void)payBtnDown:(UIButton *)payBtn{
        if ([payBtn.titleLabel.text isEqualToString:@"付款"]) {
            
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                 
                                                          message:@"请选择支付方式："
                                 
                                                         delegate:self
                                 
                                                cancelButtonTitle:@"取消"
                                 
                                                otherButtonTitles:@"使用微信支付",
                                 @"使用支付宝支付",
                                 nil];
            [alert show];
        }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if (buttonIndex == 1) {
//        NSLog(@"%@",_model.pname);
//        //         [WeChantViewViewController payName:_payName andMoney:[NSString stringWithFormat:@"%0.2f",_payNumber.floatValue * 100 ]];
//        NSLog(@"%@",[NSString stringWithFormat:@"GB%@",_model.groupNo]);
        [WeChantViewViewController payName:_model.pname andMoney:[NSString stringWithFormat:@"%0.2f",_model.totalPrice.floatValue *100] andOder:[NSString stringWithFormat:@"GB%@",_model.ccpo]];
    }else if (buttonIndex == 2){
//        NSLog(@"%@",[NSString stringWithFormat:@"GB%@",_model.groupNo]);

        [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"GB%@",_model.ccpo] totalMoney:[NSString stringWithFormat:@"%0.2f",_model.totalPrice.floatValue] payTitle:_model.pname];
    }
}
    // Do any additional setup after loading the view.


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
