//
//  MineGroupTableViewCell.m
//  360du
//
//  Created by linghang on 16/4/12.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "MineGroupTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MIneGroupModel.h"
#import "UIView+Toast.h"
#import "ShopListView.h"
#import "WeChantViewViewController.h"
#import "AlipayViewController.h"
#import "MineGroupViewController.h"
#import "GroupWMPageViewController.h"
#import "MineGroupViewController.h"
#import "MineGroupTwoViewController.h"
#import "MineGroupThreeViewController.h"
#import "MineOneViewController.h"
#import <Foundation/NSDateFormatter.h>
@interface MineGroupTableViewCell()<UIAlertViewDelegate>{
//    UILabel *_payLab;//待付款
//    UILabel *_buyTime;//下单时间
//    UIImageView *_leftImg;//左边图片
//    UILabel *_nameLab;//名称
//    UILabel *_deatilLab;//介绍
//    UILabel *_prePriceLab;//原先价格
//    UILabel *_nowPiceLab;//现在价格
//    UILabel *_countLab;//数量
//    UILabel *_totoalPriceLab;//总价
//    UIButton *_payBtn;//付款按钮
    CGFloat _heigth;
    CGFloat _allHeight;
    NSString *_ccpo;
    NSString *_payName;
    NSString *_payNumber;
}


@end

@implementation MineGroupTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createMainView];
    }
    return self;
}
- (void)createMainView{
    _payLab = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_payLab];
    _payLab.font = [UIFont systemFontOfSize:15];
    _payLab.textColor = [UIColor redColor];
    
    
    _buyTime = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_buyTime];
    _buyTime.font = [UIFont systemFontOfSize:15];
    _buyTime.textColor = SMSColor(51, 51, 51);

    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 39 * self.numSingleVersion, WIDTH_VIEW, 1 * self.numSingleVersion)];
    lineLab.backgroundColor = SMSColor(241, 241, 241);
    [self.contentView addSubview:lineLab];
    
    
    CGFloat allHeight = 40 * self.numSingleVersion;
    _allHeight = allHeight;
    CGFloat height = 40 * self.numSingleVersion;
    _heigth = height;
    
    //图片
    _leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 30 * self.numSingleVersion + height, 80 * self.numSingleVersion, 80 * self.numSingleVersion)];
    [self.contentView addSubview:_leftImg];
   // [_leftImg sd_setImageWithURL:[NSURL URLWithString:self.model.cppicture]];
   // height = 70 * self.numSingleVersion;
    //名字
    //NSArray *textArr = @[self.model.cpname,[NSString stringWithFormat:@"种类:%@",self.model.cpname]];
    allHeight += 100 * self.numSingleVersion;
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(100 * self.numSingleVersion, 20 * self.numSingleVersion + 50 * i + height, WIDTH_CONTENTVIEW - 130 * self.numSingleVersion, 40 * self.numSingleVersion)];
        nameLable.tag = 2200 + i;
        //nameLable.text = textArr[i];
        if (i == 0) {
            nameLable.font = [UIFont systemFontOfSize:15];
            nameLable.textColor = SMSColor(51, 51, 51);
        }else{
            nameLable.font = [UIFont systemFontOfSize:13];
            nameLable.textColor = SMSColor(151, 151, 151);
        }
        
        nameLable.numberOfLines= 2;
        [self.contentView addSubview:nameLable];
        
    }
   // NSArray *priceArr = @[[NSString stringWithFormat:@"￥%@",self.model.pprice],[NSString stringWithFormat:@"￥%@",self.model.mprice],[NSString stringWithFormat:@"x%@",self.model.preCount]];
    NSArray *colorArr = @[SMSColor(51, 51, 51),SMSColor(151, 151, 151),SMSColor(151, 151, 151)];
    
    for (NSInteger i = 0; i < 3; i++) {
        UILabel *beforeMoneyLable = [[UILabel alloc] initWithFrame:CGRectZero];
        beforeMoneyLable.textColor = colorArr[i];
        //beforeMoneyLable.text = priceArr[i];
        beforeMoneyLable.tag = 2300 + i;
        beforeMoneyLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:beforeMoneyLable];
        
        if (i == 1) {
            UILabel *lineMoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1 * self.numSingleVersion)];
            lineMoney.backgroundColor = SMSColor(121,121,121);
            lineMoney.tag = 2400;
            //lineMoney.backgroundColor = [UIColor redColor];
            //self.lineMoney.font = [UIFont systemFontOfSize:18];
            [self.contentView addSubview:lineMoney];
                    }
    }
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, allHeight + 39 * self.numSingleVersion * i , WIDTH_VIEW, 1 * self.numSingleVersion)];
        bottomLine.backgroundColor = SMSColor(241, 241, 241);
        [self.contentView addSubview:bottomLine];

    }
    _totoalPriceLab = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_totoalPriceLab];
    _totoalPriceLab.font = [UIFont systemFontOfSize:16];
    _totoalPriceLab.textColor = [UIColor redColor];
    
    _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _payBtn.frame = CGRectMake(WIDTH_VIEW - 150 * self.numSingleVersion, 180* self.numSingleVersion, 70 * self.numSingleVersion, 40 * self.numSingleVersion);
    [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_payBtn];
    _payBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _payBtn.backgroundColor = [UIColor redColor];
    _payBtn.tag = 151884;
