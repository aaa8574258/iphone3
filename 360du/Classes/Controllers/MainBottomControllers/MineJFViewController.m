//
//  MineJFViewController.m
//  360du
//
//  Created by 利美 on 17/3/14.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "MineJFViewController.h"
#import "StoreageMessage.h"
@interface MineJFViewController ()<UIScrollViewDelegate>
@property (nonatomic ,weak) UIScrollView *Scro;
@end

@implementation MineJFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    UIScrollView *Scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, HEIGHT_CONTENTVIEW)];
    Scro.contentSize = CGSizeMake(WIDTH_CONTENTVIEW, 1000000);
    Scro.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:Scro];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, 20)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    self.Scro = Scro;
    self.Scro.delegate = self;
    [self getInfo];
}

-(void) getInfo{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:USERJFCX,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        NSMutableArray *qdJfArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *nameArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *endTimeArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            [qdJfArr addObject:dic[@"integral"]];
            [nameArr addObject:dic[@"integralName"]];
            [endTimeArr addObject:dic[@"endTime"]];
        }
        [self makeUIWithZJF:getResult[@"score"] andGuoqi:getResult[@"desc"] andHtml:@"www.baidu.com" andQdJfArr:qdJfArr.mutableCopy andNameArr:nameArr.mutableCopy andEndTimeArr:endTimeArr.mutableCopy];
    }];

}

-(void) makeUIWithZJF:(NSString *)zjf andGuoqi:(NSString *)guoQi andHtml:(NSString *)htmlStr andQdJfArr:(NSArray *)qdjfArr andNameArr:(NSArray *)nameArr andEndTimeArr:(NSArray *)endTimeArr {
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectZero];
    lab1.text = [NSString stringWithFormat:@"%@ 分",zjf];
    lab1.font = [UIFont systemFontOfSize:20 *self.numSingleVesion];
    lab1.textColor = SMSColor(252, 139, 15);
    lab1.center = CGPointMake(self.view.frame.size.width/2, 85 * self.numSingleVesion);
    [lab1 sizeToFit];
    [self.Scro addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40 *self.numSingleVesion, 50 * self.numSingleVesion)];
    lab2.text = [NSString stringWithFormat:@"%@",guoQi];
    lab2.font = [UIFont systemFontOfSize:15 *self.numSingleVesion];
    lab2.textColor = SMSColor(102, 102, 102);
    lab2.numberOfLines = 2;
    lab2.center = CGPointMake(self.view.frame.size.width/2, lab1.frame.origin.y + lab1.frame.size.height + 35 * self.numSingleVesion);
    [lab2 sizeToFit];
    [self.Scro addSubview:lab2];
    
    UIButton *JFbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    JFbtn.frame = CGRectMake(49 * self.numSingleVesion, lab2.frame.origin.y + lab2.frame.size.height + 50 * self.numSingleVesion, 90 *self.numSingleVesion, 30 * self.numSingleVesion);
    [JFbtn setImage:[UIImage imageNamed:@"积分商城@2x.png"] forState:UIControlStateNormal];
    [self.Scro addSubview:JFbtn];
    
    UIButton *DHbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    DHbtn.frame = CGRectMake(self.view.frame.size.width - 85 *self.numSingleVesion - 49 * self.numSingleVesion, lab2.frame.origin.y + lab2.frame.size.height + 50 * self.numSingleVesion, 90 *self.numSingleVesion, 30 * self.numSingleVesion);
    [DHbtn setImage:[UIImage imageNamed:@"兑换记录e@2x.png"] forState:UIControlStateNormal];
    [self.Scro addSubview:DHbtn];
    
    
    UIView *v11 = [[UIView alloc] initWithFrame:CGRectMake(20 *self.numSingleVesion, DHbtn.frame.origin.y + DHbtn.frame.size.height + 52 *self.numSingleVesion, 110 *self.numSingleVesion, 1 *self.numSingleVesion)];
    v11.backgroundColor = SMSColor(153, 153, 153);
    [self.Scro addSubview:v11];
    
    UIView *v12 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width -  130 *self.numSingleVesion, DHbtn.frame.origin.y + DHbtn.frame.size.height + 52 *self.numSingleVesion, 110 *self.numSingleVesion, 1 *self.numSingleVesion)];
    v12.backgroundColor = SMSColor(153, 153, 153);
    [self.Scro addSubview:v12];
    
    UILabel *lllab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 66 *self.numSingleVesion, 25 *self.numSingleVesion)];
    lllab.text = @"积分明细";
    lllab.font = [UIFont systemFontOfSize:15 *self.numSingleVesion];
    lllab.center = CGPointMake(self.view.frame.size.width/2, v12.frame.origin.y + 0.5 * self.numSingleVesion);
    [lllab sizeToFit];
    [self.Scro addSubview:lllab];
    NSInteger count = qdjfArr.count;
    UIView *lastV = [[UIView alloc] initWithFrame:CGRectMake(0, lllab.frame.origin.y + lllab.frame.size.height, self.view.frame.size.width, count * 70 * self.numSingleVesion)];
    [self.Scro addSubview:lastV];
    self.Scro.contentSize  = CGSizeMake(self.view.frame.size.width, lllab.frame.origin.y + lllab.frame.size.height + count * 70 * self.numSingleVesion);
