//
//  OrderStatusView.m
//  360du
//
//  Created by linghang on 16/1/3.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "OrderStatusView.h"
#import "OrderStatusModel.h"
#import "OrderDeatilViewController.h"
@interface OrderStatusView()
@property(nonatomic,assign)CGFloat hegiht;
@end
@implementation OrderStatusView
- (id)initWithFrame:(CGRect)frame andArr:(NSArray *)dataArr andStatue:(NSString *)statue andOrderId:(NSString *)orderId{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SMSColor(246, 246, 246);
        [self makeOrderId:orderId];
        [self makeScrollView:dataArr];
        if ([statue isEqual:@"交易完成"] || [statue isEqual:@"未确认"]) {
            [self makeBottom:statue];

        }
    }
    return self;
}
- (void)makeOrderId:(NSString *)orderId{
    self.hegiht += 60 * self.numSingleVesion;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 0, WIDTH_VIEW, 60 * self.numSingleVesion)];
    lable.backgroundColor = SMSColor(246, 246, 246);
    [self addSubview:lable];
    lable.textColor = SMSColor(151, 151, 151);
    lable.font = [UIFont systemFontOfSize:14];
    lable.text = orderId;
    
}
- (void)makeScrollView:(NSArray *)dataArr{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.hegiht, WIDTH_VIEW, self.frame.size.height - self.hegiht - 60 * self.numSingleVesion)];
    if (dataArr.count * 140 * self.numSingleVesion > self.frame.size.width - self.hegiht - 60 * self.numSingleVesion) {
        scrollView.contentSize = CGSizeMake(WIDTH_VIEW, dataArr.count * 140 * self.numSingleVesion);

    }else{
        scrollView.contentSize = CGSizeMake(WIDTH_VIEW, self.frame.size.width - self.hegiht - 60 * self.numSingleVesion);

    }
//    scrollView.contentSize = CGSizeMake(WIDTH_VIEW, self.frame.size.height - self.hegiht - 60 * self.numSingleVesion);

    [self addSubview:scrollView];
    scrollView.showsVerticalScrollIndicator = NO;
