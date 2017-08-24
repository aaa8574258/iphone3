//
//  CommonEvaluateMechantCell.m
//  360du
//
//  Created by linghang on 15/8/29.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "CommonEvaluateMechantCell.h"
#import "UIImageView+WebCache.h"
@interface CommonEvaluateMechantCell()
@property(nonatomic,strong)UIImageView *imgViewLeft;
@property(nonatomic,strong)UILabel *nameLab;
@end
@implementation CommonEvaluateMechantCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    //图片
    self.imgViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(5 * self.numSingleVersion, 12.5 * self.numSingleVersion, 15 * self.numSingleVersion, 15 * self.numSingleVersion)];
    [self.contentView addSubview:self.imgViewLeft];
    //标题
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(50 * self.numSingleVersion, 5 * self.numSingleVersion, 100 * self.numSingleVersion, 15 * self.numSingleVersion)];
    self.nameLab.font = [UIFont systemFontOfSize:15 * self.numSingleVersion];
    [self.contentView addSubview:self.nameLab];
    

}
- (void)refreshArr:(NSArray *)everCellArr andSection:(NSInteger)section andHeight:(CGFloat)height{
    if (section == 0) {
        self.imgViewLeft.image = [UIImage imageNamed:everCellArr[0]];
    }else{
        [self.imgViewLeft sd_setImageWithURL:[NSURL URLWithString:everCellArr[0]] placeholderImage:[UIImage imageNamed:@"geren01"]];
    }
    self.nameLab.text = everCellArr[1];
    self.nameLab.frame = CGRectMake(30 * self.numSingleVersion, (self.frame.size.height - 15 * self.numSingleVersion) / 2, self.allWidth - 60 * self.numSingleVersion, 15 * self.numSingleVersion);
    //[self.nameLab sizeToFit];
    //self.nameLab.center = CGPointMake(25 * self.numSingleVersion + self.nameLab.frame.size.width, self.frame.size.height / 2);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
