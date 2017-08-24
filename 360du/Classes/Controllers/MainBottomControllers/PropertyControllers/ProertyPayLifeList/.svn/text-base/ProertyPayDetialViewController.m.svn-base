//
//  ProertyPayDetialViewController.m
//  360du
//
//  Created by 利美 on 16/10/23.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ProertyPayDetialViewController.h"
#import "UIView+Toast.h"
#import "StoreageMessage.h"
#import "WeChantViewViewController.h"
@interface ProertyPayDetialViewController ()
@property (nonatomic ,strong) UIImageView *imagevx;
@property (nonatomic ,strong) UIImageView *imageAl;
@property (nonatomic ,copy) NSString *payType;
@end

@implementation ProertyPayDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"0.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 20) / 2, 15, 15);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text=@"账单详情";
    lable.font = [UIFont systemFontOfSize:19 * self.numSingleVesion];
    lable.textColor = [UIColor blackColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftBarButtonItems = @[leftSecondItem,centerBar];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self makeUI];
    
    if (self.tag.integerValue == 4 || self.tag.integerValue == 5) {
        NSLog(@"%@",self.model.payStatus);

        if (self.model.payStatus.integerValue == 2) {//已交
            [self makeUI41];
        }
        if (self.model.payStatus.integerValue == 1) {
            [self makeUI42];
        }
    }else if (self.tag.integerValue == 6) {
        NSLog(@"%@",self.model.payStatus);
        
        if (self.model.payStatus.integerValue == 1) {//未交
            [self makeUI62];
        }
        if (self.model.payStatus.integerValue == 2) {
            [self makeUI61];
        }
    }else{
        if ([self.model.payStatus isEqualToString:@"未交"]) {
            [self makeUI2];
        }
        if ([self.model.payStatus isEqualToString:@"已交"]) {
            [self makeUI1];
        }
    }
}

-(void) makeUI{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    if (self.tag.integerValue == 1 ) {
        [imageView setImage:[UIImage imageNamed:@"jiaoshuifei.png"]];

    }else if(self.tag.integerValue == 2){
        [imageView setImage:[UIImage imageNamed:@"jiaodianfei.png"]];

    }else if (self.tag.integerValue == 3) {
        [imageView setImage:[UIImage imageNamed:@"jiaoranqifei.png"]];

    }else if (self.tag.integerValue == 4){
        [imageView setImage:[UIImage imageNamed:@"jiaoqunuanfei.png"]];

    }else if ( self.tag.integerValue == 5){
        [imageView setImage:[UIImage imageNamed:@"jiaowuyefei.jpg"]];
    }else if (self.tag.integerValue == 6) {
        [imageView setImage:[UIImage imageNamed:@"jiaoqunuanfei.jpg"]];
    }
    imageView.center = CGPointMake(100 *self.numSingleVesion, 64 + 25 * self.numSingleVesion);
    [self.view addSubview:imageView];
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectZero];
    titLab.font = [UIFont systemFontOfSize:17 * self.numSingleVesion];
    if (self.tag.integerValue == 6) {
        titLab.text = self.model.xqname;

    }else{
        titLab.text = self.model.xqName;
    }
    [titLab sizeToFit];
    titLab.center = CGPointMake(self.view.frame.size.width/2, 64 + 25 *self.numSingleVesion);
    titLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:titLab];
    
    UILabel *titLab1 = [[UILabel alloc] initWithFrame:CGRectZero];
    titLab1.font = [UIFont systemFontOfSize:30 * self.numSingleVesion];
    if (self.tag.integerValue == 5 && self.model.resultPropor.integerValue != 0) {
        titLab1.text = [NSString stringWithFormat:@"%@",self.model.paid];
    }else{
    
    
        if (self.tag.integerValue == 4 || self.tag.integerValue == 5) {
            titLab1.text =[NSString stringWithFormat:@"%@",self.model.payMoney];
            NSLog(@"%@",self.model.payMoney);
        }else{
            titLab1.text = self.model.totalMoney;
        }
    }
    [titLab1 sizeToFit];
    titLab1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];

    titLab1.center = CGPointMake(self.view.frame.size.width/2, 64 + 80 * self.numSingleVesion);
    [self.view addSubview:titLab1];
    
    UILabel *titLab2 = [[UILabel alloc] initWithFrame:CGRectZero];
    titLab2.font = [UIFont systemFontOfSize:17 * self.numSingleVesion];
//    titLab2.text = self.model.payStatus;
    if (self.tag.integerValue == 4 || self.tag.integerValue == 5) {
//        NSLog(@"%@",self.model.payStatus);
//
        if (self.model.payStatus.integerValue == 1) {
            titLab2.text = @"已交";
        }else{
            titLab2.text = @"未交";
        }
    }else if (self.tag.integerValue == 6) {

        if (self.model.payStatus.integerValue == 1) {
            titLab2.text = @"未交";
        }else{
            titLab2.text = @"已交";
        }
    }else{
        titLab2.text = self.model.payStatus;
    }
    [titLab2 sizeToFit];
    titLab2.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];

    titLab2.center = CGPointMake(self.view.frame.size.width/2, 64 + 115 *self.numSingleVesion);
    [self.view addSubview:titLab2];
    
   
    
    

}



-(void) makeUI1{
    NSArray *arr1 = @[@"住户姓名",@"房间信息",@"费用开始时间",@"费用结束时间",@"上月表字数",@"本月表字数",@"流水账号",@"缴费时间",@"缴费人手机号"];
    NSArray *arr2 = @[self.model.userName,self.model.houseInfo,self.model.startTime,self.model.endTime,self.model.beforeValue,self.model.nowValue,self.model.thirdPayNo,self.model.paytime,self.model.payerPhone];
    for (NSInteger i = 0; i < 9 ; i ++) {
        UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 210 + i * 29 * self.numSingleVesion, 100, 29 * self.numSingleVesion)];
        titLab.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        titLab.text = arr1[i];
        [titLab sizeToFit];
        titLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:titLab];
        UILabel *titLab1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 200, 210 + i * 29 * self.numSingleVesion, 192 * self.numSingleVesion, 29 * self.numSingleVesion)];
        titLab1.textAlignment = NSTextAlignmentRight;

        titLab1.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        titLab1.text = arr2[i];
        titLab1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [self.view addSubview:titLab1];
        
        
    }
}

