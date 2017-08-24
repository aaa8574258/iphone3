//
//  PushNotificationCell.m
//  360du
//
//  Created by 利美 on 16/12/9.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "PushNotificationCell.h"

@implementation PushNotificationCell

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
    self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 60 * self.numSingleVersion, 30 *self.numSingleVersion)];
    self.timeLab.font = [UIFont systemFontOfSize:13 *self.numSingleVersion];
    self.timeLab.textColor = [UIColor lightGrayColor];
    self.timeLab.center = CGPointMake(40 *self.numSingleVersion, 35 *self.numSingleVersion);
    [self.contentView addSubview:self.timeLab];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(80 *self.numSingleVersion, 8 *self.numSingleVersion, 280 *self.numSingleVersion, 30)];
    self.titleLab.font = [UIFont systemFontOfSize:15 *self.numSingleVersion];
    self.titleLab.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLab];
    
    self.messageLab = [[UILabel alloc] initWithFrame:CGRectMake(80 *self.numSingleVersion, 33 *self.numSingleVersion, 280 *self.numSingleVersion, 30)];
    self.messageLab.font = [UIFont systemFontOfSize:14 *self.numSingleVersion];
    self.messageLab.textColor = [UIColor blackColor];
//    self.messageLab.backgroundColor = [UIColor redColor];
    self.dianV = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, 8 *self.numSingleVersion , 8 *self.numSingleVersion)];
    self.dianV.layer.masksToBounds = YES;
    self.dianV.layer.cornerRadius = 4 * self.numSingleVersion;
    self.dianV.backgroundColor = [UIColor redColor];
    self.dianV.center = CGPointMake(365 * self.numSingleVersion, 35 *self.numSingleVersion);
    [self.contentView addSubview:self.dianV];
    
    
    
    [self.contentView addSubview:self.messageLab];
}
@end
