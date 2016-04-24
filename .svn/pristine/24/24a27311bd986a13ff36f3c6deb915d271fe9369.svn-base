//
//  GroupPurchaseCenterTableViewCell.m
//  360du
//
//  Created by linghang on 15/12/20.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "GroupPurchaseCenterTableViewCell.h"
#import "CZCountDownView.h"
#import "UIImageView+WebCache.h"
#import "TranlateTime.h"
@interface GroupPurchaseCenterTableViewCell()
@property(nonatomic,strong)UILabel *nameLable;//0,0,0
@property(nonatomic,strong)UIImageView *leftImg;
@property(nonatomic,strong)UILabel *nowMoneyLable;//252,193,69
@property(nonatomic,strong)UILabel *beforeMoneyLable;//150,150,150
@property(nonatomic,strong)UIImageView *robImage;
@property(nonatomic,strong)UILabel *surplusCountLab;//200,200,200
@property(nonatomic,strong)UILabel *surplusTimeLab;//193,193,193,25,25,25
@property(nonatomic,strong)UILabel *lineMoney;//钱数横线
@property(nonatomic,weak)UIView *timeView;//时间图
@property(nonatomic,strong)CZCountDownView *countDownView;
@end
@implementation GroupPurchaseCenterTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    CGFloat height = 10 * self.numSingleVersion;
    //名字
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, height, WIDTH_CONTENTVIEW - 30 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.nameLable.font = [UIFont systemFontOfSize:18];
    self.nameLable.textColor = SMSColor(0, 0, 0);
    [self.contentView addSubview:self.nameLable];
    height = 40 * self.numSingleVersion;
    //图片
    self.leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 40 * self.numSingleVersion, 150 * self.numSingleVersion, 120 * self.numSingleVersion)];
    [self.contentView addSubview:self.leftImg];
    
    //现在价格
    self.nowMoneyLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nowMoneyLable.textColor = SMSColor(252,193,69);
    self.nowMoneyLable.font = [UIFont systemFontOfSize:30];
    [self.contentView addSubview:self.nowMoneyLable];
    //原先价格
    self.beforeMoneyLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.beforeMoneyLable.textColor = SMSColor(150,150,150);
    self.beforeMoneyLable.font = [UIFont systemFontOfSize:25];
    [self.contentView addSubview:self.beforeMoneyLable];
    //钱数横线
    self.lineMoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1 * self.numSingleVersion)];
    self.lineMoney.textColor = SMSColor(150,150,150);
//        self.lineMoney.textColor = [UIColor redColor];
    //self.lineMoney.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.lineMoney];
    //抢购图片
    UIImageView *robImg = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 0 * self.numSingleVersion - 54 * self.numSingleVersion - 67 * self.numSingleVersion, 40 * self.numSingleVersion + 30 * self.numSingleVersion + 25 * self.numSingleVersion, 120 * self.numSingleVersion, 50 * self.numSingleVersion)];
    robImg.image = [UIImage imageNamed:@"group_book_button"];
    [self.contentView addSubview:robImg];
    //仅剩下多少
    self.surplusCountLab = [[UILabel alloc] initWithFrame:CGRectZero];
    self.surplusCountLab.textColor = SMSColor(200,200,200);
    self.surplusCountLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.surplusCountLab];
    height = 160 * self.numSingleVersion;
    //剩余时间
     self.countDownView = [CZCountDownView countDown];
    self.countDownView.frame = CGRectMake(10 * self.numSingleVersion, 180 * self.numSingleVersion, WIDTH_CONTENTVIEW - 20 * self.numSingleVersion, 30 * self.numSingleVersion);
    self.countDownView.backgroundColor = SMSColor(211, 211, 211);
    [self.contentView addSubview:self.countDownView];
    self.countDownView.backgroundImageName = @"search_k";

//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 180 * self.numSingleVersion, WIDTH_CONTENTVIEW - 20 * self.numSingleVersion, 30 * self.numSingleVersion)];
//    view.backgroundColor = SMSColor(211, 211, 211);
//    [self.contentView addSubview:view];
//    self.timeView = view;
    //
