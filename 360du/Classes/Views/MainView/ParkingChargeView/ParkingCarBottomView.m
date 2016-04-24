//
//  ParkingCarBottomView.m
//  360du
//
//  Created by linghang on 16/1/7.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ParkingCarBottomView.h"
#import "ParkingMangerViewController.h"
@interface ParkingCarBottomView()
@end
@implementation ParkingCarBottomView
- (id)initWithFrame:(CGRect)frame andCarArr:(NSArray *)carArr andBottomState:(NSInteger)state{//0，为第一个，1为第二个
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SMSColor(57, 198, 237);
        [self createCarArr:carArr andState:state];
    }
    return self;
}

- (void)createCarArr:(NSArray *)carArr andState:(NSInteger)state{
    if (state == 0) {
        CGFloat smallWidth = WIDTH_VIEW / (CGFloat)9;
        CGFloat bigWidth = WIDTH_VIEW / (CGFloat)7;
        CGFloat everHight = smallWidth;
        for (NSInteger i = 0; i < carArr.count; i++) {
            UIButton *firstCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (i <= 26) {
                firstCarBtn.frame = CGRectMake(1 * self.numSingleVesion + i % 9 * smallWidth, 1 * self.numSingleVesion + i / 9 * everHight, smallWidth - 1* self.numSingleVesion, everHight - 1 * self.numSingleVesion);
                
            }else{
                firstCarBtn.frame = CGRectMake(1 * self.numSingleVesion + (i - 26 ) % 7 * bigWidth, 1 * self.numSingleVesion + i / 9 * everHight, bigWidth - 1* self.numSingleVesion, everHight - 1 * self.numSingleVesion);

            }
            [firstCarBtn setTitle:carArr[i] forState:UIControlStateNormal];
            [firstCarBtn setTitleColor:SMSColor(51, 51, 51) forState:UIControlStateNormal];
            [firstCarBtn setBackgroundColor:[UIColor whiteColor]];
            firstCarBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            firstCarBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            firstCarBtn.tag = 1700 + i;
            [self addSubview:firstCarBtn];
            [firstCarBtn addTarget:self action:@selector(carBtnDown:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }else{
        CGFloat firstWidth = WIDTH_VIEW / (CGFloat)10;
        CGFloat firstHeight = firstWidth;
        CGFloat secondWidth = WIDTH_VIEW / (CGFloat)9;
        CGFloat secondHeight = secondWidth;
        for (NSInteger i = 0; i < carArr.count; i++) {
            UIButton *firstCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (i <= 19) {
                firstCarBtn.frame = CGRectMake(1 * self.numSingleVesion + firstWidth * (i % 10), 1 * self.numSingleVesion + i / 10 * firstHeight, firstWidth - 1 * self.numSingleVesion, firstHeight - 1 * self.numSingleVesion);
            }else if (i > 19 && i <= 28){
                firstCarBtn.frame = CGRectMake(1 * self.numSingleVesion + secondWidth * ((i - 20) % 9), 1 * self.numSingleVesion + firstHeight * (i / 10), secondWidth - 1 * self.numSingleVesion, secondHeight - 1 * self.numSingleVesion);

            }else{
                if (i == carArr.count - 1) {
                    firstCarBtn.frame = CGRectMake(1 + firstWidth * 7, 1 * self.numSingleVesion + firstHeight * 2 + secondHeight, WIDTH_VIEW - firstWidth * 7 - 1 * self.numSingleVesion, secondHeight - 1 * self.numSingleVesion);
                    
                }else{
                    firstCarBtn.frame = CGRectMake(1 * self.numSingleVesion +  firstWidth * ((i - 29) % 8), 1 * self.numSingleVesion + firstHeight * 2 + secondHeight, firstWidth - 1 * self.numSingleVesion, secondHeight - 1 * self.numSingleVesion);

                }
            }
            if (i == carArr.count - 1) {
                [firstCarBtn setImage:[UIImage imageNamed:carArr[i]] forState:UIControlStateNormal];
                [firstCarBtn setBackgroundColor:SMSColor(191, 191, 191)];
            }else{
                [firstCarBtn setTitle:carArr[i] forState:UIControlStateNormal];
                [firstCarBtn setTitleColor:SMSColor(51, 51, 51) forState:UIControlStateNormal];
                firstCarBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
                firstCarBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                [firstCarBtn setBackgroundColor:[UIColor whiteColor]];

            }
            
            firstCarBtn.tag = 1800 + i;
            [self addSubview:firstCarBtn];
            [firstCarBtn addTarget:self action:@selector(carBtnDown:) forControlEvents:UIControlEventTouchUpInside];
            

        }
    }
}
- (void)carBtnDown:(UIButton *)carBtn{
    //如果tag值为1700多，为第一个，tag大于1800，为第二个
    if ([self.target isKindOfClass:[ParkingMangerViewController class]]) {
        if (carBtn.tag >= 1800) {
            if (carBtn.currentTitle.length == 0) {
                [self.target returnCarContent:carBtn.currentTitle andState:1 andTag:1];

            }else{
                [self.target returnCarContent:carBtn.currentTitle andState:1 andTag:0];

            }
        }else{
            [self.target returnCarContent:carBtn.currentTitle andState:0 andTag:0];

        }
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
