//
//  AutoRobOrderCell.m
//  360du
//
//  Created by linghang on 15/8/15.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "AutoRobOrderCell.h"
#import "AtOnceRobModel.h"
@interface AutoRobOrderCell()
@property(nonatomic,strong)UILabel *beginLab;//开始地点
@property(nonatomic,strong)UILabel *endLab;//结束地点
@property(nonatomic,strong)UIButton *statusBtn;//状态按钮
@end
@implementation AutoRobOrderCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
    
}
- (void)makeUI{
   CGFloat width = self.allWidth;
    //源地
    self.beginLab = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 5 * self.numSingleVersion, width - 5 * self.numSingleVersion - 50 * self.numSingleVersion, 17 * self.numSingleVersion)];
    self.beginLab.font = [UIFont systemFontOfSize:14];
    self.beginLab.textColor = [UIColor redColor];
    [self.contentView addSubview:self.beginLab];
    //目的地
    self.endLab = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 25 * self.numSingleVersion, width - 5 * self.numSingleVersion - 50 * self.numSingleVersion, 17 * self.numSingleVersion)];
    self.endLab.font = [UIFont systemFontOfSize:14];
    self.endLab.textColor = [UIColor redColor];
    [self.contentView addSubview:self.endLab];
    //状态按钮
    self.statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.statusBtn.frame = CGRectMake(width - 60 * self.numSingleVersion, 5 * self.numSingleVersion, 50 * self.numSingleVersion, 40 * self.numSingleVersion);
    [self.contentView addSubview:self.statusBtn];
    self.statusBtn.layer.borderWidth = 1 * self.numSingleVersion;
    self.statusBtn.layer.borderColor = [SMSColor(211, 211, 211) CGColor];
    [self.statusBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.statusBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.statusBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.statusBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.statusBtn addTarget:self action:@selector(statusBtnDown:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)statusBtnDown:(UIButton *)statusBtn{
    
}
- (void)refeshModel:(AutoRobModel *)model andSection:(NSInteger)section{
    //section：1，调用抢单中心，2，调用申请小区抢单
    if(section == 1){
        //起始地
        
        self.beginLab.text = [NSString stringWithFormat:@"从:%@",model.shopName];
        //目的地
        self.endLab.text = [NSString stringWithFormat:@"到:%@",model.companyAddress];
        //开始
        NSMutableAttributedString *beginStr = [[NSMutableAttributedString alloc] initWithString:self.beginLab.text];
        [beginStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
        self.beginLab.attributedText = beginStr;
        //目的地
        NSMutableAttributedString *destationStr = [[NSMutableAttributedString alloc] initWithString:self.endLab.text];
        [destationStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
        self.endLab.attributedText = destationStr;
    }else if (section == 2){
        CGFloat width = self.allWidth;
        self.beginLab.text = [NSString stringWithFormat:@"小区:%@",model.xqname];
        self.endLab.text = [NSString stringWithFormat:@"地址:%@",model.xqAddress];
        self.endLab.frame = CGRectMake(5 * self.numSingleVersion, 25 * self.numSingleVersion, width - 5 * self.numSingleVersion - 50 * self.numSingleVersion, 40 * self.numSingleVersion);
        [self.statusBtn setTitle:model.sqStatusName forState:UIControlStateNormal];
        self.statusBtn.frame = CGRectMake(width - 60 * self.numSingleVersion, (self.frame.size.height - 40 * self.numSingleVersion) / 2, 50 * self.numSingleVersion, 40 * self.numSingleVersion);
        self.endLab.numberOfLines = 2;
        //开始
        NSMutableAttributedString *beginStr = [[NSMutableAttributedString alloc] initWithString:self.beginLab.text];
        [beginStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,3)];
        self.beginLab.attributedText = beginStr;
        //目的地
        NSMutableAttributedString *destationStr = [[NSMutableAttributedString alloc] initWithString:self.endLab.text];
        [destationStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,3)];
        self.endLab.attributedText = destationStr;
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