//                person_buying.png
    CGFloat everHeight = 140 * self.numSingleVesion;
    for (NSInteger i = 0; i < dataArr.count; i++) {
        OrderStatusModel *model = dataArr[i];
        UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(20 * self.numSingleVesion, 10 * self.numSingleVesion + everHeight * i, 50 * self.numSingleVesion, 50 * self.numSingleVesion)];
        leftImg.image = [UIImage imageNamed:@"person_buying"];
        [scrollView addSubview:leftImg];
        UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(80 * self.numSingleVesion, 10 * self.numSingleVesion + everHeight * i, WIDTH_VIEW - 100 * self.numSingleVesion, 60 * self.numSingleVesion)];
        rightImg.image = [UIImage imageNamed:@"course_serach@3x"];
        [scrollView addSubview:rightImg];
        //31,31,31，名称
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 10 * self.numSingleVesion, WIDTH_VIEW - 20 * self.numSingleVesion, 15 * self.numSingleVesion)];
        nameLab.textColor = SMSColor(31, 31, 31);
        [rightImg addSubview:nameLab];
        nameLab.text = model.title;
        nameLab.font = [UIFont systemFontOfSize:16];
        [nameLab sizeToFit];
        nameLab.frame = CGRectMake(10 * self.numSingleVesion, 10 * self.numSingleVesion,nameLab.frame.size.width, 15 * self.numSingleVesion);
        //203,203,203，时间
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 10 * self.numSingleVesion, WIDTH_VIEW - 20 * self.numSingleVesion, 15 * self.numSingleVesion)];
        timeLab.textColor = SMSColor(203, 203, 203);
        [rightImg addSubview:timeLab];
        timeLab.text = model.infoTime;
        timeLab.font = [UIFont systemFontOfSize:14];
        [timeLab sizeToFit];
        timeLab.frame = CGRectMake(rightImg.frame.size.width -  timeLab.frame.size.width - 10 * self.numSingleVesion, 13 * self.numSingleVesion,timeLab.frame.size.width, 15 * self.numSingleVesion);
        //详细介绍
        UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 10 * self.numSingleVesion, WIDTH_VIEW - 20 * self.numSingleVesion, 15 * self.numSingleVesion)];
        contentLab.textColor = SMSColor(203, 203, 203);
        [rightImg addSubview:contentLab];
        contentLab.text = model.Content;
        contentLab.font = [UIFont systemFontOfSize:14];
        [contentLab sizeToFit];
        contentLab.frame = CGRectMake(10 * self.numSingleVesion, 40 * self.numSingleVesion,contentLab.frame.size.width, 15 * self.numSingleVesion);
        
        if (i != dataArr.count - 1) {
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(45 * self.numSingleVesion, 60 * self.numSingleVesion + everHeight * i, 1 * self.numSingleVesion, 50 * self.numSingleVesion + 40 * self.numSingleVesion)];
            line.backgroundColor = [UIColor redColor];
            [scrollView addSubview:line];
        }
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0 * self.numSingleVesion, 79 * self.numSingleVesion + everHeight * i, WIDTH_VIEW, 1 * self.numSingleVesion)];
        line1.backgroundColor = SMSColor(203, 203, 203);
        [scrollView addSubview:line1];

    }
}
- (void)makeBottom:(NSString *)statue{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 60 * self.numSingleVesion, WIDTH_VIEW, 60 * self.numSingleVesion)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    UIImageView *timImg = [[UIImageView alloc] initWithFrame:CGRectMake(20 * self.numSingleVesion, 15 * self.numSingleVesion, 30 * self.numSingleVesion, 30 * self.numSingleVesion)];
    timImg.image = [UIImage imageNamed:@"clock_icon"];
    [bottomView addSubview:timImg];
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(60 * self.numSingleVesion, 5 * self.numSingleVesion, 1 * self.numSingleVesion,  50 * self.numSingleVesion)];
    line1.backgroundColor = SMSColor(203, 203, 203);
    [bottomView addSubview:line1];
    //0,未确认，立即支付，取消订单，1取消订单，啥也没有，2交易完成，去评价
    if ([statue isEqualToString:@"未确认"]) {
        NSArray *tempArr = @[@"立即支付",@"取消订单"];
        for (NSInteger i = 0; i < 2; i++) {
            UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            bottomBtn.frame = CGRectMake(80 * self.numSingleVesion + (WIDTH_VIEW - 100 * self.numSingleVesion - 0 * self.numSingleVesion) / 2 * i, 15 * self.numSingleVesion, (WIDTH_VIEW - 100 * self.numSingleVesion - 20 * self.numSingleVesion) / 2, 30 * self.numSingleVesion);
            bottomBtn.backgroundColor = [UIColor redColor];
            [bottomView addSubview:bottomBtn];
            [bottomBtn setTitle:tempArr[i] forState:UIControlStateNormal];
            bottomBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            bottomBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            bottomBtn.tag = 1700 + i;
            [bottomBtn addTarget:self action:@selector(bottomBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else if ([statue isEqualToString:@"取消订单"]){
        
    }else if([statue isEqualToString:@"交易完成"]){
       // UIButton
        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomBtn.frame = CGRectMake(80 * self.numSingleVesion, 15 * self.numSingleVesion, WIDTH_VIEW - 100 * self.numSingleVesion, 30 * self.numSingleVesion);
        bottomBtn.backgroundColor = [UIColor redColor];
        [bottomView addSubview:bottomBtn];
        [bottomBtn setTitle:@"去评价" forState:UIControlStateNormal];
        bottomBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bottomBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        bottomBtn.tag = 1700 + 10 * 2;
        [bottomBtn addTarget:self action:@selector(bottomBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)bottomBtnDown:(UIButton *)bottomBtn{
    if ([self.target isKindOfClass:[OrderDeatilViewController class]]) {
        if (bottomBtn.tag == 1720) {
            [self.target returnOrderStatueView:@"去评价"];

        }else if (bottomBtn.tag == 1700){
            [self.target returnOrderStatueView:@"立即支付"];

        }else if (bottomBtn.tag == 1701){
            [self.target returnOrderStatueView:@"取消订单"];

        }
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
