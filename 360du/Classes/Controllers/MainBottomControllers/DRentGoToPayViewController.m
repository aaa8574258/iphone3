//
//  DRentGoToPayViewController.m
//  360du
//
//  Created by 利美 on 16/6/23.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "DRentGoToPayViewController.h"
#import "ZFChooseTimeViewController.h"
#import "StoreageMessage.h"
#import "WeChantViewViewController.h"
#import "AlipayViewController.h"
#import "UIView+Toast.h"
#import "NSString+URLEncoding.h"
#import <AlipaySDK/AlipaySDK.h>
//#import 
@interface DRentGoToPayViewController ()
@property (nonatomic ,assign) NSInteger payFlag;
//@property (nonatomic ,copy) NSString *money;
@end

@implementation DRentGoToPayViewController


-(void)viewWillAppear:(BOOL)animated{

//    [self asas];

    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"landi.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 40);
    [leftBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    if (self.star && self.end) {
        [self asas];
//        [self viewDidLoad];
    }else{
        self.timeLab.text = @"";
        self.fjzeLab.text = @"尚未选择时间!";
    }
    NSLog(@"%@--%@--%@--%@--%@",self.rent,self.yj,self.tilr,self.star,self.end);
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap=[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (randomColor:)];
    [self.chooseTimeView addGestureRecognizer :tap];
    self.chooseTimeView. userInteractionEnabled = YES ;
    self.titleLab.text = self.tilr;
    self.starTime.text = self.star;
    self.endTime.text =self.end;
    self.yfdjLab.text = self.yj;
    
    
    
    UITapGestureRecognizer *tapPay1 =[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (PayAction:)];
    [self.aliPayView addGestureRecognizer :tapPay1];
    self.aliPayView. userInteractionEnabled = YES ;

    UITapGestureRecognizer *tapPay2 =[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (PayAction:)];
    [self.weChatPayView addGestureRecognizer :tapPay2];
    self.weChatPayView. userInteractionEnabled = YES ;
    
    [self.OkBtn addTarget:self action:@selector(pushToSever) forControlEvents:UIControlEventTouchUpInside];
}


-(void)PayAction:( UITapGestureRecognizer *)gestureRecognizer{

    if (gestureRecognizer.view.tag == 410880) {
        [self.aliImage setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_on"]];
        [self.weChatImage setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off"]];
        
    }else if (gestureRecognizer.view.tag == 410881){
        [self.weChatImage setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_on"]];
        [self.aliImage setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off"]];
    }
    self.payFlag = gestureRecognizer.view.tag - 410879;
}






-( void )randomColor:( UITapGestureRecognizer *)gestureRecognizer{

    
    
    AFNetworkTwoPackaging *twoPacking1 = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking1 getUrl:[NSString stringWithFormat:TIMETORENT,self.houseId] andFinishBlock:^(id getResult) {
        NSLog(@"time :%@",getResult);
        ZFChooseTimeViewController * vc =[ZFChooseTimeViewController new];
        //    vc.timeCannotChooseArr = @[@"2016",@"07",@"02"];
        
        [vc backDate:^(NSArray *goDate, NSArray *backDate) {
            self.star = [goDate componentsJoinedByString:@"-"];
            self.end = [backDate componentsJoinedByString:@"-"];
            //        NSLog(@"%@",self.StarTime);
            NSLog(@"%@-%lu",backDate, backDate.count);
            //        [self.ckrlBtn setTitle:[NSString stringWithFormat:@"%@ 到 %@",[goDate componentsJoinedByString:@"-"],[backDate componentsJoinedByString:@"-"]] forState:UIControlStateNormal];
            self.starTime.text = [goDate componentsJoinedByString:@"-"];
            self.endTime.text = [backDate componentsJoinedByString:@"-"];
            [self asas];
        }];
        
        if ([getResult[@"code"] isEqualToString:@"000001"]) {
            
            
            
        }else if ([getResult[@"code"] isEqualToString:@"000000"]){
            
            vc.arr = getResult[@"datas"];
        }
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:^{
        }];
    }];
}

-(void)asas{
    NSString *dateStr = self.star;// 2012-05-17 11:23:23
    NSLog(@"%@,%@",self.starTime.text,self.endTime.text);
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *fromdate=[format dateFromString:dateStr];
    
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    
    NSLog(@"fromdate=%@",fromDate);
    
    
    
    NSString *dateStr1 = self.end;// 2012-05-17 11:23:23
    
    NSCalendar *gregorian1 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags1 = NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    
    [format1 setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *fromdate1=[format dateFromString:dateStr1];
    
    NSTimeZone *fromzone1 = [NSTimeZone systemTimeZone];
    
    NSInteger frominterval1 = [fromzone1 secondsFromGMTForDate: fromdate];
    
    NSDate *fromDate1 = [fromdate1  dateByAddingTimeInterval: frominterval1];
    
    NSLog(@"fromdate=%@",fromDate1);
    
//    NSDate *date = [NSDate date];
//    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
//    
//    NSLog(@"enddate=%@",localeDate);
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:fromDate toDate:fromDate1 options:0];
    
//    NSInteger months = [components month];
    
    NSInteger days = [components day];//年[components year]
//    NSLog(@"month=%d",months);
    
    NSLog(@"days=%ld",(long)days);
    self.timeLab.text = [NSString stringWithFormat:@"共%ld天",(long)days];

    self.fjzeLab.text = [NSString stringWithFormat:@"%ld元",self.rent.intValue * days];
    self.money = [NSString stringWithFormat:@"%ld",self.rent.intValue * days];
}




-(void) pushToSever {
    if (![StoreageMessage getMessage][2]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"获取登录信息失败!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!_star) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择开始和结束时间!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!_end) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择开始和结束时间!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!self.personCountTextF.text.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写住房人数!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!self.nameTextField.text.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写联系人姓名!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!self.telTextF.text.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写联系人联系方式!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else if (!_payFlag) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择付款方式!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
    }else{
    
    
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    NSString *strUrl = [NSString stringWithFormat:RENTGOTOPAY,_houseId,[StoreageMessage getMessage][2],_star,_end,[[self.personCountTextF.text urlEncodeString] urlEncodeString] ,[[self.nameTextField.text urlEncodeString] urlEncodeString] ,[[self.telTextF.text urlEncodeString] urlEncodeString],[NSString stringWithFormat:@"%ld",(long)_payFlag]];
        NSLog(@"%@",strUrl);
    [twoPacking getUrl:strUrl andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
        NSLog(@"%@-%@",getResult,getResult[@"datas"][@"orderId"]);
        [self pay:[NSString stringWithFormat:@"RENT%@",getResult[@"datas"][@"orderId"]]];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
    }

}

-(void)pay:(NSString *)str{
    [self.view makeToast:@"即将跳转至支付页面!"];
    NSLog(@"121212%@",[NSString stringWithFormat:@"%f",self.money.floatValue]);
    if (self.payFlag == 2) {
        [WeChantViewViewController payName:self.tilr andMoney:[NSString stringWithFormat:@"%f",self.fjzeLab.text.floatValue * 100] andOder:str];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayResultNoti:) name:WX_PAY_RESULT object:nil];
        
    }
    if (self.payFlag == 1) {
        [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:str totalMoney:[NSString stringWithFormat:@"%0.2f",self.fjzeLab.text.floatValue] payTitle:self.tilr];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AliPayResultNoti:) name:ALI_PAY_RESULT object:nil];
    }

//    [self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>]
}
-(void)weChatPayResultNoti:(NSNotification *)noti{
    NSLog(@"%@",noti);
    if ([[noti object] isEqualToString:IS_SUCCESSED]) {
        [self.view makeToast:@"支付成功"];
    }else{
        [self.view makeToast:@"支付失败"];
    }
    //上边添加了监听，这里记得移除
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WX_PAY_RESULT object:nil];
}

//支付宝支付成功失败
-(void)AliPayResultNoti:(NSNotification *)noti
{
    NSLog(@"%@",noti);
    if ([[noti object] isEqualToString:ALIPAY_SUCCESSED]) {
        [self.view makeToast:@"支付成功"];
    }else{
        [self.view makeToast:@"支付失败"];
    }
    //上边添加了监听，这里记得移除
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALI_PAY_RESULT object:nil];
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
