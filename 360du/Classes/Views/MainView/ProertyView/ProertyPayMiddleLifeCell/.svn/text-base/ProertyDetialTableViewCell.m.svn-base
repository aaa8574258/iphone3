//
//  ProertyDetialTableViewCell.m
//  360du
//
//  Created by 利美 on 16/5/18.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ProertyDetialTableViewCell.h"

@implementation ProertyDetialTableViewCell

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
    self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(15*self.numSingleVersion , 20*self.numSingleVersion, 60*self.numSingleVersion, 60*self.numSingleVersion)];
    [self.contentView addSubview:self.imageView1];
    
    self.pbIDlabel  = [[UILabel alloc] initWithFrame:CGRectMake(80*self.numSingleVersion, 10*self.numSingleVersion, self.allWidth - 80*self.numSingleVersion - 10*self.numSingleVersion, 20*self.numSingleVersion)];
    self.contentlabel  = [[UILabel alloc] initWithFrame:CGRectMake(80*self.numSingleVersion, 27*self.numSingleVersion, self.allWidth - 80*self.numSingleVersion - 10*self.numSingleVersion, 50*self.numSingleVersion)];
    self.statuslabel  = [[UILabel alloc] initWithFrame:CGRectMake(80*self.numSingleVersion, 72*self.numSingleVersion, self.allWidth - 80*self.numSingleVersion - 10*self.numSingleVersion, 20*self.numSingleVersion)];
    self.pbIDlabel.textColor = [UIColor lightGrayColor];
    self.statuslabel.textColor = [UIColor lightGrayColor];
    self.contentlabel.textColor = [UIColor redColor];
    self.contentlabel.font = [UIFont systemFontOfSize:13 *self.numSingleVersion];
    self.pbIDlabel.font = [UIFont systemFontOfSize:13 *self.numSingleVersion];

    self.statuslabel.font = [UIFont systemFontOfSize:13 *self.numSingleVersion];

    self.contentlabel.numberOfLines = 3;
    [self.contentView addSubview:self.pbIDlabel];
    [self.contentView addSubview:self.contentlabel];
    [self.contentView addSubview:self.statuslabel];

}

@end
