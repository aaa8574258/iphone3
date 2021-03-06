//
//  OrderCenterFinishAndUnFinishCell.m
//  360du
//
//  Created by linghang on 15/8/14.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "OrderCenterFinishAndUnFinishCell.h"
#import "OrderCenterFinishModel.h"
@interface OrderCenterFinishAndUnFinishCell()
@property(nonatomic,strong)UILabel *nameLab;//姓名
@property(nonatomic,strong)UILabel *telLab;//手机号
@property(nonatomic,strong)UILabel *priceLab;//价格
@property(nonatomic,strong)UILabel *beginLab;//开始地点
@property(nonatomic,strong)UILabel *endLab;//结束地点

@end
@implementation OrderCenterFinishAndUnFinishCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    CGFloat width = self.allWidth;
    //姓名
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 10 * self.numSingleVersion, 50 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.nameLab.font = [UIFont systemFontOfSize:14];
    self.nameLab.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.nameLab];
    //电话
    UIView *telView = [[UIView alloc] initWithFrame:CGRectMake(70 * self.numSingleVersion, 5 * self.numSingleVersion, 100 * self.numSingleVersion, 20 * self.numSingleVersion)];
    telView.layer.borderWidth = 1 * self.numSingleVersion;
    telView.layer.borderColor = [SMSColor(153, 153, 153) CGColor];
    [self.contentView addSubview:telView];
    
    self.telLab = [[UILabel alloc] initWithFrame:telView.bounds];
    self.telLab.textAlignment = NSTextAlignmentCenter;
    [telView addSubview:self.telLab];
    self.telLab.font = [UIFont systemFontOfSize:14];
    //价格
    self.priceLab = [[UILabel alloc] initWithFrame:CGRectMake(width - 100 * self.numSingleVersion, 10 * self.numSingleVersion, 40 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.priceLab.font = [UIFont systemFontOfSize:13];
    self.priceLab.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.priceLab];
    //源地
    self.beginLab = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 30 * self.numSingleVersion, width - 5 * self.numSingleVersion - 50 * self.numSingleVersion, 17 * self.numSingleVersion)];
    self.beginLab.font = [UIFont systemFontOfSize:14];
    self.beginLab.textColor = [UIColor redColor];
    [self.contentView addSubview:self.beginLab];
    //目的地
    self.endLab = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 55 * self.numSingleVersion, width - 5 * self.numSingleVersion - 50 * self.numSingleVersion, 17 * self.numSingleVersion)];
    self.endLab.font = [UIFont systemFontOfSize:14];
    self.endLab.textColor = [UIColor redColor];
    [self.contentView addSubview:self.endLab];
    //状态按钮
    self.statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.statusBtn.frame = CGRectMake(width - 60 * self.numSingleVersion, 30 * self.numSingleVersion, 50 * self.numSingleVersion, 40 * self.numSingleVersion);
    [self.contentView addSubview:self.statusBtn];
    self.statusBtn.layer.borderWidth = 1 * self.numSingleVersion;
    self.statusBtn.layer.borderColor = [SMSColor(211, 211, 211) CGColor];
    [self.statusBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.statusBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.statusBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.statusBtn setTitle:@"未完成" forState:UIControlStateNormal];

}

- (void)refreshUI:(OrderCenterFinishModel *)model andRow:(NSInteger)row andSection:(NSInteger)section{
    //名称
    self.nameLab.text = model.consignee;
    //电话
    self.telLab.text = model.phone;
    //价格
    self.priceLab.text = [NSString stringWithFormat:@"￥:%@",model.totalPrice];
    //起始地
    self.beginLab.text = [NSString stringWithFormat:@"从:%@",model.businessAddress];
    //目的地
    self.endLab.text = [NSString stringWithFormat:@"到:%@",model.goalAddress];
    //起始地
    NSMutableAttributedString *beginStr = [[NSMutableAttributedString alloc] initWithString:self.beginLab.text];
    [beginStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
    self.beginLab.attributedText = beginStr;
    //目的地
    NSMutableAttributedString *destationStr = [[NSMutableAttributedString alloc] initWithString:self.endLab.text];
    [destationStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
    self.endLab.attributedText = destationStr;
    //状态按钮
    [self.statusBtn setTitle:model.isSendedName forState:UIControlStateNormal];
    self.statusBtn.tag = 10000 + 1000 * section + row;
    if (section == 2) {
        NSString *statusStr = nil;
        if (model.sendStatus.integerValue == 1) {
            statusStr = @"未抢";
        }else if (model.sendStatus.integerValue == 2){
            statusStr = @"延迟";
        }else if (model.sendStatus.integerValue == 3){
            statusStr = @"推送";
        }else if (model.sendStatus.integerValue == 4){
            statusStr = @"已抢";
        }else if (model.sendStatus.integerValue == 5){
            statusStr = @"已取货";
        }if (model.sendStatus.integerValue == 6) {
            statusStr = @"已完成";
        }
        [self.statusBtn setTitle:statusStr forState:UIControlStateNormal];
    }else if (section == 3){
        [self.statusBtn setTitle:@"抢" forState:UIControlStateNormal];
        self.statusBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.statusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.statusBtn setBackgroundColor:[UIColor redColor]];
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
