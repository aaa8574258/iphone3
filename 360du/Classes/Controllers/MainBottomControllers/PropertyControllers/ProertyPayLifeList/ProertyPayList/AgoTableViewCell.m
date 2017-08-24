//
//  AgoTableViewCell.m
//  360du
//
//  Created by 利美 on 16/6/12.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "AgoTableViewCell.h"

@implementation AgoTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.numSingleVersion = [VersionTranlate returnVersionRateAnyIphone:WIDTH_CONTENTVIEW];
        [self makeIt];
     }
    return self;
}

-(void) makeIt{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 122*self.numSingleVersion, WIDTH_CONTENTVIEW, 274*self.numSingleVersion)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:view];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8*self.numSingleVersion, 8*self.numSingleVersion, 80*self.numSingleVersion, 25*self.numSingleVersion)];
    label.text = @"缴费单位:";
    label.font = [UIFont systemFontOfSize:15*self.numSingleVersion];
    [self.contentView addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(8*self.numSingleVersion, 46*self.numSingleVersion, 80*self.numSingleVersion, 25*self.numSingleVersion)];
    label1.text = @"付款人:";
    label1.font = [UIFont systemFontOfSize:15*self.numSingleVersion];

    [self.contentView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(8*self.numSingleVersion, 8*self.numSingleVersion, 80*self.numSingleVersion, 25*self.numSingleVersion)];
    label2.text = @"缴费明细:";
    label2.font = [UIFont systemFontOfSize:15*self.numSingleVersion];
    [view addSubview:label2];
    
   
    _firstlabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 126*self.numSingleVersion,8*self.numSingleVersion, 110*self.numSingleVersion, 30*self.numSingleVersion)];
//    _firstlabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_firstlabel];
    
    _secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 126*self.numSingleVersion,46*self.numSingleVersion, 110*self.numSingleVersion, 30*self.numSingleVersion)];
//    _secondLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_secondLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8*self.numSingleVersion,84*self.numSingleVersion, 250*self.numSingleVersion, 30*self.numSingleVersion)];
//    _timeLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_timeLabel];
    
    _areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,8*self.numSingleVersion, WIDTH_CONTENTVIEW, 30*self.numSingleVersion)];
    _areaLabel.textAlignment = UITextAlignmentRight;
//    _areaLabel.backgroundColor = [UIColor redColor];
    [view addSubview:_areaLabel];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,46*self.numSingleVersion, WIDTH_CONTENTVIEW, 30*self.numSingleVersion)];
    _userNameLabel.textAlignment = UITextAlignmentCenter;
//    _userNameLabel.backgroundColor = [UIColor redColor];
    [view addSubview:_userNameLabel];
    
    _cleaningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,84*self.numSingleVersion, WIDTH_CONTENTVIEW, 30*self.numSingleVersion)];
    _cleaningLabel.textAlignment = UITextAlignmentCenter;

//    _cleaningLabel.backgroundColor = [UIColor redColor];
    [view addSubview:_cleaningLabel];
    
    _safeFeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,122*self.numSingleVersion, WIDTH_CONTENTVIEW, 30*self.numSingleVersion)];
//    _safeFeeLabel.backgroundColor = [UIColor redColor];
    _safeFeeLabel.textAlignment = UITextAlignmentCenter;

    [view addSubview:_safeFeeLabel];
    
    _rubbishFeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,160*self.numSingleVersion, WIDTH_CONTENTVIEW, 30*self.numSingleVersion)];
//    _rubbishFeeLabel.backgroundColor = [UIColor redColor];
    _rubbishFeeLabel.textAlignment = UITextAlignmentCenter;

    [view addSubview:_rubbishFeeLabel];
    
    _wyFeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,198*self.numSingleVersion, WIDTH_CONTENTVIEW, 30*self.numSingleVersion)];
//    _wyFeeLabel.backgroundColor = [UIColor redColor];
    _wyFeeLabel.textAlignment = UITextAlignmentCenter;

    [view addSubview:_wyFeeLabel];
    
    _realFeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,236*self.numSingleVersion, WIDTH_CONTENTVIEW, 30*self.numSingleVersion)];
//    _realFeeLabel.backgroundColor = [UIColor redColor];
    _realFeeLabel.textAlignment = UITextAlignmentRight;

    [view addSubview:_realFeeLabel];
    
    _firstlabel.font = [UIFont systemFontOfSize:15*self.numSingleVersion];
    _secondLabel.font = [UIFont systemFontOfSize:15*self.numSingleVersion];
    _timeLabel.font = [UIFont systemFontOfSize:15*self.numSingleVersion];
    _areaLabel.font = [UIFont systemFontOfSize:15*self.numSingleVersion];
    _userNameLabel.font = [UIFont systemFontOfSize:15*self.numSingleVersion];
    _cleaningLabel.font = [UIFont systemFontOfSize:15*self.numSingleVersion];
    _safeFeeLabel.font = [UIFont systemFontOfSize:15*self.numSingleVersion];
    _rubbishFeeLabel.font = [UIFont systemFontOfSize:15*self.numSingleVersion];
    _wyFeeLabel.font = [UIFont systemFontOfSize:15*self.numSingleVersion];
    _realFeeLabel.font = [UIFont systemFontOfSize:15*self.numSingleVersion];

}

-(void)haveModel:(DetialInfoPropertyModel *)model{
    _firstlabel.text = model.getPayCompany;
    _secondLabel.text = model.payerName;
    _timeLabel.text = [NSString stringWithFormat:@"缴费账期:  %@--%@",model.startDate,model.endDate];
    _areaLabel.text = [NSString stringWithFormat:@"房屋面积:%@㎡",model.area];
    _userNameLabel.text = [NSString stringWithFormat:@"业主姓名:  %@",model.userName];
    _cleaningLabel.text = [NSString stringWithFormat:@"保洁费:  %@元",model.cleaningFee];
    _safeFeeLabel.text = [NSString stringWithFormat:@"治安费:  %@元",model.safeFee];
    _rubbishFeeLabel.text = [NSString stringWithFormat:@"垃圾清理费:  %@元",model.rubbishFee];
    _wyFeeLabel.text = [NSString stringWithFormat:@"物业费:  %@元",model.wyFee];
    _realFeeLabel.text = [NSString stringWithFormat:@"缴费金额:%@",model.realFee];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
