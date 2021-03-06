//
//  ProertyTelCell.m
//  360du
//
//  Created by linghang on 15/7/18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ProertyTelCell.h"
#import "ProertyTelModel.h"
#import "ProertyTelViewController.h"
@interface ProertyTelCell()
@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,strong)UILabel *telLable;
@property(nonatomic,strong)UIButton *telBtn;
@end
@implementation ProertyTelCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.nameLable];
    
    UIView *telView = [[UIView alloc] initWithFrame:CGRectMake(self.allWidth / 2 - 70 * self.numSingleVersion, 10 * self.numSingleVersion, 140 * self.numSingleVersion, 20 * self.numSingleVersion)];
//    telView.layer.borderColor = [[UIColor redColor] CGColor];
//    telView.layer.borderWidth = 1 * self.numSingleVersion;
    [self.contentView addSubview:telView];
    telView.backgroundColor = [UIColor whiteColor];
    
    self.telLable = [[UILabel alloc] initWithFrame:telView.bounds];
    self.telLable.textAlignment = UITextAlignmentRight;
    self.telLable.font = [UIFont systemFontOfSize:15];
    [telView addSubview:self.telLable];
    
    
    self.telBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    self.telBtn.frame = CGRectMake(self.allWidth - 60 * self.numSingleVersion, 5 * self.numSingleVersion, 50 * self.numSingleVersion, 30 * self.numSingleVersion);
    [self.telBtn setTitle:@"拨打" forState:UIControlStateNormal];
    self.telBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.telBtn addTarget:self action:@selector(telBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.telBtn];
    [self.telBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.telBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:40/255.0 blue:79/255.0 alpha:1];
    self.telBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.telBtn.layer.borderWidth = 1 * self.numSingleVersion;
//    self.telBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
}
-(void)telBtnDown:(UIButton *)telBtn{
    if ([self.target isKindOfClass:[ProertyTelViewController class]]) {
        [self.target returnTelRow:telBtn.tag - 1700];
    }
}
-(void)refreshModel:(ProertyTelModel *)model andRow:(NSInteger)row{
    self.nameLable.text = model.phoneName;
    [self.nameLable sizeToFit];
    self.nameLable.center = CGPointMake(self.nameLable.frame.size.width / 2 + 10 * self.numSingleVersion, self.frame.size.height / 2);    self.telLable.text = model.phone;
    self.telBtn.tag = 1700 + row;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
