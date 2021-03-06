//
//  PrivilegeTableViewCell.m
//  360du
//
//  Created by linghang on 15/12/10.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "PrivilegeTableViewCell.h"
#import "PrivilegeCenterModel.h"
#import "UIImageView+WebCache.h"

@interface PrivilegeTableViewCell(){
    UILabel *_privelageLeftLab;//左边优惠券内容
    UILabel *_progressLab;//已经领取多少
    UILabel *_progressNumLab;//数字进度
    UIImageView *_bgImg;//北京图
    UIImageView *_privilegeImg;//优惠图
    UILabel *_yellowMineyLab;//黄色钱数
    UILabel *_fullMoneyLab;//满多少钱可以用
    UILabel *_shopNameLab;//点名
    UILabel *_timeLab;//时间
    UILabel *_getLab;//立即领取
    UIButton *_allBtn;//点击按钮
}

@end
@implementation PrivilegeTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    CGFloat height = 5 * self.numSingleVersion;
    UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(0, 2 * self.numSingleVersion + height, WIDTH_CONTENTVIEW, 1 * self.numSingleVersion)];
    line.backgroundColor = SMSColor(151, 151, 151);
    [self.contentView addSubview:line];
    //左边优惠钱数
    _privelageLeftLab = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 5 * self.numSingleVersion + height + 20 * self.numSingleVersion, 100 * self.numSingleVersion, 15 * self.numSingleVersion)];
    [self.contentView addSubview:_privelageLeftLab];
    _privelageLeftLab.font = [UIFont systemFontOfSize:14];
    _privelageLeftLab.textColor = SMSColor(51, 51, 51);
    //右边已领取
    _progressLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _progressLab.text = @"已领取0%";
    _progressLab.textColor = SMSColor(211, 211, 211);
    _progressLab.font = [UIFont systemFontOfSize:13];
    [_progressLab sizeToFit];
    _progressLab.frame = CGRectMake(WIDTH_CONTENTVIEW - 5 * self.numSingleVersion - _progressLab.frame.size.width - 5 * self.numSingleVersion, 5 * self.numSingleVersion + height + 20 * self.numSingleVersion, _progressLab.frame.size.width, 15 * self.numSingleVersion);
    [self.contentView addSubview: _progressLab];
    //进度条
    UILabel *bgProgressLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - _progressLab.frame.size.width - 19 * self.numSingleVersion - 100, 3 * self.numSingleVersion + height + 20 * self.numSingleVersion, 100 * self.numSingleVersion, 19 * self.numSingleVersion)];
    bgProgressLab.layer.cornerRadius = 5 * self.numSingleVersion;

    bgProgressLab.layer.borderColor = [SMSColor(211, 211, 211) CGColor];
    bgProgressLab.layer.borderWidth = 1 * self.numSingleVersion;
    [self.contentView addSubview:bgProgressLab];
    //显示进度
    _progressNumLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _progressNumLab.backgroundColor = [UIColor redColor];
    _progressNumLab.layer.cornerRadius = 5 * self.numSingleVersion;
    [bgProgressLab addSubview:_progressNumLab];
    //背景图
    _bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 30 * self.numSingleVersion + height + 30 * self.numSingleVersion, WIDTH_CONTENTVIEW - 10 * self.numSingleVersion, 120 * self.numSingleVersion)];
    _bgImg.image = [UIImage imageNamed:@"coupon_background.png"];
    [self.contentView addSubview:_bgImg];
    //优惠图
    _privilegeImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 5 * self.numSingleVersion, 60 * self.numSingleVersion, 60 * self.numSingleVersion)];
    _privilegeImg.layer.cornerRadius = 30 * self.numSingleVersion;
    [_bgImg addSubview:_privilegeImg];
    _privilegeImg.clipsToBounds = YES;
    //黄色钱数
    _yellowMineyLab = [[UILabel alloc] initWithFrame:CGRectMake(100 * self.numSingleVersion, 10 * self.numSingleVersion, 200 * self.numSingleVersion, 30 * self.numSingleVersion)];
    _yellowMineyLab.textColor = [UIColor colorWithRed:255/255.0 green:205/255.0 blue:88/255.0 alpha:1];
    [_bgImg addSubview:_yellowMineyLab];
    _yellowMineyLab.font = [UIFont systemFontOfSize:30];
    //满多少可以用
    _fullMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(100 * self.numSingleVersion, 50 * self.numSingleVersion, WIDTH_CONTENTVIEW - 100 * self.numSingleVersion - 100 * self.numSingleVersion, 30 * self.numSingleVersion)];
    _fullMoneyLab.backgroundColor = SMSColor(203, 231, 250);
    _fullMoneyLab.layer.cornerRadius = 10 * self.numSingleVersion;
    _fullMoneyLab.textAlignment = NSTextAlignmentCenter;
    _fullMoneyLab.font = [UIFont systemFontOfSize:14];
    [_bgImg addSubview:_fullMoneyLab];
    _fullMoneyLab.textColor = SMSColor(151, 151, 151);
    //店铺
    _shopNameLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 90 * self.numSingleVersion - 5 * self.numSingleVersion, WIDTH_CONTENTVIEW - 80 * self.numSingleVersion, 15 * self.numSingleVersion)];
    _shopNameLab.font = [UIFont systemFontOfSize:12];
    _shopNameLab.textColor = SMSColor(151, 151, 151);
    [_bgImg addSubview:_shopNameLab];
    //时间
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 110 * self.numSingleVersion - 8 * self.numSingleVersion, WIDTH_CONTENTVIEW - 120 * self.numSingleVersion, 15 * self.numSingleVersion)];
    _timeLab.textColor = [UIColor whiteColor];
    [_bgImg addSubview:_timeLab];
    _timeLab.font = [UIFont systemFontOfSize:12];
    
    //理解领取
    _getLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 60 * self.numSingleVersion, 20 * self.numSingleVersion, 30 * self.numSingleVersion, 80 * self.numSingleVersion)];
    _getLab.text = @"立\n即\n领\n取";
    _getLab.numberOfLines = 0;