//    _payBtn.backgroundColor = [UIColor cyanColor];

    
    
    
    
    _logisticsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _logisticsBtn.frame = CGRectMake(WIDTH_VIEW - 230 * self.numSingleVersion, 180* self.numSingleVersion, 70 * self.numSingleVersion, 40 * self.numSingleVersion);
    [_logisticsBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_logisticsBtn];
    _logisticsBtn.tag = 1518840;
//    _logisticsBtn.backgroundColor = [UIColor cyanColor];
    _logisticsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    _shouHuoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shouHuoBtn.frame = CGRectMake(WIDTH_VIEW - 70 * self.numSingleVersion, 180* self.numSingleVersion, 65 * self.numSingleVersion, 40 * self.numSingleVersion);
    [_shouHuoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_payBtn];
    
//    _shouHuoBtn.backgroundColor = [UIColor cyanColor];
    _shouHuoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.shouHuoBtn];
    
    _payBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _shouHuoBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _logisticsBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
- (void)payBtnDown:(UIButton *)payBtn{
//    NSLog(@"%@",_ccpo);

    if (payBtn.tag == 151884) {
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
    }else{
        if ([payBtn.titleLabel.text isEqualToString:@"确认收货"]) {
//            NSLog(@"333%@",_ccpo);
            AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
            NSString *url = nil;
            url = [NSString stringWithFormat:ORDERFINISHBUY,_ccpo];
            [twoPack getUrl:url andFinishBlock:^(id getResult) {
//                NSLog(@"%@",getResult);
                [self.contentView makeToast:getResult[@"message"]];
            }];

        }
    
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if (buttonIndex == 1) {
//         [WeChantViewViewController payName:_payName andMoney:[NSString stringWithFormat:@"%0.2f",_payNumber.floatValue * 100 ]];
//        NSLog(@"%@",[NSString stringWithFormat:@"GB%@",_ccpo]);
        [WeChantViewViewController payName:_payName andMoney:[NSString stringWithFormat:@"%0.2f",_payNumber.floatValue *100] andOder:[NSString stringWithFormat:@"GB%@",_ccpo]];
    }else if (buttonIndex == 2){
//        AlipayViewController *aliPay = [[AlipayViewController alloc] initPrice:[NSString stringWithFormat:@"%0.2f",_payNumber.floatValue] andDescMerchant:nil andTitle:_payName andMerOrder:nil];
        
        id next = [self nextResponder] ;
        
        while (next != nil) {
            
            next = [next nextResponder];
            
            if ([next isKindOfClass:[MineGroupViewController class]]) {
//                NSLog(@"qwqwqw%@",next);
//                NSLog(@"%@",[NSString stringWithFormat:@"GB%@",_ccpo]);
//                
//                [next pushViewController:aliPay animated:YES];
                [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"GB%@",_ccpo] totalMoney:[NSString stringWithFormat:@"%0.2f",_payNumber.floatValue] payTitle:_payName];
                return;
                
            }
        }
    }
//    for (UIView* next = [self superview]; next; next = next.superview) {
//        UIResponder* nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            (UIViewController*;
//        }
//    }
//    UITableView *tv = (UITableView *) self.superview;
//    [tv reloadData];

    
    GroupWMPageViewController *pageVC = [[GroupWMPageViewController alloc] initWithViewControllerClasses:@[[MineGroupViewController class],[MineOneViewController class],[MineGroupTwoViewController class],[MineGroupThreeViewController class]] andTheirTitles:@[@"全部",@"待付款",@"待收货",@"已收货"]];
    pageVC.pageAnimatable = YES;
    pageVC.menuItemWidth = 85;
    pageVC.menuHeight = 45 * self.numSingleVersion;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    // 默认
    pageVC.title = @"我的村味汇";
    //            pageVC.preloadPolicy = WMPageControllerPreloadPolicyNeighbour;
    //            pageVC.keys = [@[@"statue",@"statue",@"statue"]mutableCopy];
    //            pageVC.values = [@[@"1",@"2",@"3"] mutableCopy];
//    [self pushViewController:pageVC animated:YES];
//    UITableView *tv = (UITableView *) self.superview;
//    UIViewController*vc = (UIViewController *) tv.dataSource;
//    [vc.navigationController pushViewController:pageVC animated:YES];
//    if (self.target isKindOfClass:[]) {
//        <#statements#>
//    }
//    [self.target pushViewController:pageVC animated:YES];
    
}

