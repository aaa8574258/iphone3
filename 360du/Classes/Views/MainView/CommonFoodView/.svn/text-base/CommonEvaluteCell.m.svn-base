//
//  CommonEvaluteCell.m
//  360du
//
//  Created by linghang on 15/8/27.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "CommonEvaluteCell.h"
#import "CommonEvaluateModel.h"
#import "UIImageView+WebCache.h"
@interface CommonEvaluteCell()
@property(nonatomic,strong)UIImageView *leftImg;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *contentLab;
@end
@implementation CommonEvaluteCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    //图片
    self.leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 5 * self.numSingleVersion, 30 * self.numSingleVersion, 30 * self.numSingleVersion)];
    self.leftImg.image = [UIImage imageNamed:@"geren01"];
    self.leftImg.layer.cornerRadius = 15 * self.numSingleVersion;
    [self.contentView addSubview:self.leftImg];
    //标题
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(50 * self.numSingleVersion, 5 * self.numSingleVersion, 100 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.nameLab.font = [UIFont systemFontOfSize:15 * self.numSingleVersion];
    [self.contentView addSubview:self.nameLab];
    
    
    //s时间
    self.timeLab = [[UILabel alloc] initWithFrame:CGRectZero];
    self.timeLab.font = [UIFont systemFontOfSize:13 * self.numSingleVersion];
    [self.contentView addSubview:self.timeLab];
    self.timeLab.textColor = [UIColor lightGrayColor];
    
    //星星背景图
    //    self.backStarImg = [[UIImageView alloc] initWithFrame:CGRectMake(60 * self.numSingleVersion, 22 * self.numSingleVersion, 100 * self.numSingleVersion, 20 * self.numSingleVersion)];
    //    self.backStarImg.image = [UIImage imageNamed:@"StarsBackground.png"];
    //    [self.contentView addSubview:self.backStarImg];
    
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *starImg = [[UIImageView alloc] initWithFrame:CGRectMake(50 * self.numSingleVersion + 15 * self.numSingleVersion * i,  22 * self.numSingleVersion, 15 * self.numSingleVersion, 15 * self.numSingleVersion)];
        starImg.image = [UIImage imageNamed:@"xing03"];
        [self.contentView addSubview:starImg];
    }
    //内容详情
    self.contentLab = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLab.font = [UIFont systemFontOfSize:13 * self.numSingleVersion];
    self.contentLab.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.contentLab];
    
    
}
- (void)refreahEvaluateModel:(CommonEvaluateModel *)mdoel{
    self.nameLab.text = mdoel.username;
    //星星的评价
    float starNum = mdoel.starcount.floatValue;
    for (NSInteger i = 0; i < starNum; i++) {
        UIImageView *starFlImg = [[UIImageView alloc] initWithFrame:CGRectMake(50 * self.numSingleVersion + 15 * self.numSingleVersion * i,  22 * self.numSingleVersion, 15 * self.numSingleVersion, 15 * self.numSingleVersion)];
        starFlImg.image = [UIImage imageNamed:@"xing02"];
        [self.contentView addSubview:starFlImg];
    }
    if (starNum > (NSInteger)starNum) {
        UIImageView *starFlImg = [[UIImageView alloc] initWithFrame:CGRectMake(60 * self.numSingleVersion + 15 * self.numSingleVersion * (NSInteger)starNum,  22 * self.numSingleVersion, 15 * self.numSingleVersion, 15 * self.numSingleVersion)];
        starFlImg.image = [UIImage imageNamed:@"xing01"];
        [self.contentView addSubview:starFlImg];
    }
    self.timeLab.text = mdoel.claddtime;
    [self.timeLab sizeToFit];
    self.timeLab.frame = CGRectMake(self.allWidth - 10 * self.numSingleVersion - self.timeLab.frame.size.width, 5 * self.numSingleVersion, self.timeLab.frame.size.width, 15 * self.numSingleVersion);
    
    self.contentLab.text = mdoel.pingjia;
    self.contentLab.frame = CGRectMake(50 * self.numSingleVersion, 40 * self.numSingleVersion, self.allWidth - 10 * self.numSingleVersion - 50 * self.numSingleVersion, self.height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
