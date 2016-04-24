//
//  MIneGroupPageViewController.m
//  360du
//
//  Created by linghang on 16/3/4.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "MIneGroupPageViewController.h"
#import "MineGroupViewController.h"
@interface MIneGroupPageViewController ()

@end

@implementation MIneGroupPageViewController
- (NSArray<NSString *> *)titles{
    return @[@"全部",@"待付款",@"待收货"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.menuItemWidth = 60;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleSizeSelected = 15.0;

    }
    return self;
}
#pragma mark - WMPageController DataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
//    MineGroupViewController *mine
  //  return vc;
    return nil;
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
