//
//  FZHPopView.m
//  test
//
//  Created by 冯志浩 on 16/5/27.
//  Copyright © 2016年 FZH. All rights reserved.
//

#import "FZHPopView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation FZHPopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        //初始化各种起始属性
        [self initAttribute];
    }
    return self;
}
/**
 *  初始化起始属性
 */
- (void)initAttribute{
    
    self.buttonH = SCREEN_HEIGHT * (40.0/736.0);
    self.buttonMargin = 10;
    self.contentShift = SCREEN_HEIGHT * (200.0/736.0);
    self.animationTime = 1;
//    self.backgroundColor = [UIColor colorWithWhite:0.614 alpha:0.700];
    
    [self initSubViews];
}
/**
 *  初始化子控件
 */
- (void)initSubViews{
    
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = CGRectMake(0, 64, SCREEN_WIDTH, self.contentShift);
    [self addSubview:self.contentView];
}
/**
 *  展示pop视图
 *
 *  @param array 需要显示button的title数组
 */
- (void)showThePopViewWithArray:(NSMutableArray *)array{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    
    [window addSubview:self];
    //1.在contentView上添加控件
    for (int i = 0; i < array.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i * (self.buttonH + self.buttonMargin) + self.buttonMargin, SCREEN_WIDTH, self.buttonH);
        NSString * buttonStr = array[i];
        [button setTitle:buttonStr forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000 + i;
        [self.contentView addSubview:button];
    }
    //2.执行动画
    [UIView animateWithDuration:self.animationTime animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.contentView.transform = CGAffineTransformMakeTranslation(0, 40);
    }];
    
}

- (void)buttonClick:(UIButton *)button{
    
    if ([self.fzhPopViewDelegate respondsToSelector:@selector(getTheButtonTitleWithButton:)]) {
        [self.fzhPopViewDelegate getTheButtonTitleWithButton:button];
    }
}

- (void)dismissThePopView{
    
    [UIView animateWithDuration:self.animationTime animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissThePopView];
}

@end
