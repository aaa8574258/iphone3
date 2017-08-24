//
//  ExceptViewController.m
//  360du
//
//  Created by 利美 on 16/9/6.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ExceptViewController.h"

@interface ExceptViewController ()
@property(nonatomic ,copy) NSString *name;
@end

@implementation ExceptViewController
- (id)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        self.name = name;
        [self makeUI];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setBackImageStateName:@"fanhuijian2222.png" AndHighlightedName:@""];

//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
//    btn.center = CGPointMake(self.view.frame.size.height/2 - 30, self.view.frame.size.width/2);
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    [self setBackImageStateName:@"fanhuijian2222.png" AndHighlightedName:@""];

}


-(void)makeUI{
//    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    //    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    //[self setNavTitleItemWithNameAndImage:@"登陆" imageName:@"360.png"];
    [self setNavTitleItemWithName:self.name];
    [self setBackImageStateName:@"fanhuijian2222.png" AndHighlightedName:@""];

    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50 *self.numSingleVesion, self.view.frame.size.height/2,  140*self.numSingleVesion, 30*self.numSingleVesion)];
//    label.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    label.text = @"筹备中,敬请期待!";
    label.font = [UIFont systemFontOfSize:14*self.numSingleVesion];
    label.textColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-70*self.numSingleVesion, self.view.frame.size.height/2+30*self.numSingleVesion,  140*self.numSingleVesion, 30*self.numSingleVesion)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14*self.numSingleVesion];
//    [btn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 10*self.numSingleVesion;
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) btnAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