-(void) makeUI2{
    NSArray *arr1 = @[@"住户姓名",@"房间信息",@"费用开始时间",@"费用结束时间",@"上月表字数",@"本月表字数"];
    NSArray *arr2 = @[self.model.userName,self.model.houseInfo,self.model.startTime,self.model.endTime,self.model.beforeValue,self.model.nowValue];
    for (NSInteger i = 0; i < 6 ; i ++) {
        UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(8* self.numSingleVesion, 210* self.numSingleVesion + i * 29 * self.numSingleVesion, 100* self.numSingleVesion, 29 * self.numSingleVesion)];
        titLab.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        titLab.text = arr1[i];
        [titLab sizeToFit];
        //        titLab.center = CGPointMake(8 * self.numSingleVesion,150 * self.numSingleVesion + i * 30*self.numSingleVesion);
        titLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:titLab];
        
        
        UILabel *titLab1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 200* self.numSingleVesion, 210* self.numSingleVesion + i * 29 * self.numSingleVesion, 192 * self.numSingleVesion, 29 * self.numSingleVesion)];
        titLab1.textAlignment = NSTextAlignmentRight;
        
        titLab1.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        titLab1.text = arr2[i];
        //        [titLab1 sizeToFit];
        //        titLab.center = CGPointMake(8 * self.numSingleVesion,150 * self.numSingleVesion + i * 30*self.numSingleVesion);
        titLab1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:titLab1];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8* self.numSingleVesion, 383 *self.numSingleVesion, self.view.frame.size.width - 16* self.numSingleVesion, 1 * self.numSingleVesion)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    if (self.zfbTag.integerValue == 1 || self.wxTag.integerValue == 1) {

    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10* self.numSingleVesion, 410 * self.numSingleVesion, 100* self.numSingleVesion, 20* self.numSingleVesion)];
    lab1.font = [UIFont systemFontOfSize:12 * self.numSingleVesion];
    lab1.text = @"选择支付方式";
    lab1.textColor = [UIColor redColor];
    [self.view addSubview:lab1];
    }
    if (self.zfbTag.integerValue == 1) {
        
    UIView *payView1 = [[UIView alloc] initWithFrame:CGRectMake(8* self.numSingleVesion, 425 * self.numSingleVesion, self.view.frame.size.width - 16* self.numSingleVesion, 30 * self.numSingleVesion)];
    payView1.tag = 111111;
    [self.view addSubview:payView1];
    
    
    UILabel *lab11 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8 * self.numSingleVesion, 100* self.numSingleVesion, 30* self.numSingleVesion)];
    lab11.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    lab11.text = @"支付宝支付";
    [payView1 addSubview:lab11];
    
    UIImageView *image11 = [[UIImageView alloc] initWithFrame:CGRectMake(payView1.frame.size.width - 20 *self.numSingleVesion, 14 * self.numSingleVesion, 18 * self.numSingleVesion, 18 *self.numSingleVesion)];
//    image11.backgroundColor = [UIColor redColor];
    [image11 setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off.png"]];

    [payView1 addSubview:image11];
    self.imageAl = image11;
        
        UITapGestureRecognizer * tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
        [payView1 addGestureRecognizer:tapGesture1];

    }

    if (self.wxTag.integerValue == 1) {
        
    UIView *payView2 = [[UIView alloc] initWithFrame:CGRectMake(8* self.numSingleVesion, 465 * self.numSingleVesion, self.view.frame.size.width - 16* self.numSingleVesion, 30 * self.numSingleVesion)];
    payView2.tag = 222222;
    [self.view addSubview:payView2];
    
    UILabel *lab12 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8 * self.numSingleVesion, 100* self.numSingleVesion, 30* self.numSingleVesion)];
    lab12.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    lab12.text = @"微信支付";
    [payView2 addSubview:lab12];
    
    UIImageView *image12 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 16* self.numSingleVesion - 20 *self.numSingleVesion, 14 * self.numSingleVesion, 18 * self.numSingleVesion, 18 *self.numSingleVesion)];
//    image12.backgroundColor = [UIColor redColor];
      [image12 setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off.png"]];
    [payView2 addSubview:image12];
    self.imagevx = image12;
    
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
//    UITapGestureRecognizer * tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
    
    
    //将手势添加到需要相应的view中去
    
//    [payView1 addGestureRecognizer:tapGesture1];
    [payView2 addGestureRecognizer:tapGesture];
    
    }

    if (self.zfbTag.integerValue == 0 || self.wxTag.integerValue == 0) {

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.view.frame.size.height - 50 * self.numSingleVesion, self.view.frame.size.width, 50 * self.numSingleVesion);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"去缴费" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(OKBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    }
}

-(void) makeUI61{
    NSArray *arr1;
    NSArray *arr2;
    if (self.model.prompt.length == 0) {
        arr1 = @[@"物业名称",@"车位编号",@"缴费人电话",@"免费天数",@"滞纳金百分比",@"账单起始时间",@"账单结束时间",@"滞纳金",@"支付单号",@"实际缴费",@"缴费时间"];
        arr2 = @[self.model.wyName,self.model.parkingNo,self.model.phone,self.model.freeDays,self.model.breachPercentage,self.model.startDate,self.model.endDate,self.model.breachMoney,self.model.ThirdPaymentID,self.model.real_pay,self.model.payTime];
    }else{
        arr1 = @[@"物业名称",@"车位编号",@"缴费人电话",@"免费天数",@"滞纳金百分比",@"账单起始时间",@"账单结束时间",@"滞纳金",@"支付单号",@"实际缴费",@"缴费时间",@"缴费提示信息",@"缴费提示时间"];
        arr2 = @[self.model.wyName,self.model.parkingNo,self.model.phone,self.model.freeDays,self.model.breachPercentage,self.model.startDate,self.model.endDate,self.model.breachMoney,self.model.ThirdPaymentID,self.model.real_pay,self.model.payTime,self.model.prompt,self.model.promptTime];
    }
    for (NSInteger i = 0; i < arr1.count ; i ++) {
        UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 210 + i * 29 * self.numSingleVesion, 100, 29 * self.numSingleVesion)];
        titLab.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        titLab.text = arr1[i];
        [titLab sizeToFit];
        titLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:titLab];
        UILabel *titLab1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 200 *self.numSingleVesion, 210 + i * 29 * self.numSingleVesion, 192 * self.numSingleVesion, 29 * self.numSingleVesion)];
        titLab1.textAlignment = NSTextAlignmentRight;
        
        titLab1.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        titLab1.text = arr2[i];
        titLab1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [self.view addSubview:titLab1];
        
        
    }
}