- (void)setGroupModel:(MIneGroupModel *)groupModel{
    NSString *statusStr = nil;
    NSString *shouBtnText = nil;
    NSString *logistStr = nil;
    _ccpo = groupModel.ccpo;
    _payName = groupModel.pname;
    _payNumber = groupModel.totalPrice;
    switch (groupModel.orderStatus.integerValue) {
        case 1:
            if ([self time:groupModel.ordertime]) {
                statusStr = @"确认中";
            }else{
//                if ([self.tag1 isEqualToString:@"2"]) {
                    statusStr = @"付款";
//                }else{
//                    statusStr = @"已过期";
//                }
            }
//            shouBtnText = @"";
            break;
        case 2:
//            if ([self time:groupModel.ordertime]) {
//                statusStr = @"确认中";
//            }else{
            statusStr = @"已付款";
            shouBtnText = @"确认收货";
            logistStr = @"查看物流";
//            }
            break;

        case 3:
            if ([self time:groupModel.ordertime]) {
                statusStr = @"确认中";
            }else{
                statusStr = @"配送中";
                logistStr = @"查看物流";

            }
            break;

        case 4:
            if ([self time:groupModel.ordertime]) {
                statusStr = @"确认中";
            }else{
            statusStr = @"配送完成";
                logistStr = @"查看物流";

            }
            break;

        case 5:
            if ([self time:groupModel.ordertime]) {
                statusStr = @"确认中";
            }else{
            statusStr = @"需退款";
            }
            break;

        case 6:
            if ([self time:groupModel.ordertime]) {
                statusStr = @"确认中";
            }else{
            statusStr = @"退款完成";
            }
            break;
        case 7:
            if ([self time:groupModel.ordertime]) {
                statusStr = @"确认中";
            }else{
                statusStr = @"已取消";
            }
            break;
        default:
            break;
    }
    
    
    
    
    [_payBtn setTitle:statusStr forState:UIControlStateNormal];
    [_shouHuoBtn setTitle:shouBtnText forState:UIControlStateNormal];
    [_logisticsBtn setTitle:logistStr forState:UIControlStateNormal];
    if ([_payBtn.titleLabel.text isEqualToString:@"已过期"]) {
        _payBtn.backgroundColor = [UIColor grayColor];
        _payLab.textColor = [UIColor grayColor];
    }
//    [_logisticsBtn addTarget:self action:@selector(logisticsAction:) forControlEvents:UIControlEventTouchUpInside];
    [_payBtn addTarget:self action:@selector(payBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [_shouHuoBtn addTarget:self action:@selector(payBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    _payLab.text = statusStr;
    [_payLab sizeToFit];
    _payLab.center = CGPointMake(20 * self.numSingleVersion + _payLab.frame.size.width / 2, 20 * self.numSingleVersion);
    
    _buyTime.text = groupModel.ordertime;
    [_buyTime sizeToFit];
    _buyTime.center = CGPointMake(WIDTH_VIEW - 20 * self.numSingleVersion - _buyTime.frame.size.width / 2, 20 * self.numSingleVersion);
    
    
     [_leftImg sd_setImageWithURL:[NSURL URLWithString:groupModel.cppicture]];
    NSArray *textArr = @[groupModel.pname,[NSString stringWithFormat:@"%@",groupModel.name]];
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *nameLable = (UILabel *)[self.contentView viewWithTag:2200 + i];
        nameLable.text = textArr[i];

    }
//    NSLog(@"%@-----%@",groupModel.marketPrice,groupModel.unitPrice);
     NSArray *priceArr = @[[NSString stringWithFormat:@"￥%@",groupModel.unitPrice],[NSString stringWithFormat:@"￥%@",groupModel.marketPrice],[NSString stringWithFormat:@"x%@",groupModel.preCount]];
    for (NSInteger i = 0; i < priceArr.count; i++) {
        UILabel *beforeMoneyLable = (UILabel *)[self.contentView viewWithTag:2300 + i];
        beforeMoneyLable.text = priceArr[i];
        [beforeMoneyLable sizeToFit];
        beforeMoneyLable.frame = CGRectMake(WIDTH_VIEW - beforeMoneyLable.frame.size.width - 5 * self.numSingleVersion, 25 * self.numSingleVersion + 30 * self.numSingleVersion * i + _heigth, beforeMoneyLable.frame.size.width, 15 * self.numSingleVersion);
        
        if (i == 1) {
            UILabel *lineMoney = (UILabel *)[self.contentView viewWithTag:2400];
            lineMoney.frame =  CGRectMake(WIDTH_VIEW - beforeMoneyLable.frame.size.width - 5 * self.numSingleVersion, 25 * self.numSingleVersion + 30 * self.numSingleVersion * i + 7.5 * self.numSingleVersion + _heigth, beforeMoneyLable.frame.size.width, 1 * self.numSingleVersion);

        }
    }
    
    _totoalPriceLab.text = [NSString stringWithFormat:@"合计:%@",groupModel.totalPrice];
    [_totoalPriceLab sizeToFit];
    _totoalPriceLab.center = CGPointMake(WIDTH_VIEW - 20 * self.numSingleVersion - _totoalPriceLab.frame.size.width / 2, 160 * self.numSingleVersion);

}




-(BOOL) time:(NSString *)dates{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //然后创建日期对象
    
    NSDate *date1 = [dateFormatter dateFromString:dates];
    
    NSDate *date = [NSDate date];
    
    //计算时间间隔（单位是秒）
    
    NSTimeInterval time = [date1 timeIntervalSinceDate:date];
    
    //计算天数、时、分、秒
    
    int days = ((int)time)/(3600*24);
    
    int hours = ((int)time)%(3600*24)/3600;
    
    int minutes = ((int)time)%(3600*24)%3600/60;
    
//    int seconds = ((int)time)%(3600*24)%3600%60;
    NSString *dateContent = [[NSString alloc] initWithFormat:@"%i,%i,%i",days,hours,minutes];
    
    if (days == 0 && hours == 0 && minutes >= -1) {
        return YES;
    }else{
        return NO;
    }
    
    
    
//    NSLog(@"%@",dateContent);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
