//
//  MerchantDiscountViewController.m
//  360du
//
//  Created by linghang on 15/12/5.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "MerchantDiscountViewController.h"
#import "BuyFoodCarViewController.h"
@interface MerchantDiscountViewController ()
@property(nonatomic,copy)NSString *money;
@end

@implementation MerchantDiscountViewController
- (id)initWithMoney:(NSString *)money{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"优惠券";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
    
    //保存
    UIButton *favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favoriteBtn.frame = CGRectMake(WIDTH_CONTROLLER - 0 * self.numSingleVesion - 0 * self.numSingleVesion, 5, 30 * self.numSingleVesion, 34);
    [favoriteBtn setTitleColor:SMSColor(211, 211, 211) forState:UIControlStateNormal];
    [favoriteBtn setTitle:@"使用说明" forState:UIControlStateNormal];
    favoriteBtn.titleLabel.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
    [favoriteBtn addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
    favoriteBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:favoriteBtn];
    //    rightItem.
    //    [[UIBarButtonItem alloc]]
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)saveAddress{
    
    if ([self.target isKindOfClass:[BuyFoodCarViewController class]]) {
        [self.target retunMoney:self.money];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