-(void) makeUI62{
    NSArray *arr1;
    NSArray *arr2;
    if (self.model.prompt.length == 0) {
        arr1 = @[@"物业名称",@"车位编号",@"缴费人电话",@"免费天数",@"滞纳金百分比",@"账单起始时间",@"账单结束时间",@"滞纳金"];
        arr2 = @[self.model.wyName,self.model.parkingNo,self.model.phone,self.model.freeDays,self.model.breachPercentage,self.model.startDate,self.model.endDate,self.model.breachMoney];
    }else{
        arr1 = @[@"物业名称",@"车位编号",@"缴费人电话",@"免费天数",@"滞纳金百分比",@"账单起始时间",@"账单结束时间",@"滞纳金",@"缴费提示信息",@"缴费提示时间"];
        arr2 = @[self.model.wyName,self.model.parkingNo,self.model.phone,self.model.freeDays,self.model.breachPercentage,self.model.startDate,self.model.endDate,self.model.breachMoney,self.model.prompt,self.model.promptTime];
    }
    for (NSInteger i = 0; i < arr1.count ; i ++) {
        UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(8* self.numSingleVesion, 210* self.numSingleVesion + i * 29 * self.numSingleVesion, 100* self.numSingleVesion, 29 * self.numSingleVesion)];
        titLab.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        titLab.text = arr1[i];
        [titLab sizeToFit];
        //        titLab.center = CGPointMake(8 * self.numSingleVesion,150 * self.numSingleVesion + i * 30*self.numSingleVesion);
        titLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:titLab];
        
        
        UILabel *titLab1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 200* self.numSingleVesion, 210* self.numSingleVesion + i * 29 * self.numSingleVesion, 192 * self.numSingleVesion, 29 * self.numSingleVesion)];
        titLab1.textAlignment = NSTextAlignmentRight;
        
        titLab1.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        titLab1.text = arr2[i];
        //        [titLab1 sizeToFit];
        //        titLab.center = CGPointMake(8 * self.numSingleVesion,150 * self.numSingleVesion + i * 30*self.numSingleVesion);
        titLab1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:titLab1];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8* self.numSingleVesion, 210* self.numSingleVesion + arr1.count * 29 * self.numSingleVesion, self.view.frame.size.width - 16* self.numSingleVesion, 1 * self.numSingleVesion)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    if (self.zfbTag.integerValue == 1 || self.wxTag.integerValue == 1) {
        
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10* self.numSingleVesion, 507 * self.numSingleVesion, 100* self.numSingleVesion, 20* self.numSingleVesion)];
        lab1.font = [UIFont systemFontOfSize:12 * self.numSingleVesion];
        lab1.text = @"选择支付方式";
        lab1.textColor = [UIColor redColor];
        [self.view addSubview:lab1];
    }
    if (self.zfbTag.integerValue == 1) {
        
        UIView *payView1 = [[UIView alloc] initWithFrame:CGRectMake(8* self.numSingleVesion, 522 * self.numSingleVesion, self.view.frame.size.width - 16* self.numSingleVesion, 30 * self.numSingleVesion)];
        payView1.tag = 111111;
        [self.view addSubview:payView1];
        
        
        UILabel *lab11 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8 * self.numSingleVesion, 100* self.numSingleVesion, 30* self.numSingleVesion)];
        lab11.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
        lab11.text = @"支付宝支付";
        [payView1 addSubview:lab11];
        
        UIImageView *image11 = [[UIImageView alloc] initWithFrame:CGRectMake(payView1.frame.size.width - 20 *self.numSingleVesion, 14 * self.numSingleVesion, 18 * self.numSingleVesion, 18 *self.numSingleVesion)];
        //    image11.backgroundColor = [UIColor redColor];
        [image11 setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off.png"]];
        
        [payView1 addSubview:image11];
        self.imageAl = image11;
        
        UITapGestureRecognizer * tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
        [payView1 addGestureRecognizer:tapGesture1];
        
    }
    
    if (self.wxTag.integerValue == 1) {
        
        UIView *payView2 = [[UIView alloc] initWithFrame:CGRectMake(8* self.numSingleVesion, 562 * self.numSingleVesion, self.view.frame.size.width - 16* self.numSingleVesion, 30 * self.numSingleVesion)];
        payView2.tag = 222222;
        [self.view addSubview:payView2];
        
        UILabel *lab12 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8 * self.numSingleVesion, 100* self.numSingleVesion, 30* self.numSingleVesion)];
        lab12.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
        lab12.text = @"微信支付";
        [payView2 addSubview:lab12];
        
        UIImageView *image12 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 16* self.numSingleVesion - 20 *self.numSingleVesion, 14 * self.numSingleVesion, 18 * self.numSingleVesion, 18 *self.numSingleVesion)];
        //    image12.backgroundColor = [UIColor redColor];
        [image12 setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off.png"]];
        [payView2 addSubview:image12];
        self.imagevx = image12;
        
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
        //    UITapGestureRecognizer * tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
        
        
        //将手势添加到需要相应的view中去
        
        //    [payView1 addGestureRecognizer:tapGesture1];
        [payView2 addGestureRecognizer:tapGesture];
        
    }
    
    if (self.zfbTag.integerValue == 0 || self.wxTag.integerValue == 0) {
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, self.view.frame.size.height - 50 * self.numSingleVesion, self.view.frame.size.width, 50 * self.numSingleVesion);
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"去缴费" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(OKBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}