//    self.surplusTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW - 20 * self.numSingleVersion, 15 * self.numSingleVersion)];
//    self.surplusTimeLab.center = CGPointMake(WIDTH_CONTENTVIEW / 2, 15 * self.numSingleVersion);
//    [view addSubview:self.surplusTimeLab];
    
}
- (void)setTime:(NSString *)time{
    
//    // 封装后
//    CZCountDownView *countDown = [CZCountDownView shareCountDown];
//    countDown.frame = CGRectMake(100, 100, 200, 30);
//    countDown.timestamp = 5;
//    countDown.backgroundImageName = @"search_k";
//    countDown.timerStopBlock = ^{
//        NSLog(@"时间停止");
//    };
    
    
    self.countDownView.timestamp = [[TranlateTime returnTimeStamp:time] integerValue];
    self.countDownView.timerStopBlock = ^{
        NSLog(@"时间停止");
    };


//    //剩余时间
//    NSString *finalTime = [NSString stringWithFormat:@"剩余时间: %@",time];
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:finalTime];
//    [str addAttribute:NSForegroundColorAttributeName value:SMSColor(151, 151, 151) range:NSMakeRange(0,5)];
//    [str addAttribute:NSForegroundColorAttributeName value:SMSColor(25, 25, 25) range:NSMakeRange(6,finalTime.length - 6)];
//        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(6, finalTime.length - 6)];
//    self.surplusTimeLab.attributedText = str;
//    [self.surplusTimeLab sizeToFit];
//    self.surplusTimeLab.frame = CGRectMake((WIDTH_CONTENTVIEW - self.surplusTimeLab.frame.size.width) / 2, 7.5 * self.numSingleVersion, self.surplusTimeLab.frame.size.width, 15 * self.numSingleVersion);
    //self.surplusTimeLab.center = CGPointMake(WIDTH_CONTENTVIEW / 2, 15 * self.numSingleVersion);
}
- (void)setModel:(GroupPurchaseModel *)model{
    //名字
    self.nameLable.text = model.cpname;
    //图片
    [self.leftImg sd_setImageWithURL:[NSURL URLWithString:model.cppicture]];
    //现在价格
    self.nowMoneyLable.text = [NSString stringWithFormat:@"￥%@",model.unitPirce];
    [self.nowMoneyLable sizeToFit];
    self.nowMoneyLable.frame = CGRectMake(WIDTH_CONTENTVIEW - 10 * self.numSingleVersion - self.nowMoneyLable.frame.size.width, 40 * self.numSingleVersion, self.nowMoneyLable.frame.size.width, 20 * self.numSingleVersion);
    //原先价格
    self.beforeMoneyLable.text = [NSString stringWithFormat:@"RMB:%@",model.marketPrice];
    
    [self.beforeMoneyLable sizeToFit];
    self.beforeMoneyLable.frame = CGRectMake(WIDTH_CONTENTVIEW - 10 * self.numSingleVersion - self.beforeMoneyLable.frame.size.width, 40 * self.numSingleVersion + 30 * self.numSingleVersion, self.beforeMoneyLable.frame.size.width, 20 * self.numSingleVersion);

    //横线
    self.lineMoney.frame = CGRectMake(WIDTH_CONTENTVIEW - 10 * self.numSingleVersion - self.beforeMoneyLable.frame.size.width, 40 * self.numSingleVersion + 30 * self.numSingleVersion + 8 * self.numSingleVersion, self.beforeMoneyLable.frame.size.width, 1 * self.numSingleVersion);
    self.lineMoney.backgroundColor = SMSColor(150,150,150);
    self.lineMoney.center = CGPointMake(WIDTH_CONTENTVIEW - 10 * self.numSingleVersion - self.beforeMoneyLable.frame.size.width / 2, 40 * self.numSingleVersion + 30 * self.numSingleVersion + 10 * self.numSingleVersion);
    //剩下
    self.surplusCountLab.text = [NSString stringWithFormat:@"仅剩:%ld件",(model.topLimit.integerValue - model.nowCount.integerValue)];
    [self.surplusCountLab sizeToFit];
    self.surplusCountLab.frame = CGRectMake(WIDTH_CONTENTVIEW - 10 * self.numSingleVersion - self.surplusCountLab.frame.size.width, 40 * self.numSingleVersion + 30 * self.numSingleVersion + 25 * self.numSingleVersion + 40 * self.numSingleVersion + 10 * self.numSingleVersion, self.surplusCountLab.frame.size.width, 20 * self.numSingleVersion);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
