//
//  StudyMainBottomView.m
//  XiaomiIOs
//
//  Created by linghang on 15-3-12.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "StudyMainBottomView.h"
#import "ViewController.h"
#import "VersionTranlate.h"
@implementation StudyMainBottomView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
    //NSArray *imgeArr = @[@"home_bar_1@2x.png",@"home_nav_6@2x.png",@"home_bar_2@2x.png",@"home_bar_3@2x.png",@"home_bar_4@2x.png"];
    NSArray *imgeArr = @[@"geren01.png",@"dingdan01.png",@"shoucang01.png",@"xiaoxi01.png",@"shezhi01.png"];
    NSArray *lightArr = @[@"geren02.png",@"dingdan02.png",@"shoucang02.png",@"xiaoxi02.png",@"shezhi02.png"];
    NSArray *titleArr = @[@"个人中心",@"订单",@"收藏",@"消息",@"设置"];
//    NSArray *imgeArr = @[@"home_bar_1@2x.png",@"home_nav_6@2x.png",@"home_bar_2@2x.png",@"home_bar_3@2x.png"];
    CGFloat everWidth = WIDTH_VIEW / imgeArr.count;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
    imgView.image = [UIImage imageNamed:@"bottombg.gif"];
    imgView.userInteractionEnabled = YES;
    [self addSubview:imgView];
    
    for (NSInteger i = 0; i < imgeArr.count; i++) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15 * self.numSingleVesion)];
        titleLab.font = [UIFont systemFontOfSize:14 ];
        titleLab.text = titleArr[i];
        [titleLab sizeToFit];
        titleLab.textColor = MAINVIEWBOTTOMCOLOR;
        titleLab.center = CGPointMake(everWidth / 2 + i * everWidth, 30 * self.numSingleVesion + 4 * self.numSingleVesion + 7.5 * self.numSingleVesion);
        [imgView addSubview:titleLab];
        
        UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imgBtn.frame = CGRectMake(i * everWidth, (49 - 30) / 2.0 * self.numSingleVesion, 30 * self.numSingleVesion, 30 * self.numSingleVesion);
        imgBtn.center = CGPointMake(everWidth / 2 + i * everWidth, 15 * self.numSingleVesion);
        //[imgBtn setBackgroundImage:[UIImage imageNamed:self.imgArr[i]] forState:UIControlStateNormal];
        [imgBtn setImage:[UIImage imageNamed:imgeArr[i]] forState:UIControlStateNormal];
        //[imgBtn setImage:[UIImage imageNamed:self.lightArr[i]] forState:UIControlStateHighlighted];
        //[imgBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (everWidth - 30) / 2, 19, (everWidth - 30) / 2)];
        [imgBtn addTarget:self action:@selector(imgBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        imgBtn.userInteractionEnabled = YES;
        [imgView addSubview:imgBtn];
        imgBtn.tag = 1900 + i;
    }
}
-(void)imgBtnDown:(UIButton *)imgBtn{
    if ([self.target isKindOfClass:[ViewController class]]) {
        [self.target returnBottomTag:imgBtn.tag - 1900];
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
