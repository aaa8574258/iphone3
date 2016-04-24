//
//  MerchantMangerOrderDealTableViewCell.m
//  360du
//
//  Created by linghang on 15/12/12.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "MerchantMangerOrderDealTableViewCell.h"
#import "MerchantOrderDetailModel.h"
#import "NSString+NSString.h"
@interface MerchantMangerOrderDealTableViewCell()

@end
@implementation MerchantMangerOrderDealTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (void)makeUI{
    
}
- (void)setClickNum:(NSInteger)clickNum{
    //sw
    switch (clickNum) {
        case 0:{
            [self makeAddress];
            break;
        }
        case 1:{
            [self makeMenu];
            break;
        }
        case 2:{
            [self makeOtherPay];
            break;
        }
        case 3:{
            [self makePriviege];
            break;
        }
        default:
            break;
    }
}
//第一个地址
- (void)makeAddress{
    NSLog(@"WIDTH_CONTENTVIEW%lf",85 * self.numSingleVersion);
    NSArray *tempArr = @[@"在线支付",self.detailModel.name,self.detailModel.address];
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 10 * self.numSingleVersion, WIDTH_CONTENTVIEW - 30 * self.numSingleVersion, 25 * self.numSingleVersion)];
    lable1.text = tempArr[0];
    lable1.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:lable1];
    lable1.backgroundColor = SMSColor(231, 61, 61);
    lable1.textColor = [UIColor whiteColor];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.frame = CGRectMake(10 * self.numSingleVersion, 10 * self.numSingleVersion, 70 * self.numSingleVersion, 30 * self.numSingleVersion);
    CGFloat height = 40 * self.numSingleVersion;
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 45 * self.numSingleVersion + 25 * i, WIDTH_CONTENTVIEW - 30 * self.numSingleVersion, 15 * self.numSingleVersion)];
        lable.text = tempArr[i + 1];
        lable.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:lable];
        lable.textColor = SMSColor(66, 66, 66);
        if (i == 0) {
            height += 5 * self.numSingleVersion;
            height += 15 * self.numSingleVersion;
        }else{
            height += 25 * self.numSingleVersion;
        }
    }
    //订单编号
    UILabel *orderNum = [[UILabel alloc] initWithFrame:CGRectZero];
    orderNum.text = [NSString stringWithFormat:@"订单编号:%@",self.detailModel.orderId];
    orderNum.font = [UIFont systemFontOfSize:15];
    orderNum.textColor = SMSColor(66, 66, 66);
    [self.contentView addSubview:orderNum];
    [orderNum sizeToFit];
    orderNum.center = CGPointMake(WIDTH_CONTENTVIEW - 5 * self.numSingleVersion - orderNum.frame.size.width / 2, 25 * self.numSingleVersion);
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0,  height - 1 * self.numSingleVersion, WIDTH_VIEW, 1 * self.numSingleVersion)];
    line.backgroundColor = SMSColor(151, 151, 151);
    [self.contentView addSubview:line];
}
//第二个菜单
- (void)makeMenu{
    for (NSInteger j  = 0; j < [self.detailModel.goodsInfo count]; j++) {
        self.goodsInfoModel = [[MerchantOrderDetailGoodsInfoModel alloc] initWithDictionary:self.detailModel.goodsInfo[j]];
        NSArray *tempArr = @[self.goodsInfoModel.goodsName,[NSString stringWithFormat:@"x%@",self.goodsInfoModel.count],[NSString stringWithFormat:@"￥%@",self.goodsInfoModel.price]];
        UIView *goodsView = [[UIView alloc] initWithFrame:CGRectMake(0,30 * j * self.numSingleVersion, WIDTH_VIEW, 30 * self.numSingleVersion)];
        [self.contentView addSubview:goodsView];
        CGFloat sizeWidth = WIDTH_CONTENTVIEW / 2;//判判距离是不是超过一半
        for (NSInteger i = 0; i < 3; i++) {
            UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectZero];
            lable1.font = [UIFont systemFontOfSize:13];
            lable1.textColor = SMSColor(66, 66, 66);
            [goodsView addSubview:lable1];
            lable1.text = tempArr[i];
            if (i == 0) {
                CGFloat tmpWid = [lable1.text returnSizeFont:13 andWidth:0].width;
                if (sizeWidth - 10 * self.numSingleVersion < tmpWid) {
                    NSLog(@"sizeWIdth:%f",sizeWidth);
                    sizeWidth = tmpWid;
                    //sizeWidth =  MIN(sizeWidth,WIDTH_CONTENTVIEW -  105 * self.numSingleVersion);
                    NSLog(@"sizeWIdth2:%f",sizeWidth);
                    NSLog(@"content:%f",WIDTH_CONTENTVIEW -  75 * self.numSingleVersion);


                }
                lable1.frame = CGRectMake(10 * self.numSingleVersion, 7.5 * self.numSingleVersion, sizeWidth, 15 * self.numSingleVersion);
            }else if (i == 2){
                lable1.frame = CGRectMake(sizeWidth + 20 * self.numSingleVersion +  15 * self.numSingleVersion, 7.5 * self.numSingleVersion, 40 * self.numSingleVersion, 15 * self.numSingleVersion);
            }else{
                lable1.frame = CGRectMake(sizeWidth + 20 * self.numSingleVersion, 7.5 * self.numSingleVersion, 30 * self.numSingleVersion, 15 * self.numSingleVersion);

            }
        }
    }
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0,  self.detailModel.goodsInfo.count * 30 * self.numSingleVersion - 1 * self.numSingleVersion , WIDTH_VIEW, 1 * self.numSingleVersion)];
    line.backgroundColor = SMSColor(151, 151, 151);
    [self.contentView addSubview:line];

}
//第三个其他费用
- (void)makeOtherPay{
    NSArray *tempArr = @[@"其他费用",@"配送费"];
    for (NSInteger i = 0; i < tempArr.count; i++) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 10 * self.numSingleVersion + 30 * i, WIDTH_CONTENTVIEW - 30 * self.numSingleVersion, 15 * self.numSingleVersion)];
        lable.text = tempArr[i];
        lable.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:lable];
            lable.textColor = SMSColor(66, 66, 66);
        if (i == 1) {
            UILabel *lablePay = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 30 * self.numSingleVersion, 10 * self.numSingleVersion + 30 * i, 20 * self.numSingleVersion, 15 * self.numSingleVersion)];
            lablePay.text = self.detailModel.sendFee;
            lablePay.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:lablePay];
            lablePay.textColor = SMSColor(215, 60, 59);
        }
    }
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0,  55 * self.numSingleVersion - 1 * self.numSingleVersion , WIDTH_VIEW, 1 * self.numSingleVersion)];
    line.backgroundColor = SMSColor(151, 151, 151);
    [self.contentView addSubview:line];
}
//第四个优惠
- (void)makePriviege{
    NSArray *tempArr = @[[NSString stringWithFormat:@"已优惠 %@",self.detailModel.youhuiMoney],[NSString stringWithFormat:@"共计%@",self.detailModel.payAmount]];
    for (NSInteger i = 0; i < tempArr.count; i++) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 10 * self.numSingleVersion + 30 * i, WIDTH_CONTENTVIEW - 30 * self.numSingleVersion, 15 * self.numSingleVersion)];
        lable.text = tempArr[i];
        lable.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:lable];
        lable.textColor = SMSColor(66, 66, 66);
        if (i == 1) {
            [lable sizeToFit];
            lable.frame = CGRectMake(WIDTH_CONTENTVIEW - 10 * self.numSingleVersion - lable.frame.size.width, 10 * self.numSingleVersion, lable.frame.size.width, 15 * self.numSingleVersion);
        }
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tempArr[i]];
        if (i == 0) {
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,str.length - 3)];

        }else{
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2,str.length - 2)];

        }
        //[str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2,lable.text.length-1)];
//        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30.0] range:NSMakeRange(0, 5)];
//        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(6, 12)];
//        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:30.0] range:NSMakeRange(19, 6)];
        lable.attributedText = str;
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
