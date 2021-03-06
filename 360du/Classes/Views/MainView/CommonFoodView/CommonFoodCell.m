//
//  CommonFoodCell.m
//  360du
//
//  Created by linghang on 15-4-18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "CommonFoodCell.h"
#import "CommomFoodModel.h"
#import "UIImageView+WebCache.h"
#import "FoodCommonViewController.h"
@implementation CommonFoodCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.numSingleVersion = [VersionTranlate returnVersionRateAnyIphone:WIDTH_CONTENTVIEW];
    }
    return self;
}
-(void)makeUI{

    //图片
    self.leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(15 * self.numSingleVersion, 20 * self.numSingleVersion, 71 * self.numSingleVersion, 54 * self.numSingleVersion)];
    [self.contentView addSubview:self.leftImg];
    //标题
    self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(96 * self.numSingleVersion, 20 * self.numSingleVersion, 300, 20 * self.numSingleVersion)];
    self.titleLable.font = [UIFont systemFontOfSize:16 * self.numSingleVersion];
    [self addSubview:self.titleLable];
   
    //价格
    self.priceUsualLable = [[UILabel alloc] initWithFrame:CGRectMake(96 * self.numSingleVersion, self.contentView.frame.size.height - 20 * self.numSingleVersion, 300, 15 * self.numSingleVersion)];
    self.priceUsualLable.font = [UIFont systemFontOfSize:10 * self.numSingleVersion];
    [self.contentView addSubview:self.priceUsualLable];
    self.priceUsualLable.textColor = [UIColor lightGrayColor];
    
    self.sendTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.sendTimeLab.font = [UIFont systemFontOfSize:13 * self.numSingleVersion];
    [self.contentView addSubview:self.sendTimeLab];
    self.sendTimeLab.textColor = [UIColor redColor];
    self.sendTimeLab.center = CGPointMake(self.contentView.frame.size.width - 80 *self.numSingleVersion, self.contentView.frame.size.height/2);
    self.sendTimeLab.textAlignment = NSTextAlignmentRight;
    
    //星星背景图
//    self.backStarImg = [[UIImageView alloc] initWithFrame:CGRectMake(60 * self.numSingleVersion, 22 * self.numSingleVersion, 100 * self.numSingleVersion, 20 * self.numSingleVersion)];
//    self.backStarImg.image = [UIImage imageNamed:@"StarsBackground.png"];
//    [self.contentView addSubview:self.backStarImg];
    
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *starImg = [[UIImageView alloc] initWithFrame:CGRectMake(96 * self.numSingleVersion + 3 * self.numSingleVersion + 15 * self.numSingleVersion * i,  45 * self.numSingleVersion , 10 * self.numSingleVersion, 10 * self.numSingleVersion)];
        starImg.image = [UIImage imageNamed:@"xing03"];
        [self.contentView addSubview:starImg];
    }
    //星星显示图
