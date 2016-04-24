//
//  CommonFoodFourBtnHead.m
//  360du
//
//  Created by linghang on 15/5/17.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "CommonFoodFourBtnHead.h"
#import "FoodListCategoryModel.h"
#import "UIImageView+WebCache.h"
#import "LocationModel.h"
#import "FoodCommonViewController.h"
@interface CommonFoodFourBtnHead()
@property(nonatomic,assign)NSInteger numHead;
@property(nonatomic,strong)NSArray *headArr;
@end
@implementation CommonFoodFourBtnHead
-(id)initWithFrame:(CGRect)frame andNSArray:(NSArray *)dataArr andNum:(NSInteger)num{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self makeUI:dataArr andNum:num];
        self.numHead = num;
        self.headArr = dataArr;
    }
    return self;
}
-(void)makeUI:(NSArray *)dataArr andNum:(NSInteger)num{
    UIScrollView *scr = [[UIScrollView alloc] initWithFrame:self.bounds];
    scr.contentSize = CGSizeMake(WIDTH_VIEW, dataArr.count * 40 * self.numSingleVesion);
    [self addSubview:scr];
    for (NSInteger i = 0; i < dataArr.count; i++) {
        if (num == 3) {
            LocationModel *model = dataArr[i];
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 15 * self.numSingleVesion + 40 * self.numSingleVesion * i, WIDTH_VIEW - 20 * self.numSingleVesion, 15 * self.numSingleVesion)];
            lable.textColor = [UIColor blackColor];
            lable.font = [UIFont systemFontOfSize:15];
            [scr addSubview:lable];
            lable.text = model.xqname;
        }else{
            UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion,15 * self.numSingleVesion +  40 * self.numSingleVesion * i, 20 * self.numSingleVesion, 20 * self.numSingleVesion)];
            [scr addSubview:leftImg];
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40 * self.numSingleVesion, 15 * self.numSingleVesion + 40 * self.numSingleVesion * i, WIDTH_VIEW - 40 * self.numSingleVesion, 15 * self.numSingleVesion)];
            title.font = [UIFont systemFontOfSize:15];
            [scr addSubview:title];
            title.textColor = [UIColor blackColor];
            FoodListCategoryModel *model = dataArr[i];
            [leftImg sd_setImageWithURL:[NSURL URLWithString:model.imgrul] placeholderImage:[UIImage imageNamed:@"fu.png"]];
            title.text = model.name;
        }
        
        UIButton *alphaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        alphaBtn.frame = CGRectMake(0, 40 * self.numSingleVesion * i, WIDTH_VIEW, 40 * self.numSingleVesion);
        [alphaBtn setTitle:@"" forState:UIControlStateNormal];
        [alphaBtn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
        [scr addSubview:alphaBtn];
        alphaBtn.tag = 10000 + 1000 * num + i;
    }
    
}
-(void)btnDown:(UIButton *)btn{
    if ([self.target isKindOfClass:[FoodCommonViewController class]]) {
        NSInteger num =  btn.tag - 10000 - self.numHead * 1000;
        if (self.numHead == 3) {
            LocationModel *model = self.headArr[num];
            [self.target returnHeadBtn:self.numHead andHeadString:model.xqid];
            return;
        }
        FoodListCategoryModel *model = self.headArr[num];
        [self.target returnHeadBtn:self.numHead andHeadString:model.pid];
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
