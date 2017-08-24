//
//  MainBottomView.m
//  360du
//
//  Created by linghang on 15-4-11.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "MainBottomView.h"
#import "ViewController.h"
#import "MerchantViewController.h"
@implementation MainBottomView

-(id)initWithFrame:(CGRect)frame andImgArr:(NSArray *)imgArr andTitleArr:(NSArray *)titleArr andBgImg:(NSString *)bgImg andHeilightImg:(NSArray *)linghtImg{
    self = [super initWithFrame:frame];
    if(self){
        self.imgArr = imgArr;
        self.titleArr = titleArr;
        self.bgImg = bgImg;
        self.lightArr = linghtImg;
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
//    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.bounds];
//    bgImgView.userInteractionEnabled = YES;
//    bgImgView.image = [UIImage imageNamed:self.bgImg];
//    [self addSubview:bgImgView];
    CGFloat everWidth = WIDTH_VIEW / self.imgArr.count;
    for (NSInteger i = 0; i < self.titleArr.count; i++) {
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15 * self.numSingleVesion)];
        titleLab.font = [UIFont systemFontOfSize:14 ];
        titleLab.text = self.titleArr[i];
        [titleLab sizeToFit];
        titleLab.textColor = MAINVIEWBOTTOMCOLOR;
        titleLab.center = CGPointMake(everWidth / 2 + i * everWidth, 30 * self.numSingleVesion + 4 * self.numSingleVesion + 7.5 * self.numSingleVesion);
        [self addSubview:titleLab];
        
        UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imgBtn.frame = CGRectMake(i * everWidth, (49 - 26) / 2.0 * self.numSingleVesion, 24 * self.numSingleVesion, 24 * self.numSingleVesion);
//        if(i == 0){
//            imgBtn.frame =CGRectMake(i * everWidth, (49 - 30) / 2.0 * self.numSingleVesion, 24 * self.numSingleVesion, 30 * self.numSingleVesion);
//        }
        imgBtn.center = CGPointMake(everWidth / 2 + i * everWidth, 2 * self.numSingleVesion +  14 * self.numSingleVesion);
        //[imgBtn setBackgroundImage:[UIImage imageNamed:self.imgArr[i]] forState:UIControlStateNormal];
        [imgBtn setImage:[UIImage imageNamed:self.imgArr[i]] forState:UIControlStateNormal];
        //[imgBtn setImage:[UIImage imageNamed:self.lightArr[i]] forState:UIControlStateHighlighted];
        //[imgBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (everWidth - 30) / 2, 19, (everWidth - 30) / 2)];
        [imgBtn addTarget:self action:@selector(imgBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        imgBtn.userInteractionEnabled = YES;
        [self addSubview:imgBtn];
        imgBtn.tag = 2900 + i;
//        if (i == 0) {
//            [imgBtn setImage:[UIImage imageNamed:self.lightArr[0]] forState:UIControlStateNormal];
//        }
        ////
        
//        [UIImage imageNamed:@""]
    }
}
-(void)imgBtnDown:(UIButton *)imgBtn{
    if ([self.target isKindOfClass:[ViewController class]] || [self.target isKindOfClass:[MerchantViewController class]]) {
        [self.target returnBottomTag:imgBtn.tag - 2900];
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