-(void)event:(UITapGestureRecognizer *)sender{
    NSLog(@"%ld",(long)sender.view.tag);
    if (sender.view.tag == 111111) {
        [self.imageAl setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_on.png"]];
        [self.imagevx setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off.png"]];
        self.payType = @"1";
    }else if (sender.view.tag == 222222){
        [self.imagevx setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_on.png"]];
        [self.imageAl setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off.png"]];
        self.payType = @"2";
    
    }
}

-(void)OKBtn:(UIButton *)sender{
    if (self.zfbTag.integerValue == 0 && self.wxTag.integerValue == 0) {
        [self.view makeToast:@"暂无法缴费"];
        return;
    }
    NSLog(@"%ld",self.zfbTag.integerValue);
    if (self.payType.length == 0) {
        [self.view makeToast:@"请选择支付方式"];
    }else{
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        [twoPacking getUrl:[NSString stringWithFormat:GETBUSINESSPAYINFO,self.model.wyid,self.payType] andFinishBlock:^(id getResult) {
            NSLog(@"%@",getResult);
            if (![getResult[@"code"] isEqualToString:@"000000"]) {
                [self.view makeToast:getResult[@"message"]];
                return ;
            }else{
                for (NSDictionary *dic in getResult[@"datas"]) {
                    NSLog(@"%@",dic[@"PID"]);
                
                if (self.tag.integerValue == 5) {
                    NSLog(@"%@--%@",self.model.payMoney,self.model.wyfId);
                    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
                    [twoPacking getUrl:[NSString stringWithFormat:WYFJF,[StoreageMessage getMessage][2],self.model.wyfId] andFinishBlock:^(id getResult) {
                        
                        NSLog(@"%@",getResult);
                        
                        NSString *payStr;
                        if (self.tag.integerValue == 5) {
                            payStr = self.model.paid;
                        }else{
                            payStr = self.model.payMoney;
                        }
                        
                        
                        if ([getResult[@"code"] isEqualToString:@"000000"]) {
                            if ([self.payType isEqualToString:@"2"]) {
//                                [WeChantViewViewController payName:@"快快猫水电燃气费缴纳" andMoney:[NSString stringWithFormat:@"%0.2f",self.model.payMoney.floatValue *100] andOder:[NSString stringWithFormat:@"%@",getResult[@"wyfOrder"]]];
                                [StoreageMessage WeChatfromMchId:dic[@"mch_id"] andPartnerId:dic[@"APP_SECRET"] andOrderID:[NSString stringWithFormat:@"%@",getResult[@"wyfOrder"]] andMoney:[NSString stringWithFormat:@"%0.2f",payStr.floatValue *100] andPayTitle:@"快快猫物业费支付"];
                                //                        [self.navigationController popViewControllerAnimated:YES];
//                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayResultNoti:) name:WX_PAY_RESULT object:nil];
                                
                            }else if ([self.payType isEqualToString:@"1"]){
//                                [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"%@",getResult[@"wyfOrder"]] totalMoney:[NSString stringWithFormat:@"%0.2f",self.model.payMoney.floatValue] payTitle:@"快快猫水电燃气费缴纳"];
                                [StoreageMessage AlipayfromAlipartnerId:dic[@"PID"] andAliSellerID:dic[@"payAccount"] andOrderID:[NSString stringWithFormat:@"%@",getResult[@"wyfOrder"]] andMoney:[NSString stringWithFormat:@"%0.2f",payStr.floatValue] andPayTitle:@"快快猫物业费支付"];
                                //                        [self.navigationController popViewControllerAnimated:YES];
//                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AliPayResultNoti:) name:ALI_PAY_RESULT object:nil];
                            }
                            
                            
                            
                        }else{
                            [self.view makeToast:@"提交信息失败"];
                        }
                    }];
                    
                }else if (self.tag.integerValue == 4){
                    NSLog(@"%@--%@",self.model.payMoney,self.model.qnfId);
                    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
                    [twoPacking getUrl:[NSString stringWithFormat:RQFJF,[StoreageMessage getMessage][2],self.model.qnfId] andFinishBlock:^(id getResult) {
                        
                        NSLog(@"%@",getResult);
                        if ([getResult[@"code"] isEqualToString:@"000000"]) {
                            if ([self.payType isEqualToString:@"2"]) {
//                                [WeChantViewViewController payName:@"快快猫水电燃气费缴纳" andMoney:[NSString stringWithFormat:@"%0.2f",self.model.payMoney.floatValue * 100] andOder:[NSString stringWithFormat:@"%@",getResult[@"qnfOrder"]]];
                                //                        [self.navigationController popViewControllerAnimated:YES];
                                 [StoreageMessage WeChatfromMchId:dic[@"mch_id"] andPartnerId:dic[@"APP_SECRET"] andOrderID:[NSString stringWithFormat:@"%@",getResult[@"qnfOrder"]] andMoney:[NSString stringWithFormat:@"%0.2f",self.model.payMoney.floatValue * 100] andPayTitle:@"快快猫取暖费支付"];
//                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayResultNoti:) name:WX_PAY_RESULT object:nil];
                                
                            }else if ([self.payType isEqualToString:@"1"]){
//                                [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"%@",getResult[@"qnfOrder"]] totalMoney:[NSString stringWithFormat:@"%0.2f",0.01] payTitle:@"快快猫水电燃气费缴纳"];
                                //                        self.model.payMoney.floatValue
                                //                        [self.navigationController popViewControllerAnimated:YES];
//                                NSLog(@"%@--%@",getResult[@"datas"][@"PID"]);
                                [StoreageMessage AlipayfromAlipartnerId:dic[@"PID"] andAliSellerID:dic[@"payAccount"] andOrderID:[NSString stringWithFormat:@"%@",getResult[@"qnfOrder"]]andMoney:[NSString stringWithFormat:@"%0.2f",_model.payMoney.floatValue] andPayTitle:@"快快猫取暖费支付"];
                                NSLog(@"1111111");
                            }
                            
                            
                            
                        }else{
                            [self.view makeToast:@"提交信息失败"];
                        }
                    }];
                    
                    
                    
                }else if (self.tag.integerValue == 6){
                    NSLog(@"%@--%@",self.model.payMoney,self.model.qnfId);
                    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
                    NSString *url = [NSString stringWithFormat:@"http://www.360duang.net/360duang/serviceServlet?serviceName=ParkingService&medthodName=payTCF&memberId=%@&tcfId=%@",[StoreageMessage getMessage][2],self.model.tcfId];
                    NSLog(@"%@",url);
                    [twoPacking getUrl:url andFinishBlock:^(id getResult) {
                        
                        NSLog(@"%@",getResult);
                        if ([getResult[@"code"] isEqualToString:@"000000"]) {
                            if ([self.payType isEqualToString:@"2"]) {
                                //                                [WeChantViewViewController payName:@"快快猫水电燃气费缴纳" andMoney:[NSString stringWithFormat:@"%0.2f",self.model.payMoney.floatValue * 100] andOder:[NSString stringWithFormat:@"%@",getResult[@"qnfOrder"]]];
                                //                        [self.navigationController popViewControllerAnimated:YES];
                                [StoreageMessage WeChatfromMchId:dic[@"mch_id"] andPartnerId:dic[@"APP_SECRET"] andOrderID:[NSString stringWithFormat:@"%@",getResult[@"tcfOrder"]] andMoney:[NSString stringWithFormat:@"%0.2f",self.model.totalMoney.floatValue * 100] andPayTitle:@"快快猫车位管理费支付"];
                                //                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayResultNoti:) name:WX_PAY_RESULT object:nil];
                                
                            }else if ([self.payType isEqualToString:@"1"]){
                                //                                [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"%@",getResult[@"qnfOrder"]] totalMoney:[NSString stringWithFormat:@"%0.2f",0.01] payTitle:@"快快猫水电燃气费缴纳"];
                                //                        self.model.payMoney.floatValue
                                //                        [self.navigationController popViewControllerAnimated:YES];
                                //                                NSLog(@"%@--%@",getResult[@"datas"][@"PID"]);
                                [StoreageMessage AlipayfromAlipartnerId:dic[@"PID"] andAliSellerID:dic[@"payAccount"] andOrderID:[NSString stringWithFormat:@"%@",getResult[@"tcfOrder"]]andMoney:[NSString stringWithFormat:@"%0.2f",_model.totalMoney.floatValue] andPayTitle:@"快快猫车位管理费支付"];
                                NSLog(@"1111111");
                            }
                            
                            
                            
                        }else{
                            [self.view makeToast:@"提交信息失败"];
                        }
                    }];
                    
                    
                    
                }else{
                    
                    
                    
                    
                    NSLog(@"%@",self.model.totalMoney);
                    NSLog(@"%@",[NSString stringWithFormat:PAYHOUSEFEES,[StoreageMessage getMessage][2],self.model.preid]);
                    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
                    [twoPacking getUrl:[NSString stringWithFormat:PAYHOUSEFEES,[StoreageMessage getMessage][2],self.model.preid] andFinishBlock:^(id getResult) {
                        
                        NSLog(@"%@",getResult);
                        if ([getResult[@"code"] isEqualToString:@"000000"]) {
                            if ([self.payType isEqualToString:@"2"]) {
//                                [WeChantViewViewController payName:@"快快猫水电燃气费缴纳" andMoney:[NSString stringWithFormat:@"%0.2f",self.model.totalMoney.floatValue *100] andOder:[NSString stringWithFormat:@"%@",getResult[@"feeOrder"]]];
                                
                                [StoreageMessage WeChatfromMchId:dic[@"mch_id"] andPartnerId:dic[@"APP_SECRET"] andOrderID:[NSString stringWithFormat:@"%@",getResult[@"feeOrder"]] andMoney:[NSString stringWithFormat:@"%0.2f",self.model.totalMoney.floatValue *100] andPayTitle:@"快快猫水电燃气费支付"];
//                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayResultNoti:) name:WX_PAY_RESULT object:nil];
                            }else if ([self.payType isEqualToString:@"1"]){
//                                [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"%@",getResult[@"feeOrder"]] totalMoney:[NSString stringWithFormat:@"%0.2f",self.model.totalMoney.floatValue] payTitle:@"快快猫水电燃气费缴纳"];
                                
                                 [StoreageMessage AlipayfromAlipartnerId:dic[@"PID"] andAliSellerID:dic[@"payAccount"] andOrderID:[NSString stringWithFormat:@"%@",getResult[@"feeOrder"]] andMoney:[NSString stringWithFormat:@"%0.2f",self.model.totalMoney.floatValue] andPayTitle:@"快快猫水电燃气费支付"];
//                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AliPayResultNoti:) name:ALI_PAY_RESULT object:nil];
                            }
                            
                            
                            
                        }else{
                            [self.view makeToast:@"提交信息失败"];
                        }
                    }];
                }
            
            
            
                }
            
            
            }
        }];
        
        
        
//        if (self.tag.integerValue == 5) {
//            NSLog(@"%@--%@",self.model.payMoney,self.model.wyfId);
//            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
//            [twoPacking getUrl:[NSString stringWithFormat:WYFJF,[StoreageMessage getMessage][2],self.model.wyfId] andFinishBlock:^(id getResult) {
//                
//                NSLog(@"%@",getResult);
//                if ([getResult[@"code"] isEqualToString:@"000000"]) {
//                    if ([self.payType isEqualToString:@"2"]) {
//                        [WeChantViewViewController payName:@"快快猫水电燃气费缴纳" andMoney:[NSString stringWithFormat:@"%0.2f",self.model.payMoney.floatValue *100] andOder:[NSString stringWithFormat:@"%@",getResult[@"wyfOrder"]]];
////                        [self.navigationController popViewControllerAnimated:YES];
//                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayResultNoti:) name:WX_PAY_RESULT object:nil];
//                        
//                    }else if ([self.payType isEqualToString:@"1"]){
//                        [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"%@",getResult[@"wyfOrder"]] totalMoney:[NSString stringWithFormat:@"%0.2f",self.model.payMoney.floatValue] payTitle:@"快快猫水电燃气费缴纳"];
////                        [self.navigationController popViewControllerAnimated:YES];
//                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AliPayResultNoti:) name:ALI_PAY_RESULT object:nil];
//                    }
//                    
//                    
//                    
//                }else{
//                    [self.view makeToast:@"提交信息失败"];
//                }
//            }];
//
//        }else if (self.tag.integerValue == 4){
//            NSLog(@"%@--%@",self.model.payMoney,self.model.qnfId);
//            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
//            [twoPacking getUrl:[NSString stringWithFormat:RQFJF,[StoreageMessage getMessage][2],self.model.qnfId] andFinishBlock:^(id getResult) {
//                
//                NSLog(@"%@",getResult);
//                if ([getResult[@"code"] isEqualToString:@"000000"]) {
//                    if ([self.payType isEqualToString:@"2"]) {
//                            [WeChantViewViewController payName:@"快快猫水电燃气费缴纳" andMoney:[NSString stringWithFormat:@"%0.2f",self.model.payMoney.floatValue * 100] andOder:[NSString stringWithFormat:@"%@",getResult[@"qnfOrder"]]];
////                        [self.navigationController popViewControllerAnimated:YES];
//                            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayResultNoti:) name:WX_PAY_RESULT object:nil];
//
//                    }else if ([self.payType isEqualToString:@"1"]){
//                        [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"%@",getResult[@"qnfOrder"]] totalMoney:[NSString stringWithFormat:@"%0.2f",0.01] payTitle:@"快快猫水电燃气费缴纳"];
////                        self.model.payMoney.floatValue
////                        [self.navigationController popViewControllerAnimated:YES];
//                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AliPayResultNoti:) name:ALI_PAY_RESULT object:nil];
//                    }
//                    
//                    
//                    
//                }else{
//                    [self.view makeToast:@"提交信息失败"];
//                }
//            }];
//        
//        
//        
//        }else{
//        
//        
//        
//        
//        NSLog(@"%@",self.model.totalMoney);
//        NSLog(@"%@",[NSString stringWithFormat:PAYHOUSEFEES,[StoreageMessage getMessage][2],self.model.preid]);
//        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
//        [twoPacking getUrl:[NSString stringWithFormat:PAYHOUSEFEES,[StoreageMessage getMessage][2],self.model.preid] andFinishBlock:^(id getResult) {
//            
//            NSLog(@"%@",getResult);
//            if ([getResult[@"code"] isEqualToString:@"000000"]) {
//                if ([self.payType isEqualToString:@"2"]) {
//                        [WeChantViewViewController payName:@"快快猫水电燃气费缴纳" andMoney:[NSString stringWithFormat:@"%0.2f",self.model.totalMoney.floatValue *100] andOder:[NSString stringWithFormat:@"%@",getResult[@"feeOrder"]]];
//                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayResultNoti:) name:WX_PAY_RESULT object:nil];
//                }else if ([self.payType isEqualToString:@"1"]){
//                    [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"%@",getResult[@"feeOrder"]] totalMoney:[NSString stringWithFormat:@"%0.2f",self.model.totalMoney.floatValue] payTitle:@"快快猫水电燃气费缴纳"];
//                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AliPayResultNoti:) name:ALI_PAY_RESULT object:nil];
//                }
//
//                
//                
//            }else{
//                [self.view makeToast:@"提交信息失败"];
//            }
//        }];
//        }
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AliPayResultNoti:) name:@"back" object:nil];
    }
}


//new1
-(void)lastBtnOk:(UIButton *)sender{

    
    
    
    
    
    NSLog(@"%@",self.model.preid);
    if (self.payType.length == 0) {
        [self.view makeToast:@"请选择支付方式"];
    }else{
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        [twoPacking getUrl:[NSString stringWithFormat:GETBUSINESSPAYINFO,self.model.wyid,self.payType] andFinishBlock:^(id getResult) {
            NSLog(@"%@",getResult);
            
        }];
        if (self.tag.integerValue == 5) {
            NSLog(@"%@--%@",self.model.payMoney,self.model.wyfId);
            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
            [twoPacking getUrl:[NSString stringWithFormat:WYFJF,[StoreageMessage getMessage][2],self.model.wyfId] andFinishBlock:^(id getResult) {
                
                NSLog(@"%@",getResult);
                if ([getResult[@"code"] isEqualToString:@"000000"]) {
                    if ([self.payType isEqualToString:@"2"]) {
                        [WeChantViewViewController payName:@"快快猫水电燃气费缴纳" andMoney:[NSString stringWithFormat:@"%0.2f",self.model.payMoney.floatValue *100] andOder:[NSString stringWithFormat:@"%@",getResult[@"wyfOrder"]]];
                        //                        [self.navigationController popViewControllerAnimated:YES];
                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayResultNoti:) name:WX_PAY_RESULT object:nil];
                        
                    }else if ([self.payType isEqualToString:@"1"]){
                        [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"%@",getResult[@"wyfOrder"]] totalMoney:[NSString stringWithFormat:@"%0.2f",self.model.payMoney.floatValue] payTitle:@"快快猫水电燃气费缴纳"];
                        //                        [self.navigationController popViewControllerAnimated:YES];
                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AliPayResultNoti:) name:ALI_PAY_RESULT object:nil];
                    }
                    
                }else{
                    [self.view makeToast:@"提交信息失败"];
                }
            }];
            
        }else if (self.tag.integerValue == 4){
            NSLog(@"%@--%@",self.model.payMoney,self.model.qnfId);
            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
            [twoPacking getUrl:[NSString stringWithFormat:RQFJF,[StoreageMessage getMessage][2],self.model.qnfId] andFinishBlock:^(id getResult) {
                
                NSLog(@"%@",getResult);
                if ([getResult[@"code"] isEqualToString:@"000000"]) {
                    if ([self.payType isEqualToString:@"2"]) {
                        [WeChantViewViewController payName:@"快快猫水电燃气费缴纳" andMoney:[NSString stringWithFormat:@"%0.2f",self.model.payMoney.floatValue * 100] andOder:[NSString stringWithFormat:@"%@",getResult[@"qnfOrder"]]];
                        //                        [self.navigationController popViewControllerAnimated:YES];
//                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayResultNoti:) name:WX_PAY_RESULT object:nil];
                        
                    }else if ([self.payType isEqualToString:@"1"]){
                        [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"%@",getResult[@"qnfOrder"]] totalMoney:[NSString stringWithFormat:@"%0.2f",0.01] payTitle:@"快快猫水电燃气费缴纳"];
                        //                        self.model.payMoney.floatValue
                        //                        [self.navigationController popViewControllerAnimated:YES];
//                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AliPayResultNoti:) name:ALI_PAY_RESULT object:nil];
                    }
                    
                    
                    
                }else{
                    [self.view makeToast:@"提交信息失败"];
                }
            }];
            
            
            
        }else{
            
            
            
            
            NSLog(@"%@",self.model.totalMoney);
            NSLog(@"%@",[NSString stringWithFormat:PAYHOUSEFEES,[StoreageMessage getMessage][2],self.model.preid]);
            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
            [twoPacking getUrl:[NSString stringWithFormat:PAYHOUSEFEES,[StoreageMessage getMessage][2],self.model.preid] andFinishBlock:^(id getResult) {
                
                NSLog(@"%@",getResult);
                if ([getResult[@"code"] isEqualToString:@"000000"]) {
                    if ([self.payType isEqualToString:@"2"]) {
                        [WeChantViewViewController payName:@"快快猫水电燃气费缴纳" andMoney:[NSString stringWithFormat:@"%0.2f",self.model.totalMoney.floatValue *100] andOder:[NSString stringWithFormat:@"%@",getResult[@"feeOrder"]]];
                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayResultNoti:) name:WX_PAY_RESULT object:nil];
                    }else if ([self.payType isEqualToString:@"1"]){
                        [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"%@",getResult[@"feeOrder"]] totalMoney:[NSString stringWithFormat:@"%0.2f",self.model.totalMoney.floatValue] payTitle:@"快快猫水电燃气费缴纳"];
                        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AliPayResultNoti:) name:ALI_PAY_RESULT object:nil];
                    }
                    
                    
                    
                }else{
                    [self.view makeToast:@"提交信息失败"];
                }
            }];
        }
        
    }
}