//    NSArray *arr1 = @[@"签到积分",@"签到积分",@"签到积分",@"签到积分",@"签到积分"];
//    NSArray *arr2 = @[@"asdasdasdasdada",@"afasfafasdfasdfa",@"afasfafasdfasdfa",@"afasfafasdfasdfa",@"afasfafasdfasdfa"];
//    NSArray *arr3 = @[@"1",@"3",@"3",@"3",@"3"];
    
    [self makeTableWithCount:count andNameArr:nameArr andTimeArr:endTimeArr andJfArr:qdjfArr andOtherArr:nil inTheView:lastV];
    
}


-(void) makeTableWithCount:(NSInteger)count andNameArr:(NSArray *)NameArr andTimeArr:(NSArray *)timeArr andJfArr:(NSArray *)jfArr andOtherArr:(NSArray *)otherArr inTheView:(UIView *)view{
    

    
    
    for (NSInteger i = 0; i < count; i ++) {
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(16 * self.numSingleVesion, 14 *self.numSingleVesion + 70 *self.numSingleVesion *i, self.view.frame.size.width - 40 *self.numSingleVesion, 30 *self.numSingleVesion)];
        nameLab.text = NameArr[i];
        nameLab.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
        nameLab.textColor = SMSColor(51, 51, 51);
        [nameLab sizeToFit];
        [view addSubview:nameLab];
        
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(16 *self.numSingleVesion, nameLab.frame.origin.y + nameLab.frame.size.height + 7 *self.numSingleVesion , self.view.frame.size.width - 40 *self.numSingleVesion, 30 *self.numSingleVesion)];
        timeLab.text = timeArr[i];
        timeLab.font = [UIFont systemFontOfSize:17 * self.numSingleVesion];
        timeLab.textColor = SMSColor(153, 153, 153);
        [timeLab sizeToFit];
        [view addSubview:timeLab];
        
        UILabel *JfLab = [[UILabel alloc] initWithFrame:CGRectMake(0,0,30 *self.numSingleVesion, 30 *self.numSingleVesion)];
        JfLab.text = [NSString stringWithFormat:@"+%@",jfArr[i]];
        JfLab.font = [UIFont systemFontOfSize:17 * self.numSingleVesion];
        JfLab.textColor = SMSColor(255, 137, 17);
        [JfLab sizeToFit];
        JfLab.center = CGPointMake(self.view.frame.size.width - 16 *self.numSingleVesion - JfLab.frame.size.width/2, 35 * self.numSingleVesion + 70 *self.numSingleVesion * i);
        [view addSubview:JfLab];
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 69 *self.numSingleVesion + 70 *self.numSingleVesion * i, self.view.frame.size.width, 1 * self.numSingleVesion)];
        lineV.backgroundColor = SMSColor(153, 153, 153);
        [view addSubview:lineV];
    }



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
