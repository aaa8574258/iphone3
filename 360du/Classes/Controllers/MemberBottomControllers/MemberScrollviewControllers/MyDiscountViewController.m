//
//  MyDiscountViewController.m
//  360du
//
//  Created by linghang on 15/10/29.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "MyDiscountViewController.h"

@interface MyDiscountViewController ()

@end

@implementation MyDiscountViewController
- (id)init{
    self = [super init];
    if (self) {
        [self makeNav];
        [self makeUI];
    }
    return self;
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"我的优惠券"];
}
- (void)makeUI{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