//微信支付付款成功失败
-(void)weChatPayResultNoti:(NSNotification *)noti{
    NSLog(@"%@",noti);
    [self.navigationController popViewControllerAnimated:YES];

    if ([[noti object] isEqualToString:IS_SUCCESSED]) {
//        [self showMessage:@"支付成功"];
        //在这里填写支付成功之后你要做的事情
        
    }else{
//        [self showMessage:@"支付失败"];
    }
    //上边添加了监听，这里记得移除
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WX_PAY_RESULT object:nil];
}


//支付宝支付成功失败
-(void)AliPayResultNoti:(NSNotification *)noti
{
    [self.navigationController popViewControllerAnimated:YES];

//    NSLog(@"%@",noti);
//    if ([[noti object] isEqualToString:ALIPAY_SUCCESSED]) {
////        [self showMessage:@"支付成功"];
//        //在这里填写支付成功之后你要做的事情
//        
//    }else{
////        [self showMessage:@"支付失败"];
//    }
//    //上边添加了监听，这里记得移除
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALI_PAY_RESULT object:nil];
}

-(void)makeUI41{
    NSArray *arr1 ;
    NSArray *arr2;
    if (self.tag.integerValue == 5) {
        NSLog(@"%@",self.model.resultPropor);

            if (self.model.prompt.length == 0) {
                if (self.model.resultPropor.integerValue != 0) {
                    arr1 = @[@"住户姓名",@"房间信息",@"应缴金额",@"兑换金额",@"点券总数",@"兑换比例",@"兑换上限"];
                    arr2 = @[self.model.userName,self.model.houseInfo,self.model.payMoney,self.model.resultPropor,self.model.coupons,self.model.proportion,self.model.topLimit];
                    
                }else{
                arr1 = @[@"住户姓名",@"房间信息"];
                arr2 = @[self.model.userName,self.model.houseInfo];
                }
            }else {
                if (self.model.resultPropor.integerValue != 0) {
                    arr1 = @[@"住户姓名",@"房间信息",@"应缴金额",@"兑换金额",@"点券总数",@"兑换比例",@"兑换上限"];
                    arr2 = @[self.model.userName,self.model.houseInfo,self.model.payMoney,self.model.resultPropor,self.model.coupons,self.model.proportion,self.model.topLimit];
                    
                }else{
                arr1 = @[@"住户姓名",@"房间信息",@"催缴提示信息",@"催缴提示时间"];
                arr2 = @[self.model.userName,self.model.houseInfo,self.model.prompt,self.model.promptTime];
                }
            }
    }else{

            arr1 = @[@"住户姓名",@"房间信息"];
            arr2 = @[self.model.userName,self.model.houseInfo];
        
    
    }
    NSLog(@"%lu---%lu",(unsigned long)arr1.count,arr2.count);
    for (NSInteger i = 0; i < arr1.count; i ++) {
        UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(8* self.numSingleVesion, 210* self.numSingleVesion + i * 29 * self.numSingleVesion, 100* self.numSingleVesion, 29 * self.numSingleVesion)];
        titLab.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        titLab.text = [NSString stringWithFormat:@"%@", arr1[i]];
        [titLab sizeToFit];
        //        titLab.center = CGPointMake(8 * self.numSingleVesion,150 * self.numSingleVesion + i * 30*self.numSingleVesion);
        titLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:titLab];
        
        
        UILabel *titLab1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 200* self.numSingleVesion, 210 * self.numSingleVesion+ i * 29 * self.numSingleVesion, 192 * self.numSingleVesion, 29 * self.numSingleVesion)];
        titLab1.textAlignment = NSTextAlignmentRight;
        titLab1.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        titLab1.text = [NSString stringWithFormat:@"%@", arr2[i]];
        //        [titLab1 sizeToFit];
        //        titLab.center = CGPointMake(8 * self.numSingleVesion,150 * self.numSingleVesion + i * 30*self.numSingleVesion);
        titLab1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:titLab1];
    }
    
    
    
    UIView *view22 = [[UIView alloc] initWithFrame:CGRectMake(8* self.numSingleVesion, 210 * self.numSingleVesion+ arr1.count * 29 * self.numSingleVesion, self.view.frame.size.width - 16* self.numSingleVesion, 1 * self.numSingleVesion)];
    view22.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view22];
    
    NSLog(@"%@",self.model.payItem);
    if (self.model.payItem.count != 0 && self.tag.integerValue == 5) {
        UILabel *aaaa = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.4 + 5 *self.numSingleVesion,220 * self.numSingleVesion+ arr1.count * 29 * self.numSingleVesion ,self.view.frame.size.width * 2/3 - 20 *self.numSingleVesion, 30 *self.numSingleVesion)];
        aaaa.text = @" 起始时间           结束时间";
        aaaa.font = [UIFont systemFontOfSize:14 *self.numSingleVesion];
        aaaa.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:aaaa];
    for (NSInteger i = 0;  i < self.model.payItem.count; i ++) {
        NSLog(@"%@",self.model.payItem[i]);
        NSLog(@"%@--%@",self.model.payItem[i][@"fee_name"],self.model.payItem[i][@"fee"]);

        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.numSingleVesion ,250 * self.numSingleVesion+ arr1.count * 29 * self.numSingleVesion+ i * 30 *self.numSingleVesion,       self.view.frame.size.width/3, 30 *self.numSingleVesion)];
