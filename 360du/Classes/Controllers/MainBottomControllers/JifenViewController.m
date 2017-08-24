//
//  JifenViewController.m
//  360du
//
//  Created by 利美 on 17/3/10.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "JifenViewController.h"
#import "JifenNextViewController.h"
@interface JifenViewController ()

@end

@implementation JifenViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self makeUI];

}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

-(void) makeUI{
    UIImageView *mianImg = [[UIImageView alloc] initWithFrame:self.view.frame];
    [mianImg setImage:[UIImage imageNamed:@"签到@2x.png"]];
    [self.view addSubview:mianImg];

    UILabel *firstLab = [[UILabel alloc] initWithFrame:CGRectZero];
    firstLab.text = [NSString stringWithFormat:@"您已经连续签到%@天",self.checkingDay];
    firstLab.font = [UIFont systemFontOfSize:22 *self.numSingleVesion];
    firstLab.textColor = [UIColor whiteColor];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:firstLab.text];
    //设置字号
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22 *self.numSingleVesion] range:NSMakeRange(2, 3)];
    //设置文字颜色
    NSRange startRange12 = [firstLab.text rangeOfString:@"签到"];
    NSRange endRange12 = [firstLab.text rangeOfString:@"天"];
    NSRange range12 = NSMakeRange(startRange12.location + startRange12.length, endRange12.location - startRange12.location - startRange12.length);
    [str1 addAttribute:NSForegroundColorAttributeName value:SMSColor(254, 214, 18) range:range12];
    firstLab.attributedText = str1;

    [firstLab sizeToFit];
    firstLab .center = CGPointMake(self.view.frame.size.width/2,273 *self.numSingleVesion + firstLab.frame.size.height/2);
    [self.view addSubview:firstLab];
    
    UILabel *secLab = [[UILabel alloc] initWithFrame:CGRectZero];
    secLab.text = [NSString stringWithFormat:@"积分+%@",self.score];
    secLab.font = [UIFont systemFontOfSize:15 *self.numSingleVesion];
    secLab.textColor = [UIColor whiteColor];
    
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:secLab.text];
    //设置字号
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15 *self.numSingleVesion] range:NSMakeRange(2, 3)];
    //设置文字颜色
    NSRange startRange1 = [secLab.text rangeOfString:@"积分"];
    NSRange endRange1 = NSMakeRange(secLab.text.length, 0);
    NSRange range11 = NSMakeRange(startRange1.location + startRange1.length, endRange1.location - startRange1.location - startRange1.length);
            [str addAttribute:NSForegroundColorAttributeName value:SMSColor(254, 214, 18) range:range11];
    [str addAttribute:NSForegroundColorAttributeName value:SMSColor(254, 214, 18) range:range11];
//    NSRange startRange1 = [secLab.text rangeOfString:@"  经验"];
//    NSRange endRange1 = NSMakeRange(secLab.text.length, 0);
//    NSRange range11 = NSMakeRange(startRange1.location + startRange1.length, endRange1.location - startRange1.location - startRange1.length);
//        [str addAttribute:NSForegroundColorAttributeName value:SMSColor(254, 214, 18) range:range11];
    secLab.attributedText = str;
    [secLab sizeToFit];
    secLab.center = CGPointMake(self.view.frame.size.width/2, 273 *self.numSingleVesion + firstLab.frame.size.height + 30 * self.numSingleVesion + secLab.frame.size.height/2);
    [self.view addSubview:secLab];
    
    
    
    
    
    
    UILabel *thirLab = [[UILabel alloc] initWithFrame:CGRectZero];
    thirLab.text = [NSString stringWithFormat:@"再连续签到%@天，可额外获得积分+%@  经验+%@",@"6",@"30",@"30"];
    thirLab.font = [UIFont systemFontOfSize:15 *self.numSingleVesion];
    thirLab.textColor = [UIColor whiteColor];
    NSRange startRange = [thirLab.text rangeOfString:@"额外获得积分"];
    NSRange endRange = [thirLab.text rangeOfString:@"经验"];
    NSRange lastRange = NSMakeRange(thirLab.text.length, 0);
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSRange range1 = NSMakeRange(endRange.location + endRange.length, lastRange.location - endRange.location - endRange.length);
    NSMutableAttributedString *str111 = [[NSMutableAttributedString alloc] initWithString:thirLab.text];
    NSRange beginRange = [thirLab.text rangeOfString:@"连续签到"];
    NSRange beginRange1 = [thirLab.text rangeOfString:@"天"];
    NSRange rangeB = NSMakeRange(beginRange.location + beginRange.length, beginRange1.location - beginRange.location - beginRange.length);
    NSLog(@"%@",NSStringFromRange(rangeB));
    [str111 addAttribute:NSForegroundColorAttributeName value:SMSColor(254, 214, 18) range:rangeB];
        [str111 addAttribute:NSForegroundColorAttributeName value:SMSColor(254, 214, 18) range:range];
        [str111 addAttribute:NSForegroundColorAttributeName value:SMSColor(254, 214, 18) range:range1];
    thirLab.attributedText = str111;
    [thirLab sizeToFit];
    thirLab.center  = CGPointMake(self.view.frame.size.width/2, secLab.frame.origin.y + secLab.frame.size.height/2 + 20 *self.numSingleVesion +thirLab.frame.size.height/2);
//    [self.view addSubview:thirLab];
    
    UIImageView *imageV =  [[UIImageView alloc] initWithFrame:CGRectMake(0,0,115 *self.numSingleVesion , 34* self.numSingleVesion)];
    [imageV setImage:[UIImage imageNamed:@"圆角矩形1@2x.png"]];
    imageV.center = CGPointMake(self.view.frame.size.width/2, thirLab.frame.origin.y + thirLab.frame.size.height +55 *self.numSingleVesion + 17 *self.numSingleVesion);
//    imageV.backgroundColor = [UIColor cyanColor];
    [self .view addSubview:imageV];
    UILabel *nextLab = [[UILabel alloc] initWithFrame:CGRectZero];
    nextLab.text = @"积分商城";
    nextLab.font = [UIFont systemFontOfSize:17 *self.numSingleVesion];
    nextLab.textColor = [UIColor whiteColor];
    [nextLab sizeToFit];

    nextLab.center = imageV.center;
    [self.view addSubview:nextLab];
    UITapGestureRecognizer *tapNext =[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (nextAction:)];
    [imageV addGestureRecognizer :tapNext];
    imageV. userInteractionEnabled = YES ;
    
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 34 * self .numSingleVesion, 34 * self.numSingleVesion);
    backBtn.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - 110 *self.numSingleVesion - backBtn.frame.size.height/2);
    [backBtn setImage:[UIImage imageNamed:@"叉叉@2x.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    




}


-(void)nextAction:( UITapGestureRecognizer *)gestureRecognizer{
    NSLog(@"111");
    JifenNextViewController *next = [[JifenNextViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

-(void)fuwenbenLabel:(UILabel *)labell FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    labell.attributedText = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