//    _getLab.backgroundColor = [UIColor redColor];
    [_bgImg addSubview:_getLab];
    _getLab.font = [UIFont systemFontOfSize:16*self.numSingleVersion];
    _getLab.textColor = SMSColor(51, 51, 51);
//    _getLab.transform = CGAffineTransformMakeRotation(M_PI / 2);
    
//    //整个按钮
//    _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _allBtn.frame = _bgImg.bounds;
//    [_allBtn setTitle:@"" forState:UIControlStateNormal];
//    [_bgImg addSubview:_allBtn];
//    [_allBtn addTarget:self action:@selector(allBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    
}
//- (void)allBtnDown:(UIButton *)allBtn{
//    
//}
- (void)setModel:(PrivilegeCenterModel *)model{
    //优惠券
    _privelageLeftLab.text = model.yhName;
    //已领取多少，右边
    _progressLab.text = [NSString stringWithFormat:@"已领取%@%%",model.haveGeted];
    [_progressLab sizeToFit];
    //进度背景
    _progressNumLab.frame = CGRectMake(0, 0, 100 * [model.haveGeted floatValue] / (float)100, 19 * self.numSingleVersion);
    _progressNumLab.clipsToBounds = YES;
    //优惠图
    [_privilegeImg sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@""]];
    //黄色钱数
    _yellowMineyLab.text = [NSString stringWithFormat:@"￥ %@",model.ysMoney];
    //满多少keyong
    _fullMoneyLab.text = [NSString stringWithFormat:@"满%@可用",model.startMoney];
    //店铺名
    _shopNameLab.text = model.userScope;
    //时间
    _timeLab.text = [NSString stringWithFormat:@"%@ -- %@",model.startTime,model.endTime];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
