//
//  OrderAddEvaluate.m
//  360du
//
//  Created by linghang on 16/1/4.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "OrderAddEvaluate.h"
#import "OrderAddEvaluteViewController.h"
@interface OrderAddEvaluate()<UITextViewDelegate>
@property(nonatomic,copy)NSString *starCount;
@end
@implementation OrderAddEvaluate
- (id)initWithFrame:(CGRect)frame andStarCount:(NSString *)starCount{
    self = [super initWithFrame:frame];
    if (self) {
        [self createStarCount:starCount];
        [self createPersonalTextView];
        [self createBottom];
    }
    return self;
}
- (void)createStarCount:(NSString *)starCount{
    UILabel *evaLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 20 * self.numSingleVesion, 20, 15 * self.numSingleVesion)];
    evaLab.text = @"整体评价:";
    evaLab.font = [UIFont systemFontOfSize:16];
    evaLab.textColor = SMSColor(211, 211, 211);
    [self addSubview:evaLab];
    [evaLab sizeToFit];
    evaLab.frame = CGRectMake(10 * self.numSingleVesion, 20 * self.numSingleVesion, evaLab.frame.size.width + 5 * self.numSingleVesion, 15 * self.numSingleVesion);
    CGFloat starWidth =  evaLab.frame.size.width + 5 * self.numSingleVesion + 10 * self.numSingleVesion + 5 * self.numSingleVesion;
    for (NSInteger i = 0; i < 5; i++) {
        UIButton *starBgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        starBgBtn.frame = CGRectMake(starWidth + 44 * self.numSingleVesion * i + 4 * self.numSingleVesion, 16 * self.numSingleVesion, 40 * self.numSingleVesion, 40 * self.numSingleVesion);
        starBgBtn.center = CGPointMake(starWidth + 2 * self.numSingleVesion + 44 * self.numSingleVesion * i, 20 * self.numSingleVesion + 7.5 * self.numSingleVesion);
        [starBgBtn setImage:[UIImage imageNamed:@"xing03"] forState:UIControlStateNormal];
        [starBgBtn addTarget:self action:@selector(starBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:starBgBtn];
        starBgBtn.tag = 1600 + i;
//        main_shoucang_p
    }
    if ([starCount isEqual:@"false"]) {//没有评价过
    }else{
        for (NSInteger i = 0; i < starCount.integerValue; i++) {
            UIButton *starBtn = (UIButton *)[self viewWithTag:1600 + i];
            [starBtn setImage:[UIImage imageNamed:@"xing02"] forState:UIControlStateNormal];
        }
        if (starCount.floatValue > starCount.integerValue) {
            UIButton *starBtn = (UIButton *)[self viewWithTag:1600 + starCount.integerValue + 1];
            [starBtn setImage:[UIImage imageNamed:@"xing01"] forState:UIControlStateNormal];
        }
    }
}
- (void)starBtnDown:(UIButton *)starTempBtn{
    if ([starTempBtn.imageView.image isEqual:[UIImage imageNamed:@"xing01"]]) {
        for (NSInteger i = 0; i <= starTempBtn.tag - 1600; i++) {
            UIButton *starBtn = (UIButton *)[self viewWithTag:1600 + i];
            [starBtn setImage:[UIImage imageNamed:@"xing02"] forState:UIControlStateNormal];
        }
        //self.starCount = [NSString stringWithFormat:@"%ld",starBtn.tag - 1600];
    }else if ([starTempBtn.imageView.image isEqual:[UIImage imageNamed:@"xing02"]]){
        for (NSInteger i = 0; i <= starTempBtn.tag - 1600 - 1; i++) {
            UIButton *starBtn = (UIButton *)[self viewWithTag:1600 + i];
            [starBtn setImage:[UIImage imageNamed:@"xing02"] forState:UIControlStateNormal];
        }
        [starTempBtn setImage:[UIImage imageNamed:@"xing01"] forState:UIControlStateNormal];
        self.starCount = [NSString stringWithFormat:@"%lf",starTempBtn.tag - 1600 + 0.5];

    } else{
        if (starTempBtn.tag - 1600 == 0) {
            [starTempBtn setImage:[UIImage imageNamed:@"xing01"] forState:UIControlStateNormal];
            self.starCount = @"0.5";

            return;
        }
        
        for (NSInteger i = 0; i <= starTempBtn.tag - 1600 - 1; i++) {
            UIButton *starBtn = (UIButton *)[self viewWithTag:1600 + i];
            [starBtn setImage:[UIImage imageNamed:@"xing02"] forState:UIControlStateNormal];
        }
            [starTempBtn setImage:[UIImage imageNamed:@"xing01"] forState:UIControlStateNormal];
        self.starCount = [NSString stringWithFormat:@"%lf",starTempBtn.tag - 1600  + 0.5];

    }
}
- (void)createPersonalTextView{
    //textView
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 70 * self.numSingleVesion, WIDTH_VIEW - 20 * self.numSingleVesion, 200 * self.numSingleVesion)];
    [self addSubview:textView];
    textView.delegate = self;
    textView.layer.cornerRadius = 3 * self.numSingleVesion;
    textView.layer.borderWidth = 1 * self.numSingleVesion;
    textView.layer.borderColor = [SMSColor(112, 179, 6) CGColor];
    textView.tag = 2300;
    //placeholder
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 10 * self.numSingleVesion, 250, 20)];
    lab.text = @"您的意见很重要!来点评一下吧.....";
    [textView addSubview:lab];
    lab.tag = 2000;
    lab.textColor = SMSColor(211, 211, 211);
}
- (void)createBottom{
    UIButton *starBgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    starBgBtn.frame = CGRectMake(0 * self.numSingleVesion, self.frame.size.height - 40 * self.numSingleVesion, WIDTH_VIEW +  0 * self.numSingleVesion, 40 * self.numSingleVesion);
    starBgBtn.backgroundColor = [UIColor redColor];
    [starBgBtn setTitle:@"提交评价" forState:UIControlStateNormal];
    [starBgBtn addTarget:self action:@selector(bottomBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:starBgBtn];
}
- (void)bottomBtnDown{
    if ([self.target isKindOfClass:[OrderAddEvaluteViewController class]]) {
        UITextView *textView = (UITextView *)[self viewWithTag:2300];
        if (textView.text.length == 0) {
            textView.text = @"";
        }
        if ([self.starCount isEqual:@"false"]) {//没有评价过
            self.starCount = @"0";
        }

        [self.target returnStarCount:self.starCount andEvaluteContent:textView.text];
    }
}
#pragma mark textView的代理
//开始编辑的时候触发
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    UILabel *label = (UILabel*)[self viewWithTag:2000];
    label.hidden = YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    UITextView *textView = (UITextView *)[self viewWithTag:2300];
    [textView resignFirstResponder];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
