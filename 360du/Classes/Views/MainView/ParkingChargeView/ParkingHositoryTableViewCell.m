//
//  ParkingHositoryTableViewCell.m
//  360du
//
//  Created by linghang on 16/1/9.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ParkingHositoryTableViewCell.h"
#import "ParkingHistoryModel.h"
@interface ParkingHositoryTableViewCell()
@property(nonatomic,weak)UILabel *carNameLab;
@property(nonatomic,strong)UILabel *buyTimeLab;
@property(nonatomic,strong)UILabel *buyMoneyLab;
@property(nonatomic,weak)UILabel *startTimeLab;
@property(nonatomic,weak)UILabel *endTimeLab;
@property(nonatomic,assign)CGFloat allHeight;
@property(nonatomic,assign)CGFloat buyHeight;
@end
@implementation ParkingHositoryTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = SMSColor(246, 246, 246);
        [self createView];
    }
    return self;
}
- (void)createView{
    CGFloat width = 10 * self.numSingleVersion;
    CGFloat height = 0;
    CGFloat carImgLabWidth = 120 * self.numSingleVersion;
    CGFloat carImgLabHeight = 40 * self.numSingleVersion;
    height += 10 * self.numSingleVersion;
    UIFont *font = [UIFont systemFontOfSize:16];
    UIColor *color = SMSColor(51, 51, 51);
    //账单,155,
    UILabel *checkLab = [[UILabel alloc] initWithFrame:CGRectMake(width, height, 100 * self.numSingleVersion, 15 * self.numSingleVersion)];
    checkLab.textColor = SMSColor(155, 155, 155);
    [self addSubview:checkLab];
    checkLab.font = font;
    checkLab.text = @"账单";
    
    height += 30 * self.numSingleVersion;
    //横线206,206
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, height - 1 * self.numSingleVersion, WIDTH_CONTENTVIEW, 1 * self.numSingleVersion)];
    line1.backgroundColor = SMSColor(206, 206, 206);
    [self addSubview:line1];
    
    height += 20 * self.numSingleVersion;
    //购买时间
    self.buyHeight = height;
    self.buyTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW / 2, height, WIDTH_CONTENTVIEW / 2, 15 * self.numSingleVersion)];
    self.buyTimeLab.textColor = SMSColor(51, 51, 51);
    self.buyTimeLab.font = font;
    [self addSubview:self.buyTimeLab];
    
    height += 10 * self.numSingleVersion;
    //车牌号
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(width, height, WIDTH_CONTENTVIEW, 15 * self.numSingleVersion)];
    numLab.textColor = color;
    numLab.font = font;
    [self addSubview:numLab];
    numLab.text = @"车牌号:";
    
    height += 30 * self.numSingleVersion;
    //车牌名称
    UILabel *carImgLab = [[UILabel alloc] initWithFrame:CGRectMake(width - 5 * self.numSingleVersion, height, carImgLabWidth, carImgLabHeight)];
    carImgLab.font = [UIFont systemFontOfSize:24];
    carImgLab.textColor = [UIColor whiteColor];
    carImgLab.backgroundColor = SMSColor(11, 82, 168);
    [self addSubview:carImgLab];
    self.carNameLab = carImgLab;
    carImgLab.layer.borderColor = [SMSColor(157, 188, 219) CGColor];
    carImgLab.layer.borderWidth = 1 * self.numSingleVersion;
    carImgLab.textAlignment = NSTextAlignmentCenter;
    
    self.allHeight = height + carImgLabHeight / 2;
    
    height += carImgLabHeight + 20 * self.numSingleVersion;
    //套餐开始日期，套餐介绍日期
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *startTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(width + 20 * self.numSingleVersion, height + 20 * self.numSingleVersion * i, WIDTH_CONTENTVIEW  - 50 * self.numSingleVersion, 15 * self.numSingleVersion)];
        startTimeLab.font = font;
        startTimeLab.textColor = color;
        [self addSubview:startTimeLab];
        if ( i == 0) {
            self.startTimeLab = startTimeLab;
        }else{
            self.endTimeLab = startTimeLab;
        }
    }
    //购买金额
    self.buyMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(width - 5 * self.numSingleVersion, height, carImgLabWidth, carImgLabHeight)];
    self.buyMoneyLab.font = font;
    self.buyMoneyLab.textColor = [UIColor redColor];
    [self addSubview:self.buyMoneyLab];
    
    height += 40 * self.numSingleVersion;

    //横线206,206
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, height - 1 * self.numSingleVersion, WIDTH_CONTENTVIEW, 1 * self.numSingleVersion)];
    line2.backgroundColor = SMSColor(206, 206, 206);
    [self addSubview:line2];
    
}
- (void)setModel:(ParkingHistoryModel *)model{
    //购买时间
    self.buyTimeLab.text = [NSString stringWithFormat:@"购买时间:%@",model.cb_buyTime];
    [self.buyTimeLab sizeToFit];
    self.buyTimeLab.frame = CGRectMake(WIDTH_CONTENTVIEW - 5 * self.numSingleVersion - self.buyTimeLab.frame.size.width, self.buyHeight, self.buyTimeLab.frame.size.width, 15 * self.numSingleVersion);
    //车牌号
    self.carNameLab.text = model.cb_Pai;
    //购买金额
    self.buyMoneyLab.text = [NSString stringWithFormat:@"购买金额: %ld元",model.cb_Money.integerValue];
    [self.buyMoneyLab sizeToFit];
    self.buyMoneyLab.center = CGPointMake(WIDTH_CONTENTVIEW - 5 * self.numSingleVersion - self.buyMoneyLab.frame.size.width, self.allHeight);
    //开始日期和结束日期
    self.startTimeLab.text = [NSString stringWithFormat:@"套餐开始日期:%@",model.cb_BeginDate];
    self.endTimeLab.text = [NSString stringWithFormat:@"套餐结束日期%@",model.cb_EndDate];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