//    self.foreStarImg = [[UIImageView alloc] initWithFrame:CGRectMake(60 * self.numSingleVersion, 22 * self.numSingleVersion, 100 * self.numSingleVersion, 20 * self.numSingleVersion)];
//    self.foreStarImg.image = [UIImage imageNamed:@"StarsForeground.png"];
//    [self.contentView addSubview:self.foreStarImg];
//    self.foreStarImg.clipsToBounds = YES;
//    self.foreStarImg.contentMode = UIViewContentModeLeft;
    //销售数量
    self.countLable = [[UILabel alloc] initWithFrame:CGRectMake(96 * self.numSingleVersion + 3 * self.numSingleVersion + 15 * self.numSingleVersion * 5 + 10 * self.numSingleVersion, 45 * self.numSingleVersion , 200 * self.numSingleVersion, 10 * self.numSingleVersion)];
    self.countLable.font = [UIFont systemFontOfSize:13 * self.numSingleVersion];
    self.countLable.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.countLable];
    
    //图片付
    self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.payBtn.frame = CGRectMake((60 + 50) * self.numSingleVersion + self.titleLable.frame.size.width + 10 * self.numSingleVersion, 20 * self.numSingleVersion, 20 * self.numSingleVersion, 15 * self.numSingleVersion);
    [self.payBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.payBtn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.payBtn setImage:[UIImage imageNamed:@"fu.png"] forState:UIControlStateNormal];
    self.payBtn.tag = 1900 + self.row;
    [self.contentView addSubview:self.payBtn];
    //图片票
    self.ticketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ticketBtn.frame = CGRectMake((60 + 50) * self.numSingleVersion + self.titleLable.frame.size.width + 10 * self.numSingleVersion + 30 * self.numSingleVersion, 5 * self.numSingleVersion, 20 * self.numSingleVersion, 15 * self.numSingleVersion);
    [self.ticketBtn setImage:[UIImage imageNamed:@"piao.png"] forState:UIControlStateNormal];
    [self.ticketBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.ticketBtn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
    self.ticketBtn.tag = 1800 + self.row;
    [self.contentView addSubview:self.ticketBtn];
    
    //优惠详情
    for (NSInteger i = 0; i < self.privilegeArr.count; i++) {
//        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(60 * self.numSingleVersion + 30 * self.numSingleVersion * i, 42 * self.numSingleVersion + 15 * self.numSingleVersion + 10 * self.numSingleVersion, 20 * self.numSingleVersion, 15 * self.numSingleVersion)];
//        //lable.text = @"优";
//        lable.tag = 2400 + i;
//        lable.textColor = [UIColor lightGrayColor];
//        lable.font = [UIFont systemFontOfSize:12 * self.numSingleVersion];
//        [self.contentView addSubview:lable];
        UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake((60 + 50) * self.numSingleVersion + 20 * self.numSingleVersion * i, 40 * self.numSingleVersion + 15 * self.numSingleVersion + 10 * self.numSingleVersion + 15 * self.numSingleVersion, 15 * self.numSingleVersion, 15 * self.numSingleVersion)];
        [leftImg sd_setImageWithURL:[NSURL URLWithString:[self.privilegeArr[i] objectForKey:@"yhrul"]] placeholderImage:nil];
        [self.contentView addSubview:leftImg];
        
        
        if (i == self.privilegeArr.count - 1) {
            //优惠btn
            UIButton *privileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            privileBtn.frame = CGRectMake(self.privilegeArr.count * 20 * self.numSingleVersion + (60 + 20) * self.numSingleVersion, 42 * self.numSingleVersion + 15 * self.numSingleVersion + 10 * self.numSingleVersion + 15 * self.numSingleVersion, 200 * self.numSingleVersion, 15 * self.numSingleVersion);
            [privileBtn setTitle:@"优惠详情" forState:UIControlStateNormal];
            [privileBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
            privileBtn.titleLabel.font = [UIFont systemFontOfSize:12 * self.numSingleVersion];
            privileBtn.tag = 1600 + self.row;
            [privileBtn addTarget:self action:@selector(privileBtnDown:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:privileBtn];
        }
    }

    if (self.privilegeBtnState) {
        //可以展示下边
        self.priviegeStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 42 * self.numSingleVersion + 15 * self.numSingleVersion + 10 * self.numSingleVersion + 5 * self.numSingleVersion + 10 * self.numSingleVersion, WIDTH_CONTENTVIEW, self.privilegeArr.count * 40 * self.numSingleVersion)];
        [self.contentView addSubview:self.priviegeStateView];
        for (NSInteger i = 0; i < self.privilegeArr.count; i++) {
            UILabel *priLable = [[UILabel alloc] initWithFrame:CGRectMake(25 * self.numSingleVersion, 15 * self.numSingleVersion + 25 * self.numSingleVersion * i, WIDTH_CONTENTVIEW - 50 * self.numSingleVersion, 15 * self.numSingleVersion)];
            priLable.text = [self.privilegeArr[i] objectForKey:@"content"];
            priLable.textColor =[UIColor lightGrayColor];
            priLable.font = [UIFont systemFontOfSize:13];
            [self.priviegeStateView addSubview:priLable];
            
            UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 15 * self.numSingleVersion + 25 * self.numSingleVersion * i, 15 * self.numSingleVersion, 15 * self.numSingleVersion)];
            [leftImg sd_setImageWithURL:[NSURL URLWithString:[self.privilegeArr[i] objectForKey:@"yhrul"]] placeholderImage:nil];
            [self.priviegeStateView addSubview:leftImg];
        }
        
    }else{
        //不可以展示下边
        for (id temp in self.priviegeStateView.subviews) {
            [temp removeFromSuperview];
        }
        [self.priviegeStateView removeFromSuperview];
    }
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.allWidth, 1)];
    lineLab.backgroundColor = SMSColor(211, 211, 211);
    [self.contentView addSubview:lineLab];
}

-(void)makeTheCleanerCellUI{
    //图片
    self.leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 5 * self.numSingleVersion, (50 + 50) * self.numSingleVersion, 70 * self.numSingleVersion)];
    [self.contentView addSubview:self.leftImg];
    //标题
    self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake((60 + 50) * self.numSingleVersion, 5 * self.numSingleVersion, 300, 15 * self.numSingleVersion)];
    self.titleLable.font = [UIFont systemFontOfSize:16 * self.numSingleVersion];
    [self addSubview:self.titleLable];
    
    //距离
    self.priceUsualLable = [[UILabel alloc] initWithFrame:CGRectMake((60 + 50) * self.numSingleVersion, 60 * self.numSingleVersion, 300, 15 * self.numSingleVersion)];
    self.priceUsualLable.font = [UIFont systemFontOfSize:13 * self.numSingleVersion];
    [self.contentView addSubview:self.priceUsualLable];
    self.priceUsualLable.textColor = [UIColor lightGrayColor];
}






