//
//  JfIconListTableViewCell.m
//  360du
//
//  Created by 利美 on 17/3/15.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "JfIconListTableViewCell.h"
#import "VersionTranlate.h"
@implementation JfIconListTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%f",self.window.bounds.size.width);
        self.numSingleVersion = [VersionTranlate returnVersionRateAnyIphone:self.window.bounds.size.width];
        
        [self makeUI];
    }
    return self;
}

-(void) makeUI{
    self.firstLab = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.numSingleVersion,113 * self.numSingleVersion, self.contentView.frame.size.width, 30 * self.numSingleVersion)];
//    titLab.text = title;
    self.firstLab.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
//    [titLab sizeToFit];
    self.firstLab.font = [UIFont systemFontOfSize:12 *self.numSingleVersion];

    [self.contentView addSubview:self.firstLab];
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.numSingleVersion, 113 * self.numSingleVersion + self.firstLab.frame.size.height + 10 *self.numSingleVersion, 168 * self.numSingleVersion, 50 * self.numSingleVersion)];
//    moneyLab.text = money;
    moneyLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
//    [moneyLab sizeToFit];
    moneyLab.font = [UIFont systemFontOfSize:15 *self.numSingleVersion];
    moneyLab.numberOfLines = 2;
    self.secLab = moneyLab;

    [self.contentView addSubview:moneyLab];
    UILabel *jfLab = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.numSingleVersion,moneyLab.frame.origin.y + moneyLab.frame.size.height + 10 * self.numSingleVersion, 80 * self.numSingleVersion, 30 * self.numSingleVersion)];
    
//    jfLab.text = [NSString stringWithFormat:@"%@积分",jf];
    jfLab.textColor = [UIColor colorWithRed:255/255.0 green:122/255.0 blue:63/255.0 alpha:1];
//    [jfLab sizeToFit];
    jfLab.font = [UIFont systemFontOfSize:15 *self.numSingleVersion];
    self.thirdLab = jfLab;

    [self.contentView addSubview:jfLab];
//    UILabel *youLab = [[UILabel alloc] initWithFrame:CGRectMake(jfLab.frame.origin.x + jfLab.frame.size.width + 10 * self.numSingleVersion,jfLab.frame.origin.y, self.contentView.frame.size.width/2, 30 * self.numSingleVersion)];
////    youLab.text = [NSString stringWithFormat:@" %@包邮",you];
//    youLab.textColor = [UIColor colorWithRed:255/255.0 green:122/255.0 blue:63/255.0 alpha:1];
////    [youLab sizeToFit];
//    youLab.font = [UIFont systemFontOfSize:11 *self.numSingleVersion];
//    youLab.textAlignment = NSTextAlignmentCenter;
//    youLab.layer.borderWidth = 1 * self.numSingleVersion;
//    youLab.layer.borderColor = [SMSColor(255, 122, 63) CGColor];
//    self.fourthLab = youLab;
//
//    [self.contentView addSubview:youLab];
    
    
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6 *self.numSingleVersion, 6 *self.numSingleVersion, 168 *self.numSingleVersion, 108 * self.numSingleVersion)];
    imageView.backgroundColor = [UIColor cyanColor];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:image]];
    self.imageView1 = imageView;

    [self.contentView addSubview:imageView];
}



@end