//        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(140 *self.numSingleVesion + i%2 * 160 *self.numSingleVesion,275 *self.numSingleVesion+ i/2 * 30 *self.numSingleVesion,  100 *self.numSingleVesion, 30 *self.numSingleVesion)];
            lab1.text = [NSString stringWithFormat:@"%@:%@",self.model.payItem[i][@"fee_name"],self.model.payItem[i][@"fee"]];
      
//        lab2.text = [NSString stringWithFormat:@"%@",self.model.payItem[i][@"fee"]];
        lab1.font = [UIFont systemFontOfSize:13  *self.numSingleVesion];
        lab1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:lab1];
        
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.4,250 * self.numSingleVesion+ arr1.count * 29 * self.numSingleVesion+ i * 30 *self.numSingleVesion,       self.view.frame.size.width * 2/3 - 20 *self.numSingleVesion, 30 *self.numSingleVesion)];
        //        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(140 *self.numSingleVesion + i%2 * 160 *self.numSingleVesion,275 *self.numSingleVesion+ i/2 * 30 *self.numSingleVesion,  100 *self.numSingleVesion, 30 *self.numSingleVesion)];
        if ([self.model.payItem[i][@"endDate"] length] == 0) {
            lab2.text = @"";
        }else{
            lab2.text = [NSString stringWithFormat:@"%@       %@",self.model.payItem[i][@"startDate"],self.model.payItem[i][@"endDate"]];
        }
        //        lab2.text = [NSString stringWithFormat:@"%@",self.model.payItem[i][@"fee"]];
        lab2.font = [UIFont systemFontOfSize:14 *self.numSingleVesion];
        lab2.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        
        
