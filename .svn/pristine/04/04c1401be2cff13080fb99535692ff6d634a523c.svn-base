//
//  ProertyMendAndQuestionCell.m
//  360du
//
//  Created by linghang on 15/7/18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ProertyMendAndQuestionCell.h"
#import "PropertyListModel.h"
#import "ProertyMendSeverViewController.h"
#import "UIImageView+WebCache.h"
@interface ProertyMendAndQuestionCell()
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UIButton *nextButton;
@property(nonatomic,strong)UIImageView *imgViewLeft;
@property(nonatomic,weak)UIImageView *arrowImgView;
@end
@implementation ProertyMendAndQuestionCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    self.imgViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 15 * self.numSingleVersion, 30 * self.numSingleVersion, 30 * self.numSingleVersion)];
    [self.contentView addSubview:self.imgViewLeft];
    
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nameLab];

    //UIImageView
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake(self.allWidth - 10 * self.numSingleVersion - 30 * self.numSingleVersion, (self.frame.size.height - 30 * self.numSingleVersion) / 2, 30 * self.numSingleVersion, 30 * self.numSingleVersion);
    [self.nextButton setImage:[UIImage imageNamed:@"加"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.nextButton];
    [self.nextButton addTarget:self action:@selector(nextBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    self.nextButton.layer.cornerRadius = 15 * self.numSingleVersion;
    self.nextButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.nextButton.layer.borderWidth = 1 * self.numSingleVersion;
    
    UIImageView *arroeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.allWidth - 100 * self.numSingleVersion - 18 * self.numSingleVersion, (60 * self.numSingleVersion - 20 * self.numSingleVersion) / 2, 18 * self.numSingleVersion, 20 * self.numSingleVersion)];
    arroeImgView.image = [UIImage imageNamed:@"下一步"];
    [self.contentView addSubview:arroeImgView];
    self.arrowImgView = arroeImgView;
}
-(void)nextBtnDown:(UIButton *)nextBtn{
    if ([self.target isKindOfClass:[ProertyMendSeverViewController class]]) {
        [self.target returnNextBtn:nextBtn.tag - 1600];
    }
}
-(void)refreshModel:(PropertyListModel *)model andRow:(NSInteger)row{
    self.nameLab.text = model.name;
    [self.nameLab sizeToFit];
    self.nameLab.center = CGPointMake(self.nameLab.frame.size.width / 2 + 10 * self.numSingleVersion + 40 * self.numSingleVersion + 10 * self.numSingleVersion, self.frame.size.height / 2);
    if ([self.classId isEqual:@"5"]) {
       self.arrowImgView.center =CGPointMake(self.allWidth - 10 * self.numSingleVersion - 30 * self.numSingleVersion, self.frame.size.height / 2);
        self.nextButton.hidden = YES;
    }else{
        self.nextButton.hidden = NO;

        self.nextButton.tag = 1600 + row;
        self.nextButton.center = CGPointMake(self.allWidth - 10 * self.numSingleVersion - 30 * self.numSingleVersion, self.frame.size.height / 2);
    }
    
    [self.imgViewLeft sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"001"]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
