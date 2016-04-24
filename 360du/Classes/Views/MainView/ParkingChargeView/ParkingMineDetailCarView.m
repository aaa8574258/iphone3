//
//  ParkingMineDetailCarView.m
//  
//
//  Created by linghang on 16/1/8.
//
//

#import "ParkingMineDetailCarView.h"
#import "ParkingQueryModel.h"
#import "ParkingMineDetailViewController.h"
//#import "AlipayViewController.h"
@interface ParkingMineDetailCarView()
@property(nonatomic,assign)NSInteger month;//选择几个月
@property(nonatomic,assign)NSInteger payType;//付款方式，0，为支付宝，1，为微信
@property(nonatomic,assign)CGFloat tempHeight;//月份高度
@property(nonatomic,assign)NSInteger everMothMoney;//每月钱数
@property(nonatomic,assign)CGFloat moneyHeight;//钱的高度
@property(nonatomic,strong)ParkingQueryModel *model;
@end
@implementation ParkingMineDetailCarView
- (id)initWithFrame:(CGRect)frame andModel:(ParkingQueryModel *)model{
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        self.everMothMoney = model.unitprice.integerValue;
        self.month = 1;
        self.payType = 0;
        self.backgroundColor = SMSColor(246, 246, 246);
        [self createView:model];
        [self crateBottomBtn];
    }
    return self;
}
- (void)createView:(ParkingQueryModel *)model{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW, self.frame.size.height - 49 * self.numSingleVesion)];
    [self addSubview:scrollView];
    scrollView.backgroundColor = SMSColor(246, 246, 246);
    scrollView.showsVerticalScrollIndicator = NO;
    CGFloat height = 10 * self.numSingleVesion;
    CGFloat width = 10 * self.numSingleVesion;
    UIFont *font = [UIFont systemFontOfSize:16];
    
    //车牌号124
    UILabel *carNumber = [[UILabel alloc] initWithFrame:CGRectMake(width, height, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
    carNumber.text = @"车牌号";
    carNumber.font = font;
    carNumber.textColor = SMSColor(124, 124, 124);
    [scrollView addSubview:carNumber];
    height += 30 * self.numSingleVesion;
    CGFloat carImgLabWidth = 140 * self.numSingleVesion;
    CGFloat carImgLabHeight = 60 * self.numSingleVesion;
    //车牌照片
    UILabel *carImgLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, carImgLabWidth, carImgLabHeight)];
    carImgLab.font = [UIFont systemFontOfSize:24];
    carImgLab.textColor = [UIColor whiteColor];
    carImgLab.backgroundColor = SMSColor(11, 82, 168);
    [scrollView addSubview:carImgLab];
    carImgLab.text = model.c_Pai;
    carImgLab.layer.borderColor = [SMSColor(157, 188, 219) CGColor];
    carImgLab.layer.borderWidth = 1 * self.numSingleVesion;
    carImgLab.textAlignment = NSTextAlignmentCenter;
    carImgLab.center = CGPointMake(WIDTH_VIEW / 2, height + 30 * self.numSingleVesion);
    height += carImgLabHeight +  20 * self.numSingleVesion;
    //横线
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, height - 1 * self.numSingleVesion, WIDTH_VIEW, 1 * self.numSingleVesion)];
    line1.backgroundColor = SMSColor(211, 211, 211);
    [scrollView addSubview:line1];
    
    height += 10 * self.numSingleVesion;
    //租期
    UILabel *rentCar = [[UILabel alloc] initWithFrame:CGRectMake(width, height, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
    rentCar.text = @"租期";
    rentCar.font = font;
    rentCar.textColor = SMSColor(124, 124, 124);
    [scrollView addSubview:rentCar];
    
    //车位过期日期
    UILabel *rentOutDateCar = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_VIEW  / 2 - carImgLabWidth / 2, height + 5 * self.numSingleVesion, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
    rentOutDateCar.text = @"车位过期日期:";
    rentOutDateCar.font = [UIFont systemFontOfSize:12];
    rentOutDateCar.textColor = SMSColor(51, 51, 51);
    [rentOutDateCar sizeToFit];
    rentOutDateCar.frame = CGRectMake( WIDTH_VIEW  / 2 - carImgLabWidth / 2, height + 5 * self.numSingleVesion, rentOutDateCar.frame.size.width, 15 * self.numSingleVesion);
    [scrollView addSubview:rentOutDateCar];
    //有内容
    NSMutableString *tempStr = [model.cb_EndDate mutableCopy];
    NSArray *tempArr = [tempStr componentsSeparatedByString:@" "];
    UILabel *rentContentOutDateCar = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_VIEW  / 2 - carImgLabWidth / 2 + rentOutDateCar.frame.size.width + 10 * self.numSingleVesion, height + 0 * self.numSingleVesion, 100 * self.numSingleVesion, 70 * self.numSingleVesion)];
    rentContentOutDateCar.text = [NSString stringWithFormat:@"%@\n%@",tempArr[0],tempArr[1]];
    rentContentOutDateCar.font = [UIFont systemFontOfSize:14];
    rentContentOutDateCar.numberOfLines = 2;
    rentContentOutDateCar.textColor = [UIColor redColor];
    [scrollView addSubview:rentContentOutDateCar];
    rentContentOutDateCar.frame = CGRectMake(WIDTH_VIEW  / 2 - carImgLabWidth / 2 + rentOutDateCar.frame.size.width + 10 * self.numSingleVesion, height -25 * self.numSingleVesion, 100 * self.numSingleVesion, 70 * self.numSingleVesion);
    height += 50 * self.numSingleVesion;
    //加、减
    NSArray *imgArr = @[@"减.png",@"加.png"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake( WIDTH_VIEW  / 2 - carImgLabWidth  / 2+  (carImgLabWidth - 40 * self.numSingleVesion) * i,height, 40 * self.numSingleVesion, 40 * self.numSingleVesion);
        [addBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [scrollView addSubview:addBtn];
        [addBtn addTarget:self action:@selector(removeBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        addBtn.tag = 1200 + i ;
        addBtn.layer.cornerRadius = 20 * self.numSingleVesion;
        addBtn.layer.borderWidth = 1 * self.numSingleVesion;
        addBtn.layer.borderColor = [SMSColor(241, 241, 241) CGColor];
    }
//几个月
    UILabel *monthLab = [[UILabel alloc] initWithFrame:CGRectZero];
    monthLab.text = @"1  月";
    monthLab.textColor = SMSColor(51, 51, 51);
    monthLab.font = [UIFont systemFontOfSize:18];
    [monthLab sizeToFit];
    monthLab.center = CGPointMake(WIDTH_VIEW / 2, height + 20 * self.numSingleVesion);
    [scrollView addSubview:monthLab];
    monthLab.tag = 2200;
    self.tempHeight = height;
    //横线
    height += 60 * self.numSingleVesion;
    //横线
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, height - 1 * self.numSingleVesion, WIDTH_VIEW, 1 * self.numSingleVesion)];
    line2.backgroundColor = SMSColor(211, 211, 211);
    [scrollView addSubview:line2];
    height += 40 * self.numSingleVesion;
    //停车位置
    UILabel *locationCar = [[UILabel alloc] initWithFrame:CGRectMake(width, height, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
    locationCar.text = @"停车位置";
    locationCar.font = font;
    locationCar.textColor = SMSColor(124, 124, 124);
    [scrollView addSubview:locationCar];
    [locationCar sizeToFit];
    locationCar.center = CGPointMake(width + locationCar.frame.size.width / 2, height - 20 * self.numSingleVesion);
    //具体地址
    UILabel *detailLocationCar = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_VIEW / 2 , height, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
    detailLocationCar.text = model.pa_Name;
    detailLocationCar.font = font;
    detailLocationCar.textColor = SMSColor(51, 51, 51);
    [scrollView addSubview:detailLocationCar];
    [detailLocationCar sizeToFit];
    detailLocationCar.center = CGPointMake(WIDTH_VIEW - 100 * self.numSingleVesion, height - 20 * self.numSingleVesion);
    //横线
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, height - 1 * self.numSingleVesion, WIDTH_VIEW, 1 * self.numSingleVesion)];
    line3.backgroundColor = SMSColor(211, 211, 211);
    [scrollView addSubview:line3];
    height += 30 * self.numSingleVesion;
    //请选择支付方式
    UILabel *payLab = [[UILabel alloc] initWithFrame:CGRectMake(width, height, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
    payLab.text = @"请选择支付方式";
    payLab.font = font;
    payLab.textColor = SMSColor(124, 124, 124);
    [scrollView addSubview:payLab];
    [payLab sizeToFit];
    payLab.center = CGPointMake(width + payLab.frame.size.width / 2, height - 20 * self.numSingleVesion);
    //支付方式
    UIView *payView = [[UIView alloc] initWithFrame:CGRectMake(0, height, WIDTH_VIEW, 80 * self.numSingleVesion)];
    [scrollView addSubview:payView];
    payView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"支付宝支付",@"微信支付"];
    NSArray *detailArr = @[@"网上支付,快捷方便",@"微信扫一扫,快捷又方便"];
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(width, 5 * self.numSingleVesion + 40 * self.numSingleVesion * i, 100 * self.numSingleVesion, 15 * self.numSingleVesion)];
        titleLab.text = titleArr[i];
        titleLab.font = font;
        titleLab.textColor = SMSColor(51, 51, 51);
        [payView addSubview:titleLab];
        
        UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(width, 22 * self.numSingleVesion + 40 * self.numSingleVesion * i, 200 * self.numSingleVesion, 15 * self.numSingleVesion)];
        detailLab.text = detailArr[i];
        detailLab.font = [UIFont systemFontOfSize:12];
        detailLab.textColor = [UIColor redColor];
        [payView addSubview:detailLab];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(WIDTH_VIEW - 40 * self.numSingleVesion, 5 * self.numSingleVesion, 25 * self.numSingleVesion, 25 * self.numSingleVesion);
        rightBtn.center = CGPointMake(WIDTH_VIEW - 15 * self.numSingleVesion - 12.5 * self.numSingleVesion, 20 * self.numSingleVesion + 40 * self.numSingleVesion * i);
        [rightBtn addTarget:self action:@selector(removeBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [payView addSubview:rightBtn];
        rightBtn.tag = 1300 + i ;
        [rightBtn setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
        if(i == 0){
            [rightBtn setImage:[UIImage imageNamed:@"确认"] forState:UIControlStateNormal];
        }
        UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 39 * self.numSingleVesion + 40 * self.numSingleVesion * i, WIDTH_VIEW, 1 * self.numSingleVesion)];
        line4.backgroundColor = SMSColor(211, 211, 211);
        [self addSubview:line3];


    }
    height += 80 * self.numSingleVesion;
    
    //应付停车费
    height += 10 * self.numSingleVesion;
    UILabel *carPay = [[UILabel alloc] initWithFrame:CGRectMake(width, height, 200 * self.numSingleVesion, 15 * self.numSingleVesion)];
    carPay.text = @"租期";
    carPay.font = font;
    carPay.textColor = SMSColor(51, 51, 51);
    [self addSubview:carPay];
    //付钱数目
    height += 50 * self.numSingleVesion;
    UILabel *payMoney = [[UILabel alloc] initWithFrame:CGRectMake(width, height, 200 * self.numSingleVesion, 15 * self.numSingleVesion)];
    payMoney.text = [NSString stringWithFormat:@"%ld元",model.unitprice.integerValue];
    payMoney.font = font;
    payMoney.textColor = [UIColor redColor];
    [scrollView addSubview:payMoney];
    payMoney.tag = 2400;
    [payMoney sizeToFit];
    self.moneyHeight = height;
    payMoney.center = CGPointMake(WIDTH_VIEW / 2, height + 7.5 * self.numSingleVesion);
    //横线
    height += 40 * self.numSingleVesion;
    UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(0, height - 1 * self.numSingleVesion, WIDTH_VIEW, 1 * self.numSingleVesion)];
    line5.backgroundColor = SMSColor(211, 211, 211);
    [scrollView addSubview:line5];
    
   scrollView.contentSize = CGSizeMake(0, height);

}
- (void)removeBtnDown:(UIButton *)removeBtn{
    if(removeBtn.tag < 1220){
        UILabel *countLab = (UILabel *)[self viewWithTag:2200];
        if (removeBtn.tag == 1200) {
            if ([countLab.text isEqual:@"1  月"]) {
                
            }else{
                self.month --;
                countLab.text = [NSString stringWithFormat:@"%ld  月",self.month];
            }
        }else{
            self.month ++;
            countLab.text = [NSString stringWithFormat:@"%ld  月",self.month];
        }
        [countLab sizeToFit];
        countLab.center = CGPointMake(WIDTH_VIEW / 2, self.tempHeight + 20 * self.numSingleVesion);
        //下边钱数跟着边
         UILabel *moneyLab = (UILabel *)[self viewWithTag:2400];
        moneyLab.text = [NSString stringWithFormat:@"%ld元",(self.month * self.everMothMoney)];
        [moneyLab sizeToFit];
        moneyLab.center = CGPointMake(WIDTH_VIEW / 2, self.moneyHeight + 7.5 * self.numSingleVesion);
        
    }else if(removeBtn.tag < 1400){
        for (NSInteger i = 0; i < 2; i++) {
            UIButton *tempBtn = (UIButton *)[self viewWithTag:1300 + i];
            [tempBtn setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
        }
        if (removeBtn.tag == 1400) {
            self.payType = 0;
        }else{
            self.payType = 1;
        }
        [removeBtn setImage:[UIImage imageNamed:@"确认"] forState:UIControlStateNormal];
    }
}
- (void)crateBottomBtn{
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(10 * self.numSingleVesion, self.frame.size.height - 49 * self.numSingleVesion, WIDTH_VIEW - 20 * self.numSingleVesion, 49 * self.numSingleVesion);
    [bottomBtn setTitle:@"确认" forState:UIControlStateNormal];
    [bottomBtn setBackgroundColor:[UIColor redColor]];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(bottomBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bottomBtn];
    bottomBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)bottomBtnDown{
    if([self.target isKindOfClass:[ParkingMineDetailViewController class]]){
        [self.target getPayMoneyTime:self.month andPayTimeType:@"month" andOrderId:self.model.id andCarName:self.model.c_Pai andCarAddress:self.model.pa_Name andPayMoney:[NSString stringWithFormat:@"%ld",self.month * self.model.unitprice.integerValue] andPayType:self.payType];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