//        lab2.font = [UIFont systemFontOfSize:14 *self.numSingleVesion];
//        lab2.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:lab2];
//        [self.view addSubview:lab2];
        
        
    }
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8* self.numSingleVesion,self.model.payItem.count * self.numSingleVesion * 30 +250 * self.numSingleVesion+ arr1.count * 29 * self.numSingleVesion, self.view.frame.size.width - 16* self.numSingleVesion, 1 * self.numSingleVesion)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
        
    }
    
    if (self.zfbTag.integerValue == 1 || self.wxTag.integerValue == 1) {

    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion,self.model.payItem.count * self.numSingleVesion * 30 + 260 * self.numSingleVesion+ arr1.count * 29 * self.numSingleVesion, 100 * self.numSingleVesion, 20* self.numSingleVesion)];
    lab1.font = [UIFont systemFontOfSize:12 * self.numSingleVesion];
    lab1.text = @"选择支付方式";
    lab1.textColor = [UIColor redColor];
    [self.view addSubview:lab1];
        
    }
    if (self.zfbTag.integerValue == 1) {

    UIView *payView1 = [[UIView alloc] initWithFrame:CGRectMake(8* self.numSingleVesion,self.model.payItem.count * self.numSingleVesion * 30 + 280 * self.numSingleVesion+ arr1.count * 29 * self.numSingleVesion, self.view.frame.size.width - 16 *self.numSingleVesion, 30 * self.numSingleVesion)];
    payView1.tag = 111111;
    [self.view addSubview:payView1];
        
    
    UILabel *lab11 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8 * self.numSingleVesion, 100* self.numSingleVesion, 30* self.numSingleVesion)];
    lab11.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    lab11.text = @"支付宝支付";
    [payView1 addSubview:lab11];
    
    UIImageView *image11 = [[UIImageView alloc] initWithFrame:CGRectMake(payView1.frame.size.width - 20 *self.numSingleVesion, 14 * self.numSingleVesion, 18 * self.numSingleVesion, 18 *self.numSingleVesion)];
    //    image11.backgroundColor = [UIColor redColor];
    [image11 setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off.png"]];
    
    [payView1 addSubview:image11];
    self.imageAl = image11;
        
        UITapGestureRecognizer * tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];

        [payView1 addGestureRecognizer:tapGesture1];

    }
    if (self.wxTag.integerValue == 1) {
        
    UIView *payView2 = [[UIView alloc] initWithFrame:CGRectMake(8,self.model.payItem.count * self.numSingleVesion * 30 + 310 * self.numSingleVesion+ arr1.count * 29 * self.numSingleVesion, self.view.frame.size.width - 16* self.numSingleVesion, 30 * self.numSingleVesion)];
    payView2.tag = 222222;
    [self.view addSubview:payView2];
    
    UILabel *lab12 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8 * self.numSingleVesion, 100* self.numSingleVesion, 30* self.numSingleVesion)];
    lab12.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    lab12.text = @"微信支付";
    [payView2 addSubview:lab12];
    
    UIImageView *image12 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 16 *self.numSingleVesion - 20 *self.numSingleVesion, 14 * self.numSingleVesion, 18 * self.numSingleVesion, 18 *self.numSingleVesion)];
    //    image12.backgroundColor = [UIColor redColor];
    [image12 setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off.png"]];
    [payView2 addSubview:image12];
    self.imagevx = image12;
    
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
    
    
    //将手势添加到需要相应的view中去
    
//    [payView1 addGestureRecognizer:tapGesture1];
    [payView2 addGestureRecognizer:tapGesture];
    
    }

    
    if (self.zfbTag.integerValue == 0 || self.wxTag.integerValue == 0) {

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, self.view.frame.size.height - 50 * self.numSingleVesion, self.view.frame.size.width, 50 * self.numSingleVesion);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"去缴费" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(OKBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    }
}




