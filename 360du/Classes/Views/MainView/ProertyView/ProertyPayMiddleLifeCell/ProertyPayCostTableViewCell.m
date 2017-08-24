//
//  ProertyPayCostTableViewCell.m
//  360du
//
//  Created by 利美 on 16/10/21.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ProertyPayCostTableViewCell.h"

@implementation ProertyPayCostTableViewCell

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
-(void)makeUI{
    self.weakLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.weakLabel.font = [UIFont systemFontOfSize:15 *self.numSingleVersion];
    self.weakLabel.center = CGPointMake(30 * self.numSingleVersion, 15 * self.numSingleVersion);
//    self.weakLabel.backgroundColor = [UIColor redColor];
    self.weakLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.contentView addSubview:self.weakLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.timeLabel.font = [UIFont systemFontOfSize:12 * self.numSingleVersion];
//    [self.timeLabel sizeToFit];
    self.timeLabel.center = CGPointMake(30 * self.numSingleVersion, 38 * self.numSingleVersion);
    self.timeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.contentView addSubview:self.timeLabel];
    
    self.imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45 * self.numSingleVersion, 45* self.numSingleVersion)];
    self.imageview.center = CGPointMake(110 *self.numSingleVersion, 70/2 * self.numSingleVersion);
    [self.contentView addSubview:self.imageview];
    
    self.picelabel = [[UILabel alloc] initWithFrame:CGRectMake(160 * self.numSingleVersion, 15 *self.numSingleVersion, 200 *self.numSingleVersion, 20)];
    self.picelabel.font = [UIFont systemFontOfSize:16 * self.numSingleVersion];
//    [self.picelabel sizeToFit];
    [self.contentView addSubview:self.picelabel];
    
    self.oderLabel = [[UILabel alloc] initWithFrame:CGRectMake(160 *self.numSingleVersion, 35 *self.numSingleVersion, 200 *self.numSingleVersion, 20 *self.numSingleVersion)];
    self.oderLabel.font = [UIFont systemFontOfSize:12 * self.numSingleVersion];
    self.oderLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
//    [self.oderLabel sizeToFit];
    [self.contentView addSubview:self.oderLabel];
    
    self.xqName = [[UILabel alloc] initWithFrame:CGRectMake(160 *self.numSingleVersion, 55 *self.numSingleVersion, 200 *self.numSingleVersion, 20 *self.numSingleVersion)];
    self.xqName.font = [UIFont systemFontOfSize:12 * self.numSingleVersion];
    self.xqName.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    //    [self.oderLabel sizeToFit];
    [self.contentView addSubview:self.xqName];
    self.cjText = [[UILabel alloc] initWithFrame:CGRectMake(160 *self.numSingleVersion, 75 *self.numSingleVersion, 200 *self.numSingleVersion, 20 *self.numSingleVersion)];
    self.cjText.font = [UIFont systemFontOfSize:12 * self.numSingleVersion];
    self.cjText.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    //    [self.oderLabel sizeToFit];
    [self.contentView addSubview:self.cjText];
    self.cjTime = [[UILabel alloc] initWithFrame:CGRectMake(160 *self.numSingleVersion, 95 *self.numSingleVersion, 200 *self.numSingleVersion, 20 *self.numSingleVersion)];
    self.cjTime.font = [UIFont systemFontOfSize:12 * self.numSingleVersion];
    self.cjTime.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    //    [self.oderLabel sizeToFit];
    [self.contentView addSubview:self.cjTime];
    
    
}

@end
