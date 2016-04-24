//
//  OrderDeatilView.m
//  360du
//
//  Created by linghang on 16/1/3.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "OrderDeatilView.h"
#import "OrderDeatilViewController.h"
#import "OrderDeatilModel.h"
@interface OrderDeatilView()<UIGestureRecognizerDelegate>
@property(nonatomic,assign)CGFloat hegiht;
@end

@implementation OrderDeatilView
- (id)initWithFrame:(CGRect)frame andShopName:(NSString *)shopName andPersonal:(NSString *)personal andDeatilArr:(NSArray *)dataArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SMSColor(246, 246, 246);
        [self createShopName:shopName];
        [self createScrollView:dataArr andPersonal:personal andShopName:shopName];
        [self createBottomBtn];
        
    }
    return self;
}

//创建店铺
- (void)createShopName:(NSString *)shopName{
    self.hegiht += 60 * self.numSingleVesion;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 0, WIDTH_VIEW, 60 * self.numSingleVesion)];
    lable.backgroundColor = SMSColor(246, 246, 246);
    [self addSubview:lable];
    lable.textColor = SMSColor(151, 151, 151);
    lable.font = [UIFont systemFontOfSize:14];
    lable.text = shopName;
}
//创建scrollview
- (void)createScrollView:(NSArray *)deatilArr andPersonal:(NSString *)personal andShopName:(NSString *)shopName{
    NSArray *orderArr = deatilArr[1];
    OrderDeatilModel *detailModel = deatilArr[0];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.hegiht, WIDTH_VIEW, self.frame.size.height - self.hegiht - 60 * self.numSingleVesion)];
    if (orderArr.count * 40 * self.numSingleVesion + 100 * self.numSingleVesion > self.frame.size.width - self.hegiht - 60 * self.numSingleVesion) {
        scrollView.contentSize = CGSizeMake(WIDTH_VIEW, orderArr.count * 140 * self.numSingleVesion);
        
    }else{
        scrollView.contentSize = CGSizeMake(WIDTH_VIEW, self.frame.size.width - self.hegiht - 60 * self.numSingleVesion);
        
    }
    //    scrollView.contentSize = CGSizeMake(WIDTH_VIEW, self.frame.size.height - self.hegiht - 60 * self.numSingleVesion);
    
    [self addSubview:scrollView];
    scrollView.showsVerticalScrollIndicator = NO;

    CGFloat height = 35 * self.numSingleVesion;
    CGFloat width = 10 * self.numSingleVesion;

    //先创建订单
    for (NSInteger i = 0; i < orderArr.count + 1; i++) {
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLab.font = [UIFont systemFontOfSize:14];
        [scrollView addSubview:nameLab];
        
        nameLab.textColor = SMSColor(94, 94, 94);
        //价格
        UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectZero];
        priceLab.font = [UIFont systemFontOfSize:14];
        priceLab.textColor = SMSColor(94, 94, 94);

        if (i == orderArr.count) {
            priceLab.text = [NSString stringWithFormat:@"￥%@",detailModel.sendFee];
            nameLab.text = @"配送费";
            for (NSInteger j = 0; j < 2; j++) {
                UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 + height * i + height * self.numSingleVesion * j, WIDTH_VIEW, 1 * self.numSingleVesion)];
                line.backgroundColor = SMSColor(203, 203, 203);
                [scrollView addSubview:line];
                
                
            }

        }else{
            OrderDeatilItemModel *itemModel = orderArr[i];

            priceLab.text = [NSString stringWithFormat:@"￥%@",itemModel.price];
            nameLab.text = itemModel.Name;

        }
        [nameLab sizeToFit];
        nameLab.frame = CGRectMake(10 * self.numSingleVesion, 10 * self.numSingleVesion + height * i, self.frame.size.width, 15 * self.numSingleVesion);
        [priceLab sizeToFit];
        [scrollView addSubview:priceLab];
        priceLab.frame = CGRectMake(WIDTH_VIEW - 60 * self.numSingleVesion, 10 * self.numSingleVesion + height * i, priceLab.frame.size.width,15 * self.numSingleVesion);
        if (i != orderArr.count) {
            OrderDeatilItemModel *itemModel = orderArr[i];
            
            //数量
            UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectZero];
            countLab.textColor = SMSColor(94, 94, 94);
            countLab.text = [NSString stringWithFormat:@"x%@",itemModel.count];
            [scrollView addSubview:countLab];
            countLab.font = [UIFont systemFontOfSize:14];
            [countLab sizeToFit];
            countLab.frame = CGRectMake(WIDTH_VIEW - 60 * self.numSingleVesion - 20 * self.numSingleVesion - countLab.frame.size.width, 10 * self.numSingleVesion + height * i, countLab.frame.size.width, 15 * self.numSingleVesion);
        }
        
        
    }
    CGFloat singleHeight = height * (orderArr.count + 1) + 20 * self.numSingleVesion;
    //共计
    UILabel *totalLab = [[UILabel alloc] initWithFrame:CGRectZero];
    totalLab.textColor = SMSColor(94, 94, 94);
    totalLab.text = [NSString stringWithFormat:@"共计%@",detailModel.payAmount];
    [scrollView addSubview:totalLab];
    totalLab.font = [UIFont systemFontOfSize:14];
    [totalLab sizeToFit];
    totalLab.frame = CGRectMake(WIDTH_VIEW - 20 * self.numSingleVesion - totalLab.frame.size.width, singleHeight, totalLab.frame.size.width, 15 * self.numSingleVesion);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:totalLab.text];
    [str addAttribute:NSForegroundColorAttributeName value:SMSColor(93, 93, 93) range:NSMakeRange(0,2)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2,str.length - 2)];
    
    totalLab.attributedText = str;
    //优惠
    if(detailModel.youhuiMoney.integerValue != 0){
        UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectZero];
        countLab.textColor = SMSColor(94, 94, 94);
        countLab.text = [NSString stringWithFormat:@"优惠%@",detailModel.youhuiMoney];
        [scrollView addSubview:countLab];
        countLab.font = [UIFont systemFontOfSize:14];
        [countLab sizeToFit];
        countLab.frame = CGRectMake(WIDTH_VIEW  - 20 * self.numSingleVesion - totalLab.frame.size.width - 20 * self.numSingleVesion - countLab.frame.size.width, singleHeight, countLab.frame.size.width, 15 * self.numSingleVesion);
    }
    singleHeight += 40 * self.numSingleVesion;
    //有谁提供服务
    UILabel *serverLab = [[UILabel alloc] initWithFrame:CGRectZero];
    serverLab.textColor = SMSColor(94, 94, 94);
    serverLab.text = [NSString stringWithFormat:@"   本单由%@进行配送服务并提供服务\n   联系人%@",shopName,personal];
    [scrollView addSubview:serverLab];
    serverLab.font = [UIFont systemFontOfSize:14];
    serverLab.numberOfLines = 0;
    serverLab.backgroundColor = [UIColor whiteColor];
    serverLab.frame = CGRectMake(0 * self.numSingleVesion, singleHeight + 20 * self.numSingleVesion, WIDTH_VIEW - 0 * self.numSingleVesion, 80 * self.numSingleVesion);
}
//创建底部按钮
- (void)createBottomBtn{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50 * self.numSingleVesion, WIDTH_VIEW, 50 * self.numSingleVesion)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = bottomView.bounds;
    bottomBtn.backgroundColor = [UIColor redColor];
    [bottomView addSubview:bottomBtn];
    [bottomBtn setTitle:@"再来一单" forState:UIControlStateNormal];

    bottomBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomBtn addTarget:self action:@selector(bottomBtnDown) forControlEvents:UIControlEventTouchUpInside];
}
- (void)bottomBtnDown{
    if ([self.target isKindOfClass:[OrderDeatilViewController class]]) {
        [self.target comeAgainOrder];
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
