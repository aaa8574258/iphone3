//
//  GroupWMPageViewController.m
//  360du
//
//  Created by linghang on 16/4/9.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "GroupWMPageViewController.h"
#import "GroupPurchaseCenterViewController.h"
@interface GroupWMPageViewController ()

@end

@implementation GroupWMPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    // Do any additional setup after loading the view.
//    if (self.selectIndex == 0) {
//        self.view.backgroundColor = [UIColor redColor];
//    }
    
}


- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    GroupPurchaseCenterViewController *group = [[GroupPurchaseCenterViewController alloc]init];
    group.Id = [NSString stringWithFormat:@"%@", self.ids[index]];
    return group;
    
}

-(void) setBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
