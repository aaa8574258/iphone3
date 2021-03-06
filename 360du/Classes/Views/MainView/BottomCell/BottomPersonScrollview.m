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
#import "StoreageMessage.h"
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
    if (nameArr.count % 3 == 0) {
        count = nameArr.count / 3 + 1;
    }else{
        count = nameArr.count / 3;
    }
    self.contentSize = CGSizeMake(WIDTH_VIEW, count * 40 * numSigle );
    for (NSInteger i = 0; i < nameArr.count; i++) {
        //图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22.5 * numSigle, 22.5 * numSigle)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
//        NSInteger *badge = [StoreageMessage getBadge].integerValue;

        
        
        
        imgView.image = [UIImage imageNamed:imageArr[i]];
        NSLog(@"%@",[StoreageMessage getBadge]);
        if ([[StoreageMessage getBadge] integerValue] != 0) {
            if ([nameArr[i] isEqualToString:@"消息中心"]) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20.5 , 0, 8 *numSigle , 8 *numSigle)];
                view.layer.masksToBounds = YES;
                view.layer.cornerRadius = 4 * numSigle;
                view.backgroundColor = [UIColor redColor];
                [imgView addSubview:view];
            }
        }
        imgView.center = CGPointMake(67 * numSigle  + (100 *numSigle + 23 * numSigle ) * (i % 3) ,   (25 *numSigle + 70 *numSigle) * (i / 3) + 40 *numSigle);
        [self addSubview:imgView];
        //按钮
        UIButton *scrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        scrBtn.frame = CGRectMake(0,  0, 100 * numSigle, 60 * numSigle);
//        scrBtn.backgroundColor = [UIColor redColor];
        CGFloat scrBtnWith = scrBtn.frame.size.width;
        CGFloat scrBtnHeight = scrBtn.frame.size.height;
        [scrBtn setTitle:nameArr[i] forState:UIControlStateNormal];
        scrBtn.center = CGPointMake(17 * numSigle + scrBtnWith / 2 + (scrBtnWith + 23 * numSigle ) * (i % 3) ,  20 + (scrBtnHeight + 35 *numSigle) * (i / 3) + 50 *numSigle);
        scrBtn.titleLabel.font = [UIFont systemFontOfSize:13 * numSigle];
        [scrBtn addTarget:self action:@selector(scrBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [scrBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:scrBtn];
        scrBtn.tag = 1400 + i;
        scrBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100 * numSigle, self.frame.size.width, 1 *numSigle)];
        view1.backgroundColor = SMSColor(240, 240, 240);
        [self addSubview:view1];

        
//        if (i % 3 != 0) {
//            imgView.frame = CGRectMake(10 * numSigle + WIDTH_VIEW / 3, 5 * numSigle + i / 3 * 50 * numSigle, 30 * numSigle, 30 * numSigle);
//            scrBtn.frame = CGRectMake(40 * numSigle + WIDTH_VIEW / 3, 5 * numSigle + i / 3 * 50 * numSigle, 100 * numSigle, 30 * numSigle);
//        }
    }
}
-(void)scrBtnDown:(UIButton *)scrBtn{
    NSLog(@"%ld",(long)scrBtn.tag);
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
