//
//  JfDhListTableViewCell.m
//  360du
//
//  Created by 利美 on 17/3/15.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "JfDhListTableViewCell.h"

@implementation JfDhListTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}


-(void) makeUI{
    self.dhLab  = [[UILabel alloc] initWithFrame:CGRectZero];
    self.dhLab.textColor = SMSColor(51, 51, 51);
    self.dhLab.font = [UIFont systemFontOfSize:17 *self.numSingleVersion];
    [self.contentView addSubview:self.dhLab];
    
    self.zfFlagLab  = [[UILabel alloc] initWithFrame:CGRectZero];
    self.zfFlagLab.textColor = SMSColor(255, 138, 79);
    self.zfFlagLab.font = [UIFont systemFontOfSize:15 *self.numSingleVersion];
    [self.contentView addSubview:self.zfFlagLab];
    
    self.nameLab  = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLab.textColor = SMSColor(102, 102, 102);
    self.nameLab.font = [UIFont systemFontOfSize:15 *self.numSingleVersion];
    [self.contentView addSubview:self.nameLab];
    
    self.dNameLab  = [[UILabel alloc] initWithFrame:CGRectZero];
    self.dNameLab.textColor = SMSColor(51, 51, 51);
    self.dNameLab.font = [UIFont systemFontOfSize:16 *self.numSingleVersion];
    [self.contentView addSubview:self.dNameLab];
    
    
    self.JfLab  = [[UILabel alloc] initWithFrame:CGRectZero];
    self.JfLab.textColor = SMSColor(102, 102, 102);
    self.JfLab.font = [UIFont systemFontOfSize:16 *self.numSingleVersion];
    [self.contentView addSubview:self.JfLab];
    
    self.numberLab  = [[UILabel alloc] initWithFrame:CGRectZero];
    self.numberLab.textColor = SMSColor(102, 102, 102);
    self.numberLab.font = [UIFont systemFontOfSize:16 *self.numSingleVersion];
    [self.contentView addSubview:self.numberLab];
    
    self.JmLab  = [[UILabel alloc] initWithFrame:CGRectZero];
    self.JmLab.textColor = SMSColor(255, 138, 79);
    self.JmLab.font = [UIFont systemFontOfSize:15 *self.numSingleVersion];
    [self.contentView addSubview:self.JmLab];
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75 * self.numSingleVersion, 75 * self.numSingleVersion)];
    self.imageV.center = CGPointMake(47.5 * self.numSingleVersion, 92 * self.numSingleVersion);
    [self.contentView addSubview:self.imageV];
    
    self.line1 = [[UIView alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 45 * self.numSingleVersion, WIDTH_CONTENTVIEW - 20 *self.numSingleVersion, 0.5 * self.numSingleVersion)];
    _line1.backgroundColor = SMSColor(204, 204, 204);
    [self.contentView addSubview:self.line1];
    
    
    self.line2 = [[UIView alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 184 *self.numSingleVersion - 45 * self.numSingleVersion, WIDTH_CONTENTVIEW - 20 *self.numSingleVersion, 0.5 * self.numSingleVersion)];
    _line2.backgroundColor = SMSColor(204, 204, 204);
    [self.contentView addSubview:self.line2];
}



-(void)setModel:(JfDhListModel *)model{
    self.dhLab.frame = CGRectMake(10 *self.numSingleVersion, 10 * self.numSingleVersion, self.contentView.frame.size.width - 200 *self.numSingleVersion, 30);
    self.dhLab.text = [NSString stringWithFormat:@"订单号: %@",model.exchange_id];
    [self.dhLab sizeToFit];
    
    self.nameLab.frame = CGRectMake( 95 * self.numSingleVersion, 57 * self.numSingleVersion, self.contentView.frame.size.width - 150 * self.numSingleVersion, 30);
    self.nameLab.text = model.proName;
    [self.nameLab sizeToFit];
    
    self.dNameLab.frame = CGRectMake(95 * self.numSingleVersion, self.nameLab.frame.size.height + self.nameLab.frame.origin.y + 10 *self.numSingleVersion, self.contentView.frame.size.width - 150 * self.numSingleVersion, 30);
    self.dNameLab.text = model.proSource;
    [self.dNameLab sizeToFit];
    
    self.JfLab.frame = CGRectMake(95 *self.numSingleVersion, self.dNameLab.frame.origin.y + self.dNameLab.frame.size.height + 20 *self.numSingleVersion, self.contentView.frame.size.width - 150 * self.numSingleVersion, 30);
    self.JfLab.text = [NSString stringWithFormat:@"%@ 积分",model.proIntegral];
    [self.JfLab sizeToFit];
    
    self.numberLab .frame= CGRectZero;
    self.numberLab.center = CGPointMake(self.contentView.frame.size.width - 25 * self.numSingleVersion, 90 * self.numSingleVersion);
    self.numberLab.text = [NSString stringWithFormat:@"x%@",model.proCount];
    [self.numberLab sizeToFit];
    
    self.JmLab.frame = CGRectMake(10 *self.numSingleVersion, 184 * self.numSingleVersion - 30 *self.numSingleVersion , self.contentView.frame.size.width - 200 *self.numSingleVersion, 30 *self.numSingleVersion);
    _JmLab.text = [NSString stringWithFormat:@"卷码 %@",model.redemption];
    [_JmLab sizeToFit];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    

}


















@end
