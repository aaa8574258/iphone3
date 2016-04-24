//
//  BottomPersonScrollview.m
//  360du
//
//  Created by linghang on 15/8/13.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BottomPersonScrollview.h"
#import "VersionTranlate.h"
#import "MenberViewController.h"
@implementation BottomPersonScrollview
-(id)initWithFrame:(CGRect)frame andNameArr:(NSArray *)nameArr andImageArr:(NSArray *)imageArr{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeScrNameArr:nameArr andImageArr:imageArr];
    }
    return self;
}
-(void)makeScrNameArr:(NSArray *)nameArr andImageArr:(NSArray *)imageArr{
    //self.frame = self.bounds;
    NSInteger count = 0;
    CGFloat numSigle = [VersionTranlate returnVersionRateAnyIphone:1];
    if (nameArr.count % 2 == 0) {
        count = nameArr.count / 2 + 1;
    }else{
        count = nameArr.count / 2;
    }
    self.contentSize = CGSizeMake(WIDTH_VIEW, count * 40 * numSigle );
    for (NSInteger i = 0; i < nameArr.count; i++) {
        //图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * numSigle, 5 * numSigle + i / 2 * 50 * numSigle, 30 * numSigle, 30 * numSigle)];
        imgView.image = [UIImage imageNamed:imageArr[i]];
        [self addSubview:imgView];
        //按钮
        UIButton *scrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        scrBtn.frame = CGRectMake(40 * numSigle, 5 * numSigle + i / 2 * 50 * numSigle, 100 * numSigle, 30 * numSigle);
        [scrBtn setTitle:nameArr[i] forState:UIControlStateNormal];
        scrBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [scrBtn addTarget:self action:@selector(scrBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [scrBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:scrBtn];
        scrBtn.tag = 1400 + i;
        scrBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        if (i % 2 != 0) {
            imgView.frame = CGRectMake(10 * numSigle + WIDTH_VIEW / 2, 5 * numSigle + i / 2 * 50 * numSigle, 30 * numSigle, 30 * numSigle);
            scrBtn.frame = CGRectMake(40 * numSigle + WIDTH_VIEW / 2, 5 * numSigle + i / 2 * 50 * numSigle, 100 * numSigle, 30 * numSigle);
        }
    }
}
-(void)scrBtnDown:(UIButton *)scrBtn{
    if([self.target isKindOfClass:[MenberViewController class]]){
        [self.target returnSctBtnTag:scrBtn.tag - 1400];
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