//票、付
-(void)btnDown:(UIButton *)btn{
    
}
-(void)privileBtnDown:(UIButton *)privileBtn{
    if ([self.target isKindOfClass:[FoodCommonViewController class]]) {
        [self.target returnPrivilege:privileBtn.tag - 1600];
    }
}
-(void)refreshUI:(CommomFoodModel *)model{
    NSLog(@"%@",model.sendtime);
    self.sendTimeLab.text = [NSString stringWithFormat:@"%@分钟送达",model.sendtime];
    self.leftImg.image = [UIImage imageNamed:@"001.png"];
    [self.leftImg sd_setImageWithURL:[NSURL URLWithString:model.indeximg] placeholderImage:[UIImage imageNamed:@"001.png"]];
    self.titleLable.text = model.name;
    [self.titleLable sizeToFit];
    //CGRectMake(100 * self.numSingleVersion + 5 * self.numSingleVersion, 22 * self.numSingleVersion, 100 * self.numSingleVersion, 20 * self.numSingleVersion)
    //星星的评价
    float starNum = model.evaluate.floatValue;
//    CGRectMake(60 * self.numSingleVersion + 3 * self.numSingleVersion + 15 * self.numSingleVersion * i,  22 * self.numSingleVersion, 15 * self.numSingleVersion, 15 * self.numSingleVersion)];
//    starImg.image = [UIImage imageNamed:@"xing02"];
   // [self.contentView addSubview:starImg];
    for (NSInteger i = 0; i < starNum; i++) {
        UIImageView *starFlImg = [[UIImageView alloc] initWithFrame:CGRectMake(96 * self.numSingleVersion + 3 * self.numSingleVersion + 15 * self.numSingleVersion * i,  45 * self.numSingleVersion , 10 * self.numSingleVersion, 10 * self.numSingleVersion)];
        starFlImg.image = [UIImage imageNamed:@"xing02"];
        [self.contentView addSubview:starFlImg];
    }
    if (starNum > (NSInteger)starNum) {
        UIImageView *starFlImg = [[UIImageView alloc] initWithFrame:CGRectMake(96 * self.numSingleVersion + 3 * self.numSingleVersion + 15 * self.numSingleVersion * (NSInteger)starNum,  45 * self.numSingleVersion , 10 * self.numSingleVersion, 10 * self.numSingleVersion)];
        starFlImg.image = [UIImage imageNamed:@"xing01"];
        [self.contentView addSubview:starFlImg];
    }
////    38 * 36
//    self.foreStarImg.frame = CGRectMake(60 * self.numSingleVersion,  22 * self.numSingleVersion, 100 * self.numSingleVersion * starNum / 5.0, 20 * self.numSingleVersion);
    //销售数量
    self.countLable.text = [NSString stringWithFormat:@"已售%@份",model.sendCount];
    //起送价
    self.priceUsualLable.text = [NSString stringWithFormat:@"起送价:%@元  配送价:%@元",model.startSendPrice,model.sendPrice];
    /**
     *  
     */
//    self.priceUsualLable.textColor = [UIColor redColor];
    //判断是不是图片付、票
//    if(model.isFa){
//        self.ticketBtn.hidden = NO;
//    }else{
//        self.ticketBtn.hidden = YES;
//    }
//    if (model.isFu) {
//        self.payBtn.hidden = NO;
//    }else{
//        self.payBtn.hidden = YES;
//    }
//    if (model.isFa && model.isFu) {
//        self.payBtn.frame = CGRectMake((60 + 50) * self.numSingleVersion + self.titleLable.frame.size.width + 10 * self.numSingleVersion, 5 * self.numSingleVersion, 20 * self.numSingleVersion, 15 * self.numSingleVersion);
//        self.ticketBtn.frame = CGRectMake((60 + 50) * self.numSingleVersion + self.titleLable.frame.size.width + 10 * self.numSingleVersion + 30 * self.numSingleVersion, 5 * self.numSingleVersion, 20 * self.numSingleVersion, 15 * self.numSingleVersion);
//
//    }else if (model.isFu && !model.isFa){
//        self.payBtn.frame = CGRectMake((60 + 50) * self.numSingleVersion + self.titleLable.frame.size.width + 10 * self.numSingleVersion, 5 * self.numSingleVersion, 20 * self.numSingleVersion, 15 * self.numSingleVersion);
//
//    }else if (model.isFa && !model.isFu){
//        self.ticketBtn.frame = CGRectMake((60 + 50) * self.numSingleVersion + self.titleLable.frame.size.width + 10 * self.numSingleVersion, 5 * self.numSingleVersion, 20 * self.numSingleVersion, 15 * self.numSingleVersion);
//
//    }
    
//    //展示优惠
//    for (NSInteger i = 0; i < model.yhdetail.count; i++) {
//        UILabel *lable = (UILabel *)[self  viewWithTag:2400 + i];
//        lable.text = [model.yhdetail[i] objectForKey:@"type"];
//    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