-(void)makeUI42{
    NSArray *arr1 = @[@"住户姓名",@"房间信息",@"缴费时间",@"缴费人手机号"];
    NSArray *arr2 = @[self.model.userName,self.model.houseInfo,self.model.payTime,self.model.phone];
    for (NSInteger i = 0; i < 4 ; i ++) {
        UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(8* self.numSingleVesion, 210* self.numSingleVesion + i * 29 * self.numSingleVesion, 100* self.numSingleVesion, 29 * self.numSingleVesion)];
        titLab.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        titLab.text = arr1[i];
        [titLab sizeToFit];
        titLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:titLab];
        UILabel *titLab1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 200* self.numSingleVesion, 210* self.numSingleVesion + i * 29 * self.numSingleVesion, 192 * self.numSingleVesion, 29 * self.numSingleVesion)];
        titLab1.textAlignment = NSTextAlignmentRight;
        
        titLab1.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        titLab1.text = arr2[i];
        titLab1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [self.view addSubview:titLab1];
        
        
    }
    UIView *view22 = [[UIView alloc] initWithFrame:CGRectMake(8* self.numSingleVesion,335 *self.numSingleVesion, self.view.frame.size.width - 16* self.numSingleVesion, 1 * self.numSingleVesion)];
    view22.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view22];
    
    NSLog(@"%@",self.model.payItem);
    if (self.model.payItem.count != 0 && self.tag.integerValue == 5) {
        UILabel *aaaa = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.4 + 5 *self.numSingleVesion,335 *self.numSingleVesion ,self.view.frame.size.width * 2/3 - 20 *self.numSingleVesion, 30 *self.numSingleVesion)];
        aaaa.text = @" 起始时间           结束时间";
        aaaa.font = [UIFont systemFontOfSize:14 *self.numSingleVesion];
        aaaa.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        [self.view addSubview:aaaa];
        for (NSInteger i = 0;  i < self.model.payItem.count; i ++) {
            NSLog(@"%@",self.model.payItem[i]);
            NSLog(@"%@--%@",self.model.payItem[i][@"fee_name"],self.model.payItem[i][@"fee"]);
            
            UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.numSingleVesion ,365 *self.numSingleVesion+ i * 30 *self.numSingleVesion,       self.view.frame.size.width/3 , 30 *self.numSingleVesion)];
            //        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(140 *self.numSingleVesion + i%2 * 160 *self.numSingleVesion,275 *self.numSingleVesion+ i/2 * 30 *self.numSingleVesion,  100 *self.numSingleVesion, 30 *self.numSingleVesion)];
            lab1.text = [NSString stringWithFormat:@"%@:%@",self.model.payItem[i][@"fee_name"],self.model.payItem[i][@"fee"]];
            
            //        lab2.text = [NSString stringWithFormat:@"%@",self.model.payItem[i][@"fee"]];
            lab1.font = [UIFont systemFontOfSize:13 *self.numSingleVesion];
            lab1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [self.view addSubview:lab1];
            
            UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.4,365 *self.numSingleVesion+ i * 30 *self.numSingleVesion,       self.view.frame.size.width * 2/3 - 20 *self.numSingleVesion, 30 *self.numSingleVesion)];
            //        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(140 *self.numSingleVesion + i%2 * 160 *self.numSingleVesion,275 *self.numSingleVesion+ i/2 * 30 *self.numSingleVesion,  100 *self.numSingleVesion, 30 *self.numSingleVesion)];
            if ([self.model.payItem[i][@"endDate"] length] == 0) {
                lab2.text = @"";
            }else{
                lab2.text = [NSString stringWithFormat:@"%@       %@",self.model.payItem[i][@"startDate"],self.model.payItem[i][@"endDate"]];
            }
            //        lab2.text = [NSString stringWithFormat:@"%@",self.model.payItem[i][@"fee"]];
            lab2.font = [UIFont systemFontOfSize:14 *self.numSingleVesion];
            lab2.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            
            
            //        lab2.font = [UIFont systemFontOfSize:14 *self.numSingleVesion];
            //        lab2.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [self.view addSubview:lab2];
            //        [self.view addSubview:lab2];
            
            
        }
        
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(8* self.numSingleVesion,self.model.payItem.count * self.numSingleVesion * 30 +365 *self.numSingleVesion, self.view.frame.size.width - 16* self.numSingleVesion, 1 * self.numSingleVesion)];
        view.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:view];
        
    }

    
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
