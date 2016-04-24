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
@interface MineGroupTableViewCell(){
    UILabel *_payLab;//待付款
    UILabel *_buyTime;//下单时间
    UIImageView *_leftImg;//左边图片
    UILabel *_nameLab;//名称
    UILabel *_deatilLab;//介绍
    UILabel *_prePriceLab;//原先价格
    UILabel *_nowPiceLab;//现在价格
    UILabel *_countLab;//数量
    UILabel *_totoalPriceLab;//总价
    UIButton *_payBtn;//付款按钮
    CGFloat _heigth;
    CGFloat _allHeight;
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
    _payBtn.frame = CGRectMake(WIDTH_VIEW - 120 * self.numSingleVersion, _allHeight, 70 * self.numSingleVersion, 40 * self.numSingleVersion);
    [_payBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_payBtn];
    [_payBtn addTarget:self action:@selector(payBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    _payBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
- (void)payBtnDown:(UIButton *)payBtn{
    
}
- (void)setGroupModel:(MIneGroupModel *)groupModel{
    NSString *statusStr = nil;
    switch (groupModel.orderStatus.integerValue) {
        case 1:
            statusStr = @"未付款";
            break;
        case 2:
            statusStr = @"已付款";

            break;

        case 3:
            statusStr = @"配送中";

            break;

        case 4:
            statusStr = @"配送完成";

            break;

        case 5:
            statusStr = @"需退款";

            break;

        case 6:
            statusStr = @"退款完成";

            break;

        default:
            break;
    }
    [_payBtn setTitle:statusStr forState:UIControlStateNormal];
    
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
     NSArray *priceArr = @[[NSString stringWithFormat:@"￥%@",groupModel.marketPrice],[NSString stringWithFormat:@"￥%@",groupModel.unitPrice],[NSString stringWithFormat:@"x%@",groupModel.preCount]];
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
    _totoalPriceLab.center = CGPointMake(WIDTH_VIEW - 20 * self.numSingleVersion - _totoalPriceLab.frame.size.width / 2, 20 * self.numSingleVersion);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
